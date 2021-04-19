;*******************************************************************************
;
;    CS 107: Computer Architecture and Organization -- LAB 5
;    Filename: Lab05.s
;    Date: 11/21/19
;    Author: Joseph Dell'Aringa
;
;*******************************************************************************
;
	GLOBAL __main
	AREA main, CODE, READONLY
	EXPORT __main
	EXPORT __use_two_region_memory
__use_two_region_memory EQU 0
	EXPORT SystemInit
	ENTRY

	GET		BOARD.S

; You may want to define some constant(s) for delay and/or bitmask.
; if so, do it below this lines or uncomment following lines and
; type proper constant(s) instead of '??????'
;
main_delay	EQU	2500000
;RGBLED_R_BIT			EQU	BIT11
;RGBLED_G_BIT			EQU	BIT5
;RGBLED_B_BIT			EQU	BIT7
RGB_PINS	EQU (RGBLED_R_BIT:OR:RGBLED_G_BIT:OR:RGBLED_B_BIT)
	

; System Init routine
SystemInit
;
; Configure GPIO Pins
;
; --- Write your pin configuration code here....
;RGBLED_R_IOCONF_PIN		EQU	PIN11
;RGBLED_G_IOCONF_PIN		EQU	PIN5
;RGBLED_B_IOCONF_PIN		EQU	PIN7
;RGBLED_IOCONF_PORT		EQU	IOCON_P1_BASE
	LDR R1, = RGBLED_IOCONF_PORT
	;RED LED CONFIG
	LDR R0, = RGBLED_R_IOCONF_CFG
	STR R0, [R1, #RGBLED_R_IOCONF_PIN]
	;GREEN LED CONFIG
	LDR R0, = RGBLED_G_IOCONF_CFG
	STR R0, [R1, #RGBLED_G_IOCONF_PIN]
	;BLUE LED CONFIG
	LDR R0, = RGBLED_B_IOCONF_CFG
	STR R0, [R1, #RGBLED_B_IOCONF_PIN]
	



;
; Set pins for output
;
; --- Write your code here....
	LDR R2, = RGB_PINS
	LDR R1, = RGBLED_PORT
	STR R2, [R1, #DIR]
	
;
; Turn all off!
;
; --- Write your code to turn all 3 LEDs off here (optional)....
;RGB_DIR_MASK	EQU	(RGBLED_R_BIT:OR:RGBLED_G_BIT:OR:RGBLED_B_BIT)

;
	BX		LR
;
	ALIGN

__main
;
; --- You may write some additional initialization code here...

loop
	LDR		R3, =main_delay
delay_loop
	SUBS	R3, #1
	BNE		delay_loop
;
; Invert pin(s)
; --- Write your code to invert pin(s) here...
	LDR		R2, [R1, #PIN]
	EOR		R2, #RGB_PINS
	STR		R2, [R1, #PIN]
	B		loop	; Loop forever!

	ALIGN
	
	END