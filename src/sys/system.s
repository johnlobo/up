;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
;;  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
;;
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

.module system_system

;;.include "sys/audio.h.s"
.include "system.h.s"
.include "common.h.s"
.include "cpctelera.h.s"
.include "sys/render.h.s"

;;
;; Start of _DATA area 
;;
.area _DATA

nInterrupt:: .db 0

;;
;; Start of _CODE area
;; 
.area _CODE



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;DESCRIPTION
;; Called every interruption
;;
;;DESTROYS: AF, BC, DE
;;
set_int_handler:
	ld hl, #0x38
	ld (hl), #0xc3
	inc hl
	ld (hl), #<int_handler1
	inc hl
	ld (hl), #>int_handler1
	inc hl
	ld (hl), #0xc9
   m_reset_nInterrupt                           ;; reset number of interruption
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;DESCRIPTION
;; Called on the first interruption
;;
;;DESTROYS: AF, BC, DE
;;
int_handler1:
   ;;cpctm_setBorder_asm HW_WHITE
   m_inc_nInterrupt                                ;;increment the number of interruption
	ld hl, #int_handler2
 	call cpct_setInterruptHandler_asm	
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;DESCRIPTION
;; Called every interruption
;;
;;DESTROYS: AF, BC, DE
;;
int_handler2:
   ;;cpctm_setBorder_asm HW_RED

   m_inc_nInterrupt                                ;;increment the number of interruption

	call cpct_scanKeyboard_if_asm


	ld hl, #int_handler3
   call cpct_setInterruptHandler_asm
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;DESCRIPTION
;; Called every interruption
;;
;;DESTROYS: AF, BC, DE
;;
int_handler3:
   ;;cpctm_setBorder_asm HW_GREEN

   m_inc_nInterrupt                                ;;increment the number of interruption

	ld hl, #int_handler4
   call cpct_setInterruptHandler_asm
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;DESCRIPTION
;; Called every interruption
;;
;;DESTROYS: AF, BC, DE
;;
int_handler4:
   ;;cpctm_setBorder_asm HW_BLUE

   m_inc_nInterrupt                                ;;increment the number of interruption

	ld hl, #int_handler5
   call cpct_setInterruptHandler_asm
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;DESCRIPTION
;; Called every interruption
;;
;;DESTROYS: AF, BC, DE
;;
int_handler5:
   ;;cpctm_setBorder_asm HW_ORANGE

   m_inc_nInterrupt

;;  ld a, (music_switch)
;;  or a
;;  jr z, int_handler5_exit
;;  exx
;;  ex af', af  
;;  push af
;;  push bc
;;  push de
;;  push hl
;;  call PLY_AKG_PLAY
;;  pop hl
;;  pop de
;;  pop bc
;;  pop af
;;  ex af', af  
;;  exx
int_handler5_exit:
	ld hl, #int_handler6
   call cpct_setInterruptHandler_asm
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;DESCRIPTION
;; Called every interruption
;;
;;DESTROYS: AF, BC, DE
;;
int_handler6:
   ;;cpctm_setBorder_asm HW_PURPLE

   m_reset_nInterrupt

	ld hl, #int_handler1
   call cpct_setInterruptHandler_asm
	ret



;;-----------------------------------------------------------------
;;
;; sys_system_disable_firmware
;; Disable firmware
;;  Input:  
;;  Output: 
;;  Destroyed: af, bc,de, hl
;;
sys_system_disable_firmware::
   call cpct_disableFirmware_asm
   ld hl, #int_handler1
   call cpct_waitVSYNC_asm
   halt
   halt
   call cpct_waitVSYNC_asm
   call cpct_setInterruptHandler_asm
   
   ret


