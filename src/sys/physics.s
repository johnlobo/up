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
.include "man/array.h.s"
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
    ;; update x coord with vx
    ld a, e_vx(ix)              ;; check if the speed in x is 0
    ld c, e_vx+1(ix)            ;;
    or c                        ;; check if vx == 0
    jr z, spuoe_yCoord          ;; move to y coord if vx === 0

    ld b, e_vx(ix)              ;; lower part of the vx speed c, so bc = vx
    ld h, e_x(ix)               ;;
    ld l, e_x+1(ix)             ;; get the x coord in hl
    ld a, h                     ;; save h value in a
    adc hl, bc                  ;; add x+vx
    ld e_x(ix), h               ;; update entity with new position
    ld e_x+1(ix), l             ;;
    
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
    ld h, e_y(ix)               ;;
    ld l, e_y+1(ix)             ;; get the y coord in hl
    ld a, h                     ;; save h value in a
    adc hl, bc                  ;; add y+vy
    ld e_y(ix), h               ;; update entity with new position
    ld e_y+1(ix), l             ;;

    cp h                        ;; if h has changed (high value)moved = true
    jr z, spuoe_Exit            ;;
    ld e_moved(ix), #1          ;; flag the entity as moved

spuoe_Exit:
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

cmps_physics = ( e_cmps_alive | e_cmps_physics)
sys_physics_update::
    ld hl, #sys_physics_update_one_entity
    ld ix, #entities
    ld a, #cmps_physics
    call man_array_execute_each_matching

    ret
    
