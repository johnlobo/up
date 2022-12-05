;;-----------------------------LICENSE NOTICE------------------------------------
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-------------------------------------------------------------------------------

.module render_system


;;===============================================================================
;; PUBLIC CONSTANTS
;;===============================================================================

;;===============================================================================
;; PUBLIC VARIABLES
;;===============================================================================
.globl sys_render_back_buffer
.globl sys_render_front_buffer
.globl sys_render_touched_zones

.globl transparency_table


;;===============================================================================
;; PUBLIC METHODS
;;===============================================================================
.globl sys_render_init

;;===============================================================================
;; MACRO
;;===============================================================================
.mdelete ld_de_backbuffer
.macro ld_de_backbuffer
   ld   a, (sys_render_back_buffer)          ;; DE = Pointer to start of the screen
   ld   d, a
   ld   e, #00
.endm

.mdelete ld_de_frontbuffer
.macro ld_de_frontbuffer
   ld   a, (sys_render_front_buffer)         ;; DE = Pointer to start of the screen
   ld   d, a
   ld   e, #00
.endm

.mdelete m_screenPtr_backbuffer
.macro m_screenPtr_backbuffer X, Y
   push hl
   ld de, #(80 * (Y / 8) + 2048 * (Y & 7) + X)
   ld a, (sys_render_back_buffer)
   ld h, a
   ld l, #0         
   add hl, de
   ex de, hl
   pop hl
.endm

.mdelete m_screenPtr_frontbuffer
.macro m_screenPtr_frontbuffer X, Y
   push hl
   ld de, #(80 * (Y / 8) + 2048 * (Y & 7) + X)
   ld a, (sys_render_front_buffer)
   ld h, a
   ld l, #0         
   add hl, de
   ex de, hl
   pop hl
.endm


.mdelete m_draw_blank_small_number
.macro m_draw_blank_small_number
   push de
   push hl
   ld c, #5
   ld b, #5
   ld a, #0                         ;; Patern of solid box
   call cpct_drawSolidBox_asm
   pop hl
   pop de
.endm