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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                            110 ;; Macro
                            111 ;;
                            112 ;; Macro modified from cpctelera cpctm_screenPtr_asm
                            113 ;;===============================================================================
                            114 
                            115 .mdelete m_center_screen_ptr 
                            116 .macro m_center_screen_ptr REG16, VMEM, Y, WIDTH
                            117    ld REG16, #VMEM + 80 * (Y / 8) + 2048 * (Y & 7) + ((80 - WIDTH)/2)   ;; [3] REG16 = screenPtr
                            118 .endm
                            119 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
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
   0C39 20 20 20 20 20 20    31 string_buffer:: .asciz "          "
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
   073C                      55 sys_util_h_times_e::
   073C 16 00         [ 7]   56   ld d,#0
   073E 6A            [ 4]   57   ld l,d
   073F CB 24         [ 8]   58   sla h 
   0741 30 01         [12]   59   jr nc,.+3 
   0743 6B            [ 4]   60   ld l,e
   0744 29            [11]   61   add hl,hl 
   0745 30 01         [12]   62   jr nc,.+3 
   0747 19            [11]   63   add hl,de
   0748 29            [11]   64   add hl,hl 
   0749 30 01         [12]   65   jr nc,.+3 
   074B 19            [11]   66   add hl,de
   074C 29            [11]   67   add hl,hl 
   074D 30 01         [12]   68   jr nc,.+3 
   074F 19            [11]   69   add hl,de
   0750 29            [11]   70   add hl,hl 
   0751 30 01         [12]   71   jr nc,.+3 
   0753 19            [11]   72   add hl,de
   0754 29            [11]   73   add hl,hl 
   0755 30 01         [12]   74   jr nc,.+3 
   0757 19            [11]   75   add hl,de
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]



   0758 29            [11]   76   add hl,hl 
   0759 30 01         [12]   77   jr nc,.+3 
   075B 19            [11]   78   add hl,de
   075C 29            [11]   79   add hl,hl 
   075D D0            [11]   80   ret nc 
   075E 19            [11]   81   add hl,de
   075F C9            [10]   82   ret
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
   0760                      97 sys_util_hl_div_c::
   0760 06 10         [ 7]   98        ld b,#16
   0762 AF            [ 4]   99        xor a
   0763 29            [11]  100          add hl,hl
   0764 17            [ 4]  101          rla
   0765 B9            [ 4]  102          cp c
   0766 38 02         [12]  103          jr c,.+4
   0768 2C            [ 4]  104            inc l
   0769 91            [ 4]  105            sub c
   076A 10 F7         [13]  106          djnz .-7
   076C C9            [10]  107        ret
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
   076D                     122 sys_util_BCD_GetEnd::
                            123 ;Some of our commands need to start from the most significant byte
                            124 ;This will shift HL and DE along b bytes
   076D C5            [11]  125 	push bc
   076E 48            [ 4]  126 	ld c,b	;We want to add BC, but we need to add one less than the number of bytes
   076F 0D            [ 4]  127 	dec c
   0770 06 00         [ 7]  128 	ld b,#0
   0772 09            [11]  129 	add hl,bc
   0773 EB            [ 4]  130 	ex de, hl	;We've done HL, but we also want to do DE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 7.
Hexadecimal [16-Bits]



   0774 09            [11]  131 	add hl,bc
   0775 EB            [ 4]  132 	ex de, hl
   0776 C1            [10]  133 	pop bc
   0777 C9            [10]  134 	ret
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
   0778                     148 sys_util_BCD_Add::
   0778 B7            [ 4]  149     or a
   0779                     150 BCD_Add_Again:
   0779 1A            [ 7]  151     ld a, (de)
   077A 8E            [ 7]  152     adc (hl)
   077B 27            [ 4]  153     daa
   077C 12            [ 7]  154     ld (de), a
   077D 13            [ 6]  155     inc de
   077E 23            [ 6]  156     inc hl
   077F 10 F8         [13]  157     djnz BCD_Add_Again
   0781 C9            [10]  158     ret
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
   0782                     172 sys_util_BCD_Compare::
   0782 06 04         [ 7]  173   ld b, #SCORE_NUM_BYTES
   0784 CD 6D 07      [17]  174   call sys_util_BCD_GetEnd
   0787                     175 BCD_cp_direct:
   0787 1A            [ 7]  176   ld a, (de)
   0788 BE            [ 7]  177   cp (hl)
   0789 D8            [11]  178   ret c
   078A C0            [11]  179   ret nz
   078B 1B            [ 6]  180   dec de
   078C 2B            [ 6]  181   dec hl
   078D 10 F8         [13]  182   djnz BCD_cp_direct
   078F B7            [ 4]  183   or a                    ;; Clear carry
   0790 C9            [10]  184   ret
                            185 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 8.
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
   0791                     195 sys_util_get_random_number::
   0791 32 9B 07      [13]  196   ld (#random_max_number), a
   0794 CD 06 0B      [17]  197   call cpct_getRandom_mxor_u8_asm
   0797 7D            [ 4]  198   ld a, l                             ;; Calculates a pseudo modulus of max number
   0798 26 00         [ 7]  199   ld h,#0                             ;; Load hl with the random number
                     005F   200 random_max_number = .+1
   079A 0E 00         [ 7]  201   ld c, #0                            ;; Load c with the max number
   079C 06 00         [ 7]  202   ld b, #0
   079E                     203 _random_mod_loop:
   079E B7            [ 4]  204   or a                                ;; ??
   079F ED 42         [15]  205   sbc hl,bc                           ;; hl = hl - bc
   07A1 F2 9E 07      [10]  206   jp p, _random_mod_loop              ;; Jump back if hl > 0
   07A4 09            [11]  207   add hl,bc                           ;; Adds MAX_MODEL_CARD to hl back to get back to positive values
   07A5 7D            [ 4]  208   ld a,l                              ;; loads the normalized random number in a
   07A6 C9            [10]  209 ret
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
   07A7                     220 sys_util_delay::
   07A7 C5            [11]  221   push bc
   07A8 CD 96 0B      [17]  222   call cpct_waitVSYNCStart_asm
   07AB C1            [10]  223   pop bc
   07AC 10 F9         [13]  224   djnz sys_util_delay
   07AE C9            [10]  225   ret
