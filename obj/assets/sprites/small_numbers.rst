                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module small_numbers
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _s_small_numbers_09
                             12 	.globl _s_small_numbers_08
                             13 	.globl _s_small_numbers_07
                             14 	.globl _s_small_numbers_06
                             15 	.globl _s_small_numbers_05
                             16 	.globl _s_small_numbers_04
                             17 	.globl _s_small_numbers_03
                             18 	.globl _s_small_numbers_02
                             19 	.globl _s_small_numbers_01
                             20 	.globl _s_small_numbers_00
                             21 ;--------------------------------------------------------
                             22 ; special function registers
                             23 ;--------------------------------------------------------
                             24 ;--------------------------------------------------------
                             25 ; ram data
                             26 ;--------------------------------------------------------
                             27 	.area _DATA
                             28 ;--------------------------------------------------------
                             29 ; ram data
                             30 ;--------------------------------------------------------
                             31 	.area _INITIALIZED
                             32 ;--------------------------------------------------------
                             33 ; absolute external ram data
                             34 ;--------------------------------------------------------
                             35 	.area _DABS (ABS)
                             36 ;--------------------------------------------------------
                             37 ; global & static initialisations
                             38 ;--------------------------------------------------------
                             39 	.area _HOME
                             40 	.area _GSINIT
                             41 	.area _GSFINAL
                             42 	.area _GSINIT
                             43 ;--------------------------------------------------------
                             44 ; Home
                             45 ;--------------------------------------------------------
                             46 	.area _HOME
                             47 	.area _HOME
                             48 ;--------------------------------------------------------
                             49 ; code
                             50 ;--------------------------------------------------------
                             51 	.area _CODE
                             52 	.area _CODE
   0480                      53 _s_small_numbers_00:
   0480 FF                   54 	.db #0xff	; 255
   0481 AA                   55 	.db #0xaa	; 170
   0482 AA                   56 	.db #0xaa	; 170
   0483 AA                   57 	.db #0xaa	; 170
   0484 AA                   58 	.db #0xaa	; 170
   0485 AA                   59 	.db #0xaa	; 170
   0486 AA                   60 	.db #0xaa	; 170
   0487 AA                   61 	.db #0xaa	; 170
   0488 FF                   62 	.db #0xff	; 255
   0489 AA                   63 	.db #0xaa	; 170
   048A                      64 _s_small_numbers_01:
   048A 55                   65 	.db #0x55	; 85	'U'
   048B AA                   66 	.db #0xaa	; 170
   048C 00                   67 	.db #0x00	; 0
   048D AA                   68 	.db #0xaa	; 170
   048E 00                   69 	.db #0x00	; 0
   048F AA                   70 	.db #0xaa	; 170
   0490 00                   71 	.db #0x00	; 0
   0491 AA                   72 	.db #0xaa	; 170
   0492 00                   73 	.db #0x00	; 0
   0493 AA                   74 	.db #0xaa	; 170
   0494                      75 _s_small_numbers_02:
   0494 FF                   76 	.db #0xff	; 255
   0495 AA                   77 	.db #0xaa	; 170
   0496 00                   78 	.db #0x00	; 0
   0497 AA                   79 	.db #0xaa	; 170
   0498 FF                   80 	.db #0xff	; 255
   0499 AA                   81 	.db #0xaa	; 170
   049A AA                   82 	.db #0xaa	; 170
   049B 00                   83 	.db #0x00	; 0
   049C FF                   84 	.db #0xff	; 255
   049D AA                   85 	.db #0xaa	; 170
   049E                      86 _s_small_numbers_03:
   049E FF                   87 	.db #0xff	; 255
   049F AA                   88 	.db #0xaa	; 170
   04A0 00                   89 	.db #0x00	; 0
   04A1 AA                   90 	.db #0xaa	; 170
   04A2 55                   91 	.db #0x55	; 85	'U'
   04A3 AA                   92 	.db #0xaa	; 170
   04A4 00                   93 	.db #0x00	; 0
   04A5 AA                   94 	.db #0xaa	; 170
   04A6 FF                   95 	.db #0xff	; 255
   04A7 AA                   96 	.db #0xaa	; 170
   04A8                      97 _s_small_numbers_04:
   04A8 AA                   98 	.db #0xaa	; 170
   04A9 AA                   99 	.db #0xaa	; 170
   04AA AA                  100 	.db #0xaa	; 170
   04AB AA                  101 	.db #0xaa	; 170
   04AC FF                  102 	.db #0xff	; 255
   04AD AA                  103 	.db #0xaa	; 170
   04AE 00                  104 	.db #0x00	; 0
   04AF AA                  105 	.db #0xaa	; 170
   04B0 00                  106 	.db #0x00	; 0
   04B1 AA                  107 	.db #0xaa	; 170
   04B2                     108 _s_small_numbers_05:
   04B2 FF                  109 	.db #0xff	; 255
   04B3 AA                  110 	.db #0xaa	; 170
   04B4 AA                  111 	.db #0xaa	; 170
   04B5 00                  112 	.db #0x00	; 0
   04B6 FF                  113 	.db #0xff	; 255
   04B7 AA                  114 	.db #0xaa	; 170
   04B8 00                  115 	.db #0x00	; 0
   04B9 AA                  116 	.db #0xaa	; 170
   04BA FF                  117 	.db #0xff	; 255
   04BB AA                  118 	.db #0xaa	; 170
   04BC                     119 _s_small_numbers_06:
   04BC FF                  120 	.db #0xff	; 255
   04BD AA                  121 	.db #0xaa	; 170
   04BE AA                  122 	.db #0xaa	; 170
   04BF 00                  123 	.db #0x00	; 0
   04C0 FF                  124 	.db #0xff	; 255
   04C1 AA                  125 	.db #0xaa	; 170
   04C2 AA                  126 	.db #0xaa	; 170
   04C3 AA                  127 	.db #0xaa	; 170
   04C4 FF                  128 	.db #0xff	; 255
   04C5 AA                  129 	.db #0xaa	; 170
   04C6                     130 _s_small_numbers_07:
   04C6 FF                  131 	.db #0xff	; 255
   04C7 AA                  132 	.db #0xaa	; 170
   04C8 00                  133 	.db #0x00	; 0
   04C9 AA                  134 	.db #0xaa	; 170
   04CA 00                  135 	.db #0x00	; 0
   04CB AA                  136 	.db #0xaa	; 170
   04CC 00                  137 	.db #0x00	; 0
   04CD AA                  138 	.db #0xaa	; 170
   04CE 00                  139 	.db #0x00	; 0
   04CF AA                  140 	.db #0xaa	; 170
   04D0                     141 _s_small_numbers_08:
   04D0 FF                  142 	.db #0xff	; 255
   04D1 AA                  143 	.db #0xaa	; 170
   04D2 AA                  144 	.db #0xaa	; 170
   04D3 AA                  145 	.db #0xaa	; 170
   04D4 FF                  146 	.db #0xff	; 255
   04D5 AA                  147 	.db #0xaa	; 170
   04D6 AA                  148 	.db #0xaa	; 170
   04D7 AA                  149 	.db #0xaa	; 170
   04D8 FF                  150 	.db #0xff	; 255
   04D9 AA                  151 	.db #0xaa	; 170
   04DA                     152 _s_small_numbers_09:
   04DA FF                  153 	.db #0xff	; 255
   04DB AA                  154 	.db #0xaa	; 170
   04DC AA                  155 	.db #0xaa	; 170
   04DD AA                  156 	.db #0xaa	; 170
   04DE FF                  157 	.db #0xff	; 255
   04DF AA                  158 	.db #0xaa	; 170
   04E0 00                  159 	.db #0x00	; 0
   04E1 AA                  160 	.db #0xaa	; 170
   04E2 00                  161 	.db #0x00	; 0
   04E3 AA                  162 	.db #0xaa	; 170
                            163 	.area _INITIALIZER
                            164 	.area _CABS (ABS)
