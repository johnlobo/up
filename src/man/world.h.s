;; ___  ___                 ______                _    
;; |  \/  |                 | ___ \              | |   
;; | .  . | ___   ___  _ __ | |_/ /_ __ ___  __ _| | __
;; | |\/| |/ _ \ / _ \| '_ \| ___ \ '__/ _ \/ _` | |/ /
;; | |  | | (_) | (_) | | | | |_/ / | |  __/ (_| |   < 
;; \_|  |_/\___/ \___/|_| |_\____/|_|  \___|\__,_|_|\_\
;;                                                                                                       
;; Copyright (C) 2020  
;; This file is part of the Amstrad game: MoonBreak
;;
;; Authors:
;; Ricardo Antonio, Ruiz Falcó (@R1ckyman) (ricky.rfr@gmail.com)
;; Alejandro Vicente, Rodríguez Segado (@VicenteSegado) (alejandrors13091993@gmail.com)
;; Enrique Antonio, Cores Rodríguez (@QuiqueCores) (encorod@gmail.com)
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>
;;
;;  MAP MANAGER
;;
.module World_Manager
.include "assets/maps/world_z.h.s"

.globl world_manager_init
.globl world_manager_reset
.globl world_manager_load_next_map_left
.globl world_manager_load_next_map_right
.globl world_manager_load_next_map_up
.globl world_manager_load_next_map_down
.globl world_manager_get_current_map
.globl world_manager_get_current_tileset
.globl world_manager_set_map_index
.globl world_manager_update_map
.globl world_manager_init_map
.globl world_manager_init_level
.globl world_manager_next_level
.globl world_manager_update_current_tileset
.globl world_manager_get_current_map_index
.globl world_manager_pickup_piece
.globl world_manager_reset_doors_and_pieces
.globl world_manager_unlock_door_level_1
.globl world_manager_unlock_door_level_2
.globl world_manager_unlock_door_level_3
.globl world_manager_pickup_piece_level_1
.globl world_manager_pickup_piece_level_2
.globl world_manager_pickup_piece_level_3

;; Constants
CODE_LOCATION = 0x40
DECOMPRESS_LOCATION = CODE_LOCATION + _world_z_size - 1
;;
;;  LEVEL 1
;;
world_1_map_00 = CODE_LOCATION + _world_z_OFF_000
world_1_map_01 = CODE_LOCATION + _world_z_OFF_001
world_1_map_02 = CODE_LOCATION + _world_z_OFF_002
world_1_map_03 = CODE_LOCATION + _world_z_OFF_003
world_1_map_04 = CODE_LOCATION + _world_z_OFF_004
world_1_map_05 = CODE_LOCATION + _world_z_OFF_005
world_1_map_06 = CODE_LOCATION + _world_z_OFF_006
world_1_map_07 = CODE_LOCATION + _world_z_OFF_007
world_1_map_08 = CODE_LOCATION + _world_z_OFF_008
world_1_map_09 = CODE_LOCATION + _world_z_OFF_009
world_1_map_10 = CODE_LOCATION + _world_z_OFF_010
world_1_map_11 = CODE_LOCATION + _world_z_OFF_011
world_1_map_12 = CODE_LOCATION + _world_z_OFF_012
world_1_map_13 = CODE_LOCATION + _world_z_OFF_013
tileset_1 = CODE_LOCATION + _world_z_OFF_014
;;
;;  LEVEL 2
;;
world_2_map_00 = CODE_LOCATION + _world_z_OFF_015
world_2_map_01 = CODE_LOCATION + _world_z_OFF_016
world_2_map_02 = CODE_LOCATION + _world_z_OFF_017
world_2_map_03 = CODE_LOCATION + _world_z_OFF_018
world_2_map_04 = CODE_LOCATION + _world_z_OFF_019
world_2_map_05 = CODE_LOCATION + _world_z_OFF_020
world_2_map_06 = CODE_LOCATION + _world_z_OFF_021
world_2_map_07 = CODE_LOCATION + _world_z_OFF_022
world_2_map_08 = CODE_LOCATION + _world_z_OFF_023
world_2_map_09 = CODE_LOCATION + _world_z_OFF_024
world_2_map_10 = CODE_LOCATION + _world_z_OFF_025
world_2_map_11 = CODE_LOCATION + _world_z_OFF_026
tileset_2 = CODE_LOCATION + _world_z_OFF_027
;;
;;  LEVEL 3
;;
world_3_map_00 = CODE_LOCATION + _world_z_OFF_028
world_3_map_01 = CODE_LOCATION + _world_z_OFF_029
world_3_map_02 = CODE_LOCATION + _world_z_OFF_030
world_3_map_03 = CODE_LOCATION + _world_z_OFF_031
world_3_map_04 = CODE_LOCATION + _world_z_OFF_032
world_3_map_05 = CODE_LOCATION + _world_z_OFF_033
world_3_map_06 = CODE_LOCATION + _world_z_OFF_034
world_3_map_07 = CODE_LOCATION + _world_z_OFF_035
tileset_3 = CODE_LOCATION + _world_z_OFF_036