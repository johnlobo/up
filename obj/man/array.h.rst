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
                             15 .module array_manager
                             16 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             17 .include "common.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             17 .include "macros.h.s"
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
                             17 
                             18 ;;===============================================================================
                             19 ;; DEFINED MACROS
                             20 ;;===============================================================================
                             21 .mdelete BeginStruct
                             22 .macro BeginStruct struct
                             23     struct'_offset = 0
                             24 .endm
                             25 
                             26 .mdelete Field
                             27 .macro Field struct, field, size
                             28     struct'_'field = struct'_offset
                             29     struct'_offset = struct'_offset + size
                             30 .endm
                             31 
                             32 .mdelete EndStruct
                             33 .macro EndStruct struct
                             34     sizeof_'struct = struct'_offset
                             35 .endm
                             36 
                             37 ;;===============================================================================
                             38 ;; Macro
                             39 ;;
                             40 ;; Macro modified from cpctelera cpctm_screenPtr_asm
                             41 ;;===============================================================================
                             42 
                             43 .mdelete m_center_screen_ptr 
                             44 .macro m_center_screen_ptr REG16, VMEM, Y, WIDTH
                             45    ld REG16, #VMEM + 80 * (Y / 8) + 2048 * (Y & 7) + ((80 - WIDTH)/2)   ;; [3] REG16 = screenPtr
                             46 .endm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             18 
                             19 .globl _g_palette0
                             20 .globl _s_font_0
                             21 .globl _s_small_numbers_00
                             22 .globl _s_small_numbers_01
                             23 .globl _s_small_numbers_02
                             24 .globl _s_small_numbers_03
                             25 .globl _s_small_numbers_04
                             26 .globl _s_small_numbers_05
                             27 .globl _s_small_numbers_06
                             28 .globl _s_small_numbers_07
                             29 .globl _s_small_numbers_08
                             30 .globl _s_small_numbers_09
                             31 .globl _s_player_0
                             32 .globl _s_player_1
                             33 
                             34 ;;===============================================================================
                             35 ;; CPCTELERA FUNCTIONS
                             36 ;;===============================================================================
                             37 .globl cpct_disableFirmware_asm
                             38 .globl cpct_getScreenPtr_asm
                             39 .globl cpct_drawSprite_asm
                             40 .globl cpct_setVideoMode_asm
                             41 .globl cpct_setPalette_asm
                             42 .globl cpct_setPALColour_asm
                             43 .globl cpct_memset_asm
                             44 .globl cpct_getScreenToSprite_asm
                             45 .globl cpct_scanKeyboard_asm
                             46 .globl cpct_scanKeyboard_if_asm
                             47 .globl cpct_isKeyPressed_asm
                             48 .globl cpct_waitHalts_asm
                             49 .globl cpct_drawSolidBox_asm
                             50 .globl cpct_getRandom_xsp40_u8_asm
                             51 .globl cpct_setSeed_xsp40_u8_asm
                             52 .globl cpct_isAnyKeyPressed_asm
                             53 .globl cpct_setInterruptHandler_asm
                             54 .globl cpct_waitVSYNC_asm
                             55 .globl cpct_drawSpriteBlended_asm
                             56 .globl _cpct_keyboardStatusBuffer
                             57 .globl cpct_memset_f64_asm
                             58 .globl cpct_getRandom_mxor_u8_asm
                             59 .globl cpct_waitVSYNCStart_asm
                             60 .globl cpct_setSeed_mxor_asm
                             61 .globl cpct_setVideoMemoryPage_asm
                             62 
                             63 ;;===============================================================================
                             64 ;; DEFINED CONSTANTS
                             65 ;;===============================================================================
                             66 
                             67 ;;tipos de entidades
                     0000    68 e_type_invalid              = 0x00
                             69 
                             70 ;;tipos de componentes
                             71 ;;tipos de componentes
                     0000    72 e_cmps          = 0
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                     0001    73 e_cmps_render   = 0x01   ;;entidad renderizable
                     0002    74 e_cmps_movable  = 0x02   ;;entidad que se puede mover
                     0004    75 e_cmps_input    = 0x04   ;;entidad controlable por input  
                     0008    76 e_cmps_ia       = 0x08   ;;entidad controlable con ia
                     0010    77 e_cmps_animated = 0x10   ;;entidad animada
                     0020    78 e_cmps_collider = 0x20   ;;entidad que puede colisionar
                     0023    79 e_cmps_default = e_cmps_render | e_cmps_movable | e_cmps_collider  ;;componente por defecto
                             80 
                             81 
                             82 ;; Keyboard constants
                     000A    83 BUFFER_SIZE = 10
                     00FF    84 ZERO_KEYS_ACTIVATED = #0xFF
                             85 
                             86 ;; Score constants
                     0004    87 SCORE_NUM_BYTES = 4
                             88 
                             89 ;; SMALL NUMBERS CONSTANTS
                     0002    90 S_SMALL_NUMBERS_WIDTH = 2
                     0005    91 S_SMALL_NUMBERS_HEIGHT = 5
                             92 ;; Font constants
                     0002    93 FONT_WIDTH = 2
                     0009    94 FONT_HEIGHT = 9
                             95 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             18 
                             19 ;;===============================================================================
                             20 ;; PUBLIC VARIABLES
                             21 ;;===============================================================================
                             22 
                             23 
                             24 ;;===============================================================================
                             25 ;; PUBLIC METHODS
                             26 ;;===============================================================================
                             27 .globl man_array_init
                             28 .globl man_array_create_element
                             29 .globl man_array_remove_element
                             30 .globl man_array_get_element
                             31 .globl man_array_get_random_element
                             32 .globl man_array_move_all_elements
                             33 .globl man_array_execute_each
                             34 
                             35 ;;===============================================================================
                             36 ;; COMPONENT DEFINITION MACRO
                             37 ;;===============================================================================
                             38 
                             39 
                             40 .macro DefineArray _Tname, _MaxElements, _ComponentSize
                             41       _Tname'_count::                     .db 0
                             42       _Tname'_delta::                     .db 0
                             43       _Tname'_component_size::            .db _ComponentSize
                             44       _Tname'_component_max_number::      .db _MaxElements
                             45       _Tname'_pend::                      .dw _Tname'_array 
                             46       _Tname'_selected::                  .db 0
                             47       _Tname'_array::
                             48             .ds _MaxElements * _ComponentSize
                             49 .endm
                             50 
                             51 ;;===============================================================================
                             52 ;; DATA ARRAY STRUCTURE CREATION
                             53 ;;===============================================================================
   0000                      54 BeginStruct a
                     0000     1     a_offset = 0
   0000                      55 Field a, count , 1
                     0000     1     a_count = a_offset
                     0001     2     a_offset = a_offset + 1
   0000                      56 Field a, delta , 1
                     0001     1     a_delta = a_offset
                     0002     2     a_offset = a_offset + 1
   0000                      57 Field a, component_size , 1
                     0002     1     a_component_size = a_offset
                     0003     2     a_offset = a_offset + 1
   0000                      58 Field a, component_max_number , 1
                     0003     1     a_component_max_number = a_offset
                     0004     2     a_offset = a_offset + 1
   0000                      59 Field a, pend , 2
                     0004     1     a_pend = a_offset
                     0006     2     a_offset = a_offset + 2
   0000                      60 Field a, selected , 1
                     0006     1     a_selected = a_offset
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                     0007     2     a_offset = a_offset + 1
   0000                      61 Field a, array , 1
                     0007     1     a_array = a_offset
                     0008     2     a_offset = a_offset + 1
   0000                      62 EndStruct a
                     0008     1     sizeof_a = a_offset
