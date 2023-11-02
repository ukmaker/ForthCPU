;;;;
; Basic test to flash the LEDS on the dev board
;;;;
; Remember bootstrap locations
; 0000 - Cold
; 0004 - INT0
; 0008 - INT1
;;;;

#COLD:  0x0000
#INTV0: 0x0004
#INTV1: 0x0008

#HALTED: 0xAAAA
#LEDS:   0xfff9

.ORG #COLD
    JR COLD_BOOT

.ORG #INT0
    JR INT0_HANDLER

.ORG #INT1
    JR INT1_HANDLER

INT0_HANDLER:
INT1_HANDLER:
    LD   R0,#HALTED
    LD   RA,#LEDS 
    ST   (RA),R0
    HALT


COLD_BOOT:
    LD   R1,#LEDS
    LD   R2,0xffff ; Delay count
    LD   R0,0xc183 ; Alternating LED pattern

 BLINK:
    MOV R3,R2
    ST  (R1),R0 ; Light the LEDs
    ROT R0,1
DELAY:
    SUBI R3,1
    JR[NZ] DELAY
    JR BLINK

;;;;
; That's all folks
;;;;
