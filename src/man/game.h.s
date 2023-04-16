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

.module game_manager

.include "macros.h.s"

;;===============================================================================
;; PUBLIC VARIABLES
;;===============================================================================
MAX_ENTITIES = 10


;;===============================================================================
;; PUBLIC METHODS
;;===============================================================================
.globl man_game_init
.globl man_game_update


;;===============================================================================
;; CARD DEFINITION MACRO
;;===============================================================================
.macro DefineEntity _cpms, _x, _y, _w, _h, _vx, _vy, _sprite, _address, _p_address
    .db _cpms
    .db _x
    .db _y
    .db _w
    .db _h
    .db _vx
    .db _vy
    .dw _sprite
    .dw _address
    .dw _p_address
.endm

;;===============================================================================
;; ENTITIY SCTRUCTURE CREATION
;;===============================================================================
BeginStruct e
Field e, cpms       , 1
Field e, x          , 1
Field e, y          , 1
Field e, w          , 1
Field e, h          , 1
Field e, vx         , 1
Field e, vy         , 1
Field e, sprite     , 2
Field e, address    , 2
Field e, p_address  , 2
EndStruct e