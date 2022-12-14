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

.include "sys/render.h.s"
.include "common.h.s"
.include "cpctelera.h.s"


;;
;; Start of _DATA area 
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA

FONT_NUMBERS: .dw #0000

sys_render_front_buffer: .db 0xc0
sys_render_back_buffer: .db 0x80
sys_render_touched_zones: .db 0x00

.area _ABS   (ABS)
.org 0x100
transparency_table::
        .db 0xFF, 0xAA, 0x55, 0x00, 0xAA, 0xAA, 0x00, 0x00
        .db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0xAA, 0xAA, 0x00, 0x00, 0xAA, 0xAA, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x55, 0x00, 0x55, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        .db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

;;
;; Start of _CODE area
;; 
.area _CODE

;;====================================================
;; sys_render_init_back_buffer
;;  Initialize screen buffers
;;  Entrada: hl : buffer
;;  Salida:
;;  Destruye: BC, DE, HL
;;
;; Code taken form Miss Input 
;;====================================================
sys_render_clear_buffer::
    ld (hl), #0
    ld d, h
    ld e, l
    inc de
    ld bc, #0x4000-1

    ldir
ret

;;====================================================
;; sys_render_init_back_buffer
;;  Initialize screen buffers
;;  Entrada:
;;  Salida:
;;  Destruye: BC, DE, HL
;;
;; Code taken form Miss Input 
;;====================================================
sys_render_clear_back_buffer::
    ld a, (sys_render_back_buffer)
    ld h, a
    ld l, #0
    call sys_render_clear_buffer
    ret

;;====================================================
;; sys_render_init_back_buffer
;;  Initialize screen buffers
;;  Entrada:
;;  Salida:
;;  Destruye: BC, DE, HL
;;
;; Code taken form Miss Input 
;;====================================================
sys_render_clear_front_buffer::
    ld a, (sys_render_front_buffer)
    ld h, a
    ld l, #0
    call sys_render_clear_buffer
    ret



;;====================================================
;;  sys_render_switch_buffers
;;  
;;  Switches screen buffers
;;  Entrada:
;;  Salida:
;;  Destruye: AF, HL
;;
;; Code taken form Miss Input 
;;====================================================
sys_render_switch_buffers::
    ld hl, (sys_render_front_buffer)    ;; Inicialmente (80C0)
    ld a, l                             ;; Carga el front buffer en el back buffer
    ld (sys_render_back_buffer) , a
    ld a, h                             ;; Carga el back buffer en el front buffer
    ld (sys_render_front_buffer), a
    srl a
    srl a
    ld l, a
    call cpct_waitVSYNC_asm
    jp cpct_setVideoMemoryPage_asm


;;-----------------------------------------------------------------
;;
;; sys_render_init
;;
;;  Initilizes render system
;;  Input: 
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;
sys_render_init::
    
    ld c,#0                                 ;; Set video mode
    call cpct_setVideoMode_asm              ;;
    
    ld hl, #_g_palette0                     ;; Set palette
    ld de, #16                              ;;
    call cpct_setPalette_asm                ;;

    cpctm_setBorder_asm HW_BLACK            ;; Set Border
    ;;cpctm_setBorder_asm HW_WHITE            ;; Set Border

    ;;call sys_render_clear_back_buffer
    call sys_render_clear_front_buffer

    ;;cpctm_clearScreen_asm 0                 ;; Clear screen

    ret
