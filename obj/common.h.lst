ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180 / ZX-Next / eZ80), page 1.
Hexadecimal [24-Bits]



                                      1 ;;-----------------------------LICENSE NOTICE------------------------------------
                                      2 ;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
                                      3 ;;  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
                                      4 ;;
                                      5 ;;  This program is free software: you can redistribute it and/or modify
                                      6 ;;  it under the terms of the GNU Lesser General Public License as published by
                                      7 ;;  the Free Software Foundation, either version 3 of the License, or
                                      8 ;;  (at your option) any later version.
                                      9 ;;
                                     10 ;;  This program is distributed in the hope that it will be useful,
                                     11 ;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;;  GNU Lesser General Public License for more details.
                                     14 ;;
                                     15 ;;  You should have received a copy of the GNU Lesser General Public License
                                     16 ;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;-------------------------------------------------------------------------------
                                     18 
                                     19 .module main
                                     20 
                                     21 
                                     22 ;;===============================================================================
                                     23 ;; SPRITES
                                     24 ;;===============================================================================
                                     25 .globl _g_palette0
                                     26 .globl _s_font_0
                                     27 .globl _s_small_numbers_00
                                     28 .globl _s_small_numbers_01
                                     29 .globl _s_small_numbers_02
                                     30 .globl _s_small_numbers_03
                                     31 .globl _s_small_numbers_04
                                     32 .globl _s_small_numbers_05
                                     33 .globl _s_small_numbers_06
                                     34 .globl _s_small_numbers_07
                                     35 .globl _s_small_numbers_08
                                     36 .globl _s_small_numbers_09
                                     37 
                                     38 
                                     39 ;;===============================================================================
                                     40 ;; PUBLIC VARIBLES
                                     41 ;;===============================================================================
                                     42 
                                     43 
                                     44 ;;===============================================================================
                                     45 ;; CPCTELERA FUNCTIONS
                                     46 ;;===============================================================================
                                     47 .globl cpct_disableFirmware_asm
                                     48 .globl cpct_getScreenPtr_asm
                                     49 .globl cpct_drawSprite_asm
                                     50 .globl cpct_setVideoMode_asm
                                     51 .globl cpct_setPalette_asm
                                     52 .globl cpct_scanKeyboard_if_asm
                                     53 .globl cpct_isKeyPressed_asm
                                     54 .globl cpct_waitHalts_asm
                                     55 .globl cpct_drawSolidBox_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180 / ZX-Next / eZ80), page 2.
Hexadecimal [24-Bits]



                                     56 .globl cpct_setSeed_mxor_asm
                                     57 .globl cpct_isAnyKeyPressed_asm
                                     58 .globl cpct_setInterruptHandler_asm
                                     59 .globl cpct_waitVSYNC_asm
                                     60 .globl _cpct_keyboardStatusBuffer
                                     61 .globl cpct_getRandom_mxor_u8_asm
                                     62 .globl cpct_px2byteM0_asm
                                     63 .globl cpct_getScreenToSprite_asm
                                     64 .globl cpct_setVideoMemoryPage_asm
                                     65 .globl cpct_waitVSYNCStart_asm
                                     66 .globl cpct_drawSpriteMaskedAlignedTable_asm
                                     67 
                                     68 ;;===============================================================================
                                     69 ;; DEFINED CONSTANTS
                                     70 ;;===============================================================================
                                     71 
                           000000    72 null_ptr = 0x0000
                                     73 
                                     74 ;;tipos de componentes
                           000001    75 e_cmp_render = 0x01     ;;entidad renderizable
                           000002    76 e_cmp_movable = 0x02    ;;entidad que se puede mover
                           000004    77 e_cmp_input = 0x04      ;;entidad controlable por input  
                           000008    78 e_cmp_ia = 0x08         ;;entidad controlable con ia
                           000010    79 e_cmp_animated = 0x10   ;;entidad animada
                           000020    80 e_cmp_collider = 0x20   ;;entidad que puede colisionar
                           000023    81 e_cmp_default = e_cmp_render | e_cmp_movable | e_cmp_collider  ;;componente por defecto
                                     82 
                                     83 ;; Keyboard constants
                           00000A    84 BUFFER_SIZE = 10
                           0000FF    85 ZERO_KEYS_ACTIVATED = #0xFF
                                     86 
                                     87 ;; Score constants
                           000004    88 SCORE_NUM_BYTES = 4
                                     89 
                                     90 ;; Sprites sizes
                           000002    91 S_SMALL_NUMBERS_WIDTH = 2
                           000005    92 S_SMALL_NUMBERS_HEIGHT = 5
                                     93 
                                     94 ;; Font constants
                           000002    95 FONT_WIDTH = 2
                           000009    96 FONT_HEIGHT = 9
                                     97 
                                     98 
                                     99 ;;===============================================================================
                                    100 ;; DEFINED MACROS
                                    101 ;;===============================================================================
                                    102 .mdelete BeginStruct
                                    103 .macro BeginStruct struct
                                    104     struct'_offset = 0
                                    105 .endm
                                    106 
                                    107 .mdelete Field
                                    108 .macro Field struct, field, size
                                    109     struct'_'field = struct'_offset
                                    110     struct'_offset = struct'_offset + size
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180 / ZX-Next / eZ80), page 3.
Hexadecimal [24-Bits]



                                    111 .endm
                                    112 
                                    113 .mdelete EndStruct
                                    114 .macro EndStruct struct
                                    115     sizeof_'struct = struct'_offset
                                    116 .endm
                                    117 
                                    118 .mdelete ld__hl__hl_with_a
                                    119 .macro ld__hl__hl_with_a
                                    120     ld a,(hl)
                                    121     inc hl
                                    122     ld h,(hl)
                                    123     ld l,a
                                    124 .endm
                                    125 
                                    126 .mdelete test_hl_0
                                    127 .macro test_hl_0
                                    128     ld a, l
                                    129     or h
                                    130 .endm
