;;-----------------------------LICENSE NOTICE------------------------------------
;;
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

.module game_manager

.include "man/game.h.s"
.include "man/array.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "common.h.s"
.include "cpctelera.h.s"



;;
;; Start of _DATA area 
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA

entities::
DefineArray e, MAX_ENTITIES, sizeof_e     
.db 0   ;;ponemos este aqui como trampita para que siempre haya un tipo invalido al final

entityTpl::
DefineEntity e_cmps_default, 100, 100, 8, 40, 0, 0, _s_player_0, #0000, #0000, 1

;;
;; Start of _CODE area
;; 
.area _CODE

;;-----------------------------------------------------------------
;;
;; man_game_init
;;
;;  
;;  Input: 
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;
man_game_init::

    ld ix, #entities
    call man_array_init                 ;; Initialize entity array
    
    ;; Create an entity in 100, 100
    ld hl, #entityTpl                   ;; Template of the entity to create
    call man_array_create_element       ;; Create new entity
    
    ;; Create a second entity in 120, 100
    ld hl, #entityTpl                   ;; Template of the entity to create
    call man_array_create_element       ;; Create new entity
    push ix                             ;; Save ix 
    push hl                             ;; move pointer to the new entity to ix
    pop ix                              ;;
    ld e_x(ix), #120                    ;; move second entity to 120
    ld e_vx(ix), #1                     ;; vx = 1
    pop ix                              ;; retrieve ix
    
    ret

;;-----------------------------------------------------------------
;;
;; man_game_update
;;
;;   
;;  Input: 
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;
man_game_update::
    call sys_physics_update
    call sys_render_update
    ;; delay 
    ;;ld b, #10
    ;;call cpct_waitHalts_asm
    ret
