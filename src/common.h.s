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

;;tipos de entidades
e_type_invalid              = 0x00

;;tipos de componentes
;;tipos de componentes
e_cmps          = 0
e_cmps_render   = 0x01   ;;entidad renderizable
e_cmps_movable  = 0x02   ;;entidad que se puede mover
e_cmps_input    = 0x04   ;;entidad controlable por input  
e_cmps_ia       = 0x08   ;;entidad controlable con ia
e_cmps_animated = 0x10   ;;entidad animada
e_cmps_collider = 0x20   ;;entidad que puede colisionar
e_cmps_default = e_cmps_render | e_cmps_movable | e_cmps_collider  ;;componente por defecto


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

