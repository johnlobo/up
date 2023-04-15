;; INIT OF ENTITIES.S
.include "entities.h.s"
.include "rounds.h.s"
.include "./system/collision.h.s"
.include "./system/render.h.s"
.include "screen.h.s"
.include "game.h.s"
.include "music.h.s"
.include "./system/ui.h.s"
.include "cpctelera.h.s"

.globl _sprite_explosion
.globl _sprite_explosion2
.globl _sprite_explosion_rain
.globl _sprite_explosion2_rain

;; ----------------------------------
;; DEFINICIONES
;;
next_free_entity: .dw array_entities
current_entity: .dw array_entities
num_entities: .db 0 ;; Actual number of entities created
array_entities: .ds sizeof_e * max_entities
array_end: .db 0x00



;; Functions for entities

;; Initializes the array of entities
man_entity_init::

    
    ld hl, #num_entities
    ld (hl), #0

    ld hl, #next_free_entity
    ld (hl), #array_entities

    ld hl, #current_entity
    ld (hl), #array_entities

    ld hl, #array_entities
    
    call man_entity_first_entity
    call man_entity_collision_init

ret

;; Recibo en hl la template
;; Creates the entity
man_entity_create::
    ;; Is there free space?
    ld a, (num_entities)
    cp #max_entities
    jr z, skip_ce
     
    ;; Free space -> create entity
    ld de, (next_free_entity) ;; To
    ld bc, #sizeof_e ;; Size
    ldir    ;; Changes AF, BC, DE, HL

    ld ix, (next_free_entity)
    call man_entity_collision_add
    ;;volver a cargar 'a' desde 'ix' o se rompe todo jeje

    ;; Increase free entity
    ld hl, (next_free_entity)
    ld bc, #sizeof_e
    add hl, bc
    ld (next_free_entity), hl
    call man_entity_increase_num

    ;; No free space -> Skip
    skip_ce:
ret



;DELETES CURRENT ENTITY
man_entity_destroy:

    ld ix, (current_entity)
    call sys_render_delete

    ld a, e_cmps(ix)
    cp #e_cmps_invalid
    jr z, skip_delete ;si la entidad ya esta muerta, no hago nada

    ;; Decrease free entity
    ld hl, (next_free_entity)
    ld bc, #-sizeof_e
    add hl, bc
    ld (next_free_entity), hl


    ld de, (current_entity)

    ;si hl (last_free entity) y de (current entity) son iguales, deberiamos saltar a final_delete
    ld a, h
    cp d
    jr nz, #are_different_delete ;;si h y d son distintos, se hace el memcpy
    ld a, l
    cp e
    jr z, #final_delete ;;si h y d son iguales, y l y e son iguales, no se hace memcpy


    are_different_delete:
    ld bc, #sizeof_e

    push hl

    call cpct_memcpy_asm ;;copiamos el contenido de la ultima entidad en la que vamos a borrar

    pop hl

    final_delete:
    ld (hl), #e_cmps_invalid ;hacemos invalida a la ultima entidad

    call man_entity_decrease_num

    call man_collision_delete

    skip_delete:
ret 

;; Pointer to function
function_for_all: .db #0x00, #0x00
;; ----------------------------------------------------------- ;;
;; INPUT -> HL: contains the function                          ;;
;; General function to apply to all entities                   ;;
;; ----------------------------------------------------------- ;;
man_entity_forall::
    ld (function_for_all), hl
    call man_entity_first_entity ;; IX points to the first entity

    ld a,e_cmps(ix) ;;si la primera entidad es invalida, salimos de la funcion
    and #0xFF
    jr z, final

    loop_forall:
        ld hl, #afterjp
        push hl

        ld hl, (function_for_all)
        jp (hl)

        afterjp:

        call man_next_entity

        ld a,e_cmps(ix)
        and #0xFF
    jr nz, loop_forall

    final:
        call man_entity_first_entity
ret

;; ---------------------------------------------
;; Applies a function filtering specific criteria
;; B -> Mask of bytes (e_cmps)
;; ---------------------------------------------
man_entity_forall_matching::
    ld (function_for_all), hl
    call man_entity_first_entity ;; IX points to the first entity

    ld a,e_cmps(ix) ;;si la primera entidad es invalida, salimos de la funcion
    and #0xFF
    jr z, final_matching

    loop_forall_matching:
        push bc ;;guardo mascara de bytes
        ld a, e_cmps(ix)
        and b
        cp b
        jr nz, afterjp_matching

        
        ld hl, #afterjp_matching
        push hl

        ld hl, (function_for_all)
        jp (hl)

        afterjp_matching:


        call man_next_entity
        
        ld a,e_cmps(ix)
        and #0xFF
        pop bc
    jr nz, loop_forall_matching

    final_matching:
        call man_entity_first_entity
ret

;; ----------------------------------------------------
;;  Compares a pair of entities under a specific criteria
;;  IY -> The other pair
;;  B -> Mask to filter
;; -----------------------------------------------------
man_entity_forall_pairs_matching::
ret 

;; INPUT: A -> ID of the entity
;; OUTPUT: IX -> The entity
man_entity_get_from_idx::

    cp #max_entities
    jr nc, ret_last_ent_gfi ;;si el idx es mayor o igual a max entities, cambio A por max_entities-1 (ultima entidad)
    jr cont_gfi

    ret_last_ent_gfi:
    ld a, #max_entities-1

    cont_gfi:

    ;; Acceder al elemento 4 de un array de 4 campos
    ;; array[3] = inicio + (3*4)
    call man_entity_first_entity

    cp #0
    jr z, end_gfi

    loop_gfi:
        call man_next_entity;
        dec a
    jr nz, loop_gfi

    end_gfi:
ret 

;;Receives by ix

man_entity_set4destruction_simple::
    ld a, e_type(ix)
    cp #e_type_mainchar
    jr z, dont_destroy_simple

    ld e_cmps(ix), #e_cmps_todestroy

    dont_destroy_simple:
ret

man_entity_set4destruction_simple_iy::
    ld a, e_type(iy)
    cp #e_type_mainchar
    jr z, dont_destroy_simpleiy

    ld e_cmps(iy), #e_cmps_todestroy

    dont_destroy_simpleiy:
ret

man_entity_set4destruction::
    
    ;Para subir una vida si muere un zombie arcoiris
    ld a, e_type(ix)
    cp #e_type_mainchar
    jr nz, not_player_destroyed_2
    ;si es el jugador, se llama reset y se salta la destruccion
    call restart_game_func
    jp end_destruction

    not_player_destroyed_2:
    ld e_cmps(ix), #e_cmps_todestroy

    ld a, e_type(ix)
    cp #e_type_enemy
    jr nz, end_destruction
    
    ld a, e_type_enemy_ai(ix)
    cp #e_type_enemy_zombie
    
    jr nz, skip_up_life

    ld a, e_zombie_raimbow(ix)
    cp #0
    jr z, skip_up_life

    push ix

    ld ix, #array_entities
    ld a, e_lifes(ix)

    cp #6
    jr z, not_up_life

    inc a
    ld e_lifes(ix), a
    call sys_ui_draw_lifes
    
    not_up_life:
    pop ix
    skip_up_life:

    ld a, e_type(ix)
    cp #e_type_enemy
    jr nz, end_destruction

    push iy
    push hl
    push ix

    call enemy_update_score ;;UPDATE VALORES
    call sys_ui_update_score_unidades ;;UPDATE SCORE UI
    call sys_ui_update_score_decenas  ;;UPDATE SCORE UI
    call sys_ui_update_score_millar   ;;UPDATE SCORE UI
    call sys_ui_update_score_centenas ;;UPDATE SCORE UI

    pop ix
    pop hl
    pop iy
    
    end_destruction:

ret


man_entity_set4destruction_IY::


    ld a, e_type(iy)
    cp #e_type_mainchar
    jr z, dont_destroy_simple_iy

    ld e_cmps(iy), #e_cmps_todestroy
    
    dont_destroy_simple_iy:
    
    ld a, e_type(iy)
    cp #e_type_bullet
    jr z, end_destruction_iy
    
    ld a, e_type_enemy_ai(iy)
    cp #e_type_enemy_zombie
    
    jr nz, skip_up_life_iy

    ld a, e_zombie_raimbow(iy)
    cp #0
    jr z, skip_up_life_iy
    push ix

    ld ix, #array_entities
    ld a, e_lifes(ix)

    cp #6
    jr z, not_up_life_iy

    inc a
    ld e_lifes(ix), a
    call sys_ui_draw_lifes
    
    not_up_life_iy:
    pop ix
    skip_up_life_iy:

    ld a, e_type(iy)
    cp #e_type_enemy
    jr nz, end_destruction_iy

    push iy
    push hl
    push ix

    ld__a_iyl
    ld__ixl_a
    ld__a_iyh
    ld__ixh_a
    

    call enemy_update_score ;;UPDATE VALORES
    call sys_ui_update_score_unidades ;;UPDATE SCORE UI
    call sys_ui_update_score_decenas  ;;UPDATE SCORE UI
    call sys_ui_update_score_millar   ;;UPDATE SCORE UI
    call sys_ui_update_score_centenas ;;UPDATE SCORE UI

    pop ix
    pop hl
    pop iy
    
    end_destruction_iy:
ret


man_entity_update:: ;; Updates all entities to be destroyed
    
    ld b, #e_cmps_todestroy
    call man_entity_first_entity ;; IX points to the first entity

    ld a,e_cmps(ix) ;;si la primera entidad es invalida, salimos de la funcion
    and #0xFF
    jr z, final_matching_meu

    loop_forall_matching_meu:
        push bc ;;guardo mascara de bytes
        ld a, e_cmps(ix)
        and b
        cp b
        jr nz, afterjp_matching_meu

        ld hl, #afterjp_matching_meu
        push hl

        ld hl, #man_entity_destroy
        jp (hl)

        jr no_next_meu

        afterjp_matching_meu:

        call man_next_entity
        no_next_meu:
        ld a,e_cmps(ix)
        and #0xFF
        pop bc
    jr nz, loop_forall_matching_meu

    final_matching_meu:
        call man_entity_first_entity
    
ret

;;Receives by ix

man_entity_damaged::
    ld a, e_type(ix)
    cp #e_type_bullet
    jr nz, not_bullet
        ld a, e_bullet_ctr(ix)
        dec a
        jr nz, start_bullet_ctr
            ld e_bullet_ctr(ix), #6
            jr character_collision
        start_bullet_ctr:
        ld a, e_enemy_bullet(iy)
        cp #0
        jr nz, end_bullet_c
        jp character_collision
        end_bullet_c:
        ret
    not_bullet:
    ld a, e_type(ix)
    cp #e_type_enemy
    jr nz, only_character
    ld a, e_enemy_bullet(ix)
    cp #0
    jr nz, not_enemy
    ld e_bullet_ctr(iy), #6
    jp character_collision
    
    not_enemy:
    ld a, e_bullet_ctr(iy)
    cp #1
    jr nz, end_enemy_bullet

    ld e_bullet_ctr(iy), #6
    jp character_collision

    end_enemy_bullet:
    ret

    character_collision:

    ld a, e_type(ix)
    cp #e_type_enemy
    jr nz, not_enemy_bullet
    ld e_enemy_bullet(ix), #1
    call man_entity_calculate_retroceso

    not_enemy_bullet:

    ld a, e_type(iy)
    cp #e_type_enemy
    jr nz, not_bullet_enemy
    ld e_enemy_bullet(iy), #1
    call man_entity_calculate_retroceso_IY
    
    not_bullet_enemy:
    
    ld a, e_lifes(iY)
    dec a
    call z, set_death_anim_iy
    ld a, e_lifes(iY)
    dec a
    jr z, end_damaged_iy
    ld e_lifes(iy), a

    end_damaged_iy:


    ;; cpctm_setBorder_asm HW_WHITE
    ld l, #3 ; que sonido va a sonar
    ld h, #8 ; volumen 0-15
    ld e, #53 ; nota 0-143
    ld d, #0 ; speed (0 es original, 1 es la mas rapida)
    ld bc, #0xFFFF ;pitch
    ld a, #10 ;canal del medio
    push ix
    call cpct_akp_SFXPlay_asm
    pop ix

    only_character:
    
    ld a, e_lifes(ix)
    dec a
    call z, set_death_anim
    ld a, e_lifes(ix)
    dec a
    jr z, end_damaged
    ld e_lifes(ix), a

    end_damaged:
    ld a, e_type(ix)
    cp #e_type_mainchar
    call z, sys_ui_erase_heart
ret

man_entity_calculate_retroceso::
    ld a, e_lifes(ix)
    cp #0
    jp z, not_retroceso
        ld e_enemy_ctr_retroceso(ix), #3 ;;TIEMMPO DE RETROCESO

        ld a, e_type_enemy_ai(ix)
        cp #e_type_enemy_ovni
        jr nz, not_nub_ovni

        ld e_enemy_ctr_retroceso(ix), #2

        not_nub_ovni:
        
        ld a, e_vx(ix)
        ld e_enemy_last_vel_x(ix), a
        ld a, e_vy(ix)
        ld e_enemy_last_vel_y(ix), a

        ld a, e_vx+1(ix)
        ld e_enemy_last_vel_x+1(ix), a
        ld a, e_vy+1(ix)
        ld e_enemy_last_vel_y+1(ix), a

        ld a, e_bullet_v(iy)
        cp #0
        ;;VELOCIDADES DE RETROCESO
        jr nz, not_up_bullet

            ld a, #0
            ld b, #-3
            jp end_vel_bullet
        not_up_bullet:
        cp #1
        jr nz, not_right_bullet

            ld a, #2
            ld b, #0
            jp end_vel_bullet
        not_right_bullet:
        cp #2
        jr nz, not_down_bullet

            ld a, #0
            ld b, #3
            jp end_vel_bullet
        not_down_bullet:
        cp #3
        jr nz, end_vel_bullet

            ld a, #-2
            ld b, #0
        end_vel_bullet:

        ld e_vx(ix), a
        ld e_vy(ix), b
        ld e_vx+1(ix), #0
        ld e_vy+1(ix), #0

        ld a, e_type_enemy_ai(ix)
        cp #e_type_enemy_zombie
        jr nz, not_retroceso
        ld e_ai_st(ix), #e_ai_st_move_to_food
    not_retroceso:
ret

;;;;;;;;;;
;;;;;;;;
;;;;;;;;IY RETROCESO
;;;;;;;;
;;;;;;;;;;
man_entity_calculate_retroceso_IY::
    ld a, e_lifes(iy)
    cp #0
    jp z, not_retroceso_IY
        ld e_enemy_ctr_retroceso(iy), #4 ;;TIEMMPO DE RETROCESO

        ld a, e_type_enemy_ai(iy)
        cp #e_type_enemy_ovni
        jr nz, not_nub_ovni_IY

        ld e_enemy_ctr_retroceso(iy), #2

        not_nub_ovni_IY:
        
        ld a, e_vx(iy)
        ld e_enemy_last_vel_x(iy), a
        ld a, e_vy(iy)
        ld e_enemy_last_vel_y(iy), a

        ld a, e_vx+1(iy)
        ld e_enemy_last_vel_x+1(iy), a
        ld a, e_vy+1(iy)
        ld e_enemy_last_vel_y+1(iy), a

        ld a, e_bullet_v(ix)
        cp #0
        ;;VELOCIDADES DE RETROCESO
        jr nz, not_up_bullet_IY

            ld a, #0
            ld b, #-3
            jp end_vel_bullet_IY
        not_up_bullet_IY:
        cp #1
        jr nz, not_right_bullet_IY

            ld a, #2
            ld b, #0
            jp end_vel_bullet_IY
        not_right_bullet_IY:
        cp #2
        jr nz, not_down_bullet_IY

            ld a, #0
            ld b, #3
            jp end_vel_bullet_IY
        not_down_bullet_IY:
        cp #3
        jr nz, end_vel_bullet_IY

            ld a, #-2
            ld b, #0
        end_vel_bullet_IY:

        ld e_vx(iy), a
        ld e_vy(iy), b
        ld e_vx+1(iy), #0
        ld e_vy+1(iy), #0

        ld a, e_type_enemy_ai(iy)
        cp #e_type_enemy_zombie
        jr nz, not_retroceso_IY
        ld e_ai_st(iy), #e_ai_st_move_to_food
        ;ld e_foodctr(ix), #1
    not_retroceso_IY:
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; ITERADOR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


man_entity_increase_num: ;; Increases the value of the counter num_entities
    ld hl, #num_entities
    inc (hl)
ret

man_entity_decrease_num: ;; Decreases the value of the counter num_entities
    ld hl, #num_entities
    ld a, (hl)
    cp #0
    ret z
    dec (hl)
ret



man_entity_first_entity:: ;; Changes the entity controller to ix register
    ld hl, #array_entities
    ld (current_entity), hl
    ld ix, (current_entity)
ret

man_next_entity:: ;;aumenta la posicion de current entity
    ld hl, (current_entity)
    ld bc, #sizeof_e
    add hl, bc
    ld (current_entity), hl
    ld ix, (current_entity)
ret

man_get_current_entity::
    ld ix, (current_entity)
ret

man_entity_getFirstEntity_IY::
    ld iy, #array_entities
ret

man_entity_getArray::
    ld hl, #array_entities
ret

man_get_num_entities::
    ld a, #num_entities
ret

;;ENEMY UPDATE SCORE

enemy_update_score::
    ld a, e_type_enemy_ai(ix)
    cp #e_type_enemy_ovni
    jr nz, not_ovni_score
        ld b, #1
        call inc_decenas_score
        ld b, #5
        call inc_unidades_score
        jp no_enemy_ent
    not_ovni_score:
    cp #e_type_enemy_bat
    jr nz, not_bat_score
        ld b, #2 
        call inc_decenas_score
        jp no_enemy_ent
    not_bat_score:
    cp #e_type_enemy_calabaza
    jr nz, not_calabaza_score
        ld b, #1
        call inc_decenas_score
        jp no_enemy_ent
    not_calabaza_score:
    cp #e_type_enemy_spider
    jr nz, not_spider_score
        ld b, #3
        call inc_decenas_score
        jp no_enemy_ent
    not_spider_score:
    cp #e_type_enemy_witch
    jr nz, not_witch_score
        ld b, #4
        call inc_decenas_score
        jp no_enemy_ent
    not_witch_score:
    cp #e_type_enemy_zombie
    jr nz, not_zombie_score
        ld b, #5
        call inc_unidades_score

        ld a, e_zombie_raimbow(ix)
        cp #0
        jr z, no_enemy_ent
        ld b, #8
        call inc_decenas_score
            ld ix, #array_entities
            ld a, e_lifes(ix)
            cp #6
            jr nz, not_extra
                ld b, #5
                call inc_decenas_score
            not_extra:
        jp no_enemy_ent
    not_zombie_score:
    cp #e_type_enemy_ghost
    jr nz, not_ghost_score
        ld b, #1
        call inc_decenas_score
        jp no_enemy_ent
    not_ghost_score:

    no_enemy_ent:

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;recibe ix
set_death_anim::
    ld a, e_type(ix)
    cp #e_type_bullet
    jr z, es_bullet_deathanim

    cp #e_type_mainchar
    jr nz, not_player_destroyed2
    ;si es el jugador, se llama reset y se salta la destruccion
    call restart_game_func
    ret
    not_player_destroyed2:

    ld a, e_type(ix)
    cp #e_type_enemy
    jr nz, nop2

    ld a, e_type_enemy_ai(ix)
    cp #e_type_enemy_zombie
    jr nz, normal_sound
    ;; Rainbow sound

    ld a, e_zombie_raimbow(ix)
    cp #0
    jr z, normal_sound

    push af
    ld l, #4 ; que sonido va a sonar
    ld h, #15 ; volumen 0-15
    ld e, #60 ; nota 0-143
    ld d, #0 ; speed (0 es original, 1 es la mas rapida)
    ld bc, #0xFFFF ;pitch
    ld a, #10 ;canal del medio
    push ix
    call cpct_akp_SFXPlay_asm
    pop ix
    pop af

    jr nop2
    normal_sound:
    ;;Normal enemy sound

    push af
    ld l, #2 ; que sonido va a sonar
    ld h, #15 ; volumen 0-15
    ld e, #80 ; nota 0-143
    ld d, #0 ; speed (0 es original, 1 es la mas rapida)
    ld bc, #0xFFFF ;pitch
    ld a, #10 ;canal del medio
    push ix
    call cpct_akp_SFXPlay_asm
    pop ix
    pop af

    nop2:
    ld e_cmps(ix), #e_cmps_deathanim
    ;ld e_type(ix), #90
    ld e_deathanimCtr(ix), #16

    ret
    es_bullet_deathanim:
    call man_entity_set4destruction
ret

set_death_anim_food::
    ld e_cmps(ix), #e_cmps_deathanim
    ld e_deathanimCtr(ix), #16
ret

set_death_anim_iy::
    ld a, e_type(iy)
    cp #e_type_bullet
    jr z, es_bullet_deathanim_iy

    cp #e_type_mainchar
    jr nz, not_player_destroyed
    ;si es el jugador, se llama reset y se salta la destruccion
    call restart_game_func
    ret
    not_player_destroyed:

    ld a, e_type(iy)
    cp #e_type_enemy
    jr nz, nopi

    ld a, e_type_enemy_ai(iy)
    cp #e_type_enemy_zombie
    jr nz, normal_sound2
    ;; Rainbow sound

    ld a, e_zombie_raimbow(iy)
    cp #0
    jr z, normal_sound2

    push af
    ld l, #4 ; que sonido va a sonar
    ld h, #15 ; volumen 0-15
    ld e, #60 ; nota 0-143
    ld d, #0 ; speed (0 es original, 1 es la mas rapida)
    ld bc, #0xFFFF ;pitch
    ld a, #10 ;canal del medio
    push ix
    call cpct_akp_SFXPlay_asm
    pop ix
    pop af



    jr nopi
    normal_sound2:
    ;;Normal enemy sound

    push af
    ld l, #2 ; que sonido va a sonar
    ld h, #15 ; volumen 0-15
    ld e, #80 ; nota 0-143
    ld d, #0 ; speed (0 es original, 1 es la mas rapida)
    ld bc, #0xFFFF ;pitch
    ld a, #10 ;canal del medio
    push ix
    call cpct_akp_SFXPlay_asm
    pop ix
    pop af

    nopi:
    ld e_cmps(iy), #e_cmps_deathanim
    ld e_deathanimCtr(iy), #16
    ret
    es_bullet_deathanim_iy:
    call man_entity_set4destruction_IY
ret
;recibe ix
update_death_anim_forone:
    ld a, e_deathanimCtr(ix)
    cp #16
    jr z, first_frame_death

    cp #8
    jr z, seg_frame_death
    jp dont_change_frame_death

    first_frame_death:
    ld a, e_type(ix)
    cp #e_type_enemy
    jr nz, normal_exp_1
    ld a, e_type_enemy_ai(ix)
    cp #e_type_enemy_zombie
    jr nz, normal_exp_1
    ld a, e_zombie_raimbow(ix)
    cp #0
    jr z, normal_exp_1

    ld hl, #_sprite_explosion_rain ;;rainbow zombie explosion
    jr after_frame_death

    normal_exp_1:
    ld hl, #_sprite_explosion
    jr after_frame_death

    seg_frame_death:
    ld a, e_type(ix)
    cp #e_type_enemy
    jr nz, normal_exp_2
    ld a, e_type_enemy_ai(ix)
    cp #e_type_enemy_zombie
    jr nz, normal_exp_2
    ld a, e_zombie_raimbow(ix)
    cp #0
    jr z, normal_exp_2

    ld hl, #_sprite_explosion2_rain ;;rainbow zombie explosion
    jr after_frame_death

    normal_exp_2:
    ld hl, #_sprite_explosion2

    after_frame_death:

    ld e_sprite(ix), l
    ld e_sprite+1(ix), h

    dont_change_frame_death:

    ld a, e_deathanimCtr(ix)
    dec a
    ld e_deathanimCtr(ix), a

    jr nz, destruction_after_anim
    call enemy_died
    call man_entity_set4destruction

    destruction_after_anim:
ret

update_death_anim::
    ld hl, #update_death_anim_forone
    ld b, #e_cmps_deathanim ;; Condition: entity must have deathanim
    call man_entity_forall_matching
ret
