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



.globl man_map_set_to_map
.globl man_map_set_to_restore
.globl man_map_draw
.globl man_map_restore
.globl man_map_get_tile

;;  SIZE OF TILES
tile_w = 4
tile_h = 8
;; New position
up_position == 8
right_position == 72
left_position == 4
down_position == 152
;;  MAP SIZES
MAP_W = 20
MAP_H = 22