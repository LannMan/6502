PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003
INPUT = $1185
FIRSTNIB = $1187
SECONDNIB = $1188

; 2ms Delay for one shot @ 1Mhz
;t1_oneshot_h = %00001000
; 2ms Delay for one shot @ 3Mhz
t1_oneshot_h = %00011100
t1_oneshot_l = %00000000

; 2ms Delay for one shot @ 472hz
;t1_oneshot_h = %00000000
;t1_oneshot_l = %00000100


; VIA
T1_LC  = $6004	; Write T1 low-order latechs | Read T1 low-order-counter
T1_HC  = $6005	; Read/Write T1 high-order-counter
T1_LL  = $6006	; Read/Write T1 low-order-latch
T1_HL  = $6007	; Read/Write T1 high-order-latch
T2_LC  = $6008	; Write T2 low-order latches | Read T2 low-order-latches
T2_HC  = $6009	; Read/Write T2 high-order-counter
SR     = $600A	; Shift register
ACR    = $600b  ; Auxiliary Control Register
PCR    = $600C	; Peripheral Control Register
IFR    = $600d	; Interrupt Flag Register
IER    = $600e  ; Interrupt Enable Register

; Control words for Auxiliary Control Register in 65c22
T1_MODE0    = %00000000 	; One shot mode.
T1_MODE1    = %01000000		; Continuous mode.
T1_MODE2    = %10000000		; Mode 0. Plus PB7 one shot output
T1_MODE3    = %11000000		; Mode 1. Plus PB7 square wave output

RS	  = %01000000
RW	  = %00100000
E	  = %00010000
CLF 	  = %00000000
BF_STATUS = %01111111 

  .org $8000

; W65C22 	- LCD Module uses PB0-6 (Pin 7 not used)
; 	Data	- PB0 = D4, PB1 = D5, PB2 = D6, PB3 = D7
;	Control - PB4 = E, PB5 = RW, PB6 = RS

reset:
  ldx #$ff
  txs

  lda #%11111111	; Set all pins on port B to output
  sta DDRB
  lda #%11111111 	; Set all pins on port A to output
  sta DDRA

  lda T1_MODE0		; Set timer 1 to mode 0 without PB7 pulse
  sta ACR		; Send command to ACR
  
  lda #%00000010	; Set 4-bit mode
  sta PORTB
  jsr t1_oneshot
  lda #%00010010	; Set 4-bit mode
  sta PORTB
  jsr t1_oneshot
  lda #%00000010	; Set 4-bit mode
  sta PORTB
  jsr t1_oneshot

  lda #%00101000	; Set 4-bit mode; 2-line display; 5x8 font
  sta INPUT
  jsr lcd_instruction

  jsr t1_oneshot

  lda #%00001110	; Display on; cursor on; blink off
  sta INPUT
  jsr lcd_instruction

  jsr t1_oneshot

  lda #%00000110	; Increment and shift cursor, no scroll
  sta INPUT
  jsr lcd_instruction

  jsr t1_oneshot

  lda #%00000001	; Clear display
  sta INPUT
  jsr lcd_instruction

  jsr t1_oneshot

  ldx #0

welcome: 
  lda message,x
  beq loop
  sta INPUT
  jsr send_lcd_char

  inx 
  jmp welcome


  ;lda #$00		

loop:
  ;adc #$01
  jmp loop


lcd_wait:
  pha
  lda #BF_STATUS	; Set BF pin to input
  sta DDRB
lcd_busy:
  lda #RW
  sta PORTB
  lda #(RW | E) 
  sta PORTB
  lda PORTB
  and #%00000001
  bne lcd_busy
  
  lda #RW
  sta PORTB
  lda #%11111111	; Set all pins on port B to output
  sta DDRB
  pla
  rts

lcd_instruction:
  jsr lcd_wait
  pha
  phx
  LDX INPUT
  LDA LookupTable,X
  STA FIRSTNIB
  TXA
  AND #$0F
  STA SECONDNIB
  
  lda #CLF
  adc FIRSTNIB
  sta PORTB
  
  lda #E
  adc FIRSTNIB
  sta PORTB

  lda #CLF
  adc FIRSTNIB
  sta PORTB

  lda #CLF
  adc SECONDNIB
  sta PORTB
  
  lda #E
  adc SECONDNIB
  sta PORTB

  lda #CLF
  adc SECONDNIB
  sta PORTB
  plx
  pla
  rts

send_lcd_char:
  jsr lcd_wait
  pha
  phx
  LDX INPUT
  LDA LookupTable,X
  STA FIRSTNIB
  TXA
  AND #$0F
  STA SECONDNIB
  
  lda #CLF
  adc FIRSTNIB
  sta PORTB
  
  lda #(RS | E) 
  adc FIRSTNIB
  sta PORTB

  lda #CLF
  adc FIRSTNIB
  sta PORTB

  lda #CLF
  adc SECONDNIB
  sta PORTB
  
  lda #(RS | E) 
  adc SECONDNIB
  sta PORTB
  
  lda #CLF
  adc SECONDNIB
  sta PORTB
  plx
  pla
  rts


t1_oneshot:
  LDA #t1_oneshot_l 
  STA T1_LC    		;Low-Latch
  LDA #t1_oneshot_h     	;Delay
  STA T1_HC     	;Loads also T1CL and Starts
  LDA #$40
LOOP:
  BIT   IFR      	;Time Out?
  BEQ   LOOP
  LDA   T1_LL     	;Clear Interrupt Flag
  rts  


;the lookup table

LookupTable:
 DB $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
 DB $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
 DB $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
 DB $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
 DB $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04
 DB $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05
 DB $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06
 DB $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
 DB $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08
 DB $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09
 DB $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a, $0a
 DB $0b, $0b, $0b, $0b, $0b, $0b, $0b, $0b, $0b, $0b, $0b, $0b, $0b, $0b, $0b, $0b
 DB $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c
 DB $0d, $0d, $0d, $0d, $0d, $0d, $0d, $0d, $0d, $0d, $0d, $0d, $0d, $0d, $0d, $0d
 DB $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e, $0e
 DB $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f

message: .asciiz "-   LannMan   -                          6502 Project      "

nmi:
  rti
irq:
  rti
  
  .org $fffa
  .word nmi
  .word reset
  .word irq
