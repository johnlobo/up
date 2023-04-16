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
;;  Modified: AF, BC, DE, HL
;;
sys_physics_update_one_entity::
    ;; update x coord with vx
    ld a, e_vx(ix)
    or a                        ;; check if vx == 0
    jr z, spuoe_yCoord          ;; move to y coord if vx === 0
    add a, e_x(ix)
    ld e_x(ix), a
    ld e_moved(ix), #1          ;; flag the entity as moved

spuoe_yCoord:
    ;; update y coord with vy
    ld a, e_vy(ix)
    or a                        ;; check if vx == 0
    jr z, spuoe_Exit            ;; move to ret coord if vx === 0
    add a, e_y(ix)
    ld e_y(ix), a
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
    
