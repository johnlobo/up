;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
;;  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
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
.module component_manager

.include "man/component.h.s"
.include "cpctelera.h.s"
.include "common.h.s"
.include "sys/util.h.s"

DefineComponentPointersTable entities, e_cmpID_Num_Components, MAX_ENTITIES
_components_size = . * entities_components


;;-----------------------------------------------------------------
;;
;; man_components_init
;;
;;  Input:  
;;  Output: 
;;  Destroyed: af, hl, de, bc
;;
;;  lronaldo code (https://www.youtube.com/watch?v=OEETYTu-viw&t=1774s)
;;
man_components_init::
    ;; Set all values of the pointer array to nullpointer
    ;; filling in the array with zeroes
    ld hl, # entities_components        ;; hl points to the start of the components array
    ld de, # entities_components + 1    ;; de points to hl + 1
    ld (hl), #0                         ;; set the first byte of the array to 0
    ld bc, #_components_size-1          ;; set bc to the bytes to be filled
    ldir

    ;; Set the values for all Pend pointers in all pointer vectors
    ld b, #e_cmpID_Num_Components       ;; b = number of components
_init_next_pend:
    ;; Get in hl a pointer to the next component
    ld a, b                             ;; a = b
    dec a
    call man_components_getComponentPtrHL
    ld e, l
    ld d, h
    inc de
    inc de 
    ld (hl), e
    inc hl
    ld (hl), d
djnz _init_next_pend

ret


;;-----------------------------------------------------------------
;;
;; man_components_getComponentPtrHL
;;
;;  Input:  a: component id
;;  Output: hl: pointer to the start of the component structure
;;  Destroyed: af
;;
;;  lronaldo code (https://www.youtube.com/watch?v=OEETYTu-viw&t=1774s)
;;
man_components_getComponentPtrHL::
    ld hl, # entities_access_table      ;; hl points to the Entity components table
    add a                               ;; a = 2a
    add_hl_a                            ;; hl = 2a
    ;; Get pointer to the component structure
    ld a, (hl)
    inc hl
    ld h, (hl)
    ld l, a
    ret

;;-----------------------------------------------------------------
;;
;; man_components_getArrayHL
;;
;;  Input:  a: component id
;;  Output: hl: pointer to the start of the array of pointers for the selected component
;;  Destroyed: af
;;
;;  lronaldo code (https://www.youtube.com/watch?v=OEETYTu-viw&t=1774s)
;;
man_components_getArrayHL::
    call man_components_getComponentPtrHL
    inc hl
    inc hl
    ret