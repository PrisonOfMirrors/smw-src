DATA_07F000:
	.DB $30,$44,$58,$6C,$80,$94,$A8,$BC
	.DB $D0,$E4,$28,$2C,$80,$94,$A8,$BC
	.DB $D0,$E4,$30,$58,$00,$00,$28,$2C
	.DB $30,$54,$64,$74,$84,$94,$A4,$B4
	.DB $00,$00,$28,$2C,$30,$54,$78,$8C
	.DB $A0,$B4,$C8,$DC,$F0,$F8,$28,$2C
	.DB $30,$74,$88,$9C,$B0,$C4,$D8,$EC
	.DB $F8,$FC,$28,$2C,$30,$84,$D8,$E0
	.DB $E8,$F0,$F8,$00,$00,$00,$28,$2C
	.DB $00,$60,$74,$88,$9C,$B0,$C4,$00
	.DB $00,$00,$28,$2C,$30,$44,$58,$6C
	.DB $80,$94,$A8,$00,$00,$00,$28,$2C
	.DB $A0,$30,$34,$38,$3C,$40,$44,$48
	.DB $4C,$50,$28,$2C,$30,$48,$60,$78
	.DB $8C,$A0,$B4,$C8,$DC,$00,$28,$2C
	.DB $58,$AC,$C0,$D4,$E8,$00,$00,$00
	.DB $00,$00,$28,$2C,$58,$6C,$80,$94
	.DB $A8,$BC,$D0,$E4,$00,$00,$28,$2C
	.DB $30,$74,$B8,$C4,$D0,$DC,$E8,$F4
	.DB $00,$00,$28,$2C,$30,$48,$60,$78
	.DB $90,$A8,$C0,$D8,$00,$00,$28,$2C
	.DB $30,$44,$58,$5C,$60,$64,$68,$6C
	.DB $70,$00,$28,$2C

DATA_07F0B4:
	.DB $00,$0C,$18,$24,$30,$3C,$00,$48
	.DB $54,$60,$6C,$78,$84,$90,$9C,$00
	.DB $A8,$0C,$00,$B4

DATA_07F0C8:
	.DB $00,$08,$10,$00,$10,$00,$10,$00
	.DB $10,$00,$08,$10,$FF,$08,$08,$08
	.DB $08,$08,$FF,$00,$08,$10,$10,$08
	.DB $00,$00,$08,$10,$FF,$00,$08,$10
	.DB $08,$10,$10,$00,$08,$10,$FF,$00
	.DB $00,$10,$00,$10,$00,$08,$10,$10
	.DB $FF,$00,$08,$10,$00,$00,$08,$10
	.DB $10,$00,$08,$10,$FF,$08,$10,$00
	.DB $00,$08,$10,$00,$10,$00,$08,$10
	.DB $FF,$00,$08,$10,$10,$0C,$08,$08
	.DB $FF,$00,$08,$10,$00,$10,$00,$08
	.DB $10,$00,$10,$00,$08,$10,$FF,$00
	.DB $08,$10,$00,$10,$00,$08,$10,$10
	.DB $00,$08,$10,$FF

DATA_07F134:
	.DB $00,$00,$00,$08,$08,$10,$10,$18
	.DB $18,$20,$20,$20,$FF,$00,$08,$10
	.DB $18,$20,$FF,$00,$00,$00,$08,$10
	.DB $18,$20,$20,$20,$FF,$00,$00,$08
	.DB $10,$10,$18,$20,$20,$20,$FF,$00
	.DB $08,$08,$10,$10,$18,$18,$18,$20
	.DB $FF,$00,$00,$00,$08,$10,$10,$10
	.DB $18,$20,$20,$20,$FF,$00,$00,$08
	.DB $10,$10,$10,$18,$18,$20,$20,$20
	.DB $FF,$00,$00,$00,$08,$10,$18,$20
	.DB $FF,$00,$00,$00,$08,$08,$10,$10
	.DB $10,$18,$18,$20,$20,$20,$FF,$00
	.DB $00,$00,$08,$08,$10,$10,$10,$18
	.DB $20,$20,$20,$FF

DATA_07F1A0:
	.DB $00,$0D,$13,$1D,$27,$31,$3D,$49
	.DB $51,$5F

DATA_07F1AA:
	.DB $01,$02,$03,$04,$05,$06,$07,$08
	.DB $09,$10,$11,$12,$13,$14,$15,$16
	.DB $17,$18,$19,$20,$21,$22,$23,$24
	.DB $25,$26,$27,$28,$29,$30,$40,$50

CODE_07F1CA:
	LDA wm_SpriteDecTbl1,X
	STA m4
	STZ m2
	LDA wm_SpriteMiscTbl7,X
	LSR
	LSR
	TAX
	LDA.L DATA_07F1AA,X
	PHA
	LSR
	LSR
	LSR
	LSR
	TAX
	BEQ +
	LDA.L DATA_07F1A0,X
	TAX
	LDY #$20
	JSR CODE_07F200
+	PLA
	AND #$0F
	TAX
	LDA.L DATA_07F1A0,X
	TAX
	LDA #$20
	STA m2
	LDY #$54
	JSR CODE_07F200
	RTL

CODE_07F200:
	LDA.L DATA_07F0C8,X
	BMI CODE_07F24A
	CLC
	ADC #$64
	CLC
	ADC m2
	STA wm_ExOamSlot.1.XPos,Y
	LDA.L DATA_07F134,X
	CLC
	ADC #$40
	STA wm_ExOamSlot.1.YPos,Y
	LDA #$EF
	PHX
	LDX m4
	CPX #$10
	BCS +
	TXA
	LSR
	LSR
	TAX
	LDA.L DATA_07F24E,X
+	STA wm_ExOamSlot.1.Tile,Y
	PLX
	LDA wm_FrameA
	LSR
	AND #$0E
	ORA #$30
	STA wm_ExOamSlot.1.Prop,Y
	PHY
	TYA
	LSR
	LSR
	TAY
	LDA #$00
	STA wm_ExOamSize.1,Y
	PLY
	INY
	INY
	INY
	INY
	INX
	BRA CODE_07F200

CODE_07F24A:
	LDX wm_SprProcessIndex
	RTS

DATA_07F24E:	.DB $66,$66,$6E,$FF

CODE_07F252:
	PHX
	LDA wm_SpriteMiscTbl7,X
	LSR
	LSR
	TAX
	LDA.L DATA_07F1AA,X
	STA wm_BonusStarsGained
	PLX
	CMP #$50
	BNE +
	LDA #$0A
	JSL GivePoints
+	RTL

Sprite1656Vals:
;ABCDEEEE
;
;A disappear in smoke
;B hop in/kick shells
;C dies when jumped on
;D can be jumped on
;EEEE object clipping table $00-$0F

	.DB %01110000,%01110000,%01110000,%01110000,%00010000,%00010000,%00010000,%00010000 ; 00-07
	.DB %00010000,%00010000,%00010000,%00010000,%00010000,%00010000,%00000000,%00010000 ; 08-0F
	.DB %00010000,%00010000,%00010100,%00000000,%00000000,%00000000,%00000000,%00010000 ; 10-17
	.DB %00010000,%00010001,%10000001,%00010000,%00010000,%10000000,%00010001,%00010001 ; 18-1F
	.DB %10000010,%00000000,%00010011,%00010011,%00010011,%00010011,%00000001,%00000000 ; 20-27
	.DB %00000000,%00000000,%10000001,%00000000,%00000000,%00000000,%00000000,%00000000 ; 28-2F
	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%00000101,%10000000,%00000000 ; 30-37
	.DB %00000000,%00000000,%00000111,%00000111,%00000111,%00000000,%00000000,%00110000 ; 38-3F
	.DB %00110000,%00000000,%00000000,%00000000,%00000000,%00001000,%00000000,%00010000 ; 40-47
	.DB %00000000,%00000000,%00000000,%00010000,%00000000,%00010000,%00010000,%10001100 ; 48-4F
	.DB %10001100,%00010000,%00000000,%00000000,%00000000,%00000000,%00000001,%00000000 ; 50-57
	.DB %00000001,%00000001,%00000001,%00001011,%00001011,%00001011,%00001011,%00000000 ; 58-5F
	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 60-67
	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%00010000,%00011001,%00110000 ; 68-6F
	.DB %00001010,%00010000,%00010000,%00110000,%00000000,%00000000,%00000000,%00000000 ; 70-77
	.DB %00000000,%00000000,%00000000,%00000000,%00000001,%00000000,%00000000,%00000000 ; 78-7F
	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 80-87
	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 88-8F
	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 90-97
	.DB %00000000,%10000000,%00000000,%00010000,%00000000,%00000000,%00000000,%00010000 ; 98-9F
	.DB %00000000,%00000000,%00010000,%00000000,%00000000,%00000000,%00000000,%00000000 ; A0-A7
	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; A8-AF
	.DB %00000000,%00001101,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; B0-B7
	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%01110000,%00010000,%00001110 ; B8-BF
	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%11111111,%00000000 ; C0-C7
	.DB %00000000 ; C8

Sprite1662Vals:
;ABCCCCCC
;
;A fall straight down when killed
;B use shell as death frame
;CCCCCC sprite clipping table offset

	.DB %00000000,%00000000,%00000000,%00000000,%01000000,%01000000,%01000000,%01000000 ; 00-07
	.DB %01000000,%01000000,%01000000,%01000000,%01000000,%00000000,%00001010,%00000000 ; 08-0F
	.DB %00000000,%00000000,%00001000,%00000000,%00000000,%00000000,%00000000,%10000000 ; 10-17
	.DB %10000000,%10000001,%00000001,%10000000,%10000000,%00000000,%10000001,%10000001 ; 18-1F
	.DB %00000000,%00000000,%10000001,%10000001,%10000001,%10000001,%00000110,%00000000 ; 20-27
	.DB %00000111,%00000110,%00000001,%00000000,%00000000,%00000000,%00000000,%00000000 ; 28-2F
	.DB %00110111,%00000000,%00110111,%00000000,%00000000,%00001001,%00000001,%00000000 ; 30-37
	.DB %00000000,%00000000,%00001110,%00001110,%00001110,%00000000,%00000000,%00000000 ; 38-3F
	.DB %00000000,%00001111,%00001111,%00010000,%00010100,%00000000,%00001101,%10000000 ; 40-47
	.DB %00000000,%00011101,%00000000,%10000000,%10000000,%10000000,%10000000,%00000000 ; 48-4F
	.DB %00000000,%10000000,%00000010,%00001100,%00000011,%00000101,%00000100,%00000101 ; 50-57
	.DB %00000100,%00000000,%00000000,%00000100,%00000101,%00000100,%00000101,%00000000 ; 58-5F
	.DB %00011101,%00001100,%00000100,%00000100,%00010010,%00100000,%00100001,%00101100 ; 60-67
	.DB %00110100,%00000100,%00000100,%00000100,%00000100,%00001100,%00010110,%00000000 ; 68-6F
	.DB %00010111,%10000000,%10000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 70-77
	.DB %00000000,%00000000,%00000000,%00011110,%00110101,%00000000,%00000000,%00000000 ; 78-7F
	.DB %00001100,%00000000,%00000000,%00001100,%00001100,%00000000,%00000000,%00111010 ; 80-87
	.DB %00001000,%00001000,%00000000,%00000000,%00000000,%00000000,%00011100,%00001000 ; 88-8F
	.DB %00111000,%00001101,%00001101,%00001101,%00001101,%00001101,%00001101,%00001101 ; 90-97
	.DB %00001101,%00000000,%00001101,%10000000,%00011101,%00000000,%00000000,%10110110 ; 98-9F
	.DB %00100100,%00100011,%00111011,%00011111,%00100010,%00000000,%00100111,%00000000 ; A0-A7
	.DB %00000000,%00101000,%00000000,%00101010,%00101011,%00101011,%00000000,%00000000 ; A8-AF
	.DB %00000000,%00001100,%00000000,%00101101,%00000000,%00000000,%00000000,%00101110 ; B0-B7
	.DB %00101110,%00001100,%00011101,%00101111,%00001100,%00000000,%10000000,%00110000 ; B8-BF
	.DB %00110010,%00110001,%00000000,%00000000,%00110011,%00000111,%11111111,%00000000 ; C0-C7
	.DB %00001100 ; C8

Sprite166EVals:
;ABCDEEEF
;
;A don't interact with layer 2
;B disable water splash
;C disable cape kill
;D disable fireball kill
;EEE palette
;F use second graphics page

	.DB %00001010,%00001000,%00000110,%00000100,%00001010,%00001000,%00000110,%00000100 ; 00-07
	.DB %00001010,%00001010,%00001000,%00001000,%00000100,%00010111,%00110010,%00000100 ; 08-0F
	.DB %00000100,%00011101,%00111101,%00001001,%00001001,%01000101,%01000101,%10000101 ; 10-17
	.DB %10000101,%00001011,%00001000,%00000001,%00010010,%00010101,%00001001,%01001111 ; 18-1F
	.DB %00011100,%00100100,%00001011,%00001001,%00001011,%00001001,%00110011,%00110011 ; 20-27
	.DB %11111101,%00101011,%00001000,%00110101,%00111011,%00111010,%00011001,%00111010 ; 28-2F
	.DB %00010011,%00010011,%00010011,%00110100,%00111001,%00101010,%00010101,%11110011 ; 30-37
	.DB %11111101,%11111101,%00110111,%00110111,%00110111,%11000111,%00110000,%00000101 ; 38-3F
	.DB %00010101,%00110111,%00110111,%00110111,%00110011,%00110000,%10001011,%10000101 ; 40-47
	.DB %00011101,%00111011,%00111011,%00001001,%00110100,%00000001,%00000001,%00001000 ; 48-4F
	.DB %00001000,%00001001,%00100000,%00110000,%00100000,%11100011,%11100011,%11100011 ; 50-57
	.DB %11100011,%11100011,%11100011,%11100001,%11100001,%11101011,%11101011,%11100011 ; 58-5F
	.DB %11100011,%11100011,%11100001,%11100001,%10100011,%10100011,%10100011,%10100011 ; 60-67
	.DB %10100011,%11100011,%11110000,%11100011,%11110011,%00111111,%00111111,%00001111 ; 68-6F
	.DB %00110101,%00001011,%00001001,%00000111,%00001000,%00001010,%00100000,%00100100 ; 70-77
	.DB %00001010,%00111010,%00111010,%00100000,%00100000,%00100001,%00101000,%00100000 ; 78-7F
	.DB %00100000,%00000000,%00100000,%00100000,%00100000,%00100000,%11110101,%00100000 ; 80-87
	.DB %00100000,%00100000,%00100000,%00100000,%00100000,%00100000,%00110000,%00111011 ; 88-8F
	.DB %11110011,%00001011,%00001011,%00001011,%00001011,%00001011,%00001011,%00001011 ; 90-97
	.DB %00001011,%10011011,%10010011,%00000000,%00110000,%00110001,%00110001,%00110001 ; 98-9F
	.DB %11111011,%11111011,%10111011,%11100011,%11110011,%00110101,%00110101,%00111001 ; A0-A7
	.DB %00110101,%00110101,%01111101,%00000111,%00110111,%00110111,%00111101,%00111111 ; A8-AF
	.DB %00111111,%00110000,%00110001,%00110001,%00110001,%00000100,%00110101,%00111011 ; B0-B7
	.DB %00111011,%00110110,%01111011,%00111011,%00110011,%00000110,%00001011,%00010001 ; B8-BF
	.DB %11110101,%11110101,%11001011,%11001101,%11110011,%00111111,%11111111,%00100000 ; C0-C7
	.DB %00111000 ; C8

Sprite167AVals:
;ABCDEFGH
;
;A don't use default interaction with mario
;B gives power-up when eaten by yoshi
;C process mario interaction every frame
;D can be kicked like a shell
;E don't change into shell when stunned
;F process when off screen
;G invincible to star/cape/fire/bouncing blocks
;H don't disable clipping when killed with star

	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 00-07
	.DB %00000000,%00000000,%00000000,%00000000,%00000000,%00011000,%00000010,%00011000 ; 08-0F
	.DB %00000000,%00000000,%10000001,%00000000,%00000001,%10011001,%10011001,%00000000 ; 10-17
	.DB %00000000,%00000001,%00000000,%00000000,%00000000,%00000000,%00000000,%00000010 ; 18-1F
	.DB %00000000,%11000010,%00000000,%00000000,%00000000,%00000000,%00000001,%00000001 ; 20-27
	.DB %00000001,%10000011,%00000000,%00000000,%10011010,%00011110,%00000001,%10111110 ; 28-2F
	.DB %10000001,%10000001,%10000001,%00000010,%00011000,%10000111,%00000010,%00000001 ; 30-37
	.DB %00000001,%00000001,%00000001,%00000001,%00000001,%00000000,%00111110,%00000001 ; 38-3F
	.DB %00000001,%10000010,%10000010,%10000010,%00000001,%00000010,%10000001,%00000000 ; 40-47
	.DB %00000000,%10100010,%10000010,%00000001,%00000000,%00000000,%00000000,%00000000 ; 48-4F
	.DB %00000000,%00000000,%10100010,%00001000,%00000010,%10100010,%10100010,%10100010 ; 50-57
	.DB %10100010,%10100010,%10100010,%10100010,%10100010,%10100010,%10100010,%10100010 ; 58-5F
	.DB %10100010,%10100010,%10100010,%10100010,%10100010,%00100010,%00100010,%00100010 ; 60-67
	.DB %00100010,%10100010,%10100010,%10100010,%10100010,%11100010,%00000001,%00000001 ; 68-6F
	.DB %00000001,%00000001,%00000001,%00000001,%11000010,%11000010,%11000010,%11000010 ; 70-77
	.DB %11000010,%10000010,%10000010,%10100010,%10100010,%10011010,%10000000,%10000010 ; 78-7F
	.DB %00111110,%11000010,%10000010,%10000010,%10000010,%10010010,%10000000,%10000010 ; 80-87
	.DB %10000010,%10000010,%00000010,%00000010,%00000010,%00000010,%10100010,%10100010 ; 88-8F
	.DB %00000001,%11111001,%11111001,%11111001,%11111001,%11111001,%11111001,%11111001 ; 90-97
	.DB %11111001,%00000001,%00000001,%00000001,%10100010,%10000001,%00000000,%00000001 ; 98-9F
	.DB %10000000,%00000000,%00011001,%10100010,%00000001,%00000001,%00000001,%00000000 ; A0-A7
	.DB %00000000,%10000001,%00000001,%10000001,%10000001,%10000001,%00000000,%00000001 ; A8-AF
	.DB %00000001,%10100010,%00000000,%00000000,%00000000,%00000000,%00000000,%10100010 ; B0-B7
	.DB %10100010,%10100010,%10100010,%10100010,%10100000,%00000001,%00000001,%10100001 ; B8-BF
	.DB %10100010,%10100010,%00000001,%00000001,%10100010,%10100011,%11111111,%10000010 ; C0-C7
	.DB %10100010 ; C8

Sprite1686Vals:
;ABCDEFGH
;
;A don't interact with objects
;B spawns a new sprite
;C don't turn into coin when goal passed
;D don't change direction if touched
;E don't interact with other sprites
;F weird ground behavior
;G stay in yoshi's mouth
;H inedible

	.DB %00000000,%00000000,%00000000,%00000000,%00000010,%00000010,%00000010,%00000010 ; 00-07
	.DB %01000010,%01010010,%01010010,%01010010,%01010010,%00000000,%00001001,%00000000 ; 08-0F
	.DB %01000000,%00000000,%00000001,%00000000,%00000000,%00010000,%00010000,%10010000 ; 10-17
	.DB %10010000,%00000001,%00010000,%00010000,%10010000,%00000000,%00010001,%00000001 ; 18-1F
	.DB %00000001,%00001000,%00000000,%00000000,%00000000,%00000000,%00000001,%00000001 ; 20-27
	.DB %00011001,%10000000,%00000000,%00111001,%00001001,%00001001,%00010000,%00001010 ; 28-2F
	.DB %00001001,%00001001,%00001001,%10011001,%00011000,%00101001,%00001000,%00011001 ; 30-37
	.DB %00011001,%00011001,%00010001,%00010001,%00010101,%00010000,%00001010,%01000000 ; 38-3F
	.DB %01000000,%10001101,%10001101,%10001101,%00010001,%00011000,%00010001,%10000000 ; 40-47
	.DB %00000000,%00101001,%00101001,%00010000,%00010000,%00010000,%00010000,%00000000 ; 48-4F
	.DB %00000000,%00010000,%00101001,%00100000,%00101001,%10101001,%10101001,%10101001 ; 50-57
	.DB %10101001,%10101001,%10101001,%10101001,%10101001,%10101001,%10101001,%10101001 ; 58-5F
	.DB %00101001,%00101001,%00111101,%00111101,%00111101,%00111101,%00111101,%00111101 ; 60-67
	.DB %00111101,%00101001,%00011001,%00101001,%00101001,%01011001,%01011001,%00011000 ; 68-6F
	.DB %00011000,%00010000,%00010000,%01010000,%00101000,%00101000,%00101000,%00101000 ; 70-77
	.DB %00001000,%00101001,%00101001,%00111001,%00111001,%00101001,%00101000,%00101000 ; 78-7F
	.DB %00111010,%00101000,%00101001,%00110001,%00110001,%00101001,%00000000,%00101001 ; 80-87
	.DB %00101001,%00101001,%00101001,%00101001,%00101001,%00101001,%00101001,%00101001 ; 88-8F
	.DB %00010001,%00010001,%00010001,%00010001,%00010001,%00010001,%00010001,%00010001 ; 90-97
	.DB %00010001,%00010000,%00010001,%00000001,%00111001,%00010000,%00011001,%00011001 ; 98-9F
	.DB %00011001,%00011001,%00000001,%00101001,%10011000,%00010100,%00010100,%00010000 ; A0-A7
	.DB %00011000,%00011000,%00011000,%00000000,%00011001,%00011001,%00011001,%00011001 ; A8-AF
	.DB %00011001,%00011101,%00011101,%00011001,%00011001,%00011000,%00011000,%00011001 ; B0-B7
	.DB %00011001,%00011001,%00011101,%00011001,%00011000,%00000000,%00010000,%00000000 ; B8-BF
	.DB %10011001,%10011001,%00010000,%10010000,%10101001,%10111001,%11111111,%00111001 ; C0-C7
	.DB %00011001 ; C8

Sprite190FVals:
;ABCDEFGH
;
;A don't get stuck in walls (carryable sprites)
;B don't turn into a coin with silver POW
;C death frame 2 tiles high
;D can be jumped on with upward Y speed
;E takes 5 fireballs to kill
;F can't be killed by sliding
;G don't erase when goal passed
;H make platform passable from below

	.DB %00000000,%00000000,%00000000,%00000000,%10100000,%10100000,%10100000,%10100000 ; 00-07
	.DB %10110000,%10110000,%10110000,%10110000,%10100000,%10000000,%01000100,%10000000 ; 08-0F
	.DB %10000000,%10000000,%00100000,%00000000,%00000000,%00000000,%00000000,%00000000 ; 10-17
	.DB %00000000,%00100000,%00100000,%00000000,%00000000,%00000000,%01100000,%00100000 ; 18-1F
	.DB %00000100,%00000100,%00100000,%00100000,%00100000,%00100000,%00100100,%00000100 ; 20-27
	.DB %00000000,%01000100,%00100000,%00000100,%01000100,%11000100,%00000000,%11000100 ; 28-2F
	.DB %00100100,%00100100,%00100100,%00000100,%00000100,%01000110,%00000100,%00000100 ; 30-37
	.DB %00000100,%00000100,%00000100,%00000100,%00000100,%00000000,%11000100,%00000000 ; 38-3F
	.DB %00000000,%00000101,%00000101,%00000101,%00000100,%01000100,%01001000,%00000000 ; 40-47
	.DB %00000000,%01000000,%01000000,%01000000,%00000100,%00000000,%00000000,%00000000 ; 48-4F
	.DB %00000000,%00000000,%01100100,%11000100,%01100100,%01000101,%01100101,%01000101 ; 50-57
	.DB %01100101,%01000101,%01000101,%01000101,%01000101,%01100101,%01100101,%01000101 ; 58-5F
	.DB %01000101,%01000101,%01000101,%01000101,%01000101,%01000101,%01000101,%00000101 ; 60-67
	.DB %00000101,%01000100,%01000100,%01000100,%01000100,%01000110,%00000000,%00000000 ; 68-6F
	.DB %00000000,%00010000,%00010000,%00010000,%01000000,%01000000,%01000000,%01000000 ; 70-77
	.DB %01000000,%01000000,%01000000,%01000010,%01000010,%01000000,%01000000,%01000000 ; 78-7F
	.DB %11000000,%01000000,%01000000,%01000000,%01000000,%00000000,%00000000,%01000000 ; 80-87
	.DB %01000000,%01000000,%01000000,%01000000,%01000000,%01000000,%01000000,%00000001 ; 88-8F
	.DB %00000000,%01001000,%01001000,%01001000,%01001000,%01001000,%01001000,%01001000 ; 90-97
	.DB %01001000,%00000000,%01000000,%01000000,%01000000,%00000000,%00000100,%00000100 ; 98-9F
	.DB %01000000,%01000000,%00000000,%01000001,%00000000,%00000000,%00000000,%00000000 ; A0-A7
	.DB %00000000,%01000000,%00000000,%00000000,%01000000,%01000000,%00000000,%00000000 ; A8-AF
	.DB %00000000,%01000000,%00000000,%00000000,%00000000,%00000000,%00000000,%01000001 ; B0-B7
	.DB %01000001,%01000000,%01000001,%01000000,%00000000,%00000000,%00000000,%00100000 ; B8-BF
	.DB %01000111,%01000101,%00000000,%00000000,%01000001,%01000001,%11111111,%01000000 ; C0-C7
	.DB %01000000 ; C8

ZeroSpriteTables:
	STZ wm_SprInWaterTbl,X
	STZ wm_SprBehindScrn,X
	STZ wm_SpriteState,X
	STZ wm_SpriteMiscTbl3,X
	STZ wm_SpriteMiscTbl4,X
	STZ wm_SpriteMiscTbl5,X
	STZ wm_SpriteDir,X
	STZ wm_SprObjStatus,X
	STZ wm_SpriteOffTbl,X
	STZ wm_SpriteGfxTbl,X
	STZ wm_SpriteDecTbl1,X
	STZ wm_SpriteDecTbl2,X
	STZ wm_SpriteDecTbl3,X
	STZ wm_SpriteDecTbl4,X
	STZ wm_DisSprCapeContact,X
	STZ wm_SprChainKillTbl,X
	STZ wm_SpriteMiscTbl6,X
	STZ wm_SpriteSpeedX,X
	STZ wm_SpriteXAcc,X
	STZ wm_SpriteSpeedY,X
	STZ wm_SpriteYAcc,X
	STZ wm_SpriteInterTbl,X
	STZ wm_SpriteEatenTbl,X
	STZ wm_SpriteDecTbl6,X
	STZ wm_Tweaker1656,X
	STZ wm_Tweaker1662,X
	STZ wm_Tweaker166E,X
	STZ wm_Tweaker167A,X
	STZ wm_Tweaker1686,X
	STZ wm_SprStompImmuneTbl,X
	STZ wm_SpriteMiscTbl8,X
	STZ wm_SpriteMiscTbl7,X
	STZ wm_SpriteMiscTbl1,X
	STZ wm_1FD6,X
	LDA #$01
	STA wm_OffscreenHorz,X
	RTL

LoadSpriteTables:
	PHY
	PHX
	LDA wm_SpriteNum,X
	TAX
	LDA.L Sprite166EVals,X
	AND #$0F
	PLX
	STA wm_SpritePal,X
	JSL LoadTweakerBytes
	PLY
	RTL

LoadTweakerBytes:
	PHY
	PHX
	TXY
	LDX wm_SpriteNum,Y
	LDA.L Sprite1656Vals,X
	STA wm_Tweaker1656,Y
	LDA.L Sprite1662Vals,X
	STA wm_Tweaker1662,Y
	LDA.L Sprite166EVals,X
	STA wm_Tweaker166E,Y
	LDA.L Sprite167AVals,X
	STA wm_Tweaker167A,Y
	LDA.L Sprite1686Vals,X
	STA wm_Tweaker1686,Y
	LDA.L Sprite190FVals,X
	STA wm_Tweaker190F,Y
	PLX
	PLY
	RTL

InitSpriteTables:
	JSL ZeroSpriteTables
	JSL LoadSpriteTables
	RTL

CircleCoords:
	.DW $00,$03,$06,$09,$0C,$0F,$12,$15,$19,$1C,$1F,$22,$25,$28,$2B,$2E
	.DW $31,$35,$38,$3B,$3E,$41,$44,$47,$4A,$4D,$50,$53,$56,$59,$5C,$5F
	.DW $61,$64,$67,$6A,$6D,$70,$73,$75,$78,$7B,$7E,$80,$83,$86,$88,$8B
	.DW $8E,$90,$93,$95,$98,$9B,$9D,$9F,$A2,$A4,$A7,$A9,$AB,$AE,$B0,$B2
	.DW $B5,$B7,$B9,$BB,$BD,$BF,$C1,$C3,$C5,$C7,$C9,$CB,$CD,$CF,$D1,$D3
	.DW $D4,$D6,$D8,$D9,$DB,$DD,$DE,$E0,$E1,$E3,$E4,$E6,$E7,$E8,$EA,$EB
	.DW $EC,$ED,$EE,$EF,$F1,$F2,$F3,$F4,$F4,$F5,$F6,$F7,$F8,$F9,$F9,$FA
	.DW $FB,$FB,$FC,$FC,$FD,$FD,$FE,$FE,$FE,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.DW $0100,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FE,$FE,$FE,$FD,$FD,$FC,$FC,$FB
	.DW $FB,$FA,$F9,$F9,$F8,$F7,$F6,$F5,$F4,$F4,$F3,$F2,$F1,$EF,$EE,$ED
	.DW $EC,$EB,$EA,$E8,$E7,$E6,$E4,$E3,$E1,$E0,$DE,$DD,$DB,$D9,$D8,$D6
	.DW $D4,$D3,$D1,$CF,$CD,$CB,$C9,$C7,$C5,$C3,$C1,$BF,$BD,$BB,$B9,$B7
	.DW $B5,$B2,$B0,$AE,$AB,$A9,$A7,$A4,$A2,$9F,$9D,$9B,$98,$95,$93,$90
	.DW $8E,$8B,$88,$86,$83,$80,$7E,$7B,$78,$75,$73,$70,$6D,$6A,$67,$64
	.DW $61,$5F,$5C,$59,$56,$53,$50,$4D,$4A,$47,$44,$41,$3E,$3B,$38,$35
	.DW $31,$2E,$2B,$28,$25,$22,$1F,$1C,$19,$15,$12,$0F,$0C,$09,$06,$03

GuidedLine:
@76:	.DB $F0,$E0,$D0,$C1,$B1,$A1,$92,$82,$73,$64,$55,$46,$37,$28,$29,$1A,$1B,$1C,$0D,$0E,$0F
@77:	.DB $00,$01,$02,$13,$14,$15,$26,$27,$38,$49,$5A,$6B,$7C,$8D,$9D,$AE,$BE,$CE,$DF,$EF,$FF
@78:	.DB $00,$10,$20,$31,$41,$51,$62,$72,$83,$94,$A5,$B6,$C7,$D8,$D9,$EA,$EB,$EC,$FD,$FD,$FF
@79:	.DB $F0,$F1,$F2,$E3,$E4,$E5,$D6,$D7,$C8,$B9,$AA,$9B,$8C,$7D,$6D,$5E,$4E,$3E,$2F,$1F,$0F
@7A:	.DB $F5,$E6,$D6,$C7,$B8,$A9,$9A,$8B,$7C,$6D,$6E,$5F
@7B:	.DB $40,$41,$32,$33,$24,$25,$26,$17,$18,$19,$1A,$0B,$0C,$0D,$0E,$0F
@7C:	.DB $F0,$E0,$D0,$C0,$B0,$A1,$91,$81,$71,$62,$52,$42,$33,$23,$14,$04
@7D:	.DB $0B,$1B,$2C,$3C,$4D,$5D,$6D,$7E,$8E,$9E,$AE,$BF,$CF,$DF,$EF,$FF
@7E:	.DB $00,$01,$02,$03,$04,$15,$16,$17,$18,$29,$2A,$2B,$3C,$3D,$4E,$4F
@7F:	.DB $50,$61,$62,$73,$84,$95,$A6,$B7,$C8,$D9,$E9,$FA
@80:	.DB $05,$16,$26,$37,$48,$59,$6A,$7B,$8C,$9D,$9E,$AF
@81:	.DB $B0,$B1,$C2,$C3,$D4,$D5,$D6,$E7,$E8,$E9,$EA,$FB,$FC,$FD,$FE,$FF
@82:	.DB $00,$10,$20,$30,$40,$51,$61,$71,$81,$92,$A2,$B2,$C3,$D3,$E4,$F4
@83:	.DB $FB,$EB,$DC,$CC,$BD,$AD,$9D,$8E,$7E,$6E,$5E,$4F,$3F,$2F,$1F,$0F
@84:	.DB $F0,$F1,$F2,$F3,$F4,$E5,$E6,$E7,$E8,$D9,$DA,$DB,$CC,$CD,$BE,$BF
@85:	.DB $A0,$91,$92,$83,$74,$65,$56,$47,$38,$29,$19,$0A
@86:	.DB $F0,$E1,$D2,$D2,$C3,$B4,$A5,$A5,$96,$87,$78,$78,$69,$5A,$4B,$4B,$3C,$2D,$1E,$1E,$0F
@87:	.DB $00,$11,$22,$22,$33,$44,$55,$55,$66,$77,$88,$88,$99,$AA,$BB,$BB,$CC,$DD,$EE,$EE,$FF
@88:	.DB $F8,$E8,$D9,$C9,$BA,$AA,$9B,$8B,$7C,$6C,$5D,$4D,$3E,$2E,$1F,$0F
@89:	.DB $00,$10,$21,$31,$42,$52,$63,$73,$84,$94,$A5,$B5,$C6,$D6,$E7,$F7
@8A:	.DB $F0,$E0,$D1,$C1,$B2,$A2,$93,$83,$74,$64,$55,$45,$36,$26,$17,$07
@8B:	.DB $08,$18,$29,$39,$4A,$5A,$6B,$7B,$8C,$9C,$AD,$BD,$CE,$DE,$EF,$FF
@8C:	.DB $F0,$F1,$E2,$E3,$D4,$D5,$C6,$C7,$B8,$B9,$AA,$AB,$9C,$9D,$8E,$8F
@8D:	.DB $70,$71,$62,$63,$54,$55,$46,$47,$38,$39,$2A,$2B,$1C,$1D,$0E,$0F
@8E:	.DB $00,$01,$12,$13,$24,$25,$36,$37,$48,$49,$5A,$5B,$6C,$6D,$7E,$7F
@8F:	.DB $80,$81,$92,$93,$A4,$A5,$B6,$B7,$C8,$C9,$DA,$DB,$EC,$ED,$FE,$FF
@90:	.DB $00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$A0,$B0,$C0,$D0,$E0,$F0
@91:	.DB $0F,$1F,$2F,$3F,$4F,$5F,$6F,$7F,$8F,$9F,$AF,$BF,$CF,$DF,$EF,$FF
@92:	.DB $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
@93:	.DB $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF
@94:	.DB $F0,$E1,$D2,$D2,$C3,$B4,$A5,$A5,$96,$87,$78,$78,$69,$5A,$4B,$4B,$3C,$2D,$1E,$1E,$0F
@95:	.DB $00,$11,$22,$22,$33,$44,$55,$55,$66,$77,$88,$88,$99,$AA,$BB,$BB,$CC,$DD,$EE,$EE,$FF

@Ptrs:
@@L:
	.DB <@76,<@77,<@78,<@79,<@7A,<@7B,<@7C,<@7D
	.DB <@7E,<@7F,<@80,<@81,<@82,<@83,<@84,<@85
	.DB <@86,<@87,<@88,<@89,<@8A,<@8B,<@8C,<@8D
	.DB <@8E,<@8F,<@90,<@91,<@92,<@93,<@94,<@95

@@H:
	.DB >@76,>@77,>@78,>@79,>@7A,>@7B,>@7C,>@7D
	.DB >@7E,>@7F,>@80,>@81,>@82,>@83,>@84,>@85
	.DB >@86,>@87,>@88,>@89,>@8A,>@8B,>@8C,>@8D
	.DB >@8E,>@8F,>@90,>@91,>@92,>@93,>@94,>@95

DATA_07FC33:	.DB $E0,$20,$E0,$20

DATA_07FC37:	.DB $F0,$F0,$10,$10

CODE_07FC3B:
	PHX
	LDX #$03
-	JSL CODE_07FC47
	DEX
	BPL -
	PLX
	RTL

CODE_07FC47:
	LDY #$07
-	LDA wm_ExSpriteNum,Y
	BEQ CODE_07FC52
	DEY
	BPL -
	RTL

CODE_07FC52:
	LDA #$10
	STA wm_ExSpriteNum,Y
	PHX
	LDX wm_SprProcessIndex
	LDA wm_SpriteYLo,X
	CLC
	ADC #$04
	STA wm_ExSpriteYLo,Y
	LDA wm_SpriteYHi,X
	ADC #$00
	STA wm_ExSpriteYHi,Y
	LDA wm_SpriteXLo,X
	CLC
	ADC #$04
	STA wm_ExSpriteXLo,Y
	LDA wm_SpriteXHi,X
	ADC #$00
	STA wm_ExSpriteXHi,Y
	PLX
	LDA.L DATA_07FC33,X
	STA wm_ExSprSpeedX,Y
	LDA.L DATA_07FC37,X
	STA wm_ExSprSpeedY,Y
	LDA #$17
	STA wm_ExSpriteTbl2,Y
	RTL