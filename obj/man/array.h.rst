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
                             47 
                             48 ;;===============================================================================
                             49 ;; MACRO
                             50 ;;===============================================================================
                             51 .mdelete ld_de_backbuffer
                             52 .macro ld_de_backbuffer
                             53    ld   a, (sys_render_back_buffer)          ;; DE = Pointer to start of the screen
                             54    ld   d, a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                             55    ld   e, #00
                             56 .endm
                             57 
                             58 .mdelete ld_de_frontbuffer
                             59 .macro ld_de_frontbuffer
                             60    ld   a, (sys_render_front_buffer)         ;; DE = Pointer to start of the screen
                             61    ld   d, a
                             62    ld   e, #00
                             63 .endm
                             64 
                             65 .mdelete m_screenPtr_backbuffer
                             66 .macro m_screenPtr_backbuffer X, Y
                             67    push hl
                             68    ld de, #(80 * (Y / 8) + 2048 * (Y & 7) + X)
                             69    ld a, (sys_render_back_buffer)
                             70    ld h, a
                             71    ld l, #0         
                             72    add hl, de
                             73    ex de, hl
                             74    pop hl
                             75 .endm
                             76 
                             77 .mdelete m_screenPtr_frontbuffer
                             78 .macro m_screenPtr_frontbuffer X, Y
                             79    push hl
                             80    ld de, #(80 * (Y / 8) + 2048 * (Y & 7) + X)
                             81    ld a, (sys_render_front_buffer)
                             82    ld h, a
                             83    ld l, #0         
                             84    add hl, de
                             85    ex de, hl
                             86    pop hl
                             87 .endm
                             88 
                             89 
                             90 .mdelete m_draw_blank_small_number
                             91 .macro m_draw_blank_small_number
                             92    push de
                             93    push hl
                             94    ld c, #5
                             95    ld b, #5
                             96    ld a, #0                         ;; Patern of solid box
                             97    call cpct_drawSolidBox_asm
                             98    pop hl
                             99    pop de
                            100 .endm
                            101 
                            102 ;;===============================================================================
                            103 ;; ENTITY DEFINITION MACRO
                            104 ;;===============================================================================
                            105 .mdelete DefineEntity
                            106 .macro DefineEntity _cpms, _x, _y, _w, _h, _vx, _vy, _sprite, _address, _p_address
                            107     .db _cpms
                            108     .db _x
                            109     .db _y
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                            110     .db _w
                            111     .db _h
                            112     .db _vx
                            113     .db _vy
                            114     .dw _sprite
                            115     .dw _address
                            116     .dw _p_address
                            117 .endm
                            118 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



                             18 
                             19 ;;===============================================================================
                             20 ;; SPRITES
                             21 ;;===============================================================================
                             22 .globl _g_palette0
                             23 .globl _s_font_0
                             24 .globl _s_small_numbers_00
                             25 .globl _s_small_numbers_01
                             26 .globl _s_small_numbers_02
                             27 .globl _s_small_numbers_03
                             28 .globl _s_small_numbers_04
                             29 .globl _s_small_numbers_05
                             30 .globl _s_small_numbers_06
                             31 .globl _s_small_numbers_07
                             32 .globl _s_small_numbers_08
                             33 .globl _s_small_numbers_09
                             34 .globl _s_player_0
                             35 .globl _s_player_1
                             36 
                             37 ;;===============================================================================
                             38 ;; CPCTELERA FUNCTIONS
                             39 ;;===============================================================================
                             40 .globl cpct_disableFirmware_asm
                             41 .globl cpct_getScreenPtr_asm
                             42 .globl cpct_drawSprite_asm
                             43 .globl cpct_setVideoMode_asm
                             44 .globl cpct_setPalette_asm
                             45 .globl cpct_setPALColour_asm
                             46 .globl cpct_memset_asm
                             47 .globl cpct_getScreenToSprite_asm
                             48 .globl cpct_scanKeyboard_asm
                             49 .globl cpct_scanKeyboard_if_asm
                             50 .globl cpct_isKeyPressed_asm
                             51 .globl cpct_waitHalts_asm
                             52 .globl cpct_drawSolidBox_asm
                             53 .globl cpct_getRandom_xsp40_u8_asm
                             54 .globl cpct_setSeed_xsp40_u8_asm
                             55 .globl cpct_isAnyKeyPressed_asm
                             56 .globl cpct_setInterruptHandler_asm
                             57 .globl cpct_waitVSYNC_asm
                             58 .globl cpct_drawSpriteBlended_asm
                             59 .globl _cpct_keyboardStatusBuffer
                             60 .globl cpct_memset_f64_asm
                             61 .globl cpct_getRandom_mxor_u8_asm
                             62 .globl cpct_waitVSYNCStart_asm
                             63 .globl cpct_setSeed_mxor_asm
                             64 .globl cpct_setVideoMemoryPage_asm
                             65 
                             66 ;;===============================================================================
                             67 ;; DEFINED CONSTANTS
                             68 ;;===============================================================================
                             69 
                             70 ;;tipos de entidades
                     0000    71 e_type_invalid              = 0x00
                             72 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



                             73 ;;tipos de componentes
                             74 ;;tipos de componentes
                     0000    75 e_cmps          = 0
                     0001    76 e_cmps_alive    = 0x01   ;;entidad renderizable
                     0002    77 e_cmps_render   = 0x02   ;;entidad renderizable
                     0004    78 e_cmps_movable  = 0x04   ;;entidad que se puede mover
                     0008    79 e_cmps_input    = 0x08   ;;entidad controlable por input  
                     0010    80 e_cmps_ia       = 0x10   ;;entidad controlable con ia
                     0020    81 e_cmps_animated = 0x20   ;;entidad animada
                     0040    82 e_cmps_collider = 0x40   ;;entidad que puede colisionar
                     0047    83 e_cmps_default = e_cmps_alive | e_cmps_render | e_cmps_movable | e_cmps_collider  ;;componente por defecto
                             84 
                             85 
                             86 ;; Keyboard constants
                     000A    87 BUFFER_SIZE = 10
                     00FF    88 ZERO_KEYS_ACTIVATED = #0xFF
                             89 
                             90 ;; Score constants
                     0004    91 SCORE_NUM_BYTES = 4
                             92 
                             93 ;; SMALL NUMBERS CONSTANTS
                     0002    94 S_SMALL_NUMBERS_WIDTH = 2
                     0005    95 S_SMALL_NUMBERS_HEIGHT = 5
                             96 ;; Font constants
                     0002    97 FONT_WIDTH = 2
                     0009    98 FONT_HEIGHT = 9
                             99 
                            100 ;;===============================================================================
                            101 ;; GLOBAL VARIABLES
                            102 ;;===============================================================================
                            103 .globl entities
                            104 
                            105 
                            106 ;;===============================================================================
                            107 ;; ENTITIY SCTRUCTURE CREATION
                            108 ;;===============================================================================
   0000                     109 BeginStruct e
                     0000     1     e_offset = 0
   0000                     110 Field e, cpms       , 1
                     0000     1     e_cpms = e_offset
                     0001     2     e_offset = e_offset + 1
   0000                     111 Field e, x          , 1
                     0001     1     e_x = e_offset
                     0002     2     e_offset = e_offset + 1
   0000                     112 Field e, y          , 1
                     0002     1     e_y = e_offset
                     0003     2     e_offset = e_offset + 1
   0000                     113 Field e, w          , 1
                     0003     1     e_w = e_offset
                     0004     2     e_offset = e_offset + 1
   0000                     114 Field e, h          , 1
                     0004     1     e_h = e_offset
                     0005     2     e_offset = e_offset + 1
   0000                     115 Field e, vx         , 1
                     0005     1     e_vx = e_offset
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



                     0006     2     e_offset = e_offset + 1
   0000                     116 Field e, vy         , 1
                     0006     1     e_vy = e_offset
                     0007     2     e_offset = e_offset + 1
   0000                     117 Field e, sprite     , 2
                     0007     1     e_sprite = e_offset
                     0009     2     e_offset = e_offset + 2
   0000                     118 Field e, address    , 2
                     0009     1     e_address = e_offset
                     000B     2     e_offset = e_offset + 2
   0000                     119 Field e, p_address  , 2
                     000B     1     e_p_address = e_offset
                     000D     2     e_offset = e_offset + 2
   0000                     120 EndStruct e
                     000D     1     sizeof_e = e_offset
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
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
                             34 .globl man_array_execute_each_matching
                             35 
                             36 ;;===============================================================================
                             37 ;; COMPONENT DEFINITION MACRO
                             38 ;;===============================================================================
                             39 
                             40 
                             41 .macro DefineArray _Tname, _MaxElements, _ComponentSize
                             42       _Tname'_count::                     .db 0
                             43       _Tname'_delta::                     .db 0
                             44       _Tname'_component_size::            .db _ComponentSize
                             45       _Tname'_component_max_number::      .db _MaxElements
                             46       _Tname'_pend::                      .dw _Tname'_array 
                             47       _Tname'_selected::                  .db 0
                             48       _Tname'_array::
                             49             .ds _MaxElements * _ComponentSize
                             50 .endm
                             51 
                             52 ;;===============================================================================
                             53 ;; DATA ARRAY STRUCTURE CREATION
                             54 ;;===============================================================================
   0000                      55 BeginStruct a
                     0000     1     a_offset = 0
   0000                      56 Field a, count , 1
                     0000     1     a_count = a_offset
                     0001     2     a_offset = a_offset + 1
   0000                      57 Field a, delta , 1
                     0001     1     a_delta = a_offset
                     0002     2     a_offset = a_offset + 1
   0000                      58 Field a, component_size , 1
                     0002     1     a_component_size = a_offset
                     0003     2     a_offset = a_offset + 1
   0000                      59 Field a, component_max_number , 1
                     0003     1     a_component_max_number = a_offset
                     0004     2     a_offset = a_offset + 1
   0000                      60 Field a, pend , 2
                     0004     1     a_pend = a_offset
                     0006     2     a_offset = a_offset + 2
   0000                      61 Field a, selected , 1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



                     0006     1     a_selected = a_offset
                     0007     2     a_offset = a_offset + 1
   0000                      62 Field a, array , 1
                     0007     1     a_array = a_offset
                     0008     2     a_offset = a_offset + 1
   0000                      63 EndStruct a
                     0008     1     sizeof_a = a_offset
