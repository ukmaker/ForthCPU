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
#LEDS:   0xfff2

#UART_STATUS:     0xffe0
#UART_DATA:       0xffe2
#UART_RX_CLK_DIV: 0xffe4
#UART_TX_CLK_DIV: 0xffe6


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

HELLO:
    JPL PRINTIT
    ." Hello world!"
PRINTIT:
    LD R4,12 ; Length of string
    LD R5,#UART_DATA
    LD R7,#UART_STATUS
PRINTCHAR:
    LD_B R6,(RL++)
    ST_B (R5),R6
    
    LD RA,(R7)
    ; Wait for ready
    AND RA,4
    JR[Z] PRINTCHAR


    SUB R4,1
    JR[NZ] PRINTCHAR
    JR BLINK


;;;;
; That's all folks
;;;;
