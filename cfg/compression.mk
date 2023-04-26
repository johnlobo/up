##-----------------------------LICENSE NOTICE------------------------------------
##  This file is part of CPCtelera: An Amstrad CPC Game Engine 
##  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU Lesser General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU Lesser General Public License for more details.
##
##  You should have received a copy of the GNU Lesser General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##------------------------------------------------------------------------------
############################################################################
##                        CPCTELERA ENGINE                                ##
##                 Automatic compression utilities                        ##
##------------------------------------------------------------------------##
## This file is intended for users to automate the generation of          ##
## compressed files and their inclusion in users' projects.               ##
############################################################################

## COMPRESSION EXAMPLE (Uncomment lines to use)
##

## First 3 calls to ADD2PACK add enemy, hero and background
## graphics (previously converted to binary data) into the 
## compressed group 'mygraphics'. After that, call to PACKZX7B
## compresses all the data and generates an array with the result
## that is placed in src/mygraphics.c & src/mygraphics.h, ready
## to be included and used by other modules.
##
#$(eval $(call ADD2PACK,mygraphics,gfx/enemy.bin))
#$(eval $(call ADD2PACK,mygraphics,gfx/hero.bin))
#$(eval $(call ADD2PACK,mygraphics,gfx/background.bin))
#$(eval $(call PACKZX7B,mygraphics,src/))

# Screens compression
#$(eval $(call ADD2PACK,s_menu_z,src/assets/screens/s_menu.bin))
#$(eval $(call PACKZX7B,s_menu_z,src/assets/screens/))
#$(eval $(call ADD2PACK,s_credits_z,src/assets/screens/s_credits.bin))
#$(eval $(call PACKZX7B,s_credits_z,src/assets/screens/))
#$(eval $(call ADD2PACK,s_controls_z,src/assets/screens/s_controls.bin))
#$(eval $(call PACKZX7B,s_controls_z,src/assets/screens/))
# Maps compression
########################################################################
########################################################################
####################		LEVEL	1		############################
########################################################################
########################################################################
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_00.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_01.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_02.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_03.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_04.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_05.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_06.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_07.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_08.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_09.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_10.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_11.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_12.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/map_13.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_1/tileset_1.bin))
########################################################################
########################################################################
####################		LEVEL	2		############################
########################################################################
########################################################################
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_00.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_01.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_02.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_03.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_04.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_05.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_06.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_07.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_08.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_09.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_10.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/map_11.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_2/tileset_2.bin))
########################################################################
########################################################################
####################		LEVEL	3		############################
########################################################################
########################################################################
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_3/map_00.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_3/map_01.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_3/map_02.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_3/map_03.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_3/map_04.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_3/map_05.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_3/map_06.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_3/map_07.bin))
$(eval $(call ADD2PACK,world_z,src/assets/maps/level_3/tileset_3.bin))
$(eval $(call PACKZX7B,world_z,src/assets/maps/))


############################################################################
##              DETAILED INSTRUCTIONS AND PARAMETERS                      ##
##------------------------------------------------------------------------##
##                                                                        ##
## Macros used for compression are ADD2PACK and PACKZX7B:                 ##
##                                                                        ##
##	ADD2PACK: Adds files to packed (compressed) groups. Each call to this ##
##  		  macro will add a file to a named compressed group.          ##
##  PACKZX7B: Compresses all files in a group into a single binary and    ##
##            generates a C-array and a header to comfortably use it from ##
##            inside your code.                                           ##
##                                                                        ##
##------------------------------------------------------------------------##
##                                                                        ##
##  $(eval $(call ADD2PACK,<packname>,<file>))                            ##
##                                                                        ##
##		Sequentially adds <file> to compressed group <packname>. Each     ##
## call to this macro adds a new <file> after the latest one added.       ##
## packname could be any valid C identifier.                              ##
##                                                                        ##
##  Parameters:                                                           ##
##  (packname): Name of the compressed group where the file will be added ##
##  (file)    : File to be added at the end of the compressed group       ##
##                                                                        ##
##------------------------------------------------------------------------##
##                                                                        ##
##  $(eval $(call PACKZX7B,<packname>,<dest_path>))                       ##
##                                                                        ##
##		Compresses all files in the <packname> group using ZX7B algorithm ##
## and generates 2 files: <packname>.c and <packname>.h that contain a    ##
## C-array with the compressed data and a header file for declarations.   ##
## Generated files are moved to the folder <dest_path>.                   ##
##                                                                        ##
##  Parameters:                                                           ##
##  (packname) : Name of the compressed group to use for packing          ##
##  (dest_path): Destination path for generated output files              ##
##                                                                        ##
############################################################################
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##  * You can omit parameters by leaving them empty.                      ##
##  * Parameters (4) and (5) are optional and generally not required.     ##
############################################################################
