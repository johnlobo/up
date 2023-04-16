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
                             19 .module game_manager
                             20 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             21 .include "macros.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                             22 
                             23 ;;===============================================================================
                             24 ;; PUBLIC VARIABLES
                             25 ;;===============================================================================
                     000A    26 MAX_ENTITIES = 10
                             27 
                             28 
                             29 ;;===============================================================================
                             30 ;; PUBLIC METHODS
                             31 ;;===============================================================================
                             32 .globl man_game_init
                             33 .globl man_game_update
                             34 
                             35 
                             36 ;;===============================================================================
                             37 ;; CARD DEFINITION MACRO
                             38 ;;===============================================================================
                             39 .macro DefineEntity _cpms, _x, _y, _w, _h, _vx, _vy, _sprite, _address, _p_address
                             40     .db _cpms
                             41     .db _x
                             42     .db _y
                             43     .db _w
                             44     .db _h
                             45     .db _vx
                             46     .db _vy
                             47     .dw _sprite
                             48     .dw _address
                             49     .dw _p_address
                             50 .endm
                             51 
                             52 ;;===============================================================================
                             53 ;; ENTITIY SCTRUCTURE CREATION
                             54 ;;===============================================================================
   0000                      55 BeginStruct e
                     0000     1     e_offset = 0
   0000                      56 Field e, cpms       , 1
                     0000     1     e_cpms = e_offset
                     0001     2     e_offset = e_offset + 1
   0000                      57 Field e, x          , 1
                     0001     1     e_x = e_offset
                     0002     2     e_offset = e_offset + 1
   0000                      58 Field e, y          , 1
                     0002     1     e_y = e_offset
                     0003     2     e_offset = e_offset + 1
   0000                      59 Field e, w          , 1
                     0003     1     e_w = e_offset
                     0004     2     e_offset = e_offset + 1
   0000                      60 Field e, h          , 1
                     0004     1     e_h = e_offset
                     0005     2     e_offset = e_offset + 1
   0000                      61 Field e, vx         , 1
                     0005     1     e_vx = e_offset
                     0006     2     e_offset = e_offset + 1
   0000                      62 Field e, vy         , 1
                     0006     1     e_vy = e_offset
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                     0007     2     e_offset = e_offset + 1
   0000                      63 Field e, sprite     , 2
                     0007     1     e_sprite = e_offset
                     0009     2     e_offset = e_offset + 2
   0000                      64 Field e, address    , 2
                     0009     1     e_address = e_offset
                     000B     2     e_offset = e_offset + 2
   0000                      65 Field e, p_address  , 2
                     000B     1     e_p_address = e_offset
                     000D     2     e_offset = e_offset + 2
   0000                      66 EndStruct e
                     000D     1     sizeof_e = e_offset
