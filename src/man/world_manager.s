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


;;
;;  MAP MANAGER
;;
.module Level_Manager
.include "man/world_manager.h.s"
.include "man/hud_manager.h.s"
.include "man/map_manager.h.s"
.include "man/game_manager.h.s"
.include "man/entity_manager.h.s"
.include "man/entity_manager.h.s"
.include "sys/ai_control_system.h.s"
.include "cmp/entity.h.s"

.globl cpct_zx7b_decrunch_s_asm

current_map:          .dw world_1_map_00
current_tileset:      .dw tileset_1
map_index:            .db 0
level_index:          .db 1
pieces_index:         .db 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Decompresses the maps and the tileset
;;  MODIFIES:
;;      - A, BC, DE, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_init::
    ;;ld hl, #_world_z_end
    ;;ld de, #decompress_location
    ;;call cpct_zx7b_decrunch_s_asm
    ;;call map_manager_set_to_map
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Init maps and tileset based on the level index
;;  MODIFIES:
;;      - A, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_init_level::
;;    call entity_manager_getPlayerPositionIY
;;    ld a, (level_index)
;;    dec a
;;    jr z, _level_1
;;    dec a
;;    jr z, _level_2
;;    dec a
;;    jr z, _level_3
;;_level_1:
;;    ld e_x(iy), #32
;;    ld e_y(iy), #40
;;    call world_manager_init_level_1
;;    ld hl, #world_1_map_00
;;    call world_manager_update_map
;;    ld hl, #tileset_1
;;    call world_manager_update_current_tileset
;;    ret
;;_level_2:
;;    ld e_x(iy), #39
;;    ld e_y(iy), #100
;;    call world_manager_init_level_2
;;    ld hl, #world_2_map_00
;;    call world_manager_update_map
;;    ld hl, #tileset_2
;;    call world_manager_update_current_tileset
;;    ret
;;_level_3:
;;    ld e_x(iy), #39
;;    ld e_y(iy), #80
;;    call world_manager_init_level_3
;;    ld hl, #world_3_map_00
;;    call world_manager_update_map
;;    ld hl, #tileset_3
;;    call world_manager_update_current_tileset
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Init level 1 maps
;;  MODIFIES:
;;      - A, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_init_level_1::
;;    ;; To map 00
;;    ld a, #0
;;    ld hl, #world_1_map_00
;;    ld (_01_up_map), hl
;;    ld (_01_up_index), a
;;    ld (_04_right_map), hl
;;    ld (_04_right_index), a
;;    ld (_07_down_map), hl
;;    ld (_07_down_index), a
;;    ;; To map 01
;;    inc a
;;    ld hl, #world_1_map_01
;;    ld (_00_down_map), hl
;;    ld (_00_down_index), a
;;    ld (_03_left_map), hl
;;    ld (_03_left_index), a
;;    ld (_05_up_map), hl
;;    ld (_05_up_index), a
;;    ;; To map 02
;;    inc a
;;    ld hl, #world_1_map_02
;;    ld (_03_up_map), hl
;;    ld (_03_up_index), a
;;    ld (_13_down_map), hl
;;    ld (_13_down_index), a
;;    ;; To map 03
;;    inc a
;;    ld hl, #world_1_map_03
;;    ld (_01_right_map), hl
;;    ld (_01_right_index), a
;;    ld (_02_down_map), hl
;;    ld (_02_down_index), a
;;    ld (_06_up_map), hl
;;    ld (_06_up_index), a
;;    ;; To map 04
;;    inc a
;;    ld hl, #world_1_map_04
;;    ld (_00_left_map), hl
;;    ld (_00_left_index), a
;;    ld (_08_right_map), hl
;;    ld (_08_right_index), a
;;    ld (_09_up_map), hl
;;    ld (_09_up_index), a
;;    ;; To map 05
;;    inc a
;;    ld hl, #world_1_map_05
;;    ld (_01_down_map), hl
;;    ld (_01_down_index), a
;;    ;; To map 06
;;    inc a
;;    ld hl, #world_1_map_06
;;    ld (_03_down_map), hl
;;    ld (_03_down_index), a
;;    ;; To map 07
;;    inc a
;;    ld hl, #world_1_map_07
;;    ld (_00_up_map), hl
;;    ld (_00_up_index), a
;;    ld (_13_left_map), hl
;;    ld (_13_left_index), a
;;    ;; To map 08
;;    inc a
;;    ld hl, #world_1_map_08
;;    ld (_04_left_map), hl
;;    ld (_04_left_index), a
;;    ld (_10_up_map), hl
;;    ld (_10_up_index), a
;;    ;; To map 09
;;    inc a
;;    ld hl, #world_1_map_09
;;    ld (_04_down_map), hl
;;    ld (_04_down_index), a
;;    ld (_12_up_map), hl
;;    ld (_12_up_index), a
;;    ;; To map 10
;;    inc a
;;    ld hl, #world_1_map_10
;;    ld (_08_down_map), hl
;;    ld (_08_down_index), a
;;    ld (_11_up_map), hl
;;    ld (_11_up_index), a
;;    ;; To map 11
;;    inc a
;;    ld hl, #world_1_map_11
;;    ld (_10_down_map), hl
;;    ld (_10_down_index), a
;;    ld (_12_left_map), hl
;;    ld (_12_left_index), a
;;    ;; To map 12
;;    inc a
;;    ld hl, #world_1_map_12
;;    ld (_09_down_map), hl
;;    ld (_09_down_index), a
;;    ld (_11_right_map), hl
;;    ld (_11_right_index), a
;;    ;; To map 13
;;    inc a
;;    ld hl, #world_1_map_13
;;    ld (_02_up_map), hl
;;    ld (_02_up_index), a
;;    ld (_07_right_map), hl
;;    ld (_07_right_index), a
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Init level 2 maps
;;  MODIFIES:
;;      - A, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_init_level_2::
;;    ;; To map 00
;;    ld a, #0
;;    ld hl, #world_2_map_00
;;    ld (_01_right_map), hl
;;    ld (_01_right_index), a
;;    ld (_07_up_map), hl
;;    ld (_07_up_index), a
;;    ld (_08_left_map), hl
;;    ld (_08_left_index), a
;;    ld (_10_down_map), hl
;;    ld (_10_down_index), a
;;    ;; To map 01
;;    inc a
;;    ld hl, #world_2_map_01
;;    ld (_00_left_map), hl
;;    ld (_00_left_index), a
;;    ld (_02_right_map), hl
;;    ld (_02_right_index), a
;;    ld (_04_down_map), hl
;;    ld (_04_down_index), a
;;    ;; To map 02
;;    inc a
;;    ld hl, #world_2_map_02
;;    ld (_01_left_map), hl
;;    ld (_01_left_index), a
;;    ld (_03_down_map), hl
;;    ld (_03_down_index), a
;;    ld (_05_up_map), hl
;;    ld (_05_up_index), a
;;    ;; To map 03
;;    inc a
;;    ld hl, #world_2_map_03
;;    ld (_02_up_map), hl
;;    ld (_02_up_index), a
;;    ld (_04_left_map), hl
;;    ld (_04_left_index), a
;;    ;; To map 04
;;    inc a
;;    ld hl, #world_2_map_04
;;    ld (_01_up_map), hl
;;    ld (_01_up_index), a
;;    ld (_03_right_map), hl
;;    ld (_03_right_index), a
;;    ;; To map 05
;;    inc a
;;    ld hl, #world_2_map_05
;;    ld (_02_down_map), hl
;;    ld (_02_down_index), a
;;    ld (_06_left_map), hl
;;    ld (_06_left_index), a
;;    ;; To map 06
;;    inc a
;;    ld hl, #world_2_map_06
;;    ld (_05_right_map), hl
;;    ld (_05_right_index), a
;;    ld (_07_left_map), hl
;;    ld (_07_left_index), a
;;    ;; To map 07
;;    inc a
;;    ld hl, #world_2_map_07
;;    ld (_00_down_map), hl
;;    ld (_00_down_index), a
;;    ld (_06_right_map), hl
;;    ld (_06_right_index), a
;;    ld (_09_left_map), hl
;;    ld (_09_left_index), a
;;    ;; To map 08
;;    inc a
;;    ld hl, #world_2_map_08
;;    ld (_00_right_map), hl
;;    ld (_00_right_index), a
;;    ld (_09_up_map), hl
;;    ld (_09_up_index), a
;;    ld (_11_down_map), hl
;;    ld (_11_down_index), a
;;    ;; To map 09
;;    inc a
;;    ld hl, #world_2_map_09
;;    ld (_07_right_map), hl
;;    ld (_07_right_index), a
;;    ld (_08_down_map), hl
;;    ld (_08_down_index), a
;;    ;; To map 10
;;    inc a
;;    ld hl, #world_2_map_10
;;    ld (_00_up_map), hl
;;    ld (_00_up_index), a
;;    ld (_11_left_map), hl
;;    ld (_11_left_index), a
;;    ;; To map 11
;;    inc a
;;    ld hl, #world_2_map_11
;;    ld (_08_up_map), hl
;;    ld (_08_up_index), a
;;    ld (_10_right_map), hl
;;    ld (_10_right_index), a
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Init level 3 maps
;;  MODIFIES:
;;      - A, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_init_level_3::
;;    ;; To map 00
;;    ld a, #0
;;    ld hl, #world_3_map_00
;;    ld (_01_left_map), hl
;;    ld (_01_left_index), a
;;    ;; To map 01
;;    inc a
;;    ld hl, #world_3_map_01
;;    ld (_00_right_map), hl
;;    ld (_00_right_index), a
;;    ld (_02_up_map), hl
;;    ld (_02_up_index), a
;;    ld (_05_left_map), hl
;;    ld (_05_left_index), a
;;    ld (_07_down_map), hl
;;    ld (_07_down_index), a
;;    ;; To map 02
;;    inc a
;;    ld hl, #world_3_map_02
;;    ld (_01_down_map), hl
;;    ld (_01_down_index), a
;;    ld (_03_left_map), hl
;;    ld (_03_left_index), a
;;    ;; To map 03
;;    inc a
;;    ld hl, #world_3_map_03
;;    ld (_02_right_map), hl
;;    ld (_02_right_index), a
;;    ;; To map 04
;;    inc a
;;    ld hl, #world_3_map_04
;;    ld (_07_right_map), hl
;;    ld (_07_right_index), a
;;    ;; To map 05
;;    inc a
;;    ld hl, #world_3_map_05
;;    ld (_01_right_map), hl
;;    ld (_01_right_index), a
;;    ld (_06_left_map), hl
;;    ld (_06_left_index), a
;;    ;; To map 06
;;    inc a
;;    ld hl, #world_3_map_06
;;    ld (_05_right_map), hl
;;    ld (_05_right_index), a
;;    ;; To map 07
;;    inc a
;;    ld hl, #world_3_map_07
;;    ld (_01_up_map), hl
;;    ld (_01_up_index), a
;;    ld (_04_left_map), hl
;;    ld (_04_left_index), a
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Resets the current map, tileset and map_index
;;  MODIFIES:
;;      - A, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_reset::
;;    ld hl, #world_1_map_00
;;    ld (current_map), hl
;;    ld hl, #tileset_1
;;    ld (current_tileset), hl
;;    ld a, #0
;;    ld (map_index), a
;;    ld (pieces_index), a
;;    inc a
;;    ld (level_index), a
;;    call world_manager_reset_doors_and_pieces
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Loads the next map based on the current map index
;;  INPUT:
;;      - B: The tile of the edge
;;  MODIFIES:
;;      - A, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_load_next_map_right::
;;    ld a, (map_index)
;;    or a
;;    jr z, _map_00_r
;;    dec a
;;    jr z, _map_01_r
;;    dec a
;;    jr z, _map_02_r
;;    dec a
;;    jr z, _map_03_r
;;    dec a
;;    jr z, _map_04_r
;;    dec a
;;    jr z, _map_05_r
;;    dec a
;;    jr z, _map_06_r
;;    dec a
;;    jr z, _map_07_r
;;    dec a
;;    jr z, _map_08_r
;;    dec a
;;    jr z, _map_09_r
;;    dec a
;;    jr z, _map_10_r
;;    dec a
;;    jr z, _map_11_r
;;    dec a
;;    jr z, _map_12_r
;;    dec a
;;    jr z, _map_13_r
;;_map_00_r:
;;    _00_right_map = . + 1
;;    ld hl, #0
;;    _00_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_01_r:
;;    _01_right_map = . + 1
;;    ld hl, #0
;;    _01_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_02_r:
;;    
;;    _02_right_map = . + 1
;;    ld hl, #0
;;    _02_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_03_r:
;;    
;;    _03_right_map = . + 1
;;    ld hl, #0
;;    _03_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_04_r:
;;    _04_right_map = . + 1
;;    ld hl, #0
;;    _04_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_05_r:
;;    
;;    _05_right_map = . + 1
;;    ld hl, #0
;;    _05_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_06_r:
;;    
;;    _06_right_map = . + 1
;;    ld hl, #0
;;    _06_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_07_r:
;;    _07_right_map = . + 1
;;    ld hl, #0
;;    _07_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_08_r:
;;    _08_right_map = . + 1
;;    ld hl, #0
;;    _08_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_09_r:
;;    
;;    _09_right_map = . + 1
;;    ld hl, #0
;;    _09_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_10_r:
;;    
;;    _10_right_map = . + 1
;;    ld hl, #0
;;    _10_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_11_r:
;;    _11_right_map = . + 1
;;    ld hl, #0
;;    _11_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_12_r:
;;    
;;    _12_right_map = . + 1
;;    ld hl, #0
;;    _12_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_13_r:
;;    
;;    _13_right_map = . + 1
;;    ld hl, #0
;;    _13_right_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Loads the next map based on the current map index
;;  INPUT:
;;      - B: The tile of the edge
;;  MODIFIES:
;;      - A, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_load_next_map_left::
;;    ld a, (map_index)
;;    or a
;;    jr z, _map_00_l
;;    dec a
;;    jr z, _map_01_l
;;    dec a
;;    jr z, _map_02_l
;;    dec a
;;    jr z, _map_03_l
;;    dec a
;;    jr z, _map_04_l
;;    dec a
;;    jr z, _map_05_l
;;    dec a
;;    jr z, _map_06_l
;;    dec a
;;    jr z, _map_07_l
;;    dec a
;;    jr z, _map_08_l
;;    dec a
;;    jr z, _map_09_l
;;    dec a
;;    jr z, _map_10_l
;;    dec a
;;    jr z, _map_11_l
;;    dec a
;;    jr z, _map_12_l
;;    dec a
;;    jr z, _map_13_l
;;_map_00_l:
;;    _00_left_map = . + 1
;;    ld hl, #0
;;    _00_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_01_l:   
;;    _01_left_map = . + 1
;;    ld hl, #0
;;    _01_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_02_l:    
;;    _02_left_map = . + 1
;;    ld hl, #0
;;    _02_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_03_l:
;;    _03_left_map = . + 1
;;    ld hl, #0
;;    _03_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_04_l:
;;    _04_left_map = . + 1
;;    ld hl, #0
;;    _04_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_05_l:   
;;    _05_left_map = . + 1
;;    ld hl, #0
;;    _05_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_06_l:    
;;    _06_left_map = . + 1
;;    ld hl, #0
;;    _06_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_07_l:    
;;    _07_left_map = . + 1
;;    ld hl, #0
;;    _07_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_08_l:  
;;    _08_left_map = . + 1
;;    ld hl, #0
;;    _08_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_09_l:   
;;    _09_left_map = . + 1
;;    ld hl, #0
;;    _09_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_10_l:    
;;    _10_left_map = . + 1
;;    ld hl, #0
;;    _10_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_11_l:  
;;    _11_left_map = . + 1
;;    ld hl, #0
;;    _11_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_12_l:
;;    _12_left_map = . + 1
;;    ld hl, #0
;;    _12_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_13_l:
;;    _13_left_map = . + 1
;;    ld hl, #0
;;    _13_left_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Loads the next map based on the current map index
;;  INPUT:
;;      - B: The tile of the edge
;;  MODIFIES:
;;      - A, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_load_next_map_up::
;;    ld a, (map_index)
;;    or a
;;    jr z, _map_00_u
;;    dec a
;;    jr z, _map_01_u
;;    dec a
;;    jr z, _map_02_u
;;    dec a
;;    jr z, _map_03_u
;;    dec a
;;    jr z, _map_04_u
;;    dec a
;;    jr z, _map_05_u
;;    dec a
;;    jr z, _map_06_u
;;    dec a
;;    jr z, _map_07_u
;;    dec a
;;    jr z, _map_08_u
;;    dec a
;;    jr z, _map_09_u
;;    dec a
;;    jr z, _map_10_u
;;    dec a
;;    jr z, _map_11_u
;;    dec a
;;    jr z, _map_12_u
;;    dec a
;;    jr z, _map_13_u
;;_map_00_u:
;;    _00_up_map = . + 1
;;    ld hl, #0
;;    _00_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_01_u:
;;    _01_up_map = . + 1
;;    ld hl, #0
;;    _01_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_02_u:
;;    _02_up_map = . + 1
;;    ld hl, #0
;;    _02_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_03_u:
;;    _03_up_map = . + 1
;;    ld hl, #0
;;    _03_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_04_u:    
;;    _04_up_map = . + 1
;;    ld hl, #0
;;    _04_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_05_u:
;;    _05_up_map = . + 1
;;    ld hl, #0
;;    _05_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_06_u:
;;    _06_up_map = . + 1
;;    ld hl, #0
;;    _06_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_07_u:    
;;    _07_up_map = . + 1
;;    ld hl, #0
;;    _07_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_08_u:
;;    _08_up_map = . + 1
;;    ld hl, #0
;;    _08_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_09_u:
;;    _09_up_map = . + 1
;;    ld hl, #0
;;    _09_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_10_u:
;;    _10_up_map = . + 1
;;    ld hl, #0
;;    _10_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_11_u:
;;    _11_up_map = . + 1
;;    ld hl, #0
;;    _11_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_12_u:
;;    _12_up_map = . + 1
;;    ld hl, #0
;;    _12_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_13_u:
;;    _13_up_map = . + 1
;;    ld hl, #0
;;    _13_up_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Loads the next map based on the current map index
;;  INPUT:
;;      - B: The tile of the edge
;;  MODIFIES:
;;      - A, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_load_next_map_down::
;;    ld a, (map_index)
;;    or a
;;    jr z, _map_00_d
;;    dec a
;;    jr z, _map_01_d
;;    dec a
;;    jr z, _map_02_d
;;    dec a
;;    jr z, _map_03_d
;;    dec a
;;    jr z, _map_04_d
;;    dec a
;;    jr z, _map_05_d
;;    dec a
;;    jr z, _map_06_d
;;    dec a
;;    jr z, _map_07_d
;;    dec a
;;    jr z, _map_08_d
;;    dec a
;;    jr z, _map_09_d
;;    dec a
;;    jr z, _map_10_d
;;    dec a
;;    jr z, _map_11_d
;;    dec a
;;    jr z, _map_12_d
;;    dec a
;;    jr z, _map_13_d
;;_map_00_d:
;;    _00_down_map = . + 1
;;    ld hl, #0
;;    _00_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_01_d:
;;    _01_down_map = . + 1
;;    ld hl, #0
;;    _01_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_02_d:
;;    _02_down_map = . + 1
;;    ld hl, #0
;;    _02_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_03_d:
;;    _03_down_map = . + 1
;;    ld hl, #0
;;    _03_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_04_d:
;;    _04_down_map = . + 1
;;    ld hl, #0
;;    _04_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_05_d:
;;    _05_down_map = . + 1
;;    ld hl, #0
;;    _05_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_06_d:
;;    _06_down_map = . + 1
;;    ld hl, #0
;;    _06_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_07_d:
;;    _07_down_map = . + 1
;;    ld hl, #0
;;    _07_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_08_d:
;;    _08_down_map = . + 1
;;    ld hl, #0
;;    _08_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_09_d:
;;    _09_down_map = . + 1
;;    ld hl, #0
;;    _09_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_10_d:
;;    _10_down_map = . + 1
;;    ld hl, #0
;;    _10_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_11_d:
;;    _11_down_map = . + 1
;;    ld hl, #0
;;    _11_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_12_d:
;;    _12_down_map = . + 1
;;    ld hl, #0
;;    _12_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
;;    ret
;;_map_13_d:
;;    _13_down_map = . + 1
;;    ld hl, #0
;;    _13_down_index = . + 1
;;    ld a, #0
;;    ld (map_index), a
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Loads the entities of the current map
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_init_map::
    ;;call entity_manager_deleteEverythingExceptPlayer
    ;;ld a, (map_index)
    ;;or a
    ;;call z, world_manager_init_map_00
    ;;dec a
    ;;call z, world_manager_init_map_01
    ;;dec a
    ;;call z, world_manager_init_map_02
    ;;dec a
    ;;call z, world_manager_init_map_03
    ;;dec a
    ;;call z, world_manager_init_map_04
    ;;dec a
    ;;call z, world_manager_init_map_05
    ;;dec a
    ;;call z, world_manager_init_map_06
    ;;dec a
    ;;call z, world_manager_init_map_07
    ;;dec a
    ;;call z, world_manager_init_map_08
    ;;dec a
    ;;call z, world_manager_init_map_09
    ;;dec a
    ;;call z, world_manager_init_map_10
    ;;dec a
    ;;call z, world_manager_init_map_11
    ;;dec a
    ;;call z, world_manager_init_map_12
    ;;dec a
    ;;call z, world_manager_init_map_13
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates the current map and sets the state to map_load
;;  INPUT:
;;      - HL: The map to update
;;  MODIFIES:
;;      - DE: Returns current map
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_update_map::
    ld (current_map), hl
    ld a, #map_load
    call game_manager_set_state
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Changes to the next level
;;  MODIFIES:
;;      - A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_next_level::
    ld a, (level_index)
    inc a
    ld (level_index), a
    sub #4
    jr z, _game_finished
    call world_manager_init_level
    ret
    _game_finished:
    ld a, #victory
    call game_manager_set_state
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Gets the current map
;;  MODIFIES:
;;      - DE: Returns current map
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_get_current_map::
    ld de, (current_map)
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Gets the current map index
;;  MODIFIES:
;;      - A: Returns current map index
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_get_current_map_index::
    ld a, (map_index)
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Gets the current map index
;;  MODIFIES:
;;      - A: Returns current map
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_set_map_index::
    ld (map_index), a
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Gets the current tileset
;;  MODIFIES:
;;      - HL: Returns current tileset
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_get_current_tileset::
    ld hl, (current_tileset)
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates the current tileset
;;  INPUT:
;;      -HL: the tileset to load
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_update_current_tileset::
    ld (current_tileset), hl
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates the current tileset
;;  INPUT:
;;      -HL: the tileset to load
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
world_manager_pickup_piece::
    call hud_manager_add_piece
    ld a, (pieces_index)
    inc a
    ld (pieces_index), a
    ld a, (level_index)
    dec a
    jr z, _pickup_level_1
    dec a
    jr z, _pickup_level_2
    _pickup_level_3:
    call world_manager_pickup_piece_level_3
    ld a, (pieces_index)
    cp #6
    call z, world_manager_unlock_door_level_3
    jr _end_pickup
    _pickup_level_1:
    call world_manager_pickup_piece_level_1
    ld a, (pieces_index)
    cp #2
    call z, world_manager_unlock_door_level_1
    jr _end_pickup
    _pickup_level_2:
    call world_manager_pickup_piece_level_2
    ld a, (pieces_index)
    cp #4
    call z, world_manager_unlock_door_level_2
    _end_pickup:
    ret

world_manager_unlock_door_level_1::
    ld hl, #(world_1_map_00 + 236)
    ld (hl), #0x37
    inc hl
    ld (hl), #0x38
    ld hl, #(world_1_map_00 + 256)
    ld (hl), #0x39
    inc hl
    ld (hl), #0x3A
    ret

world_manager_unlock_door_level_2::
    ld hl, #(world_2_map_00 + 84)
    ld (hl), #0x37
    inc hl
    ld (hl), #0x38
    ld hl, #(world_2_map_00 + 104)
    ld (hl), #0x39
    inc hl
    ld (hl), #0x3A
    ret

world_manager_unlock_door_level_3::
    ld hl, #(world_3_map_00 + 141)
    ld (hl), #0x37
    inc hl
    ld (hl), #0x38
    ld hl, #(world_3_map_00 + 161)
    ld (hl), #0x39
    inc hl
    ld (hl), #0x3A
    ret

world_manager_pickup_piece_level_1::
    call world_manager_get_current_map_index
    cp #10
    jr z, _level_1_map_10
    _level_1_map_13:
    ld hl, #(world_1_map_13 + 57)
    ld (hl), #0x00
    jr _level_1_end
    _level_1_map_10:
    ld hl, #(world_1_map_10 + 51)
    ld (hl), #0x00
    _level_1_end:
    ret

world_manager_pickup_piece_level_2::
    call world_manager_get_current_map_index
    cp #5
    jr z, _level_2_map_05
    _level_2_map_07:
    ld hl, #(world_2_map_07 + 261)
    ld (hl), #0x00
    jr _level_2_end
    _level_2_map_05:
    ld hl, #(world_2_map_05 + 33)
    ld (hl), #0x00
    _level_2_end:
    ret

world_manager_pickup_piece_level_3::
    call world_manager_get_current_map_index
    cp #6
    jr z, _level_3_map_06
    _level_3_map_07:
    ld hl, #(world_3_map_07 + 145)
    ld (hl), #0x00
    jr _level_3_end
    _level_3_map_06:
    ld hl, #(world_3_map_06 + 37)
    ld (hl), #0x00
    inc hl
    ld (hl), #0x00
    _level_3_end:
    ret

world_manager_reset_doors_and_pieces::
    ;; Level 1
    ld hl, #(world_1_map_13 + 57)
    ld (hl), #0x3F
    ld hl, #(world_1_map_10 + 51)
    ld (hl), #0x40
    ld hl, #(world_1_map_00 + 236)
    ld (hl), #0x3B
    inc hl
    ld (hl), #0x3C
    ld hl, #(world_1_map_00 + 256)
    ld (hl), #0x3D
    inc hl
    ld (hl), #0x3E
    ;; Level 2
    ld hl, #(world_2_map_07 + 261)
    ld (hl), #0x3F
    ld hl, #(world_2_map_05 + 33)
    ld (hl), #0x40
    ;;
    ld hl, #(world_2_map_00 + 84)
    ld (hl), #0x3B
    inc hl
    ld (hl), #0x3C
    ld hl, #(world_2_map_00 + 104)
    ld (hl), #0x3D
    inc hl
    ld (hl), #0x3E
    ;; Level 3
    ld hl, #(world_3_map_07 + 145)
    ld (hl), #0x3F
    ld hl, #(world_3_map_06 + 37)
    ld (hl), #0x40
    inc hl
    ld (hl), #0x41
    ;;
    ld hl, #(world_3_map_00 + 141)
    ld (hl), #0x3B
    inc hl
    ld (hl), #0x3C
    ld hl, #(world_3_map_00 + 161)
    ld (hl), #0x3D
    inc hl
    ld (hl), #0x3E
    ret