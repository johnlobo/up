                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Mac OS X ppc)
                                      4 ;--------------------------------------------------------
                                      5 	.module g_palette0
                                      6 	.optsdcc -mz80
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _g_palette0
                                     12 ;--------------------------------------------------------
                                     13 ; special function registers
                                     14 ;--------------------------------------------------------
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area _DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area _INITIALIZED
                                     23 ;--------------------------------------------------------
                                     24 ; absolute external ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area _DABS (ABS)
                                     27 ;--------------------------------------------------------
                                     28 ; global & static initialisations
                                     29 ;--------------------------------------------------------
                                     30 	.area _HOME
                                     31 	.area _GSINIT
                                     32 	.area _GSFINAL
                                     33 	.area _GSINIT
                                     34 ;--------------------------------------------------------
                                     35 ; Home
                                     36 ;--------------------------------------------------------
                                     37 	.area _HOME
                                     38 	.area _HOME
                                     39 ;--------------------------------------------------------
                                     40 ; code
                                     41 ;--------------------------------------------------------
                                     42 	.area _CODE
                                     43 	.area _CODE
      0005B2                         44 _g_palette0:
      0005B2 54                      45 	.db #0x54	; 84	'T'
      0005B3 4D                      46 	.db #0x4d	; 77	'M'
      0005B4 40                      47 	.db #0x40	; 64
      0005B5 5C                      48 	.db #0x5c	; 92
      0005B6 4C                      49 	.db #0x4c	; 76	'L'
      0005B7 4E                      50 	.db #0x4e	; 78	'N'
      0005B8 4A                      51 	.db #0x4a	; 74	'J'
      0005B9 47                      52 	.db #0x47	; 71	'G'
      0005BA 56                      53 	.db #0x56	; 86	'V'
      0005BB 5E                      54 	.db #0x5e	; 94
      0005BC 53                      55 	.db #0x53	; 83	'S'
      0005BD 5F                      56 	.db #0x5f	; 95
      0005BE 55                      57 	.db #0x55	; 85	'U'
      0005BF 58                      58 	.db #0x58	; 88	'X'
      0005C0 44                      59 	.db #0x44	; 68	'D'
      0005C1 4B                      60 	.db #0x4b	; 75	'K'
                                     61 	.area _INITIALIZER
                                     62 	.area _CABS (ABS)
