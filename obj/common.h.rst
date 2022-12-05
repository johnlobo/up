ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;
                              3 ;;  This program is free software: you can redistribute it and/or modify
                              4 ;;  it under the terms of the GNU Lesser General Public License as published by
                              5 ;;  the Free Software Foundation, either version 3 of the License, or
                              6 ;;  (at your option) any later version.
                              7 ;;
                              8 ;;  This program is distributed in the hope that it will be useful,
                              9 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             10 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             11 ;;  GNU Lesser General Public License for more details.
                             12 ;;
                             13 ;;  You should have received a copy of the GNU Lesser General Public License
                             14 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             15 ;;-------------------------------------------------------------------------------
                             16 
                             17 .globl _g_palette0
                             18 .globl _s_font_0
                             19 .globl _s_small_numbers_00
                             20 .globl _s_small_numbers_01
                             21 .globl _s_small_numbers_02
                             22 .globl _s_small_numbers_03
                             23 .globl _s_small_numbers_04
                             24 .globl _s_small_numbers_05
                             25 .globl _s_small_numbers_06
                             26 .globl _s_small_numbers_07
                             27 .globl _s_small_numbers_08
                             28 .globl _s_small_numbers_09
                             29 
                             30 ;;===============================================================================
                             31 ;; CPCTELERA FUNCTIONS
                             32 ;;===============================================================================
                             33 .globl cpct_disableFirmware_asm
                             34 .globl cpct_getScreenPtr_asm
                             35 .globl cpct_drawSprite_asm
                             36 .globl cpct_setVideoMode_asm
                             37 .globl cpct_setPalette_asm
                             38 .globl cpct_setPALColour_asm
                             39 .globl cpct_memset_asm
                             40 .globl cpct_getScreenToSprite_asm
                             41 .globl cpct_scanKeyboard_asm
                             42 .globl cpct_scanKeyboard_if_asm
                             43 .globl cpct_isKeyPressed_asm
                             44 .globl cpct_waitHalts_asm
                             45 .globl cpct_drawSolidBox_asm
                             46 .globl cpct_getRandom_xsp40_u8_asm
                             47 .globl cpct_setSeed_xsp40_u8_asm
                             48 .globl cpct_isAnyKeyPressed_asm
                             49 .globl cpct_setInterruptHandler_asm
                             50 .globl cpct_waitVSYNC_asm
                             51 .globl cpct_drawSpriteBlended_asm
                             52 .globl _cpct_keyboardStatusBuffer
                             53 .globl cpct_memset_f64_asm
                             54 .globl cpct_getRandom_mxor_u8_asm
                             55 .globl cpct_waitVSYNCStart_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 .globl cpct_setSeed_mxor_asm
                             57 
                             58 ;;===============================================================================
                             59 ;; DEFINED CONSTANTS
                             60 ;;===============================================================================
                             61 
                             62 ;;tipos de entidades
                     0000    63 e_type_invalid              = 0x00
                             64 
                             65 ;;tipos de componentes
                     0001    66 e_cmp_render = 0x01     ;;entidad renderizable
                     0002    67 e_cmp_movable = 0x02    ;;entidad que se puede mover
                     0004    68 e_cmp_input = 0x04      ;;entidad controlable por input  
                     0008    69 e_cmp_ia = 0x08         ;;entidad controlable con ia
                     0010    70 e_cmp_animated = 0x10   ;;entidad animada
                     0020    71 e_cmp_collider = 0x20   ;;entidad que puede colisionar
                     0023    72 e_cmp_default = e_cmp_render | e_cmp_movable | e_cmp_collider  ;;componente por defecto
                             73 
                             74 
                             75 ;; Keyboard constants
                     000A    76 BUFFER_SIZE = 10
                     00FF    77 ZERO_KEYS_ACTIVATED = #0xFF
                             78 
                             79 ;; Score constants
                     0004    80 SCORE_NUM_BYTES = 4
                             81 
                             82 ;; SMALL NUMBERS CONSTANTS
                     0002    83 S_SMALL_NUMBERS_WIDTH = 2
                     0005    84 S_SMALL_NUMBERS_HEIGHT = 5
                             85 ;; Font constants
                     0002    86 FONT_WIDTH = 2
                     0009    87 FONT_HEIGHT = 9
                             88 
                             89 
                             90 ;;===============================================================================
                             91 ;; DEFINED MACROS
                             92 ;;===============================================================================
                             93 .mdelete BeginStruct
                             94 .macro BeginStruct struct
                             95     struct'_offset = 0
                             96 .endm
                             97 
                             98 .mdelete Field
                             99 .macro Field struct, field, size
                            100     struct'_'field = struct'_offset
                            101     struct'_offset = struct'_offset + size
                            102 .endm
                            103 
                            104 .mdelete EndStruct
                            105 .macro EndStruct struct
                            106     sizeof_'struct = struct'_offset
                            107 .endm
                            108 
                            109 ;;===============================================================================
                            110 ;; Macro
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                            111 ;;
                            112 ;; Macro modified from cpctelera cpctm_screenPtr_asm
                            113 ;;===============================================================================
                            114 
                            115 .mdelete m_center_screen_ptr 
                            116 .macro m_center_screen_ptr REG16, VMEM, Y, WIDTH
                            117    ld REG16, #VMEM + 80 * (Y / 8) + 2048 * (Y & 7) + ((80 - WIDTH)/2)   ;; [3] REG16 = screenPtr
                            118 .endm
                            119 
