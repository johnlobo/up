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
                             15 
                             16 .module render_system
                             17 
                             18 
                             19 ;;===============================================================================
                             20 ;; PUBLIC CONSTANTS
                             21 ;;===============================================================================
                             22 
                             23 ;;===============================================================================
                             24 ;; PUBLIC VARIABLES
                             25 ;;===============================================================================
                             26 .globl sys_render_back_buffer
                             27 .globl sys_render_front_buffer
                             28 .globl sys_render_touched_zones
                             29 
                             30 .globl transparency_table
                             31 
                             32 
                             33 ;;===============================================================================
                             34 ;; PUBLIC METHODS
                             35 ;;===============================================================================
                             36 .globl sys_render_init
                             37 
                             38 ;;===============================================================================
                             39 ;; MACRO
                             40 ;;===============================================================================
                             41 .mdelete ld_de_backbuffer
                             42 .macro ld_de_backbuffer
                             43    ld   a, (sys_render_back_buffer)          ;; DE = Pointer to start of the screen
                             44    ld   d, a
                             45    ld   e, #00
                             46 .endm
                             47 
                             48 .mdelete ld_de_frontbuffer
                             49 .macro ld_de_frontbuffer
                             50    ld   a, (sys_render_front_buffer)         ;; DE = Pointer to start of the screen
                             51    ld   d, a
                             52    ld   e, #00
                             53 .endm
                             54 
                             55 .mdelete m_screenPtr_backbuffer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                             56 .macro m_screenPtr_backbuffer X, Y
                             57    push hl
                             58    ld de, #(80 * (Y / 8) + 2048 * (Y & 7) + X)
                             59    ld a, (sys_render_back_buffer)
                             60    ld h, a
                             61    ld l, #0         
                             62    add hl, de
                             63    ex de, hl
                             64    pop hl
                             65 .endm
                             66 
                             67 .mdelete m_screenPtr_frontbuffer
                             68 .macro m_screenPtr_frontbuffer X, Y
                             69    push hl
                             70    ld de, #(80 * (Y / 8) + 2048 * (Y & 7) + X)
                             71    ld a, (sys_render_front_buffer)
                             72    ld h, a
                             73    ld l, #0         
                             74    add hl, de
                             75    ex de, hl
                             76    pop hl
                             77 .endm
                             78 
                             79 
                             80 .mdelete m_draw_blank_small_number
                             81 .macro m_draw_blank_small_number
                             82    push de
                             83    push hl
                             84    ld c, #5
                             85    ld b, #5
                             86    ld a, #0                         ;; Patern of solid box
                             87    call cpct_drawSolidBox_asm
                             88    pop hl
                             89    pop de
                             90 .endm
