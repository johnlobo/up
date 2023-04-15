;; This file contains all the indexes to adress to the entities

.module Entity_Manager

;;------------------------------------------------------
;; Entities
;; Definition of entity structure fields

e_cmps      == 0
e_x         == 1 ;2 bytes
e_y         == 3 ;2 bytes
e_vx        == 5 ;2 bytes
e_vy        == 7 ;2 bytes
e_w         == 9
e_h         == 10
e_type      == 11
e_ai_st     == 12
e_sprite    == 13    ;; Pointer, 2 bytes
e_prv_ptr   == 15    ;; Pointer, 2 bytes
e_lifes     == 17    ;; Lifes of both character and enemy
e_deathanimCtr == 18
;e_level     == 18    ;; Dificultad de los enemigos (velocidad)

e_fs1       == 19 
e_fs2       == 20
e_fs3       == 21
e_fs4       == 22
e_fs5       == 23
e_fs6       == 24
e_fs7       == 25
e_fs8       == 27
e_fs9       == 29

e_enemy_ctr_retroceso == e_fs6
e_enemy_last_vel_x    == e_fs7
e_enemy_last_vel_y    == e_fs8
e_enemy_bullet        == e_fs9

;;;;;food;;;;;;;;
;fs1 == 18 
e_food_decision_enemy == e_fs1

e_food_ctr_enemy      == e_fs4

e_death               == e_fs5 

e_food_ctr_destroy_counter  == e_fs7

e_food_ctr_destroy    == e_fs8

e_food_final_reder    == e_fs9

;;;;;balas;;;;;;;;
;fs1 == 18 
e_color == e_fs1
;fs2 == 19 
e_bullet_v == e_fs2
;fs3 == 20 
e_bullet_ctr == e_fs3

;fs4 == 21 

;fs5 == 22 


;;;;;Zombie;;;;;;;;
;;fs1 contador para quitar vida a la comida, inicializar a 1
e_foodctr == e_fs1

;fs2 == 19 
e_enemlevel == e_fs2
;fs3 == 20 
e_type_enemy_ai == e_fs3 ;;Tipo de inteligencia/enemigo
;fs4 == 21 
e_zombie_raimbow == e_fs4
;fs5 == 22 

;;;;;Calabaza;;;;;;;;
;fs1 == 18 

;;fs1 contador para quitar vida a la comida, inicializar a 1
e_calabaza_ctr == e_fs1 ;;Contador para pararse, seguirte e ir a por ti
;; 151 siempre
;fs2 == 19 

;fs3 == 20 

;fs4 == 21 
e_calabaza_y   == e_fs4 ;; Posicion x e y a donde va a apuntar
;fs5 == 22
e_calabaza_x   == e_fs5 ;; Donde almacena la posicion del jugador antes de saltar


;;;;;Spider;;;;;;;;
;;fs1 contador para quitar vida a la comida, inicializar a 1
e_spider_ctr == e_fs1

;fs2 == 19 

;fs3 == 20 

;fs4 == 21 
e_spider_move == e_fs4
;fs5 == 22
e_spider_move_h == e_fs5

;;;;;Witch;;;;;;;;
;;fs1 contador para quitar vida a la comida, inicializar a 1
e_witch_ctr == e_fs1

;fs2 == 19 

;fs3 == 20 

;fs4 == 21 
e_witch_move == e_fs4
;fs5 == 22
e_witch_move_h == e_fs5

;;;;;Player;;;;;;;;
;fs1 == 18 

;;fs1 contador para quitar vida a al personaje, inicializar a 1
e_playerctr == e_fs1

;fs2 == 19 
e_player_moving == e_fs2
;fs3 == 20 
e_player_anim_ctr == e_fs3
;fs4 == 21 
e_player_current_anim == e_fs4
;fs5 == 22 


;;enemigo1

;; Entity info
sizeof_e        == 30
max_entities    == 10

;; Entity AI enum status
e_ai_st_noAI            == 0
e_ai_st_stand_by        == 1
e_ai_st_move_to         == 2
e_ai_st_move_to_food    == 3
;; Bit for matching & properties

e_cmps_alive_bit     = 7
e_cmps_position_bit  = 6
e_cmps_input_bit     = 5
e_cmps_physics_bit   = 4
e_cmps_render_bit    = 3
e_cmps_deathanim_bit = 2
;;-----
e_cmps_todestroy_bit = 1

;; Component Types (masks)
e_cmps_invalid    == 0x00
e_cmps_alive      == (1 << e_cmps_alive_bit)
e_cmps_position   == (1 << e_cmps_position_bit)
e_cmps_input      == (1 << e_cmps_input_bit)
e_cmps_physics    == (1 << e_cmps_physics_bit)
e_cmps_render     == (1 << e_cmps_render_bit)
e_cmps_todestroy  == (1 << e_cmps_todestroy_bit)
e_cmps_deathanim  == (1 << e_cmps_deathanim_bit)
e_cmps_default    == 0xFF

;; Entity types
e_type_mainchar     = 0
e_type_enemy        = 1
e_type_floor        = 2
e_type_bullet       = 3
e_type_enemy_ovni   = 4
e_type_enemy_bat    = 5
e_type_enemy_calabaza = 6
e_type_enemy_zombie   = 7
e_type_enemy_ghost    = 8
e_type_enemy_spider   = 9
e_type_enemy_witch    = 10
e_type_enemy_food     = 11
e_type_food           = 12

;; Public functions
.globl man_entity_init
.globl man_entity_create
.globl man_entity_destroy
.globl man_entity_forall
.globl man_entity_forall_matching
.globl man_entity_forall_pairs_matching
.globl man_entity_get_from_idx
.globl man_entity_set4destruction
.globl man_entity_set4destruction_simple
.globl man_entity_update
.globl cpct_memcpy_asm
.globl man_entity_increase_num
.globl man_entity_decrease_num
.globl mainchar_entity
.globl man_entity_first_entity
.globl man_entity_getFirstEntity_IY
.globl man_entity_set4destruction_IY
;.globl man_next_entity_iy_iterator
;.globl man_next_entity_iy
.globl man_next_entity
.globl man_entity_damaged
.globl cpct_drawSolidBox_asm
.globl cpct_getScreenPtr_asm
.globl update_death_anim
.globl set_death_anim
.globl man_entity_set4destruction_simple_iy
.globl set_death_anim_food