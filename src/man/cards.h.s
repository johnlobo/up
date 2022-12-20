;;-----------------------------LICENSE NOTICE------------------------------------
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU  General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-------------------------------------------------------------------------------

.include "common.h.s"

;;===============================================================================
;; CONSTANST
;;===============================================================================

;; ASPECTS
ASPECT_DAMAGE = 1
ASPECT_LIFE = 2
ASPECT_GOLD = 3
ASPECT_SHIELD = 4
ASPECT_CHEST = 5

;;===============================================================================
;; CARD DEFINITION MACRO
;;===============================================================================

.macro DefineCard _id, _name, _sprite, _aspect, _value, _reward_aspect, _reward_value
    .db _id
    .asciz "_name"
    .dw _sprite
    .db _aspect
    .db _value
    .db _reward_aspect
    .db _reward_value
.endm

;;===============================================================================
;; CARD STRUCTURE CREATION
;;===============================================================================
BeginStruct card
Field card, id, 1
Field card, name , 30
Field card, sprite , 2
Field card, aspect , 1
Field card, value , 1
Field card, reward_aspect, 1
Field card, reward_value, 1
EndStruct card