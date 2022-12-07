ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;;-----------------------------LICENSE NOTICE------------------------------------
                              2 ;;  This program is free software: you can redistribute it and/or modify
                              3 ;;  it under the terms of the GNU Lesser General Public License as published by
                              4 ;;  the Free Software Foundation, either version 3 of the License, or
                              5 ;;  (at your option) any later version.
                              6 ;;
                              7 ;;  This program is distributed in the hope that it will be useful,
                              8 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                              9 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                             10 ;;  GNU Lesser General Public License for more details.
                             11 ;;
                             12 ;;  You should have received a copy of the GNU Lesser General Public License
                             13 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                             14 ;;-------------------------------------------------------------------------------
                             15 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             16 .include "common.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             55 .globl cpct_waitVSYNCStart_asm
                             56 .globl cpct_setSeed_mxor_asm
                             57 .globl cpct_setVideoMemoryPage_asm
                             58 
                             59 ;;===============================================================================
                             60 ;; DEFINED CONSTANTS
                             61 ;;===============================================================================
                             62 
                             63 ;;tipos de entidades
                     0000    64 e_type_invalid              = 0x00
                             65 
                             66 ;;tipos de componentes
                     0001    67 e_cmp_render = 0x01     ;;entidad renderizable
                     0002    68 e_cmp_movable = 0x02    ;;entidad que se puede mover
                     0004    69 e_cmp_input = 0x04      ;;entidad controlable por input  
                     0008    70 e_cmp_ia = 0x08         ;;entidad controlable con ia
                     0010    71 e_cmp_animated = 0x10   ;;entidad animada
                     0020    72 e_cmp_collider = 0x20   ;;entidad que puede colisionar
                     0023    73 e_cmp_default = e_cmp_render | e_cmp_movable | e_cmp_collider  ;;componente por defecto
                             74 
                             75 
                             76 ;; Keyboard constants
                     000A    77 BUFFER_SIZE = 10
                     00FF    78 ZERO_KEYS_ACTIVATED = #0xFF
                             79 
                             80 ;; Score constants
                     0004    81 SCORE_NUM_BYTES = 4
                             82 
                             83 ;; SMALL NUMBERS CONSTANTS
                     0002    84 S_SMALL_NUMBERS_WIDTH = 2
                     0005    85 S_SMALL_NUMBERS_HEIGHT = 5
                             86 ;; Font constants
                     0002    87 FONT_WIDTH = 2
                     0009    88 FONT_HEIGHT = 9
                             89 
                             90 
                             91 ;;===============================================================================
                             92 ;; DEFINED MACROS
                             93 ;;===============================================================================
                             94 .mdelete BeginStruct
                             95 .macro BeginStruct struct
                             96     struct'_offset = 0
                             97 .endm
                             98 
                             99 .mdelete Field
                            100 .macro Field struct, field, size
                            101     struct'_'field = struct'_offset
                            102     struct'_offset = struct'_offset + size
                            103 .endm
                            104 
                            105 .mdelete EndStruct
                            106 .macro EndStruct struct
                            107     sizeof_'struct = struct'_offset
                            108 .endm
                            109 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                            110 ;;===============================================================================
                            111 ;; Macro
                            112 ;;
                            113 ;; Macro modified from cpctelera cpctm_screenPtr_asm
                            114 ;;===============================================================================
                            115 
                            116 .mdelete m_center_screen_ptr 
                            117 .macro m_center_screen_ptr REG16, VMEM, Y, WIDTH
                            118    ld REG16, #VMEM + 80 * (Y / 8) + 2048 * (Y & 7) + ((80 - WIDTH)/2)   ;; [3] REG16 = screenPtr
                            119 .endm
                            120 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                             17 
                             18 .module fight_manager
                             19 
                             20 ;;------------------------------------------------------------------------------
                             21 ;; Global constants
                             22 ;;------------------------------------------------------------------------------
                             23 
                     0003    24 COMBAT_CARDS_PER_ROUND = 3
                     000C    25 COMBAT_MAX_ROUNDS = 12
                             26 
                             27 ;;------------------------------------------------------------------------------
                             28 ;; Global variables
                             29 ;;------------------------------------------------------------------------------
                             30 
                             31 ;;------------------------------------------------------------------------------
                             32 ;; Global routines
                             33 ;;------------------------------------------------------------------------------
                             34 
                             35 
                             36 ;;===============================================================================
                             37 ;; MACROS
                             38 ;;===============================================================================
                             39 
                             40 
                             41 ;;===============================================================================
                             42 ;; COMPONENT DEFINITION MACRO
                             43 ;;===============================================================================
                             44 
                             45 .macro DefineComponentCombat _Tname, _N, _ComponentSize
                             46       _Tname'_count::               .db 0
                             47       _Tname'_delta::               .db 0
                             48       _Tname'_component_size::      .db _ComponentSize
                             49       _Tname'_pend::                .dw _Tname'_array 
                             50       _Tname'_selected::            .db 0
                             51       _Tname'_array::
                             52             .ds _N * _ComponentSize
                             53 .endm
                             54 
                             55 ;;===============================================================================
                             56 ;; DATA ARRAY STRUCTURE CREATION
                             57 ;;===============================================================================
   0000                      58 BeginStruct combat
                     0000     1     combat_offset = 0
   0000                      59 Field combat, name , 30
                     0000     1     combat_name = combat_offset
                     001E     2     combat_offset = combat_offset + 30
   0000                      60 Field combat, rounds , 1
                     001E     1     combat_rounds = combat_offset
                     001F     2     combat_offset = combat_offset + 1
   0000                      61 Field combat, cards, (COMBAT_MAX_ROUNDS*COMBAT_CARDS_PER_ROUND) 
                     001F     1     combat_cards = combat_offset
                     0043     2     combat_offset = combat_offset + (COMBAT_MAX_ROUNDS*COMBAT_CARDS_PER_ROUND)
   0000                      62 EndStruct combat
                     0043     1     sizeof_combat = combat_offset
