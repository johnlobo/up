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



                             22 ;;
                             23 ;; Start of _DATA area 
                             24 ;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
                             25 ;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
                             26 ;;  right after _CODE area contents.
                             27 ;;
                             28 .area _DATA
                             29 
                             30 
   1EE1 20 20 20 20 20 20    31 string_buffer:: .asciz "          "
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
   0AA6                      55 sys_util_h_times_e::
   0AA6 16 00         [ 7]   56   ld d,#0
   0AA8 6A            [ 4]   57   ld l,d
   0AA9 CB 24         [ 8]   58   sla h 
   0AAB 30 01         [12]   59   jr nc,.+3 
   0AAD 6B            [ 4]   60   ld l,e
   0AAE 29            [11]   61   add hl,hl 
   0AAF 30 01         [12]   62   jr nc,.+3 
   0AB1 19            [11]   63   add hl,de
   0AB2 29            [11]   64   add hl,hl 
   0AB3 30 01         [12]   65   jr nc,.+3 
   0AB5 19            [11]   66   add hl,de
   0AB6 29            [11]   67   add hl,hl 
   0AB7 30 01         [12]   68   jr nc,.+3 
   0AB9 19            [11]   69   add hl,de
   0ABA 29            [11]   70   add hl,hl 
   0ABB 30 01         [12]   71   jr nc,.+3 
   0ABD 19            [11]   72   add hl,de
   0ABE 29            [11]   73   add hl,hl 
   0ABF 30 01         [12]   74   jr nc,.+3 
   0AC1 19            [11]   75   add hl,de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   0AC2 29            [11]   76   add hl,hl 
   0AC3 30 01         [12]   77   jr nc,.+3 
   0AC5 19            [11]   78   add hl,de
   0AC6 29            [11]   79   add hl,hl 
   0AC7 D0            [11]   80   ret nc 
   0AC8 19            [11]   81   add hl,de
   0AC9 C9            [10]   82   ret
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
   0ACA                      97 sys_util_hl_div_c::
   0ACA 06 10         [ 7]   98        ld b,#16
   0ACC AF            [ 4]   99        xor a
   0ACD 29            [11]  100          add hl,hl
   0ACE 17            [ 4]  101          rla
   0ACF B9            [ 4]  102          cp c
   0AD0 38 02         [12]  103          jr c,.+4
   0AD2 2C            [ 4]  104            inc l
   0AD3 91            [ 4]  105            sub c
   0AD4 10 F7         [13]  106          djnz .-7
   0AD6 C9            [10]  107        ret
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
   0AD7                     122 sys_util_BCD_GetEnd::
                            123 ;Some of our commands need to start from the most significant byte
                            124 ;This will shift HL and DE along b bytes
   0AD7 C5            [11]  125 	push bc
   0AD8 48            [ 4]  126 	ld c,b	;We want to add BC, but we need to add one less than the number of bytes
   0AD9 0D            [ 4]  127 	dec c
   0ADA 06 00         [ 7]  128 	ld b,#0
   0ADC 09            [11]  129 	add hl,bc
   0ADD EB            [ 4]  130 	ex de, hl	;We've done HL, but we also want to do DE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
Hexadecimal [16-Bits]



   0ADE 09            [11]  131 	add hl,bc
   0ADF EB            [ 4]  132 	ex de, hl
   0AE0 C1            [10]  133 	pop bc
   0AE1 C9            [10]  134 	ret
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
   0AE2                     148 sys_util_BCD_Add::
   0AE2 B7            [ 4]  149     or a
   0AE3                     150 BCD_Add_Again:
   0AE3 1A            [ 7]  151     ld a, (de)
   0AE4 8E            [ 7]  152     adc (hl)
   0AE5 27            [ 4]  153     daa
   0AE6 12            [ 7]  154     ld (de), a
   0AE7 13            [ 6]  155     inc de
   0AE8 23            [ 6]  156     inc hl
   0AE9 10 F8         [13]  157     djnz BCD_Add_Again
   0AEB C9            [10]  158     ret
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
   0AEC                     172 sys_util_BCD_Compare::
   0AEC 06 04         [ 7]  173   ld b, #SCORE_NUM_BYTES
   0AEE CD D7 0A      [17]  174   call sys_util_BCD_GetEnd
   0AF1                     175 BCD_cp_direct:
   0AF1 1A            [ 7]  176   ld a, (de)
   0AF2 BE            [ 7]  177   cp (hl)
   0AF3 D8            [11]  178   ret c
   0AF4 C0            [11]  179   ret nz
   0AF5 1B            [ 6]  180   dec de
   0AF6 2B            [ 6]  181   dec hl
   0AF7 10 F8         [13]  182   djnz BCD_cp_direct
   0AF9 B7            [ 4]  183   or a                    ;; Clear carry
   0AFA C9            [10]  184   ret
                            185 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 9.
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
   0AFB                     195 sys_util_get_random_number::
   0AFB 32 05 0B      [13]  196   ld (#random_max_number), a
   0AFE CD 32 1D      [17]  197   call cpct_getRandom_mxor_u8_asm
   0B01 7D            [ 4]  198   ld a, l                             ;; Calculates a pseudo modulus of max number
   0B02 26 00         [ 7]  199   ld h,#0                             ;; Load hl with the random number
                     005F   200 random_max_number = .+1
   0B04 0E 00         [ 7]  201   ld c, #0                            ;; Load c with the max number
   0B06 06 00         [ 7]  202   ld b, #0
   0B08                     203 _random_mod_loop:
   0B08 B7            [ 4]  204   or a                                ;; ??
   0B09 ED 42         [15]  205   sbc hl,bc                           ;; hl = hl - bc
   0B0B F2 08 0B      [10]  206   jp p, _random_mod_loop              ;; Jump back if hl > 0
   0B0E 09            [11]  207   add hl,bc                           ;; Adds MAX_MODEL_CARD to hl back to get back to positive values
   0B0F 7D            [ 4]  208   ld a,l                              ;; loads the normalized random number in a
   0B10 C9            [10]  209 ret
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
   0B11                     220 sys_util_delay::
   0B11 C5            [11]  221   push bc
   0B12 CD C4 1D      [17]  222   call cpct_waitVSYNCStart_asm
   0B15 C1            [10]  223   pop bc
   0B16 10 F9         [13]  224   djnz sys_util_delay
   0B18 C9            [10]  225   ret
