;; File 'src/assets/maps/world_z.h.s' generated using cpct_pack
;; Compresor used:   zx7b
;; Files compressed: [ 'src/assets/maps/level_1/map_00.bin' 'src/assets/maps/level_1/map_01.bin' 'src/assets/maps/level_1/map_02.bin' 'src/assets/maps/level_1/map_03.bin' 'src/assets/maps/level_1/map_04.bin' 'src/assets/maps/level_1/map_05.bin' 'src/assets/maps/level_1/map_06.bin' 'src/assets/maps/level_1/map_07.bin' 'src/assets/maps/level_1/map_08.bin' 'src/assets/maps/level_1/map_09.bin' 'src/assets/maps/level_1/map_10.bin' 'src/assets/maps/level_1/map_11.bin' 'src/assets/maps/level_1/map_12.bin' 'src/assets/maps/level_1/map_13.bin' 'src/assets/maps/level_1/tileset_1.bin' 'src/assets/maps/level_2/map_00.bin' 'src/assets/maps/level_2/map_01.bin' 'src/assets/maps/level_2/map_02.bin' 'src/assets/maps/level_2/map_03.bin' 'src/assets/maps/level_2/map_04.bin' 'src/assets/maps/level_2/map_05.bin' 'src/assets/maps/level_2/map_06.bin' 'src/assets/maps/level_2/map_07.bin' 'src/assets/maps/level_2/map_08.bin' 'src/assets/maps/level_2/map_09.bin' 'src/assets/maps/level_2/map_10.bin' 'src/assets/maps/level_2/map_11.bin' 'src/assets/maps/level_2/tileset_2.bin' 'src/assets/maps/level_3/map_00.bin' 'src/assets/maps/level_3/map_01.bin' 'src/assets/maps/level_3/map_02.bin' 'src/assets/maps/level_3/map_03.bin' 'src/assets/maps/level_3/map_04.bin' 'src/assets/maps/level_3/map_05.bin' 'src/assets/maps/level_3/map_06.bin' 'src/assets/maps/level_3/map_07.bin' 'src/assets/maps/level_3/tileset_3.bin' ]
;; Uncompressed:        21296 bytes
;; Compressed:           9861 bytes
;; Space saved:      11435 bytes
;;

;; Declaration of the compressed array and
;; the address of the latest byte of the compressed array (for unpacking purposes)
.globl _world_z
.globl _world_z_end

;; Compressed and uncompressed sizes
_world_z_size_z ==     9861
_world_z_size   ==    21296


;; Define constants for starting offsets of files in the uncompressed array
_world_z_OFF_000 ==      0   ;; Starting offset for src/assets/maps/level_1/map_00.bin
_world_z_OFF_001 ==    440   ;; Starting offset for src/assets/maps/level_1/map_01.bin
_world_z_OFF_002 ==    880   ;; Starting offset for src/assets/maps/level_1/map_02.bin
_world_z_OFF_003 ==   1320   ;; Starting offset for src/assets/maps/level_1/map_03.bin
_world_z_OFF_004 ==   1760   ;; Starting offset for src/assets/maps/level_1/map_04.bin
_world_z_OFF_005 ==   2200   ;; Starting offset for src/assets/maps/level_1/map_05.bin
_world_z_OFF_006 ==   2640   ;; Starting offset for src/assets/maps/level_1/map_06.bin
_world_z_OFF_007 ==   3080   ;; Starting offset for src/assets/maps/level_1/map_07.bin
_world_z_OFF_008 ==   3520   ;; Starting offset for src/assets/maps/level_1/map_08.bin
_world_z_OFF_009 ==   3960   ;; Starting offset for src/assets/maps/level_1/map_09.bin
_world_z_OFF_010 ==   4400   ;; Starting offset for src/assets/maps/level_1/map_10.bin
_world_z_OFF_011 ==   4840   ;; Starting offset for src/assets/maps/level_1/map_11.bin
_world_z_OFF_012 ==   5280   ;; Starting offset for src/assets/maps/level_1/map_12.bin
_world_z_OFF_013 ==   5720   ;; Starting offset for src/assets/maps/level_1/map_13.bin
_world_z_OFF_014 ==   6160   ;; Starting offset for src/assets/maps/level_1/tileset_1.bin
_world_z_OFF_015 ==   8272   ;; Starting offset for src/assets/maps/level_2/map_00.bin
_world_z_OFF_016 ==   8712   ;; Starting offset for src/assets/maps/level_2/map_01.bin
_world_z_OFF_017 ==   9152   ;; Starting offset for src/assets/maps/level_2/map_02.bin
_world_z_OFF_018 ==   9592   ;; Starting offset for src/assets/maps/level_2/map_03.bin
_world_z_OFF_019 ==  10032   ;; Starting offset for src/assets/maps/level_2/map_04.bin
_world_z_OFF_020 ==  10472   ;; Starting offset for src/assets/maps/level_2/map_05.bin
_world_z_OFF_021 ==  10912   ;; Starting offset for src/assets/maps/level_2/map_06.bin
_world_z_OFF_022 ==  11352   ;; Starting offset for src/assets/maps/level_2/map_07.bin
_world_z_OFF_023 ==  11792   ;; Starting offset for src/assets/maps/level_2/map_08.bin
_world_z_OFF_024 ==  12232   ;; Starting offset for src/assets/maps/level_2/map_09.bin
_world_z_OFF_025 ==  12672   ;; Starting offset for src/assets/maps/level_2/map_10.bin
_world_z_OFF_026 ==  13112   ;; Starting offset for src/assets/maps/level_2/map_11.bin
_world_z_OFF_027 ==  13552   ;; Starting offset for src/assets/maps/level_2/tileset_2.bin
_world_z_OFF_028 ==  15664   ;; Starting offset for src/assets/maps/level_3/map_00.bin
_world_z_OFF_029 ==  16104   ;; Starting offset for src/assets/maps/level_3/map_01.bin
_world_z_OFF_030 ==  16544   ;; Starting offset for src/assets/maps/level_3/map_02.bin
_world_z_OFF_031 ==  16984   ;; Starting offset for src/assets/maps/level_3/map_03.bin
_world_z_OFF_032 ==  17424   ;; Starting offset for src/assets/maps/level_3/map_04.bin
_world_z_OFF_033 ==  17864   ;; Starting offset for src/assets/maps/level_3/map_05.bin
_world_z_OFF_034 ==  18304   ;; Starting offset for src/assets/maps/level_3/map_06.bin
_world_z_OFF_035 ==  18744   ;; Starting offset for src/assets/maps/level_3/map_07.bin
_world_z_OFF_036 ==  19184   ;; Starting offset for src/assets/maps/level_3/tileset_3.bin

