ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
                             19 .module sys_util
                             20 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             21 .include "../common.h.s"
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



                             22 ;;
                             23 ;; Start of _DATA area 
                             24 ;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
                             25 ;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
                             26 ;;  right after _CODE area contents.
                             27 ;;
                             28 .area _DATA
                             29 
                             30 
   1F12 20 20 20 20 20 20    31 string_buffer:: .asciz "          "
        20 20 20 20 00
                             32 
                             33 
                             34 ;;
                             35 ;; Start of _CODE area
                             36 ;; 
                             37 .area _CODE
                             38 
                             39 ;;-----------------------------------------------------------------;; 
                             40 ;;  sys_util_h_times_e
                             41 ;;
                             42 ;; Inputs:
                             43 ;;   H and E
                             44 ;; Outputs:
                             45 ;;   HL is the product
                             46 ;;   D is 0
                             47 ;;   A,E,B,C are preserved
                             48 ;; 36 bytes
                             49 ;; min: 190cc
                             50 ;; max: 242cc
                             51 ;; avg: 216cc
                             52 ;; Credits:
                             53 ;;  Z80Heaven (http://z80-heaven.wikidot.com/advanced-math#toc9)
                             54 
   0AD7                      55 sys_util_h_times_e::
   0AD7 16 00         [ 7]   56   ld d,#0
   0AD9 6A            [ 4]   57   ld l,d
   0ADA CB 24         [ 8]   58   sla h 
   0ADC 30 01         [12]   59   jr nc,.+3 
   0ADE 6B            [ 4]   60   ld l,e
   0ADF 29            [11]   61   add hl,hl 
   0AE0 30 01         [12]   62   jr nc,.+3 
   0AE2 19            [11]   63   add hl,de
   0AE3 29            [11]   64   add hl,hl 
   0AE4 30 01         [12]   65   jr nc,.+3 
   0AE6 19            [11]   66   add hl,de
   0AE7 29            [11]   67   add hl,hl 
   0AE8 30 01         [12]   68   jr nc,.+3 
   0AEA 19            [11]   69   add hl,de
   0AEB 29            [11]   70   add hl,hl 
   0AEC 30 01         [12]   71   jr nc,.+3 
   0AEE 19            [11]   72   add hl,de
   0AEF 29            [11]   73   add hl,hl 
   0AF0 30 01         [12]   74   jr nc,.+3 
   0AF2 19            [11]   75   add hl,de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 10.
Hexadecimal [16-Bits]



   0AF3 29            [11]   76   add hl,hl 
   0AF4 30 01         [12]   77   jr nc,.+3 
   0AF6 19            [11]   78   add hl,de
   0AF7 29            [11]   79   add hl,hl 
   0AF8 D0            [11]   80   ret nc 
   0AF9 19            [11]   81   add hl,de
   0AFA C9            [10]   82   ret
                             83 
                             84 ;;-----------------------------------------------------------------;; 
                             85 ;;  sys_util_h_times_e
                             86 ;;
                             87 ;;Inputs:
                             88 ;;     HL is the numerator
                             89 ;;     C is the denominator
                             90 ;;Outputs:
                             91 ;;     A is the remainder
                             92 ;;     B is 0
                             93 ;;     C is not changed
                             94 ;;     DE is not changed
                             95 ;;     HL is the quotient
                             96 ;;
   0AFB                      97 sys_util_hl_div_c::
   0AFB 06 10         [ 7]   98        ld b,#16
   0AFD AF            [ 4]   99        xor a
   0AFE 29            [11]  100          add hl,hl
   0AFF 17            [ 4]  101          rla
   0B00 B9            [ 4]  102          cp c
   0B01 38 02         [12]  103          jr c,.+4
   0B03 2C            [ 4]  104            inc l
   0B04 91            [ 4]  105            sub c
   0B05 10 F7         [13]  106          djnz .-7
   0B07 C9            [10]  107        ret
                            108 
                            109 ;;-----------------------------------------------------------------
                            110 ;;
                            111 ;; sys_util_BCD_GetEnd
                            112 ;;
                            113 ;;  
                            114 ;;  Input:  b: number of bytes of the bcd number
                            115 ;;          de: source for the first bcd bnumber
                            116 ;;          hl: source for the second bcd number
                            117 ;;  Output: 
                            118 ;;  Destroyed: af, bc,de, hl
                            119 ;;
                            120 ;;  Chibi Akumas BCD code (https://www.chibiakumas.com/z80/advanced.php#LessonA1)
                            121 ;;
   0B08                     122 sys_util_BCD_GetEnd::
                            123 ;Some of our commands need to start from the most significant byte
                            124 ;This will shift HL and DE along b bytes
   0B08 C5            [11]  125 	push bc
   0B09 48            [ 4]  126 	ld c,b	;We want to add BC, but we need to add one less than the number of bytes
   0B0A 0D            [ 4]  127 	dec c
   0B0B 06 00         [ 7]  128 	ld b,#0
   0B0D 09            [11]  129 	add hl,bc
   0B0E EB            [ 4]  130 	ex de, hl	;We've done HL, but we also want to do DE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 11.
Hexadecimal [16-Bits]



   0B0F 09            [11]  131 	add hl,bc
   0B10 EB            [ 4]  132 	ex de, hl
   0B11 C1            [10]  133 	pop bc
   0B12 C9            [10]  134 	ret
                            135 
                            136 ;;-----------------------------------------------------------------
                            137 ;;
                            138 ;; BCD_Add
                            139 ;;
                            140 ;;   Add two BCD numbers
                            141 ;;  Input:  hl: Number to add to de
                            142 ;;          de: Number to store the sum 
                            143 ;;  Output: 
                            144 ;;  Destroyed: af, bc,de, hl
                            145 ;;
                            146 ;;  Chibi Akumas BCD code (https://www.chibiakumas.com/z80/advanced.php#LessonA1)
                            147 ;;
   0B13                     148 sys_util_BCD_Add::
   0B13 B7            [ 4]  149     or a
   0B14                     150 BCD_Add_Again:
   0B14 1A            [ 7]  151     ld a, (de)
   0B15 8E            [ 7]  152     adc (hl)
   0B16 27            [ 4]  153     daa
   0B17 12            [ 7]  154     ld (de), a
   0B18 13            [ 6]  155     inc de
   0B19 23            [ 6]  156     inc hl
   0B1A 10 F8         [13]  157     djnz BCD_Add_Again
   0B1C C9            [10]  158     ret
                            159   
                            160 ;;-----------------------------------------------------------------
                            161 ;;
                            162 ;; sys_util_BCD_Compare
                            163 ;;
                            164 ;;  Compare two BCD numbers
                            165 ;;  Input:  hl: BCD Number 1
                            166 ;;          de: BCD Number 2
                            167 ;;  Output: 
                            168 ;;  Destroyed: af, bc,de, hl
                            169 ;;
                            170 ;;  Chibi Akumas BCD code (https://www.chibiakumas.com/z80/advanced.php#LessonA1)
                            171 ;;
   0B1D                     172 sys_util_BCD_Compare::
   0B1D 06 04         [ 7]  173   ld b, #SCORE_NUM_BYTES
   0B1F CD 08 0B      [17]  174   call sys_util_BCD_GetEnd
   0B22                     175 BCD_cp_direct:
   0B22 1A            [ 7]  176   ld a, (de)
   0B23 BE            [ 7]  177   cp (hl)
   0B24 D8            [11]  178   ret c
   0B25 C0            [11]  179   ret nz
   0B26 1B            [ 6]  180   dec de
   0B27 2B            [ 6]  181   dec hl
   0B28 10 F8         [13]  182   djnz BCD_cp_direct
   0B2A B7            [ 4]  183   or a                    ;; Clear carry
   0B2B C9            [10]  184   ret
                            185 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 12.
Hexadecimal [16-Bits]



                            186 ;;-----------------------------------------------------------------
                            187 ;;
                            188 ;; sys_util_get_random_number
                            189 ;;
                            190 ;;  Returns a random number between 0 and <end>
                            191 ;;  Input:  a: <end>
                            192 ;;  Output: a: random number
                            193 ;;  Destroyed: af, bc,de, hl
                            194 
   0B2C                     195 sys_util_get_random_number::
   0B2C 32 36 0B      [13]  196   ld (#random_max_number), a
   0B2F CD 63 1D      [17]  197   call cpct_getRandom_mxor_u8_asm
   0B32 7D            [ 4]  198   ld a, l                             ;; Calculates a pseudo modulus of max number
   0B33 26 00         [ 7]  199   ld h,#0                             ;; Load hl with the random number
                     005F   200 random_max_number = .+1
   0B35 0E 00         [ 7]  201   ld c, #0                            ;; Load c with the max number
   0B37 06 00         [ 7]  202   ld b, #0
   0B39                     203 _random_mod_loop:
   0B39 B7            [ 4]  204   or a                                ;; ??
   0B3A ED 42         [15]  205   sbc hl,bc                           ;; hl = hl - bc
   0B3C F2 39 0B      [10]  206   jp p, _random_mod_loop              ;; Jump back if hl > 0
   0B3F 09            [11]  207   add hl,bc                           ;; Adds MAX_MODEL_CARD to hl back to get back to positive values
   0B40 7D            [ 4]  208   ld a,l                              ;; loads the normalized random number in a
   0B41 C9            [10]  209 ret
                            210 
                            211 ;;-----------------------------------------------------------------
                            212 ;;
                            213 ;; sys_util_delay
                            214 ;;
                            215 ;;  Waits a determined number of frames 
                            216 ;;  Input:  b: number of frames
                            217 ;;  Output: 
                            218 ;;  Destroyed: af, bc
                            219 ;;
   0B42                     220 sys_util_delay::
   0B42 C5            [11]  221   push bc
   0B43 CD F5 1D      [17]  222   call cpct_waitVSYNCStart_asm
   0B46 C1            [10]  223   pop bc
   0B47 10 F9         [13]  224   djnz sys_util_delay
   0B49 C9            [10]  225   ret
