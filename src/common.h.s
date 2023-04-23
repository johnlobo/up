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

.include "macros.h.s"

;;===============================================================================
;; SPRITES
;;===============================================================================
.globl _g_palette0
.globl _s_font_0
.globl _s_small_numbers_00
.globl _s_small_numbers_01
.globl _s_small_numbers_02
.globl _s_small_numbers_03
.globl _s_small_numbers_04
.globl _s_small_numbers_05
.globl _s_small_numbers_06
.globl _s_small_numbers_07
.globl _s_small_numbers_08
.globl _s_small_numbers_09
.globl _s_player_0
.globl _s_player_1
.globl _s_player_w_r_0
.globl _s_player_w_r_1
.globl _s_player_w_r_2
.globl _s_player_w_r_3

;;===============================================================================
;; CPCTELERA FUNCTIONS
;;===============================================================================
.globl cpct_disableFirmware_asm
.globl cpct_getScreenPtr_asm
.globl cpct_drawSprite_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPalette_asm
.globl cpct_setPALColour_asm
.globl cpct_memset_asm
.globl cpct_getScreenToSprite_asm
.globl cpct_scanKeyboard_asm
.globl cpct_scanKeyboard_if_asm
.globl cpct_isKeyPressed_asm
.globl cpct_waitHalts_asm
.globl cpct_drawSolidBox_asm
.globl cpct_getRandom_xsp40_u8_asm
.globl cpct_setSeed_xsp40_u8_asm
.globl cpct_isAnyKeyPressed_asm
.globl cpct_setInterruptHandler_asm
.globl cpct_waitVSYNC_asm
.globl cpct_drawSpriteBlended_asm
.globl _cpct_keyboardStatusBuffer
.globl cpct_memset_f64_asm
.globl cpct_getRandom_mxor_u8_asm
.globl cpct_waitVSYNCStart_asm
.globl cpct_setSeed_mxor_asm
.globl cpct_setVideoMemoryPage_asm

;;===============================================================================
;; DEFINED CONSTANTS
;;===============================================================================

COF                     = #0x0016           ;; Coefficient of Friction
GRAVITY                 = #0x0024           ;; Gravity
DASH_IMPULSE            = 0x0200
DASH_TIMER              = 10
STEP_HORIZONTAL_SPEED   = 0x0018
MAX_HORIZONTAL_SPEED_POS    = 0x0100
MAX_HORIZONTAL_SPEED_NEG    = 0xff00

MAX_ENTITIES = 10


nullptr = 0x0000

;;==============================================================================================================================
;;==============================================================================================================================
;;  ENTITY TYPE MASKS AND BITS
;;==============================================================================================================================
;;==============================================================================================================================
e_type_invalid          = 0xff
e_type_dead             = 0x08
e_type_shot             = 0x04
e_type_enemy            = 0x02
e_type_player           = 0x01
e_type_default          = 0x00

;;===============================================================================
;;tipos de componentes
;;===============================================================================
e_cmp          = 0
e_cmp_alive    = 0x01   ;;entidad renderizable
e_cmp_render   = 0x02   ;;entidad renderizable
e_cmp_physics  = 0x04   ;;entidad que se puede mover
e_cmp_input    = 0x08   ;;entidad controlable por input  
e_cmp_ai       = 0x10   ;;entidad controlable con ia
e_cmp_animated = 0x20   ;;entidad animada
e_cmp_collider = 0x40   ;;entidad que puede colisionar
e_cmp_collisionable = 0x80   ;;entidad que puede ser colisionada
e_cmp_default = e_cmp_alive | e_cmp_render | e_cmp_physics | e_cmp_collider  ;;componente por defecto

;;===============================================================================
;; Entity Component IDs
;;===============================================================================
DefEnum e_cmpID
Enum e_cmpID AI
Enum e_cmpID Physics
Enum e_cmpID Animation
Enum e_cmpID Collisionable
Enum e_cmpID Num_Components

;;===============================================================================
;; ENTITIY SCTRUCTURE CREATION
;;===============================================================================
BeginStruct e
Field e, cmps               , 1
Field e, ptr                , 2
Field e, type               , 1
Field e, x                  , 2
Field e, y                  , 2
Field e, w                  , 1
Field e, h                  , 1
Field e, end_x              , 1
Field e, end_y              , 1
Field e, vx                 , 2
Field e, vy                 , 2
Field e, sprite             , 2
Field e, address            , 2
Field e, p_address          , 2
Field e, moved              , 1
Field e, on_platform        , 1
Field e, orientation        , 1
Field e, dashing            , 1
Field e, animation_ptr      , 2
Field e, animation_status   , 1
EndStruct e

;; Keyboard constants
BUFFER_SIZE = 10
ZERO_KEYS_ACTIVATED = #0xFF

;; Score constants
SCORE_NUM_BYTES = 4

;; SMALL NUMBERS CONSTANTS
S_SMALL_NUMBERS_WIDTH = 2
S_SMALL_NUMBERS_HEIGHT = 5
;; Font constants
FONT_WIDTH = 2
FONT_HEIGHT = 9

;;===============================================================================
;; GLOBAL VARIABLES
;;===============================================================================
.globl entities
