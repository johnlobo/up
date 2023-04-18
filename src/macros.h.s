;;-----------------------------LICENSE NOTICE------------------------------------
;;
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


;;===============================================================================
;; DEFINED MACROS
;;===============================================================================
.mdelete BeginStruct
.macro BeginStruct struct
    struct'_offset = 0
.endm

.mdelete Field
.macro Field struct, field, size
    struct'_'field = struct'_offset
    struct'_offset = struct'_offset + size
.endm

.mdelete EndStruct
.macro EndStruct struct
    sizeof_'struct = struct'_offset
.endm

;;===============================================================================
;; Macro
;;
;; Macro modified from cpctelera cpctm_screenPtr_asm
;;===============================================================================

.mdelete m_center_screen_ptr 
.macro m_center_screen_ptr REG16, VMEM, Y, WIDTH
   ld REG16, #VMEM + 80 * (Y / 8) + 2048 * (Y & 7) + ((80 - WIDTH)/2)   ;; [3] REG16 = screenPtr
.endm

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
   ld c, #6
   ld b, #5
   ld a, #0                         ;; Patern of solid box
   call cpct_drawSolidBox_asm
   pop hl
   pop de
.endm

;;===============================================================================
;; ENTITY DEFINITION MACRO
;;===============================================================================
.mdelete DefineEntity
.macro DefineEntity _cpms, _x, _y, _w, _h, _vx, _vy, _sprite, _address, _p_address, _moved, _on_platform
    .db _cpms
    .dw _x
    .dw _y
    .db _w
    .db _h
    .dw _vx
    .dw _vy
    .dw _sprite
    .dw _address
    .dw _p_address
    .db _moved
    .db _on_platform
.endm

;;===============================================================================
;; ENTITIY SCTRUCTURE CREATION
;;===============================================================================
BeginStruct e
Field e, cpms           , 1
Field e, x              , 2
Field e, y              , 2
Field e, w              , 1
Field e, h              , 1
Field e, vx             , 2
Field e, vy             , 2
Field e, sprite         , 2
Field e, address        , 2
Field e, p_address      , 2
Field e, moved          , 1
Field e, on_platform    , 1
EndStruct e