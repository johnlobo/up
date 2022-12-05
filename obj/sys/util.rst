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
                                     19 .module sys_util
                                     20 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180 / ZX-Next / eZ80), page 2.
Hexadecimal [24-Bits]



                                     21 .include "../common.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180 / ZX-Next / eZ80), page 3.
Hexadecimal [24-Bits]



                                     55 .globl cpct_drawSolidBox_asm
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180 / ZX-Next / eZ80), page 4.
Hexadecimal [24-Bits]



                                    110     struct'_offset = struct'_offset + size
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180 / ZX-Next / eZ80), page 5.
Hexadecimal [24-Bits]



                                     22 ;;
                                     23 ;; Start of _DATA area 
                                     24 ;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
                                     25 ;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
                                     26 ;;  right after _CODE area contents.
                                     27 ;;
                                     28 .area _DATA
                                     29 
                                     30 
      0019CA 20 20 20 20 20 20 20    31 string_buffer:: .asciz "          "
             20 20 20 00
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
      0015DE                         55 sys_util_h_times_e::
      0015DE 16 00            [ 7]   56   ld d,#0
      0015E0 6A               [ 4]   57   ld l,d
      0015E1 CB 24            [ 8]   58   sla h 
      0015E3 30 01            [12]   59   jr nc,.+3 
      0015E5 6B               [ 4]   60   ld l,e
      0015E6 29               [11]   61   add hl,hl 
      0015E7 30 01            [12]   62   jr nc,.+3 
      0015E9 19               [11]   63   add hl,de
      0015EA 29               [11]   64   add hl,hl 
      0015EB 30 01            [12]   65   jr nc,.+3 
      0015ED 19               [11]   66   add hl,de
      0015EE 29               [11]   67   add hl,hl 
      0015EF 30 01            [12]   68   jr nc,.+3 
      0015F1 19               [11]   69   add hl,de
      0015F2 29               [11]   70   add hl,hl 
      0015F3 30 01            [12]   71   jr nc,.+3 
      0015F5 19               [11]   72   add hl,de
      0015F6 29               [11]   73   add hl,hl 
      0015F7 30 01            [12]   74   jr nc,.+3 
      0015F9 19               [11]   75   add hl,de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180 / ZX-Next / eZ80), page 6.
Hexadecimal [24-Bits]



      0015FA 29               [11]   76   add hl,hl 
      0015FB 30 01            [12]   77   jr nc,.+3 
      0015FD 19               [11]   78   add hl,de
      0015FE 29               [11]   79   add hl,hl 
      0015FF D0               [11]   80   ret nc 
      001600 19               [11]   81   add hl,de
      001601 C9               [10]   82   ret
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
      001602                         97 sys_util_hl_div_c::
      001602 06 10            [ 7]   98        ld b,#16
      001604 AF               [ 4]   99        xor a
      001605 29               [11]  100          add hl,hl
      001606 17               [ 4]  101          rla
      001607 B9               [ 4]  102          cp c
      001608 38 02            [12]  103          jr c,.+4
      00160A 2C               [ 4]  104            inc l
      00160B 91               [ 4]  105            sub c
      00160C 10 F7            [13]  106          djnz .-7
      00160E C9               [10]  107        ret
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
      00160F                        122 sys_util_BCD_GetEnd::
                                    123 ;Some of our commands need to start from the most significant byte
                                    124 ;This will shift HL and DE along b bytes
      00160F C5               [11]  125 	push bc
      001610 48               [ 4]  126 	ld c,b	;We want to add BC, but we need to add one less than the number of bytes
      001611 0D               [ 4]  127 	dec c
      001612 06 00            [ 7]  128 	ld b,#0
      001614 09               [11]  129 	add hl,bc
      001615 EB               [ 4]  130 	ex de, hl	;We've done HL, but we also want to do DE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180 / ZX-Next / eZ80), page 7.
Hexadecimal [24-Bits]



      001616 09               [11]  131 	add hl,bc
      001617 EB               [ 4]  132 	ex de, hl
      001618 C1               [10]  133 	pop bc
      001619 C9               [10]  134 	ret
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
      00161A                        148 sys_util_BCD_Add::
      00161A B7               [ 4]  149     or a
      00161B                        150 BCD_Add_Again:
      00161B 1A               [ 7]  151     ld a, (de)
      00161C 8E               [ 7]  152     adc (hl)
      00161D 27               [ 4]  153     daa
      00161E 12               [ 7]  154     ld (de), a
      00161F 13               [ 6]  155     inc de
      001620 23               [ 6]  156     inc hl
      001621 10 F8            [13]  157     djnz BCD_Add_Again
      001623 C9               [10]  158     ret
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
      001624                        172 sys_util_BCD_Compare::
      001624 06 04            [ 7]  173   ld b, #SCORE_NUM_BYTES
      001626 CD 0F 16         [17]  174   call sys_util_BCD_GetEnd
      001629                        175 BCD_cp_direct:
      001629 1A               [ 7]  176   ld a, (de)
      00162A BE               [ 7]  177   cp (hl)
      00162B D8               [11]  178   ret c
      00162C C0               [11]  179   ret nz
      00162D 1B               [ 6]  180   dec de
      00162E 2B               [ 6]  181   dec hl
      00162F 10 F8            [13]  182   djnz BCD_cp_direct
      001631 B7               [ 4]  183   or a                    ;; Clear carry
      001632 C9               [10]  184   ret
                                    185 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180 / ZX-Next / eZ80), page 8.
Hexadecimal [24-Bits]



                                    186 ;;-----------------------------------------------------------------
                                    187 ;;
                                    188 ;; sys_util_get_random_number
                                    189 ;;
                                    190 ;;  Returns a random number between 0 and <end>
                                    191 ;;  Input:  a: <end>
                                    192 ;;  Output: a: random number
                                    193 ;;  Destroyed: af, bc,de, hl
                                    194 
      001633                        195 sys_util_get_random_number::
      001633 32 3D 16         [13]  196   ld (#random_max_number), a
      001636 CD D9 18         [17]  197   call cpct_getRandom_mxor_u8_asm
      001639 7D               [ 4]  198   ld a, l                             ;; Calculates a pseudo modulus of max number
      00163A 26 00            [ 7]  199   ld h,#0                             ;; Load hl with the random number
                           00005F   200 random_max_number = .+1
      00163C 0E 00            [ 7]  201   ld c, #0                            ;; Load c with the max number
      00163E 06 00            [ 7]  202   ld b, #0
      001640                        203 _random_mod_loop:
      001640 B7               [ 4]  204   or a                                ;; ??
      001641 ED 42            [15]  205   sbc hl,bc                           ;; hl = hl - bc
      001643 F2 40 16         [10]  206   jp p, _random_mod_loop              ;; Jump back if hl > 0
      001646 09               [11]  207   add hl,bc                           ;; Adds MAX_MODEL_CARD to hl back to get back to positive values
      001647 7D               [ 4]  208   ld a,l                              ;; loads the normalized random number in a
      001648 C9               [10]  209 ret
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
      001649                        220 sys_util_delay::
      001649 C5               [11]  221   push bc
      00164A CD 11 19         [17]  222   call cpct_waitVSYNCStart_asm
      00164D C1               [10]  223   pop bc
      00164E 10 F9            [13]  224   djnz sys_util_delay
      001650 C9               [10]  225   ret
