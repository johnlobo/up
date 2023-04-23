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

.include "map_manager.h.s"
.include "world_manager.h.s"
.include "cmp/entity.h.s"
.include "cpctelera.h.s"

.module Map_Manager

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Initializes the map manager
;;  MODIFIES:
;;      - AF, CB, DE, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_map_set_to_map::
    ;;  (1B C) width	Width in tiles of the view window to be drawn
    ;;  (1B B) height	Height in tiles of the view window to be drawn
    ;;  (2B DE) tilemapWidth	Width in tiles of the complete tilemap
    ;;  (2B HL) tileset	Pointer to the start of the tileset definition (list of 32-byte tiles).
    ld c,  #MAP_W
    ld b,  #MAP_H
    ld de, #MAP_W
    call world_manager_get_current_tileset
    call cpct_etm_setDrawTilemap4x8_ag_asm
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Initializes the map manager to restore
;;  MODIFIES:
;;      - AF, CB, DE, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_map_set_to_restore::
    ;;  (1B C) width	Width in tiles of the view window to be drawn
    ;;  (1B B) height	Height in tiles of the view window to be drawn
    ;;  (2B DE) tilemapWidth	Width in tiles of the complete tilemap
    ;;  (2B HL) tileset	Pointer to the start of the tileset definition (list of 32-byte tiles).
    restore_width = . + 1
    ld c,  #2
    restore_height = . + 1
    ld b,  #3
    ld de, #MAP_W
    call world_manager_get_current_tileset
    call cpct_etm_setDrawTilemap4x8_ag_asm
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Draw the entire tile map
;;  MODIFIES:
;;      - AF, BC, DE, HL, IX, IY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_map_draw::
    ;;  (2B HL) memory	Video memory location where to draw the tilemap (character & 4-byte aligned)
    ;;  (2B DE) tilemap	Pointer to the upper-left tile of the view to be drawn of the tilemap
    ld HL, #0xC000
    call world_manager_get_current_map
    call cpct_etm_drawTilemap4x8_ag_asm
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Draw vieport around the entities coordinates
;;  INPUT:
;;      - IX
;;  MODIFIES:
;;      - AF, BC, DE, HL, IX, IY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_map_restore::
    ld a, e_type(ix)
    and #(e_type_shot | e_type_dead)
    jr z, _no_bullet
    ld a, #2
    ld (restore_height), a
    jr _restore
    _no_bullet:
    ld a, #3
    ld (restore_height), a
    _restore:
    call man_map_set_to_restore
    ;;  (2B DE) screen_start	Pointer to the start of the screen (or a backbuffer)
    ;;  (1B C ) x	[0-79] Byte-aligned column starting from 0 (x coordinate,
    ;;  (1B B ) y	[0-199] row starting from 0 (y coordinate) in bytes)
    ;; RETURN (HL) u8*	Pointer to the (x,*y*) byte in the screen memory that starts at screen_start.
    call man_map_get_view
    ld de, #0xC000
    call cpct_getScreenPtr_asm
    ;;  (2B HL) memory	Video memory location where to draw the tilemap (character & 4-byte aligned)
    ;;  (2B DE) tilemap	Pointer to the upper-left tile of the view to be drawn of the tilemap
    ld b, e_last_x(ix)
    ld c, e_last_y(ix)
    push hl
    call man_map_get_tile
    pop hl
    call cpct_etm_drawTilemap4x8_ag_asm
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Get the first tile to draw of the current map
;;  INPUT:
;;      - B: Coordinate X, C: Coordinate Y
;;  MODIFIES:
;;      - AF, BC, DE: Return tile, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_map_get_tile::
    ;;  tx = x/4
    ;;  ty = y/8
    ;;  tw = tilemap width (20)
    ;;  p = tilemap + ty * tw + tx
    ;; A = ty
    ld a, c
    srl a
    srl a
    srl a
    ;; HL = ty * tw (ty * 20)
    ld h, #0
    ld l, a
    add hl, hl  ;;  HL = 2ty
    add hl, hl  ;;  HL = 4ty
    ld d, h     ;;  DE = 4ty
    ld e, l     ;;
    add hl, hl  ;;  HL = 8ty
    add hl, hl  ;;  HL = 16ty
    add hl, de  ;;  HL = 20ty
    ;; A = tx
    ld a, b
    srl a
    srl a
    ;; HL = ty * tw + tx
    add_hl_a
    call world_manager_get_current_map
    ;; HL = tilemap + ty * tw + tx
    add hl, de
    ex de, hl
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Gets the coordinates to draw the view
;;  INPUT:
;;      - IX
;;  MODIFIES:
;;      - AF, BC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_map_get_view::
    ;; X
    ld a, e_last_x(ix)
    srl a
    srl a
    add a
    add a
    ld c, a
    ;; Y
    ld a, e_last_y(ix)
    srl a
    srl a
    srl a
    add a
    add a
    add a
    ld b, a
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Gets the coordinates to draw tiles
;;  MODIFIES:
;;      - AF, BC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_map_get_tiles_coordinates::
    ;; X / 8
    ld a, e_x(ix)
    srl a
    srl a
    ld c, a
    ;; Y / 8
    ld a, e_y(ix)
    srl a
    srl a
    srl a
    ld b, a
    ret