;;-----------------------------LICENSE NOTICE------------------------------------
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-------------------------------------------------------------------------------

.module physics_system

.include "sys/physics.h.s"
.include "man/components.h.s"
.include "common.h.s"
.include "cpctelera.h.s"


;;
;; Start of _DATA area 
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA


.area _ABS   (ABS)


;;
;; Start of _CODE area
;; 
.area _CODE


;;-----------------------------------------------------------------
;;
;; sys_physics_init
;;
;;  Initilizes render system
;;  Input: 
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;
sys_physics_init::
    ;; set pointer array address 
    ld a, #e_cmpID_Physics
    call man_components_getArrayHL
    ld  (_ent_array_ptr), hl

    ret

;;-----------------------------------------------------------------
;;
;; sys_physics_apply_gravity
;;
;;  Initilizes render system
;;  Input: 
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;
sys_physics_apply_gravity::
    ld bc, #GRAVITY
    ld h, e_vy(ix)
    ld l, e_vy+1(ix)
    adc hl, bc
    ld e_vy(ix), h              ;; restore updated vy
    ld e_vy+1(ix), l            ;; 
    ret 

;;-----------------------------------------------------------------
;;
;; sys_physics_apply_friction_vx
;;
;;  Initilizes render system
;;  Input: 
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;
sys_physics_apply_friction_vx::
    ld bc, #COF                 ;; Coeficient of friction
    ld h, e_vx(ix)
    ld l, e_vx+1(ix)
    bit 7, h                    ;; test if vx is positive or negative
    jr nz, _vx_negative         ;; if bit 7 is set, z is not set and vx is positive
                                ;; so the COF should be substracted
    or a                        ;; reset c
    sbc hl,bc                   ;; substract bc from hl
    jp p, _vx_restore           ;;
    ld h, #0                    ;; if vx has gone negative vx = 0
    ld l, h                     ;;
    jr _vx_restore
_vx_negative:
    adc hl, bc                  ;; add COF to vx
    jp m, _vx_restore           ;;
    ld h, #0                    ;; if vx has gone positive vx = 0
    ld l, h                     ;;
_vx_restore:
    ld e_vx(ix), h              ;; restore updated vx
    ld e_vx+1(ix), l            ;; restore updated vx
    ret

;;-----------------------------------------------------------------
;;
;; sys_physics_update_one_entity
;;
;;  Initilizes render system
;;  Input: ix : pointer to the entity
;;  Output: 
;;  Modified: AF, BC, HL
;;
sys_physics_update_one_entity::
    ld a, e_dashing(ix)         ;; if I'm dashing I cannot change vx
    or a
    jr z, spuoe_xCoord
    dec e_dashing(ix)           ;; else decrease dashing
    jr nz, spuoe_yCoord         ;; if dash reach 0
    ld e_dashing(ix),#0         ;; dashing = 0
    ld e_vx(ix), #0x00          ;; vx = 0x0032
    ld e_vx+1(ix), #0x32        ;;

spuoe_xCoord:
    ;; update x coord with vx
    ld a, e_vx(ix)              ;; check if the speed in x is 0
    ld c, e_vx+1(ix)            ;;
    or c                        ;; check if vx == 0
    jr z, spuoe_yCoord          ;; move to y coord if vx === 0

    ld b, e_vx(ix)              ;; lower part of the vx speed c, so bc = vx
    ld h, e_x(ix)               ;; get the x coord in hl
    ld l, e_x+1(ix)             ;; 
    ld a, h                     ;; save h value in a
    adc hl, bc                  ;; add x+vx
    ld e_x(ix), h               ;; update entity with new position
    ld e_x+1(ix), l             ;;
    ;; check if screen coord has changed to update moved.
    cp h                        ;; if h has changed (high value)moved = true
    jr z, spuoe_yCoord          ;;
    ld e_moved(ix), #1          ;; flag the entity as moved
    
spuoe_yCoord:
    ;; update y coord with vy
    ld a, e_vy(ix)            ;; check if the speed in y is 0
    ld c, e_vy+1(ix)              ;;
    or c                        ;; check if vx == 0
    jr z, spuoe_Exit            ;; move to ret coord if vx === 0
    
    ld b, e_vy(ix)              ;; lower part of the vy speed c, so bc = vy
    ld h, e_y(ix)               ;; get the y coord in hl
    ld l, e_y+1(ix)             ;; 
    ld a, h                         ;; save h value in a
    adc hl, bc                  ;; add y+vy
    ;; check if screen coord has changed to update moved.
    cp h                        ;; if h has changed (high value)moved = true
    jr z, spoue_hit_ground      ;; screen coord has not changed->check the ground
    ld e_moved(ix), #1          ;; flag the entity as moved

spoue_hit_ground:
    ;; Check if we have hitted the ground ground in 80
    ld (spoue_under_floor+1), hl
    or a                        ;;clear carry flag
    ld bc, #0x5000              ;; 80.00
    sbc hl,bc
    jr c,spoue_under_floor               ;if hl >= 160, carry flag will be cleared
    ld hl, #0x5000              ;;80.00
    ld e_vy(ix), #0             ;; reset vy 
    ld e_vy+1(ix), #0             ;; reset vy 
    ld e_on_platform(ix), #1
    jr spoue_floor_checking_exit
spoue_under_floor:
    ld hl, #0000 
spoue_floor_checking_exit:
    ld e_y(ix), h               ;; update entity with new position
    ld e_y+1(ix), l             ;;

spuoe_Exit:
    ;; Friction & Gravity
    call sys_physics_apply_friction_vx  ;; otherwise apply friction no gravity
    ld a, e_on_platform(ix)             ;; if not on_platform--> apply gravity
    or a                                ;;
    ret nz                              ;; else return
    call sys_physics_apply_gravity      ;; apply gravity
    ret

;;-----------------------------------------------------------------
;;
;; sys_render_update
;;
;;  Initilizes render system
;;  Input: 
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;

sys_physics_update::

_ent_array_ptr = . + 1
    ld  hl, #0x0000

    _loop:
    ;;  Select the pointer to the entity with AI and prepare the next position for the next iteration.
    ld e, (hl)
    inc hl
    ld d, (hl)
    inc hl

    ;;  The entities are finished traversing when find a pointer to null.
    ld a, e
    or d
    ret z

    push hl

    ld__ixl_e
    ld__ixh_d

    call sys_physics_update_one_entity

	pop hl

    jr _loop

    ret
    
