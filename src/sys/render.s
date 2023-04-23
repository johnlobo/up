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
.include "sys/text.h.s"
.include "man/array.h.s"
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

;;-----------------------------------------------------------------
;;
;; sys_render_one_entity
;;
;;  Initilizes render system
;;  Input: ix : pointer to the entity
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;
sys_render_erase_one_entity::
    ld e, e_address(ix)
    ld d, e_address+1(ix)
    ;; Check if address is #0000
    ld a, d
    or e
    ret z

    ld c, e_w(ix)
    ld b, e_h(ix) 
    ld a, #0
    call cpct_drawSolidBox_asm
    ret

;;-----------------------------------------------------------------
;;
;; sys_render_one_entity
;;
;;  Initilizes render system
;;  Input: ix : pointer to the entity
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;
sys_render_update_one_entity::
    ;; check if the entity has been moved
    ld a, e_moved(ix)
    or a
    ret z

    call sys_render_erase_one_entity

    ;; move current address to previous address
    ld a, e_address(ix)
    ld e_p_address(ix), a
    ld a, e_address+1(ix)
    ld e_p_address+1(ix), a

    ld_de_frontbuffer               ;; loads in DE the frontbuffer address
    ld c, e_x(ix)                 ;; get the higher part of the x position
    ld b, e_y(ix)                 ;; get the higher part of the y position
    call cpct_getScreenPtr_asm      ;; Calculate video memory location and return it in HL
    
    ;; move new address to current address
    ld e_address(ix), l
    ld e_address+1(ix), h

    ex de, hl

    ld l, e_sprite(ix)
    ld h, e_sprite+1(ix)
    ld c, e_w(ix)
    ld b, e_h(ix)
    call cpct_drawSprite_asm

    ld e_moved(ix), #0              ;; reset moved flag

    ret

;;-----------------------------------------------------------------
;;
;; sys_render_update
;;
;;  Initilizes render system
;;  Input: 
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;

cmps_render = ( e_cmp_alive | e_cmp_render)
sys_render_update::

    ld hl, #sys_render_update_one_entity
    ld ix, #entities
    ld a, #cmps_render
    call man_array_execute_each_matching

    ret

;;-----------------------------------------------------------------
;;
;; sys_rensys_render_debug_entityder_update
;;
;;  Initilizes render system
;;  Input: 
;;  Output: 
;;  Modified: AF, BC, DE, HL
;;
sys_render_debug_entity::
    push ix
    call man_array_first_element
    push hl
    pop ix
    ;; vx
    cpctm_screenPtr_asm de, 0xc000, 2, 2
    m_draw_blank_small_number       ;; erases previous number
    ld h, #0
    ld l, e_vx(ix)
    ld b, #15                       ;; small number color = 15 
    call sys_text_draw_small_number ;; draws number

    cpctm_screenPtr_asm de, 0xc000, 8, 2
    m_draw_blank_small_number       ;; erases previous number
    ld h, #0
    ld l, e_vx+1(ix)
    ld b, #15                       ;; small number color = 15 
    call sys_text_draw_small_number ;; draws number
    ;; vy
    cpctm_screenPtr_asm de, 0xc000, 2, 8
    m_draw_blank_small_number       ;; erases previous number
    ld h, #0
    ld l, e_vy(ix)
    ld b, #15                       ;; small number color = 15 
    call sys_text_draw_small_number ;; draws number

    cpctm_screenPtr_asm de, 0xc000, 8, 8
    m_draw_blank_small_number       ;; erases previous number
    ld h, #0
    ld l, e_vy+1(ix)
    ld b, #15                       ;; small number color = 15 
    call sys_text_draw_small_number ;; draws number

    pop ix
    ret
    
