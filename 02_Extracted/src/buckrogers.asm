; ===========================================================================
; Buck Rogers: Countdown to Doomsday (Mega Drive/Genesis) - Disassembly
; Basis-ROM: Buck Rogers - Countdown to Doomsday (USA, Europe).md
;            CRC32 44E3BFFF, 1.048.576 Byte
; Erzeugt mit 03_Tools/disasm.py + 03_Tools/gen_asm.py. Datenbereiche: data/*.bin
; (aus der eigenen ROM erzeugt mit 03_Tools/extract.py, nicht im Repo).
; ===========================================================================

	include "src/macrosetup.asm"

; --- Vektortabelle
	dc.l	$00FFFFF6
	dc.l	sub_200
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	sub_F1B64
	dc.l	$00000000
	dc.l	sub_DE8C
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
; --- ROM-Header
Header:
	dc.b	"SEGA GENESIS    "
	dc.b	"(C)T-50 1991.DEC"
	dc.b	"BUCK RODGERS COU"
	dc.b	"NTDOWN TO DOOMSD"
	dc.b	"                "
	dc.b	"BUCK RODGERS COU"
	dc.b	"NTDOWN TO DOOMSD"
	dc.b	"                "
	dc.b	$47,$4D,$20,$54,$2D,$35,$30,$32,$38,$36,$20,$2D,$30,$30,$D7,$B6
	dc.b	"J               "
	dc.b	$00,$00,$00,$00,$00,$0F,$FF,$FF,$00,$FF,$00,$00,$00,$FF,$FF,$FF
	dc.b	"                "
	dc.b	"                "
	dc.b	"                "
	dc.b	"                "
	dc.b	"U               "


; ---------------------------------------------------------------------------
sub_200:
	tst.l	($A10008).l
	bne.s	loc_20E
	tst.w	($A1000C).l
loc_20E:
	bne.s	loc_28C
	lea	dat_28E(pc),a5
	movem.w	(a5)+,d5-d7
	movem.l	(a5)+,a0-a4
	move.b	-$10FF(a1),d0
	andi.b	#$F,d0
	beq.s	loc_22E
	move.l	#$53454741,$2F00(a1)
loc_22E:
	move.w	(a4),d0
	moveq	#$0,d0
	movea.l	d0,a6
	move.l	a6,usp
	moveq	#$17,d1
loc_238:
	move.b	(a5)+,d5
	move.w	d5,(a4)
	add.w	d7,d5
	dbf	d1,loc_238
	move.l	(a5)+,(a4)
	move.w	d0,(a3)
	move.w	d7,(a1)
	move.w	d7,(a2)
loc_24A:
	btst	d0,(a1)
	bne.s	loc_24A
	moveq	#$25,d2
loc_250:
	move.b	(a5)+,(a0)+
	dbf	d2,loc_250
	move.w	d0,(a2)
	move.w	d0,(a1)
	move.w	d7,(a2)
loc_25C:
	move.l	d0,-(a6)
	dbf	d6,loc_25C
	move.l	(a5)+,(a4)
	move.l	(a5)+,(a4)
	moveq	#$1F,d3
loc_268:
	move.l	d0,(a3)
	dbf	d3,loc_268
	move.l	(a5)+,(a4)
	moveq	#$13,d4
loc_272:
	move.l	d0,(a3)
	dbf	d4,loc_272
	moveq	#$3,d5
loc_27A:
	move.b	(a5)+,$11(a3)
	dbf	d5,loc_27A
	move.w	d0,(a2)
	movem.l	(a6),d0-d7/a0-a6
	move.w	#$2700,sr
loc_28C:
	bra.s	loc_2FA
dat_28E:
	binclude	"data/00028E.bin"
loc_2FA:
	tst.w	($C00004).l
	jsr	(sub_FFFB0).l
	jsr	(sub_19CCA).l
	movea.l	#$C00004,a4
	movea.l	#$C00000,a5
	move.w	#$2700,sr
	jsr	(sub_2878).l
	move.w	#$8174,(a4)
	move.w	#$2300,sr
loc_32A:
	jsr	(sub_F1B6C).l
	tst.b	d0
	bne.s	loc_33C
	tst.b	($FFFFBA52).l
	beq.s	loc_32A
loc_33C:
	st	($FFFFBA52).l
	movea.l	#$FFFFF6,a7
	bsr.w	sub_11BA
	bsr.w	sub_12FC
	bra.s	loc_35C
loc_352:
	movea.l	#$FFFFF6,a7
	bsr.w	sub_11BA
loc_35C:
	move.w	#$36,d0
	jsr	(sub_1B900).l
	jsr	(sub_88C4).l
	clr.b	($FFFFBA5A).w
	move.l	#$384,d2
loc_376:
	jsr	(sub_DEE6).l
	jsr	(sub_F1B66).l
	tst.b	d0
	bne.s	loc_38E
	dbf	d2,loc_376
	st	($FFFFBA5A).w
loc_38E:
	bsr.w	sub_6C54
	movea.l	($FFFFB54A).w,a0
	jsr	(sub_978C).l
	clr.l	($FFFFB54A).w
	tst.b	($FFFFBA5A).w
	bne.s	loc_3B6
	jsr	(sub_85D6).l
loc_3AC:
	movea.l	#$FFFFF6,a7
	bsr.w	sub_3D2
loc_3B6:
	move.w	#$2C,d0
	jsr	(sub_1B900).l
	moveq	#$0,d2
	move.b	($FFFF9BD4).w,d2
	jsr	(sub_5734).l
	bsr.w	loc_4140
	bra.s	loc_352

; ---------------------------------------------------------------------------
sub_3D2:
	movem.l	d2/d7/a2,-(a7)
	move.b	#$0,($FFFF9BBC).w
	jsr	(sub_B0DA).l
	moveq	#$0,d0
	jsr	(sub_8A90).l
	lea	(dat_4EE).l,a0
	jsr	(sub_A768).l
	moveq	#$1,d0
	jsr	(sub_982A).l
	bsr.w	sub_4C0
	jsr	(sub_860E).l
	tst.b	($FFFF9D9E).w
	beq.s	loc_416
	bsr.w	sub_C96
	bra.w	loc_49E
loc_416:
	moveq	#$0,d2
loc_418:
	st	($FFFFD592).w
	moveq	#$0,d0
	move.b	d2,($FFFFD593).w
	move.b	#$40,($FFFFD595).w
	jsr	(sub_13C9C).l
	move.w	d0,d2
	cmp.w	#$FFFF,d2
	beq.s	loc_490
	bpl.s	loc_452
	movea.w	#$0,a0
	moveq	#$6D,d0
	st	($FFFFD596).w
	bsr.w	sub_71D6
	jsr	(sub_8A44).l
	bsr.w	sub_4C0
	bra.s	loc_418
loc_452:
	tst.b	d0
	beq.s	loc_460
	addq.w	#$1,d0
	bra.s	loc_460
	dc.b	$4A,$00,$66,$28,$70,$01
loc_460:
	cmp.b	#$5,d0
	beq.s	loc_486
	asl.w	#$1,d0
	lea	(jt_4E2).l,a0
	adda.w	(a0,d0.w),a0
	jsr	(a0)
	jsr	(sub_DEE6).l
	jsr	(sub_8A44).l
	bsr.w	sub_4C0
	bra.s	loc_418
loc_486:
	bsr.w	sub_10B2
	tst.w	d0
	bne.s	loc_494
	bra.s	loc_418
loc_490:
	st	($FFFFBA5A).w
loc_494:
	move.w	#$2C,d0
	jsr	(sub_1B900).l
loc_49E:
	lea	($FFFFB582).w,a0
	jsr	(sub_9784).l
	lea	($FFFFB532).w,a0
	jsr	(sub_9784).l
	clr.l	($FFFFB532).w
	clr.l	($FFFFD57E).w
	movem.l	(a7)+,d2/d7/a2
	rts

; ---------------------------------------------------------------------------
sub_4C0:
	jsr	(sub_C8FC).l
	moveq	#$8,d7
	jsr	(sub_AB5A).l
	tst.b	($FFFF9D9E).w
	bne.s	loc_4E0
	lea	(dat_13D92).l,a2
	jsr	(sub_A9B8).l
loc_4E0:
	rts
jt_4E2:
	dc.w	loc_532-jt_4E2
	dc.w	sub_C96-jt_4E2
	dc.w	loc_1100-jt_4E2
	dc.w	loc_1914-jt_4E2
	dc.w	loc_10CC-jt_4E2
	dc.w	loc_486-jt_4E2
dat_4EE:
	binclude	"data/0004EE.bin"
loc_532:
	movem.l	d2-d4/d6/a2-a3/a6,-(a7)
	bsr.w	sub_7194
	cmp.b	#$6,d0
	bcc.s	loc_556
	lea	($FFFFC470).w,a0
	moveq	#$0,d0
loc_546:
	tst.b	(a0)
	beq.s	loc_566
	adda.w	#$1A,a0
	addq.l	#$1,d0
	cmp.w	#$8,d0
	bne.s	loc_546
loc_556:
	moveq	#$3,d0
	st	($FFFFD5E2).w
	jsr	(sub_136DA).l
	bra.w	loc_860
loc_566:
	bsr.w	sub_6F14
	movea.l	a1,a2
	bsr.w	sub_6F02
	movea.l	a0,a3
	move.b	d0,$2(a3)
	move.b	d0,($FFFFCA20).w
	st	$11(a3)
	moveq	#$34,d0
	moveq	#$0,d1
loc_582:
	move.l	d1,(a1)+
	dbf	d0,loc_582
	move.b	#$1,$17(a2)
	move.b	#$1,$18(a2)
	move.w	#$200,$26(a2)
	move.w	#$100,$28(a2)
	move.w	#$200,$2A(a2)
	move.l	#$4E2,$1E(a2)
	move.b	#$32,$25(a2)
	move.b	#$8,$24(a2)
	move.b	#$1,$23(a2)
	move.b	#$1,$52(a2)
	bsr.w	sub_BD0
	jsr	(sub_C8FC).l
	jsr	(sub_896E).l
	jsr	(sub_13DA2).l
	lea	(dat_13D70).l,a6
	bra.w	loc_61C
loc_5E6:
	moveq	#$1,d0
	jsr	(sub_13C9C).l
	move.b	d0,($FFFFD593).w
	tst.w	d0
	bmi.w	loc_85A
	asl.w	#$1,d0
	lea	(jt_606).l,a0
	adda.w	(a0,d0.w),a0
	jmp	(a0)
jt_606:
	dc.w	loc_6A2-jt_606
	dc.w	loc_6BC-jt_606
	dc.w	loc_6D6-jt_606
	dc.w	loc_714-jt_606
	dc.w	loc_728-jt_606
	dc.w	loc_73C-jt_606
	dc.w	loc_750-jt_606
	dc.w	loc_690-jt_606
	dc.w	loc_698-jt_606
	dc.w	loc_61C-jt_606
	dc.w	loc_7C8-jt_606
loc_61C:
	lea	$10(a2),a0
	moveq	#$4,d2
loc_622:
	moveq	#$8,d0
	bsr.w	sub_6C8C
	addi.l	#$A,d0
	move.b	d0,(a0)+
	dbf	d2,loc_622
	bsr.w	sub_654
	bsr.w	sub_67C
	bra.w	loc_762
	binclude	"data/000640.bin"

; ---------------------------------------------------------------------------
sub_650:
	moveq	#$1,d1
	bra.s	loc_656

; ---------------------------------------------------------------------------
sub_654:
	moveq	#$0,d1
loc_656:
	lea	($63B).w,a1
	moveq	#$0,d2
	move.b	$17(a2),d2
	mulu.w	#$5,d2
	adda.w	d2,a1
	lea	$10(a2),a0
	moveq	#$4,d2
loc_66C:
	move.b	(a1)+,d0
	tst.w	d1
	beq.s	loc_674
	neg.b	d0
loc_674:
	add.b	d0,(a0)+
	dbf	d2,loc_66C
	rts

; ---------------------------------------------------------------------------
sub_67C:
	clr.b	$2E(a2)
	bsr.w	sub_B1C
	bsr.w	sub_B1C
	move.b	$2E(a2),$E(a3)
	rts
loc_690:
	clr.b	$16(a2)
	bra.w	loc_762
loc_698:
	move.b	#$1,$16(a2)
	bra.w	loc_762
loc_6A2:
	move.b	#$8,$24(a2)
	clr.b	$C(a2)
	moveq	#$1,d0
	bsr.w	sub_6E8
	jsr	(sub_13DF0).l
	bra.w	loc_762
loc_6BC:
	move.b	#$A,$24(a2)
	move.b	#$3,$2A(a2)
	move.b	#$1,$2C(a2)
	moveq	#$2,d0
	bsr.w	sub_6E8
	bra.s	loc_73C
loc_6D6:
	move.b	#$6,$24(a2)
	clr.b	$2C(a2)
	moveq	#$3,d0
	bsr.w	sub_6E8
	bra.s	loc_728

; ---------------------------------------------------------------------------
sub_6E8:
	cmp.b	$17(a2),d0
	beq.s	loc_702
	move.w	d0,-(a7)
	bsr.w	sub_650
	move.w	(a7)+,d0
	move.b	d0,$17(a2)
	bsr.w	sub_654
	bsr.w	sub_67C
loc_702:
	rts

; ---------------------------------------------------------------------------
sub_704:
	cmp.b	$18(a2),d0
	beq.s	loc_712
	move.b	d0,$18(a2)
	bsr.w	sub_67C
loc_712:
	rts
loc_714:
	moveq	#$1,d0
	bsr.s	sub_704
	move.b	#$2,$26(a2)
	move.l	#$4E2,$1E(a2)
	bra.s	loc_762
loc_728:
	moveq	#$2,d0
	bsr.s	sub_704
	move.l	#$5DC,$1E(a2)
	move.b	#$2,$26(a2)
	bra.s	loc_762
loc_73C:
	moveq	#$3,d0
	bsr.s	sub_704
	move.l	#$7D0,$1E(a2)
	move.b	#$4,$26(a2)
	bra.s	loc_762
loc_750:
	moveq	#$4,d0
	bsr.s	sub_704
	move.l	#$4E2,$1E(a2)
	move.b	#$2,$26(a2)
loc_762:
	jsr	(sub_13DF0).l
	movea.l	a6,a0
	move.b	$17(a2),d0
	cmp.b	#$3,d0
	bne.s	loc_78E
	moveq	#$3,d0
	jsr	(sub_13E56).l
	moveq	#$6,d0
	jsr	(sub_13E56).l
	moveq	#$5,d0
	jsr	(sub_13E56).l
	bra.s	loc_7A4
loc_78E:
	cmp.b	#$2,d0
	bne.s	loc_7A4
	moveq	#$6,d0
	jsr	(sub_13E56).l
	moveq	#$4,d0
	jsr	(sub_13E56).l
loc_7A4:
	movea.l	a3,a0
	movea.l	a2,a1
	bsr.w	sub_6D1E
	bsr.w	sub_6F26
	bsr.w	sub_6F70
	moveq	#$3,d2
	moveq	#$3,d3
	moveq	#$0,d4
	move.b	($FFFFCA20).w,d6
	jsr	(sub_AB9C).l
	bra.w	loc_5E6
loc_7C8:
	jsr	(sub_13DD6).l
	moveq	#$4E,d0
	moveq	#$C,d1
	moveq	#$5,d2
	moveq	#$2,d3
	jsr	(sub_13EB6).l
	tst.b	($FFFFD5AE).w
	bne.s	loc_7EC
	jsr	(sub_13DA2).l
	bra.w	loc_762
loc_7EC:
	lea	($FFFFD5AE).w,a0
	lea	(a2),a1
	moveq	#$A,d0
loc_7F4:
	move.b	(a0)+,(a1)+
	dbf	d0,loc_7F4
	move.b	#$2,$19(a2)
	bsr.w	sub_B92
	move.w	#$101,(a3)
	move.b	#$E,$15(a2)
	moveq	#$3,d0
	cmp.b	$18(a2),d0
	beq.s	loc_81E
	moveq	#$2,d0
	cmp.b	$17(a2),d0
	bne.s	loc_824
loc_81E:
	move.b	#$3,$2A(a2)
loc_824:
	movea.l	a3,a0
	movea.l	a2,a1
	bsr.w	sub_6D1E
	jsr	(sub_13DD6).l
	bsr.w	sub_86A
	jsr	(sub_8A44).l
	moveq	#$1,d0
	jsr	(sub_982A).l
	moveq	#$8,d0
	bsr.w	sub_E8C
	move.b	$18(a2),d0
	cmp.b	#$3,d0
	bne.s	loc_858
	bsr.w	sub_DC4
loc_858:
	bra.s	loc_860
loc_85A:
	jsr	(sub_13DD6).l
loc_860:
	clr.b	($FFFFD593).w
	movem.l	(a7)+,d2-d4/d6/a2-a3/a6
	rts

; ---------------------------------------------------------------------------
sub_86A:
	link	a6,#-$22
	move.l	a6,($FFFFD80C).w
	movem.l	d2-d6/a3,-(a7)
	jsr	(sub_8A44).l
	jsr	(sub_C8FC).l
	move.l	#$C02E0000,(a4)
	move.l	#$6220222,(a5)
	move.l	#$88778888,d0
	bsr.w	sub_1148
	lea	($FFFFB582).w,a0
	jsr	(sub_9784).l
	lea	($FFFFB532).w,a0
	jsr	(sub_9784).l
	clr.l	($FFFFD57E).w
	moveq	#$1,d0
	moveq	#$1B,d1
	jsr	(sub_92AA).l
	move.l	a0,-$8(a6)
	clr.w	-$1A(a6)
	clr.w	-$18(a6)
	move.l	#$580030,-$C(a6)
	clr.w	-$12(a6)
	clr.w	-$22(a6)
	lea	(dat_9DE).l,a0
	lea	(dat_9D4).l,a3
	jsr	(sub_9934).l
	move.l	a0,-$4(a6)
	move.l	#$4,($FFFFD5D6).w
	move.w	#$E000,($FFFFD5AC).w
	st	($FFFFD5E2).w
	move.w	#$80,d0
	jsr	(sub_11C8E).l
	moveq	#$1,d6
	moveq	#$11,d3
	moveq	#$3,d4
loc_90E:
	moveq	#$5,d5
	moveq	#$6,d2
loc_912:
	movea.l	-$4(a6),a0
	move.w	d4,d0
	jsr	(sub_94DC).l
	addi.w	#$9,d4
	addq.w	#$5,d2
	dbf	d5,loc_912
	addq.w	#$5,d3
	dbf	d6,loc_90E
	clr.b	-$20(a6)
	clr.b	($FFFFD594).w
	move.w	#$EC02,d0
	bsr.w	sub_8288
	movea.l	-$8(a6),a0
	move.w	$2(a0),(a5)
	bsr.w	sub_A5A
	move.b	#$D,($FFFF9BBC).w
loc_950:
	move.b	-$20(a6),($FFFFD593).w
	st	($FFFFD592).w
	clr.l	($FFFFD58A).w
	moveq	#$3,d0
	jsr	(sub_13C9C).l
	move.b	($FFFFD594).w,-$20(a6)
	tst.w	d0
	bmi.s	loc_950
	bset	#$7,-$20(a6)
	move.b	#$0,($FFFF9BBC).w
	jsr	(sub_9222).l
	lea	-$8(a6),a0
	jsr	(sub_9232).l
	movea.l	-$4(a6),a0
	jsr	(sub_978C).l
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F14
	move.b	-$20(a6),$42(a1)
	move.l	#$22E2E222,d0
	bsr.w	sub_1148
	jsr	(sub_96D8).l
	jsr	(sub_8A44).l
	lea	($4EE).w,a0
	jsr	(sub_A768).l
	moveq	#$1,d0
	jsr	(sub_982A).l
	movem.l	(a7)+,d2-d6/a3
	unlk	a6
	rts
dat_9D4:
	binclude	"data/0009D4.bin"
dat_9DE:
	binclude	"data/0009DE.bin"

; ---------------------------------------------------------------------------
sub_A0C:
	movem.l	d2/a3,-(a7)
	moveq	#$0,d2
	move.b	-$20(a6),d2
	mulu.w	#$9,d2
	move.w	-$1A(a6),d1
	asl.w	#$3,d1
	lea	($9EF).w,a0
	adda.w	d1,a0
	lea	-$1E(a6),a3
	moveq	#$2,d1
loc_A2C:
	move.b	(a0)+,d0
	add.b	d2,d0
	move.b	d0,(a3)+
	dbf	d1,loc_A2C
	st	(a3)
	movea.l	-$8(a6),a0
	move.w	(a0),d1
	moveq	#$1,d0
	lea	-$1E(a6),a3
	movea.l	-$4(a6),a0
	st	($FFFFD858).l
	jsr	(sub_B58A).l
	movem.l	(a7)+,d2/a3
	rts

; ---------------------------------------------------------------------------
sub_A5A:
	movea.l	($FFFFD80C).w,a6
	move.b	($FFFFD594).w,d0
	cmp.b	-$20(a6),d0
	beq.s	loc_A74
	move.b	d0,-$20(a6)
	bsr.s	sub_A0C
	move.w	#$4,-$22(a6)
loc_A74:
	subq.w	#$1,-$22(a6)
	bpl.w	loc_B1A
	move.w	#$9,-$22(a6)
	subq.w	#$1,-$12(a6)
	bpl.s	loc_AB8
	move.w	-$1A(a6),d0
	addq.w	#$1,d0
	andi.w	#$3,d0
	move.w	d0,-$1A(a6)
	asl.w	#$3,d0
	lea	-$16(a6),a0
	lea	($9EB).w,a1
	adda.w	d0,a1
	moveq	#$4,d0
loc_AA4:
	move.b	(a1)+,d1
	ext.w	d1
	move.w	d1,(a0)+
	dbf	d0,loc_AA4
	bsr.w	sub_A0C
	move.w	#$FFFF,-$18(a6)
loc_AB8:
	movea.l	-$8(a6),a0
	move.w	$2(a0),d0
	asl.w	#$3,d0
	addi.w	#$EC00,d0
	bsr.w	sub_8288
	move.w	-$C(a6),d0
	add.w	-$16(a6),d0
	move.w	d0,-$C(a6)
	move.w	-$A(a6),d1
	add.w	-$14(a6),d1
	move.w	d1,-$A(a6)
	move.w	-$18(a6),d2
	addq.w	#$1,d2
	andi.w	#$3,d2
	move.w	d2,-$18(a6)
	cmp.w	#$3,d2
	bne.s	loc_AF8
	moveq	#$1,d2
loc_AF8:
	mulu.w	#$9,d2
	addi.w	#$80,d1
	move.w	d1,(a5)
	move.w	#$A00,(a5)
	add.w	(a0),d2
	tst.w	-$10(a6)
	beq.s	loc_B12
	bset	#$B,d2
loc_B12:
	move.w	d2,(a5)
	addi.w	#$80,d0
	move.w	d0,(a5)
loc_B1A:
	rts

; ---------------------------------------------------------------------------
sub_B1C:
	move.l	d2,-(a7)
	moveq	#$0,d0
	move.b	$18(a2),d0
	subq.l	#$1,d0
	lea	(dat_B78).l,a0
	move.b	(a0,d0.w),d0
	bsr.w	sub_6C8C
	moveq	#$0,d1
	move.b	$12(a2),d1
	lea	(dat_B7C).l,a0
	move.b	(a0,d1.w),d1
	cmp.b	#$2,d1
	ble.s	loc_B56
	move.b	$18(a2),d2
	cmp.b	#$3,d2
	beq.s	loc_B56
	moveq	#$2,d1
loc_B56:
	add.b	d1,d0
	cmp.b	#$0,d0
	bgt.s	loc_B60
	moveq	#$1,d0
loc_B60:
	addq.l	#$4,d0
	add.b	d0,$2E(a2)
	cmpi.b	#$68,$2E(a2)
	bcs.s	loc_B74
	move.b	#$68,$2E(a2)
loc_B74:
	move.l	(a7)+,d2
	rts
dat_B78:
	dc.b	$04,$02,$06,$04
dat_B7C:
	binclude	"data/000B7C.bin"

; ---------------------------------------------------------------------------
sub_B92:
	moveq	#$0,d0
	move.b	$18(a2),d0
	asl.w	#$3,d0
	add.b	$19(a2),d0
	subi.b	#$A,d0
	lea	(sub_BB0).l,a1
	move.b	(a1,d0.w),$22(a2)
	rts

; ---------------------------------------------------------------------------
sub_BB0:
	move.l	$292A(a1),d4
	move.l	$2B2C(a3),d5
	move.l	$2A2A(a0),d4
	move.l	$2C2C(a4),d5
	move.l	$2B2C(a2),-(a4)
	move.l	$2F30(a6),-(a6)
	move.l	$292A(a1),d4
	move.l	$2B2C(a3),d5

; ---------------------------------------------------------------------------
sub_BD0:
	movem.l	d2-d3/a2,-(a7)
	lea	$C2(a2),a0
	move.l	a0,d3
	lea	$AE(a2),a0
	lea	(dat_C12).l,a1
	moveq	#$1,d2
loc_BE6:
	moveq	#$0,d0
	move.b	(a1),d0
	mulu.w	#$A,d0
	lea	(dat_F17CC).l,a2
	adda.w	d0,a2
	moveq	#$9,d1
loc_BF8:
	move.b	(a2)+,(a0)+
	dbf	d1,loc_BF8
	move.b	$2(a1),-$2(a0)
	addq.l	#$1,a1
	movea.l	d3,a0
	dbf	d2,loc_BE6
	movem.l	(a7)+,d2-d3/a2
	rts
dat_C12:
	binclude	"data/000C12.bin"

; ---------------------------------------------------------------------------
sub_C96:
	link	a6,#-$A
	movem.l	d2-d3/a2-a3,-(a7)
	bsr.w	sub_10B2
	tst.w	d0
	beq.w	loc_CC8
loc_CA8:
	lea	-$A(a6),a0
	moveq	#$3E,d0
	st	($FFFFBA58).w
	bsr.w	sub_71D6
	clr.b	($FFFFBA58).w
	tst.w	d0
	bmi.s	loc_CC8
	move.b	d0,($FFFFCA20).w
	bsr.w	sub_CD0
	bra.s	loc_CA8
loc_CC8:
	movem.l	(a7)+,d2-d3/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_CD0:
	movem.l	a2-a3,-(a7)
	bsr.w	sub_6EEC
	addq.b	#$1,$19(a2)
	lea	(dat_DAC).l,a0
	jsr	(sub_1344E).l
	move.w	#$C000,($FFFFD5AC).w
	move.w	#$15,($FFFFD5D8).w
	moveq	#$52,d0
	st	($FFFFD5E2).w
	jsr	(sub_11C8E).l
	move.l	#$30017,($FFFFD5D6).w
	clr.b	($FFFFD5AE).w
	lea	(a2),a0
	jsr	(sub_11BF2).l
	moveq	#$53,d0
	jsr	(sub_11BDC).l
	st	($FFFFD5E2).w
	jsr	(sub_11CA0).l
	addq.w	#$1,($FFFFD5D8).w
	clr.w	($FFFFD5D6).w
	move.b	$19(a2),d0
	move.w	#$1,($FFFFD5AA).w
	jsr	(sub_13322).l
	moveq	#$42,d0
	add.b	$18(a2),d0
	jsr	(sub_11BDC).l
	st	($FFFFD5E2).w
	jsr	(sub_11CA0).l
	st	($FFFFD5E2).w
	moveq	#$2,d0
	jsr	(sub_136DA).l
	jsr	(sub_C8FC).l
	moveq	#$4,d0
	bsr.w	sub_E8C
	btst	#$0,$19(a2)
	bne.s	loc_D86
	subq.b	#$1,$15(a2)
	move.b	$18(a2),d0
	cmp.b	#$3,d0
	bne.s	loc_D86
	bsr.w	sub_DC4
loc_D86:
	bsr.w	sub_B1C
	move.b	$2E(a2),$E(a3)
	bsr.w	sub_B92
	movea.l	a3,a0
	movea.l	a2,a1
	bsr.w	sub_6D1E
	jsr	(sub_C8FC).l
	bsr.w	sub_748C
	movem.l	(a7)+,a2-a3
	rts
dat_DAC:
	binclude	"data/000DAC.bin"

; ---------------------------------------------------------------------------
sub_DC4:
	link	a6,#-$68
	movem.l	d2/a3,-(a7)
	moveq	#$1,d0
	move.w	d0,-$6(a6)
	move.w	d0,-$8(a6)
	move.w	#$3,-$A(a6)
	lea	(dat_E78).l,a0
	lea	-$2C(a6),a1
loc_DE6:
	move.b	(a0)+,(a1)+
	bpl.s	loc_DE6
	lea	(dat_E66).l,a0
	lea	-$48(a6),a1
loc_DF4:
	move.b	(a0)+,(a1)+
	bpl.s	loc_DF4
	lea	-$68(a6),a0
	moveq	#$B,d0
loc_DFE:
	clr.b	(a0)+
	dbf	d0,loc_DFE
	lea	-$68(a6),a0
	lea	$4D(a2),a1
	moveq	#$4,d0
loc_E0E:
	move.b	(a1)+,d2
	moveq	#$1,d1
	lea	(dat_E60).l,a3
loc_E18:
	cmp.b	(a3)+,d2
	bne.s	loc_E22
	addq.b	#$1,(a0,d1.w)
	bra.s	loc_E2A
loc_E22:
	addq.w	#$2,d1
	cmp.w	#$B,d1
	bls.s	loc_E18
loc_E2A:
	dbf	d0,loc_E0E
	move.w	#$84,d2
	bsr.w	sub_F5A
	lea	$4D(a2),a0
loc_E3A:
	tst.b	(a0)+
	bne.s	loc_E3A
	subq.l	#$1,a0
	lea	(dat_E60).l,a3
	moveq	#$0,d0
	lea	-$52(a6),a1
loc_E4C:
	move.b	(a1)+,d0
	bmi.s	loc_E58
	move.b	(a3,d0.w),d0
	move.b	d0,(a0)+
	bra.s	loc_E4C
loc_E58:
	movem.l	(a7)+,d2/a3
	unlk	a6
	rts
dat_E60:
	dc.b	$03,$08,$06,$0E,$09,$0A
dat_E66:
	binclude	"data/000E66.bin"
dat_E78:
	binclude	"data/000E78.bin"

; ---------------------------------------------------------------------------
sub_E8C:
	link	a6,#-$68
	move.l	d2,-(a7)
	move.w	d0,-$6(a6)
	asr.w	#$1,d0
	move.w	d0,-$8(a6)
	move.w	#$C,-$A(a6)
	lea	(dat_F38).l,a0
	lea	-$2C(a6),a1
loc_EAC:
	move.b	(a0)+,(a1)+
	bpl.s	loc_EAC
	moveq	#$1F,d0
	add.b	$18(a2),d0
	move.b	d0,-$2A(a6)
	lea	(dat_F1C).l,a0
	lea	-$48(a6),a1
loc_EC4:
	move.b	(a0)+,(a1)+
	bpl.s	loc_EC4
	lea	-$68(a6),a0
	moveq	#$0,d0
	move.b	$18(a2),d0
	subq.b	#$1,d0
	move.b	d0,(a0)+
	move.b	$31(a2,d0.w),(a0)+
	moveq	#$A,d0
	moveq	#$4,d1
loc_EDE:
	move.b	d1,(a0)+
	move.b	$31(a2,d1.w),(a0)+
	addq.w	#$1,d1
	dbf	d0,loc_EDE
	move.l	#$135,d0
	add.b	$18(a2),d0
	move.w	d0,-$44(a6)
	move.w	#$83,d2
	bsr.w	sub_F5A
	lea	$31(a2),a0
	lea	-$68(a6),a1
	moveq	#$A,d0
	moveq	#$0,d1
loc_F0C:
	move.b	(a1)+,d1
	move.b	(a1)+,(a0,d1.w)
	dbf	d0,loc_F0C
	move.l	(a7)+,d2
	unlk	a6
	rts
dat_F1C:
	binclude	"data/000F1C.bin"
dat_F38:
	binclude	"data/000F38.bin"

; ---------------------------------------------------------------------------
sub_F5A:
	movem.l	d2-d7/a2-a3,-(a7)
	move.l	a2,-$4(a6)
	lea	(dat_9E6AC).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,($FFFFB54E).w
	lea	-$52(a6),a0
	moveq	#-$1,d0
	moveq	#$9,d1
loc_F7A:
	move.b	d0,(a0)+
	dbf	d1,loc_F7A
	bsr.w	sub_8A44
	moveq	#$0,d0
	move.b	-$47(a6),d0
	subq.w	#$1,d0
	move.l	d0,($FFFFD5D6).w
	move.w	d2,d0
	move.w	#$E000,($FFFFD5AC).w
	st	($FFFFD5E2).w
	jsr	(sub_11C8E).l
	moveq	#$3,d2
	moveq	#$4,d3
	moveq	#$0,d6
	movea.l	-$4(a6),a0
	moveq	#$0,d6
	move.b	($FFFFCA20).w,d6
	moveq	#$0,d4
	jsr	(sub_AC6C).l
	moveq	#$0,d7
loc_FBC:
	moveq	#$20,d1
	clr.w	($FFFFB514).w
	moveq	#$3,d2
	moveq	#$8,d3
	moveq	#$13,d4
	moveq	#$3,d5
	jsr	(sub_95BE).l
	move.w	-$6(a6),d4
	sub.w	d7,d4
	subq.w	#$1,d4
	bmi.s	loc_FF4
	moveq	#$3,d2
	moveq	#$8,d3
loc_FDE:
	moveq	#$2D,d0
	movea.l	-$4(a6),a0
	add.b	$18(a0),d0
	jsr	(sub_A85A).l
	addq.l	#$2,d2
	dbf	d4,loc_FDE
loc_FF4:
	lea	-$2C(a6),a2
	lea	-$68(a6),a3
	jsr	(sub_A9EA).l
	cmp.w	-$6(a6),d7
	bne.s	loc_1016
	st	($FFFFD5E2).w
	jsr	(sub_14246).l
	bra.w	loc_109E
loc_1016:
	lea	-$2C(a6),a2
	lea	-$48(a6),a3
	jsr	(sub_1391A).l
	tst.w	d0
	bpl.s	loc_1054
	subq.w	#$1,d7
	bmi.s	loc_104E
	lea	-$52(a6),a0
	moveq	#$0,d0
	move.b	(a0,d7.w),d0
	move.b	d0,($FFFFD593).w
	move.b	#$FF,(a0,d7.w)
	lea	-$68(a6),a0
	asl.w	#$1,d0
	subq.w	#$1,(a0,d0.w)
	bra.w	loc_FBC
loc_104E:
	moveq	#$0,d7
	bra.w	loc_FBC
loc_1054:
	move.b	d0,($FFFFD593).w
	lea	-$52(a6),a0
	moveq	#$0,d5
	moveq	#$0,d1
loc_1060:
	cmp.w	d7,d5
	bcc.s	loc_106E
	cmp.b	(a0)+,d0
	bne.s	loc_106A
	addq.w	#$1,d1
loc_106A:
	addq.w	#$1,d5
	bra.s	loc_1060
loc_106E:
	cmp.w	-$8(a6),d1
	bcc.s	loc_1016
	lea	-$68(a6),a0
	move.w	d0,d1
	asl.w	#$1,d1
	move.b	$1(a0,d1.w),d1
	cmp.b	-$9(a6),d1
	bcc.s	loc_1016
	lea	-$52(a6),a0
	move.b	d0,(a0,d7.w)
	lea	-$68(a6),a0
	asl.w	#$1,d0
	addq.b	#$1,$1(a0,d0.w)
	addq.w	#$1,d7
	bra.w	loc_FBC
loc_109E:
	movea.l	($FFFFB54E).w,a0
	jsr	(sub_978C).l
	clr.b	($FFFFD593).w
	movem.l	(a7)+,d2-d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_10B2:
	bsr.w	sub_7194
	move.w	d0,-(a7)
	tst.w	d0
	bne.s	loc_10C8
	moveq	#$4,d0
	st	($FFFFD5E2).w
	jsr	(sub_136DA).l
loc_10C8:
	move.w	(a7)+,d0
	rts
loc_10CC:
	bsr.w	sub_19FC
	jsr	(sub_AF00).l
	moveq	#$1,d0
	jsr	(sub_982A).l
	rts

; ---------------------------------------------------------------------------
sub_10E0:
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	moveq	#$C,d0
	moveq	#$0,d1
loc_10F0:
	move.w	d1,(a0)+
	dbf	d0,loc_10F0
	moveq	#$6A,d0
loc_10F8:
	move.w	d1,(a1)+
	dbf	d0,loc_10F8
	rts
loc_1100:
	movem.l	d2-d3,-(a7)
	bsr.s	sub_10B2
	tst.w	d0
	beq.s	loc_1142
	moveq	#$3F,d0
	movea.w	#$0,a0
	bsr.w	sub_71D6
	tst.w	d0
	bmi.s	loc_1142
	move.w	d0,d3
	move.w	d0,d1
	asr.w	#$1,d1
	mulu.w	#$28,d1
	addi.l	#$1C,d1
	btst	#$0,d0
	bne.s	loc_1132
	moveq	#$24,d0
	bra.s	loc_1136
loc_1132:
	move.w	#$B4,d0
loc_1136:
	moveq	#$7,d2
	jsr	(sub_A102).l
	move.w	d3,d0
	bsr.s	sub_10E0
loc_1142:
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_1148:
	move.l	#$6FC00003,(a4)
	moveq	#$7,d1
loc_1150:
	move.l	d0,(a5)
	rol.l	#$4,d0
	dbf	d1,loc_1150
	rts

; ---------------------------------------------------------------------------
sub_115A:
	lea	($FFFF96F6).w,a0
	move.l	#$1FF,d0
	moveq	#$0,d1
loc_1166:
	move.l	d1,(a0)+
	dbf	d0,loc_1166
	move.b	#$0,($FFFF9BBC).w
	move.b	#$8,($FFFF9BBD).w
	move.b	#$2,($FFFF97F2).w
	clr.b	($FFFF9BD5).w
	move.b	#$10,($FFFF9BD4).w
	move.l	#$1770,($FFFF9BD0).w
	moveq	#$5,d0
	lea	($FFFF98F6).w,a0
	jsr	(sub_19C60).l
	move.b	#$2,($FFFF9AFB).w
	moveq	#$7,d0
	jsr	(sub_158BA).l
	move.b	#$3,($FFFF9BCA).w
	move.l	#$5B0117,($FFFF9BC6).w
	rts

; ---------------------------------------------------------------------------
sub_11BA:
	move.w	#$2700,sr
	jsr	(sub_2864).l
	jsr	(sub_2350).l
	move.w	#$8004,(a4)
	move.w	#$8164,(a4)
	move.w	#$8228,(a4)
	move.w	#$833C,(a4)
	move.w	#$8406,(a4)
	move.w	#$8576,(a4)
	move.w	#$8700,(a4)
	move.w	#$8B00,(a4)
	move.w	#$8C81,(a4)
	move.w	#$8D38,(a4)
	move.w	#$8F02,(a4)
	move.w	#$9011,(a4)
	jsr	(sub_1B5CE).l
	moveq	#$0,d5
	jsr	(sub_A71E).l
	move.l	#$6E800003,(a4)
	moveq	#$7,d4
loc_1210:
	move.l	#$22222222,(a5)
	dbf	d4,loc_1210
	move.l	#$40000000,(a4)
	moveq	#$5,d3
	lea	(dat_12F6).l,a0
loc_1228:
	move.b	(a0)+,d1
	ext.w	d1
	bsr.w	sub_8D94
	moveq	#$7,d4
loc_1232:
	move.l	d2,(a5)
	dbf	d4,loc_1232
	dbf	d3,loc_1228
	move.l	#$22E2E222,d0
	bsr.w	sub_1148
	lea	($200000).l,a0
	moveq	#$12,d0
	moveq	#$34,d1
	move.b	d0,$5(a0)
	move.b	d1,$7(a0)
	cmp.b	$5(a0),d0
	bne.s	loc_1268
	cmp.b	$7(a0),d1
	bne.s	loc_1268
	moveq	#$1,d0
	bra.s	loc_126A
loc_1268:
	moveq	#$0,d0
loc_126A:
	move.b	d0,($FFFFCA21).w
	bsr.w	sub_2316
	st	($FFFFD500).w
	st	($FFFFB524).w
	st	($FFFFB525).w
	jsr	(sub_96D8).l
	lea	(dat_647D7).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,($FFFFB546).w
	move.w	#$6,($FFFFD5AA).w
	move.b	#$FF,($FFFFD564).w
	move.w	#$8,($FFFFBA64).w
	lea	($FFFFC470).w,a0
	moveq	#$0,d0
	moveq	#$7,d1
loc_12AE:
	move.b	d0,(a0)
	adda.w	#$1A,a0
	dbf	d1,loc_12AE
	bsr.w	sub_115A
	move.w	#$2,($FFFFB434).w
	jsr	(sub_BEF4).l
	lea	(dat_390E2).l,a1
	move.w	#$FF,d0
	moveq	#$0,d1
	lea	($FFFFD604).w,a0
loc_12D8:
	mulu.w	#$3C4D,d1
	add.w	(a1)+,d1
	move.w	d1,(a0)+
	dbf	d0,loc_12D8
	st	($FFFFBA52).w
	move.w	#$2000,sr
	moveq	#$2C,d0
	jsr	(sub_1B900).l
	rts
dat_12F6:
	dc.b	$00,$09,$0C,$0A,$01,$07

; ---------------------------------------------------------------------------
sub_12FC:
	link	a6,#-$C
	movem.l	d2-d7,-(a7)
	move.w	#$2E,d0
	jsr	(sub_1B900).l
	bsr.w	sub_862A
	clr.w	($FFFFB432).w
	move.w	#$9100,(a4)
	move.w	#$9200,(a4)
	move.b	#$E,($FFFF9BBC).w
	lea	-$C(a6),a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	tst.b	($FFFFD8FC).l
	bne.w	loc_15F0
	if DEUTSCH	; DEUTSCH-HOOK 14: Grafik G1 aus DE_Grafik_G1 (SSI-Logo PRESENTS -> PRAESENTIERT, 6 Byte wie Original)
	lea	(DE_Grafik_G1).l,a0
	else
	lea	(dat_99B5F).l,a0
	endif
	jsr	(sub_9DD4).l
	move.l	a0,-$4(a6)
	move.w	#$8000,d6
	moveq	#$2,d7
	bsr.w	sub_8594
	moveq	#$0,d0
	moveq	#$2,d1
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$28,d4
	moveq	#$1C,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	movea.l	-$4(a6),a0
	jsr	(sub_95BE).l
	move.b	#$F,($FFFF9BBC).w
	jsr	(sub_860E).l
	move.w	#$F0,d0
	jsr	(sub_75FA).l
	bsr.w	sub_15FC
	tst.b	($FFFFD8FC).l
	bne.w	loc_15F0
	bsr.w	sub_85DA
	move.b	#$E,($FFFF9BBC).w
	bsr.w	sub_8A76
	lea	(dat_96D4A).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,-$4(a6)
	lea	(dat_9AB8B).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,-$8(a6)
	if DEUTSCH	; DEUTSCH-HOOK 15: Grafik G3 aus DE_Grafik_G3 (Vorspann ACTIVE -> AKTIV, 6 Byte wie Original)
	lea	(DE_Grafik_G3).l,a0
	else
	lea	(dat_9ACF7).l,a0
	endif
	jsr	(sub_9DD4).l
	move.l	a0,-$C(a6)
	moveq	#$0,d0
	moveq	#$2,d1
	moveq	#$0,d2
	moveq	#$1,d3
	moveq	#$28,d4
	moveq	#$19,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	movea.l	-$4(a6),a0
	jsr	(sub_95BE).l
	bsr.w	sub_860E
	moveq	#$78,d0
	jsr	(sub_75FA).l
	moveq	#$6,d2
	moveq	#$11,d3
	moveq	#$1C,d4
	movea.l	-$8(a6),a0
	bsr.w	sub_166C
	moveq	#$78,d0
	jsr	(sub_75FA).l
	moveq	#$0,d0
	moveq	#$1,d1
	moveq	#$F,d2
	moveq	#$15,d3
	moveq	#$B,d4
	moveq	#$3,d5
	moveq	#$7,d7
	movea.l	-$C(a6),a0
	bsr.w	sub_1628
	moveq	#$78,d0
	jsr	(sub_75FA).l
	bsr.w	sub_160C
	tst.b	($FFFFD8FC).l
	bne.w	loc_15F0
	bsr.w	sub_8A6E
	if DEUTSCH	; DEUTSCH-HOOK 16: Grafik G4 aus DE_Grafik_G4 (Vorspann TARGET? -> ZIEL?, 6 Byte wie Original)
	lea	(DE_Grafik_G4).l,a0
	else
	lea	(dat_9AE4D).l,a0
	endif
	jsr	(sub_9DD4).l
	move.l	a0,-$8(a6)
	moveq	#$0,d0
	moveq	#$1,d1
	moveq	#$D,d2
	moveq	#$11,d3
	moveq	#$E,d4
	moveq	#$3,d5
	moveq	#$7,d7
	movea.l	-$8(a6),a0
	bsr.w	sub_1628
	moveq	#$78,d0
	jsr	(sub_75FA).l
	bsr.w	sub_160C
	tst.b	($FFFFD8FC).l
	bne.w	loc_15F0
	bsr.w	sub_8A6E
	lea	(dat_962D9).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,-$8(a6)
	if DEUTSCH	; DEUTSCH-HOOK 17: Grafik G5 aus DE_Grafik_G5 (Vorspann EARTH -> ERDE, 6 Byte wie Original)
	lea	(DE_Grafik_G5).l,a0
	else
	lea	(dat_9AFAA).l,a0
	endif
	jsr	(sub_9DD4).l
	move.l	a0,-$C(a6)
	moveq	#$0,d0
	moveq	#$1,d1
	moveq	#$7,d2
	moveq	#$11,d3
	moveq	#$19,d4
	moveq	#$9,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	movea.l	-$8(a6),a0
	jsr	(sub_95BE).l
	moveq	#$78,d0
	jsr	(sub_75FA).l
	moveq	#$F,d2
	moveq	#$C,d3
	moveq	#$A,d4
	movea.l	-$C(a6),a0
	bsr.w	sub_166C
	moveq	#$78,d0
	jsr	(sub_75FA).l
	bsr.w	sub_15FC
	bsr.w	sub_8A76
	moveq	#$0,d0
	moveq	#$8,d1
	moveq	#$F,d2
	moveq	#$C,d3
	moveq	#$A,d4
	moveq	#$3,d5
	movea.l	-$C(a6),a0
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	clr.w	($FFFFB514).w
	jsr	(sub_95BE).l
	lea	(dat_9B0B9).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,-$4(a6)
	lea	(dat_9607B).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,-$8(a6)
	moveq	#$0,d0
	moveq	#$2,d1
	moveq	#$6,d2
	moveq	#$B,d3
	moveq	#$F,d4
	moveq	#$4,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	movea.l	-$4(a6),a0
	jsr	(sub_95BE).l
	moveq	#$0,d0
	moveq	#$2,d1
	moveq	#$12,d2
	moveq	#$B,d3
	moveq	#$F,d4
	moveq	#$4,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	movea.l	-$4(a6),a0
	jsr	(sub_95BE).l
	moveq	#$9,d7
loc_1584:
	move.w	d7,d0
	moveq	#$2,d1
	moveq	#$1E,d2
	moveq	#$B,d3
	moveq	#$3,d4
	moveq	#$4,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	movea.l	-$8(a6),a0
	jsr	(sub_95BE).l
	cmp.w	#$9,d7
	bne.s	loc_15B2
	bsr.w	sub_860E
loc_15B2:
	moveq	#$3C,d0
	jsr	(sub_75FA).l
	subq.w	#$1,d7
	bne.s	loc_1584
	bsr.w	sub_15FC
	tst.b	($FFFFD8FC).l
	bne.w	loc_15F0
	move.b	#$19,($FFFF97F2).w
	move.w	#$4,($FFFFB434).w
	move.w	#$8000,d6
	moveq	#$0,d7
	clr.w	($FFFFB432).w
	bsr.w	sub_8594
	bsr.w	sub_91C8
	move.b	#$3,($FFFF97F2).w
loc_15F0:
	bsr.w	sub_15FC
	movem.l	(a7)+,d2-d7
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_15FC:
	bsr.w	sub_160C
	lea	-$4(a6),a0
	jsr	(sub_9784).l
	rts

; ---------------------------------------------------------------------------
sub_160C:
	bsr.w	sub_161C
	lea	-$8(a6),a0
	jsr	(sub_9784).l
	rts

; ---------------------------------------------------------------------------
sub_161C:
	lea	-$C(a6),a0
	jsr	(sub_9784).l
	rts

; ---------------------------------------------------------------------------
sub_1628:
	movem.l	d6/a2,-(a7)
	movem.w	d0-d5,-(a7)
	movea.l	a0,a2
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	move.w	#$2000,d6
loc_1640:
	movem.w	(a7),d0-d5
	movea.l	a2,a0
	bsr.w	sub_95BE
	eor.w	d6,($FFFFB510).w
	eor.w	d6,($FFFFB512).w
	moveq	#$1D,d2
loc_1654:
	jsr	(sub_DEE6).l
	dbf	d2,loc_1654
	dbf	d7,loc_1640
	movem.w	(a7)+,d0-d5
	movem.l	(a7)+,d6/a2
	rts

; ---------------------------------------------------------------------------
sub_166C:
	link	a6,#-$132
	movem.l	d2-d7/a2-a3,-(a7)
	movem.w	d2-d3,-$CC(a6)
	movea.l	a0,a3
	move.w	d4,-$C2(a6)
	asl.w	#$3,d4
	move.w	d4,-$C4(a6)
	asl.w	#$3,d2
	addi.w	#$80,d2
	move.w	d2,-$C8(a6)
	asl.w	#$3,d3
	addi.w	#$80,d3
	move.w	d3,-$C6(a6)
	jsr	(sub_97CC).l
	move.w	(a2),d0
	addi.w	#$48,d0
	move.w	d0,$6(a2)
	move.l	a2,-$D0(a6)
	lea	-$C0(a6),a0
	moveq	#$17,d0
loc_16B4:
	st	$6(a0)
	addq.w	#$8,a0
	dbf	d0,loc_16B4
	moveq	#$0,d7
loc_16C0:
	clr.b	-$131(a6)
	clr.b	-$132(a6)
	jsr	(sub_DEE6).l
	lea	-$C0(a6),a2
	moveq	#$17,d6
loc_16D4:
	tst.b	$6(a2)
	beq.s	loc_1722
	tst.b	-$131(a6)
	bne.s	loc_174E
	cmp.w	-$C4(a6),d7
	bcc.s	loc_174E
	st	-$131(a6)
	st	-$132(a6)
	clr.b	$6(a2)
	move.w	#$79,(a2)
	move.w	#$F,$2(a2)
	move.w	-$C8(a6),d0
	add.w	d7,d0
	move.w	d0,$4(a2)
	andi.w	#$7,d0
	beq.s	loc_1712
	st	$7(a2)
	bra.s	loc_171A
loc_1712:
	move.w	d7,d0
	asr.w	#$3,d0
	move.b	d0,$7(a2)
loc_171A:
	bsr.w	sub_1810
	addq.w	#$1,d7
	bra.s	loc_174E
loc_1722:
	st	-$132(a6)
	move.w	$2(a2),d0
	bmi.s	loc_1732
	bne.s	loc_1730
	moveq	#$1,d0
loc_1730:
	sub.w	d0,(a2)
loc_1732:
	subq.w	#$1,$2(a2)
	move.w	$2(a2),d0
	cmp.w	#$FFF8,d0
	bge.s	loc_174E
	st	$6(a2)
	move.b	$7(a2),d0
	bmi.s	loc_174E
	bsr.w	sub_17C8
loc_174E:
	move.w	d6,d0
	asl.w	#$3,d0
	addi.w	#$EC00,d0
	bsr.w	sub_8288
	movea.l	-$D0(a6),a0
	move.w	d6,d3
	mulu.w	#$3,d3
	add.w	(a0),d3
	ori.w	#$6000,d3
	move.w	d6,d2
	addq.w	#$1,d2
	cmp.w	#$18,d2
	bne.s	loc_1776
	moveq	#$0,d2
loc_1776:
	tst.b	$6(a2)
	bne.s	loc_17A0
	move.w	(a2),d0
	btst	#$0,d6
	beq.s	loc_1786
	neg.w	d0
loc_1786:
	move.w	-$C6(a6),d0
	move.w	d0,(a5)
	move.w	d2,d0
	ori.w	#$200,d0
	move.w	d0,(a5)
	move.w	d3,(a5)
	move.w	$4(a2),d0
	add.w	(a2),d0
	move.w	d0,(a5)
	bra.s	loc_17AA
loc_17A0:
	moveq	#$0,d0
	move.w	d0,(a5)
	move.w	d2,(a5)
	move.w	d0,(a5)
	move.w	d0,(a5)
loc_17AA:
	addq.w	#$8,a2
	dbf	d6,loc_16D4
	tst.b	-$132(a6)
	bne.w	loc_16C0
	lea	-$D0(a6),a0
	bsr.w	sub_9784
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_17C8:
	movem.l	d2-d4/d6-d7,-(a7)
	ext.w	d0
	asl.w	#$1,d0
	move.w	d0,d6
	movea.l	$2(a3),a0
	move.w	-$C2(a6),d4
	asl.w	#$1,d4
	adda.w	d0,a0
	movem.w	-$CC(a6),d2-d3
	asl.w	#$1,d2
	asl.w	#$7,d3
	add.w	d6,d2
	add.w	d3,d2
	addi.w	#$A000,d2
	moveq	#$2,d7
loc_17F2:
	move.w	d2,d0
	bsr.w	sub_8288
	move.w	(a0),d0
	ori.w	#$6000,d0
	move.w	d0,(a5)
	addi.w	#$80,d2
	adda.w	d4,a0
	dbf	d7,loc_17F2
	movem.l	(a7)+,d2-d4/d6-d7
	rts

; ---------------------------------------------------------------------------
sub_1810:
	movem.l	d2-d5/a2,-(a7)
	movea.l	$2(a3),a2
	move.w	d7,d0
	asr.w	#$2,d0
	bclr	#$0,d0
	adda.w	d0,a2
	move.w	-$C2(a6),d5
	asl.w	#$1,d5
	moveq	#$0,d4
loc_182A:
	move.w	(a2),d0
	move.w	d0,d2
	asl.w	#$5,d0
	bsr.w	sub_829C
	lea	-$130(a6),a1
	adda.w	d4,a1
	btst	#$C,d2
	beq.s	loc_1844
	adda.w	#$1C,a1
loc_1844:
	move.w	d7,d1
	andi.w	#$7,d1
	btst	#$B,d2
	beq.s	loc_1854
	neg.w	d1
	addq.w	#$7,d1
loc_1854:
	asl.w	#$2,d1
	moveq	#$7,d3
loc_1858:
	move.l	(a5),d0
	asl.l	d1,d0
	andi.l	#$F0000000,d0
	move.l	d0,(a1)
	btst	#$C,d2
	beq.s	loc_186E
	subq.l	#$4,a1
	bra.s	loc_1870
loc_186E:
	addq.l	#$4,a1
loc_1870:
	dbf	d3,loc_1858
	adda.w	d5,a2
	addi.w	#$20,d4
	cmp.w	#$60,d4
	bne.s	loc_182A
	move.w	d6,d0
	mulu.w	#$3,d0
	movea.l	-$D0(a6),a0
	add.w	(a0),d0
	asl.w	#$5,d0
	bsr.w	sub_8288
	lea	-$130(a6),a0
	moveq	#$17,d0
loc_1898:
	move.l	(a0)+,(a5)
	dbf	d0,loc_1898
	movem.l	(a7)+,d2-d5/a2
	rts
	binclude	"data/0018A4.bin"

; ---------------------------------------------------------------------------
sub_18BE:
	moveq	#$1,d0
	bra.s	loc_18C4

; ---------------------------------------------------------------------------
sub_18C2:
	moveq	#$0,d0
loc_18C4:
	movem.l	d2-d5/a2-a4,-(a7)
	moveq	#$0,d3
	lea	($FFFFD5E6).w,a2
	lea	($18A4).w,a3
	lea	($18B4).w,a4
	moveq	#$0,d4
	move.w	#$FF,d5
loc_18DC:
	movea.l	(a3)+,a0
	cmpa.l	#$FFFFD5E6,a0
	beq.s	loc_190C
	move.w	(a4)+,d2
	bra.s	loc_1906
loc_18EA:
	add.b	(a0)+,d4
	dbf	d5,loc_1906
	tst.b	d0
	beq.s	loc_18FC
	cmp.b	(a2)+,d4
	beq.s	loc_18FE
	moveq	#$0,d0
	bra.s	loc_190E
loc_18FC:
	move.b	d4,(a2)+
loc_18FE:
	addq.w	#$1,d3
	move.l	d3,d4
	move.w	#$FF,d5
loc_1906:
	dbf	d2,loc_18EA
	bra.s	loc_18DC
loc_190C:
	moveq	#$1,d0
loc_190E:
	movem.l	(a7)+,d2-d5/a2-a4
	rts
loc_1914:
	bsr.w	sub_7194
	tst.w	d0
	beq.w	loc_192E
	bsr.w	sub_194E
	move.b	#$0,($FFFFBA5E).w
	jsr	(sub_AF00).l
loc_192E:
	rts

; ---------------------------------------------------------------------------
sub_1930:
	move.b	($FFFF9BBC).w,($FFFF9BBD).w
	move.b	#$0,($FFFF9BBC).w
	bsr.w	sub_194E
	move.b	($FFFF9BBD).w,($FFFFBA5E).w
	jsr	(sub_AF00).l
	rts

; ---------------------------------------------------------------------------
sub_194E:
	movem.l	d2-d6/a2-a6,-(a7)
	moveq	#$0,d0
	bsr.w	sub_1A9E
	subq.w	#$1,d2
	bmi.s	loc_19B2
	bsr.w	sub_19B8
	mulu.w	#$AA8,d2
	bsr.w	sub_18C2
	tst.b	($FFFFCA21).w
	beq.s	loc_1980
	lea	($200011).l,a3
	asl.w	#$1,d2
	adda.w	d2,a3
	lea	(dat_2240).l,a5
	bra.s	loc_198E
loc_1980:
	lea	(dat_FE008).l,a3
	adda.w	d2,a3
	lea	(dat_2246).l,a5
loc_198E:
	move.l	#$18B4,d4
	move.l	#$18A4,d5
	moveq	#$0,d6
	lea	(dat_2222).l,a4
	move.w	#$AA8,d0
	bsr.w	sub_1F5E
	move.b	($FFFFB9F0).w,d0
	bsr.w	sub_40D0
loc_19B2:
	movem.l	(a7)+,d2-d6/a2-a6
	rts

; ---------------------------------------------------------------------------
sub_19B8:
	movem.l	d2-d3/a2,-(a7)
	move.w	d2,d3
	bsr.w	sub_224A
	asl.w	#$2,d0
	lea	(dat_19EC).l,a2
	adda.w	d0,a2
	moveq	#$2,d2
loc_19CE:
	bsr.w	sub_224A
	move.b	(a2,d0.w),d0
	bsr.w	sub_225C
	dbf	d2,loc_19CE
	move.w	d3,d2
	moveq	#$2,d0
	bsr.w	sub_225C
	movem.l	(a7)+,d2-d3/a2
	rts
dat_19EC:
	binclude	"data/0019EC.bin"

; ---------------------------------------------------------------------------
sub_19FC:
	move.l	d2,-(a7)
	moveq	#$1,d0
	bsr.w	sub_1A9E
	tst.w	d2
	bmi.s	loc_1A2C
	subq.w	#$1,d2
	moveq	#$1,d0
	bsr.w	sub_1A3A
	jsr	(sub_BEF4).l
	moveq	#$0,d0
	move.b	d0,($FFFF9BBC).w
	move.b	d0,($FFFFBA5E).w
	clr.w	($FFFFB52A).w
	clr.b	($FFFFB525).w
	st	($FFFFBA55).w
loc_1A2C:
	move.b	($FFFF9BBE).w,d0
	jsr	(sub_158BA).l
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_1A3A:
	movem.l	d2-d4/a2-a3,-(a7)
	move.w	d0,d4
	move.w	d2,d3
	bmi.w	loc_1A90
	mulu.w	#$AA8,d2
	tst.b	($FFFFCA21).w
	beq.s	loc_1A5C
	lea	($200011).l,a0
	asl.w	#$1,d2
	adda.w	d2,a0
	bra.s	loc_1A64
loc_1A5C:
	lea	(dat_FE008).l,a0
	adda.w	d2,a0
loc_1A64:
	jsr	(sub_9E76).l
	lea	($18A4).w,a2
	lea	($18B4).w,a3
loc_1A72:
	move.l	(a2)+,d0
	move.w	(a3)+,d1
	beq.s	loc_1A82
	ext.l	d1
	jsr	(sub_9ED8).l
	bra.s	loc_1A72
loc_1A82:
	bsr.w	sub_18BE
	bne.s	loc_1A98
	move.w	d3,d2
	moveq	#$3,d0
	bsr.w	sub_225C
loc_1A90:
	tst.w	d4
	beq.s	loc_1A98
	bsr.w	sub_1F32
loc_1A98:
	movem.l	(a7)+,d2-d4/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_1A9E:
	link	a6,#-$18
	movem.l	d3-d7/a2-a3,-(a7)
	move.w	d0,-$10(a6)
	move.b	($FFFF9AFB).w,-$9(a6)
	move.b	($FFFF9BBC).w,-$A(a6)
	move.w	($FFFFB530).w,-$C(a6)
	move.b	($FFFF9BBE).w,-$E(a6)
	move.b	($FFFFB524).w,-$D(a6)
	bsr.w	sub_85D6
	bsr.w	sub_862A
	moveq	#$1,d5
	jsr	(sub_A71E).l
	move.b	($FFFFBA5F).w,($FFFF9BBE).w
	move.b	#$0,($FFFF9BBC).w
	clr.w	($FFFFB52A).w
	clr.b	($FFFFB525).w
	bsr.w	sub_8360
	bsr.w	sub_8A60
	bsr.w	sub_8A6E
	bsr.w	sub_96D8
	lea	(dat_EA350).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,-$8(a6)
	move.l	$2(a0),$8(a0)
	moveq	#$0,d0
	moveq	#$2,d1
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$40,d4
	moveq	#$40,d5
	move.w	#$7FFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	clr.w	($FFFFB514).w
	bsr.w	sub_95BE
	lea	(dat_51326).l,a0
	lea	(dat_51360).l,a1
loc_1B40:
	move.b	(a0)+,d0
	cmp.b	#$6F,d0
	beq.s	loc_1B4C
	addq.l	#$4,a1
	bra.s	loc_1B40
loc_1B4C:
	movea.l	(a1),a0
	jsr	(sub_9DD4).l
	move.l	a0,-$4(a6)
	move.b	#$2,($FFFFB4BE).w
	moveq	#$16,d0
	bsr.w	sub_976C
	clr.b	($FFFFB4BE).w
	tst.w	-$10(a6)
	beq.s	loc_1B88
	moveq	#$2,d2
	moveq	#$1,d7
loc_1B72:
	bsr.w	sub_224A
	cmp.b	#$3,d0
	bcc.s	loc_1B82
	move.w	d2,d0
	addq.w	#$1,d0
	bset	d0,d7
loc_1B82:
	dbf	d2,loc_1B72
	bra.s	loc_1B8A
loc_1B88:
	moveq	#-$2,d7
loc_1B8A:
	bsr.w	sub_1D78
	bsr.w	sub_860E
	move.l	(dat_1DA6).l,d0
	move.l	d0,-$14(a6)
	move.l	d0,-$18(a6)
	moveq	#$0,d2
loc_1BA2:
	cmp.b	#$2,d2
	bcc.s	loc_1BB6
	move.w	#$BFFF,($FFFFB510).w
	move.w	#$A000,($FFFFB512).w
	bra.s	loc_1BC2
loc_1BB6:
	move.w	#$3FFF,($FFFFB510).w
	move.w	#$2000,($FFFFB512).w
loc_1BC2:
	move.w	#$F000,($FFFFB436).w
	movem.w	-$14(a6),d0-d1
	bsr.w	sub_1E14
	lea	(sub_1CF2).l,a0
	jsr	(sub_1344E).l
	move.l	#$20019,($FFFFD5D6).w
	move.w	#$8000,($FFFFD5AC).w
	move.w	#$184,d0
	add.w	-$10(a6),d0
	jsr	(sub_11C8E).l
	move.w	#$C000,($FFFFD5AC).w
	move.w	#$148,d0
	jsr	(sub_11C8E).l
	move.w	#$1,($FFFFD5AA).w
	move.w	d2,d0
	addq.w	#$1,d0
	jsr	(sub_13322).l
	jsr	(sub_11CA0).l
	subq.w	#$1,d2
	bmi.s	loc_1C3A
	bsr.w	sub_224A
	cmp.b	#$3,d0
	beq.s	loc_1C34
	addi.w	#$13E,d0
	bra.s	loc_1C3E
loc_1C34:
	move.w	#$146,d0
	bra.s	loc_1C3E
loc_1C3A:
	move.w	#$13D,d0
loc_1C3E:
	addq.w	#$1,d2
	jsr	(sub_11C8E).l
	move.w	#$141,d0
	jsr	(sub_11C8E).l
loc_1C50:
	jsr	(sub_F1B66).l
	btst	#$0,d0
	beq.s	loc_1C66
	cmp.w	#$2,d2
	bcs.s	loc_1C66
	subq.w	#$2,d2
	bra.s	loc_1CAC
loc_1C66:
	btst	#$1,d0
	beq.s	loc_1C76
	cmp.w	#$2,d2
	bcc.s	loc_1C76
	addq.w	#$2,d2
	bra.s	loc_1CAC
loc_1C76:
	btst	#$2,d0
	beq.s	loc_1C86
	btst	#$0,d2
	beq.s	loc_1C86
	subq.w	#$1,d2
	bra.s	loc_1CAC
loc_1C86:
	btst	#$3,d0
	beq.s	loc_1C96
	btst	#$0,d2
	bne.s	loc_1C96
	addq.w	#$1,d2
	bra.s	loc_1CAC
loc_1C96:
	btst	#$7,d0
	beq.s	loc_1CA0
	moveq	#-$1,d2
	bra.s	loc_1CB4
loc_1CA0:
	btst	#$5,d0
	beq.s	loc_1C50
	btst	d2,d7
	bne.s	loc_1CB4
	bra.s	loc_1C50
loc_1CAC:
	bsr.w	sub_1CFA
	bra.w	loc_1BA2
loc_1CB4:
	lea	-$4(a6),a0
	bsr.w	sub_9784
	lea	-$8(a6),a0
	bsr.w	sub_9784
	move.b	-$A(a6),($FFFFBA5E).w
	move.b	-$9(a6),($FFFF9AFB).w
	move.b	-$E(a6),($FFFF9BBE).w
	move.w	-$C(a6),($FFFFB52A).w
	move.b	-$D(a6),($FFFFB525).w
	move.w	#$F000,($FFFFB436).w
	movem.l	(a7)+,d3-d7/a2-a3
	unlk	a6
	rts
	dc.b	$00,$00

; ---------------------------------------------------------------------------
sub_1CF2:
	ori.b	#$19,d1
	ori.b	#$19,-(a7)

; ---------------------------------------------------------------------------
sub_1CFA:
	movem.l	d2-d7,-(a7)
	lea	(dat_1DA6).l,a0
	move.w	d2,d0
	asl.w	#$3,d0
	adda.w	d0,a0
	move.l	(a0),-$18(a6)
	moveq	#$8,d6
	move.w	#$F000,($FFFFB436).w
loc_1D16:
	movem.w	-$18(a6),d2-d3
	moveq	#$8,d0
	sub.w	d6,d0
	mulu.w	d0,d2
	mulu.w	d0,d3
	movem.w	-$14(a6),d0-d1
	mulu.w	d6,d0
	mulu.w	d6,d1
	add.w	d0,d2
	add.w	d1,d3
	lsr.w	#$3,d2
	lsr.w	#$3,d3
	move.w	d2,d0
	move.w	d3,d1
	move.w	#$BFFF,($FFFFB510).w
	move.w	#$A000,($FFFFB512).w
	clr.w	($FFFFB50E).w
	bsr.w	sub_1E14
	jsr	(sub_DEE6).l
	moveq	#$20,d1
	moveq	#$D,d4
	moveq	#$D,d5
	moveq	#$0,d0
	movea.l	d0,a0
	clr.w	($FFFFB514).w
	jsr	(sub_95BE).l
	dbf	d6,loc_1D16
	move.l	-$18(a6),-$14(a6)
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_1D78:
	movem.l	d2-d3/d5-d6/a2,-(a7)
	move.w	#$C000,($FFFFB436).w
	moveq	#$3,d5
	lea	(dat_1DBA).l,a2
loc_1D8A:
	movem.w	(a2),d0-d3
	btst	d5,d7
	sne	d6
	bsr.w	sub_1DC2
	subq.l	#$8,a2
	dbf	d5,loc_1D8A
	movem.l	(a7)+,d2-d3/d5-d6/a2
	rts
	dc.b	$00,$00,$00,$01
dat_1DA6:
	binclude	"data/001DA6.bin"
dat_1DBA:
	dc.b	$00,$03,$00,$00,$00,$1A,$00,$0B

; ---------------------------------------------------------------------------
sub_1DC2:
	movem.l	d2-d5,-(a7)
	tst.b	d1
	beq.s	loc_1DD8
	move.w	#$FFFF,($FFFFB510).w
	move.w	#$8000,($FFFFB512).w
	bra.s	loc_1DE2
loc_1DD8:
	move.w	#$7FFF,($FFFFB510).w
	clr.w	($FFFFB512).w
loc_1DE2:
	clr.w	($FFFFB50E).w
	movea.l	-$4(a6),a0
	addq.w	#$1,d2
	addq.w	#$1,d3
	moveq	#$2,d1
	moveq	#$B,d4
	moveq	#$B,d5
	bsr.w	sub_95BE
	subq.w	#$1,d2
	subq.w	#$1,d3
	move.w	d2,d0
	move.w	d3,d1
	tst.b	d6
	beq.s	loc_1E0A
	bsr.w	sub_1E14
	bra.s	loc_1E0E
loc_1E0A:
	bsr.w	sub_1E74
loc_1E0E:
	movem.l	(a7)+,d2-d5
	rts

; ---------------------------------------------------------------------------
sub_1E14:
	movem.l	d2-d6,-(a7)
	move.w	d0,d2
	move.w	d1,d3
	move.w	d2,d4
	move.w	d3,d5
	addi.w	#$C,d4
	move.b	#$0,($FFFFD5F9).w
	move.b	#$2,($FFFFD5FA).w
	bsr.w	sub_8C6C
	move.w	d2,d4
	addi.w	#$C,d5
	move.b	#$6,($FFFFD5FA).w
	bsr.w	sub_8C6C
	move.w	d2,d6
	addi.w	#$C,d2
	addi.w	#$C,d4
	move.b	#$2,($FFFFD5F9).w
	move.b	#$8,($FFFFD5FA).w
	bsr.w	sub_8C6C
	move.w	d6,d2
	addi.w	#$C,d3
	move.b	#$6,($FFFFD5F9).w
	bsr.w	sub_8C6C
	movem.l	(a7)+,d2-d6
	rts

; ---------------------------------------------------------------------------
sub_1E74:
	link	a6,#-$4
	movem.l	d2-d7,-(a7)
	movem.w	d0-d1,-$4(a6)
	moveq	#$4,d7
loc_1E84:
	moveq	#$3,d6
loc_1E86:
	movem.w	-$4(a6),d2-d3
	move.w	d6,d0
	mulu.w	#$3,d0
	move.w	d7,d1
	mulu.w	#$3,d1
	add.w	d0,d2
	add.w	d1,d3
	move.w	d2,d4
	move.w	d3,d5
	addq.w	#$3,d4
	moveq	#$1,d0
	tst.w	d6
	bne.s	loc_1EAA
	moveq	#$0,d0
loc_1EAA:
	moveq	#$1,d1
	cmp.w	#$3,d6
	bne.s	loc_1EB4
	moveq	#$2,d1
loc_1EB4:
	tst.w	d7
	beq.s	loc_1EC8
	cmp.w	#$4,d7
	beq.s	loc_1EC4
	addq.w	#$3,d0
	addq.w	#$3,d1
	bra.s	loc_1EC8
loc_1EC4:
	addq.w	#$6,d0
	addq.w	#$6,d1
loc_1EC8:
	move.b	d0,($FFFFD5F9).w
	move.b	d1,($FFFFD5FA).w
	bsr.w	sub_8C6C
	movem.w	-$4(a6),d2-d3
	move.w	d6,d0
	mulu.w	#$3,d0
	move.w	d7,d1
	mulu.w	#$3,d1
	add.w	d1,d2
	add.w	d0,d3
	move.w	d2,d4
	move.w	d3,d5
	addq.w	#$3,d5
	moveq	#$3,d0
	tst.w	d6
	bne.s	loc_1EF8
	moveq	#$0,d0
loc_1EF8:
	moveq	#$3,d1
	cmp.w	#$3,d6
	bne.s	loc_1F02
	moveq	#$6,d1
loc_1F02:
	tst.w	d7
	beq.s	loc_1F16
	cmp.w	#$4,d7
	beq.s	loc_1F12
	addq.w	#$1,d0
	addq.w	#$1,d1
	bra.s	loc_1F16
loc_1F12:
	addq.w	#$2,d0
	addq.w	#$2,d1
loc_1F16:
	move.b	d0,($FFFFD5F9).w
	move.b	d1,($FFFFD5FA).w
	bsr.w	sub_8C6C
	dbf	d6,loc_1E86
	dbf	d7,loc_1E84
	movem.l	(a7)+,d2-d7
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_1F32:
	lea	(dat_6BAAD).l,a0
	bsr.w	sub_9E76
	move.l	#$FFFFBA68,d0
	move.w	#$6B0,d1
	bsr.w	sub_9ED8
	move.l	#$FFFFC470,d0
	move.w	#$D0,d1
	bsr.w	sub_9ED8
	bsr.w	sub_115A
	rts

; ---------------------------------------------------------------------------
sub_1F5E:
	link	a6,#-$18
	movem.l	d2/d7,-(a7)
	move.w	d0,-$1A(a6)
	move.w	#$100,-$14(a6)
	move.w	#$64,-$A(a6)
	move.w	#$102,-$18(a6)
	move.w	#$9,-$C(a6)
	clr.w	-$E(a6)
	clr.w	-$10(a6)
	clr.w	-$16(a6)
	moveq	#$0,d7
	move.w	#$1FF,-$12(a6)
	lea	($FFFF6AF6).l,a0
	move.l	#$139C,d0
	moveq	#-$1,d1
loc_1FA4:
	move.w	d1,(a0)+
	dbf	d0,loc_1FA4
	jsr	(a4)
	move.w	d0,-$4(a6)
loc_1FB0:
	jsr	(a4)
	move.w	d0,-$2(a6)
	cmp.w	#$FFFF,d0
	beq.w	loc_20F6
	addq.w	#$1,-$E(a6)
	move.w	-$4(a6),d0
	move.w	-$2(a6),d1
	bsr.w	sub_212E
	move.w	d0,-$6(a6)
	asl.w	#$1,d0
	lea	($FFFF6AF6).l,a0
	move.w	(a0,d0.w),d0
	cmp.w	#$FFFF,d0
	beq.s	loc_1FEA
	move.w	d0,-$4(a6)
	bra.s	loc_1FB0
loc_1FEA:
	move.w	-$18(a6),d0
	cmp.w	-$12(a6),d0
	bhi.s	loc_2034
	move.w	-$6(a6),d0
	move.w	d0,d1
	asl.w	#$1,d1
	lea	($FFFF6AF6).l,a0
	move.w	-$18(a6),(a0,d1.w)
	lea	($FFFF23BC).l,a0
	move.w	-$4(a6),(a0,d1.w)
	lea	($FFFF1000).l,a0
	move.b	-$1(a6),(a0,d0.w)
	move.w	-$4(a6),d0
	bsr.w	sub_218C
	move.w	-$2(a6),-$4(a6)
	addq.w	#$1,-$18(a6)
	bra.s	loc_2042
loc_2034:
	move.w	-$4(a6),d0
	bsr.w	sub_218C
	move.w	-$2(a6),-$4(a6)
loc_2042:
	move.w	-$E(a6),d0
	cmp.w	-$14(a6),d0
	bls.s	loc_20C0
	move.l	#$1770,d2
	divu.w	-$E(a6),d2
	move.w	-$10(a6),d0
	mulu.w	#$64,d0
	divu.w	-$E(a6),d0
	move.w	d0,-$8(a6)
	move.w	-$A(a6),d1
	add.w	d2,d1
	cmp.w	d1,d0
	bls.s	loc_20AE
	move.w	#$100,d0
	bsr.w	sub_218C
	move.w	#$9,-$C(a6)
	move.w	#$102,-$18(a6)
	move.w	#$1FF,-$12(a6)
	clr.w	-$E(a6)
	clr.w	-$10(a6)
	move.w	#$64,-$A(a6)
	lea	($FFFF6AF6).l,a0
	move.l	#$139C,d0
	moveq	#-$1,d1
loc_20A6:
	move.w	d1,(a0)+
	dbf	d0,loc_20A6
	bra.s	loc_20B4
loc_20AE:
	move.w	-$8(a6),-$A(a6)
loc_20B4:
	move.w	-$E(a6),d0
	addi.w	#$64,d0
	move.w	d0,-$14(a6)
loc_20C0:
	move.w	-$18(a6),d0
	cmp.w	-$12(a6),d0
	bls.s	loc_20F2
	move.w	-$C(a6),d0
	cmp.w	#$C,d0
	bcc.s	loc_20F2
	addq.w	#$1,-$C(a6)
	move.w	-$C(a6),d0
	moveq	#$1,d1
	asl.w	d0,d1
	subq.w	#$1,d1
	move.w	d1,-$12(a6)
	move.w	-$E(a6),d0
	addi.w	#$100,d0
	move.w	d0,-$14(a6)
loc_20F2:
	bra.w	loc_1FB0
loc_20F6:
	move.w	-$4(a6),d0
	bsr.w	sub_218C
	move.w	-$18(a6),d0
	cmp.w	-$12(a6),d0
	bne.s	loc_210C
	addq.w	#$1,-$C(a6)
loc_210C:
	move.w	#$101,d0
	bsr.w	sub_218C
	moveq	#$0,d0
	bsr.w	sub_218C
	moveq	#$0,d0
	bsr.w	sub_218C
	moveq	#$0,d0
	bsr.w	sub_218C
	movem.l	(a7)+,d2/d7
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_212E:
	movem.l	d2-d5,-(a7)
	move.w	d1,d2
	asl.w	#$4,d2
	eor.w	d0,d2
	bne.s	loc_213E
	moveq	#$1,d3
	bra.s	loc_2144
loc_213E:
	move.w	#$139D,d3
	sub.w	d2,d3
loc_2144:
	move.w	d2,d5
	asl.w	#$1,d5
	lea	($FFFF6AF6).l,a0
	move.w	(a0,d5.w),d4
	cmp.w	#$FFFF,d4
	bne.s	loc_215C
	move.w	d2,d0
	bra.s	loc_2186
loc_215C:
	lea	($FFFF23BC).l,a0
	move.w	(a0,d5.w),d4
	cmp.w	d0,d4
	bne.s	loc_217C
	lea	($FFFF1000).l,a0
	move.b	(a0,d2.w),d4
	cmp.b	d1,d4
	bne.s	loc_217C
	move.w	d2,d0
	bra.s	loc_2186
loc_217C:
	sub.w	d3,d2
	bpl.s	loc_2184
	addi.w	#$139D,d2
loc_2184:
	bra.s	loc_2144
loc_2186:
	movem.l	(a7)+,d2-d5
	rts

; ---------------------------------------------------------------------------
sub_218C:
	movem.l	d2-d6,-(a7)
	move.w	-$12(a6),d2
	asr.w	#$1,d2
	move.w	-$18(a6),d3
	cmp.w	#$102,d3
	beq.s	loc_21A2
	subq.w	#$1,d3
loc_21A2:
	move.w	d0,d5
	and.w	d2,d5
	move.w	d3,d6
	and.w	d2,d6
	cmp.w	d6,d5
	bhi.s	loc_21BC
	asl.w	#$1,d5
	cmp.w	d2,d0
	bls.s	loc_21B6
	addq.w	#$1,d5
loc_21B6:
	move.w	-$C(a6),d4
	bra.s	loc_21C2
loc_21BC:
	move.w	-$C(a6),d4
	subq.w	#$1,d4
loc_21C2:
	moveq	#$0,d2
	move.w	d5,d2
	moveq	#$20,d6
	sub.w	d4,d6
	sub.w	-$16(a6),d6
	asl.l	d6,d2
	or.l	d2,d7
	add.w	d4,-$16(a6)
loc_21D6:
	move.w	-$16(a6),d2
	cmp.w	#$8,d2
	bcs.s	loc_21FA
	move.l	d7,d0
	swap	d0
	lsr.w	#$8,d0
	jsr	(a5)
	asl.l	#$8,d7
	subq.w	#$8,-$16(a6)
	addq.w	#$1,-$10(a6)
	subq.w	#$1,-$1A(a6)
	bne.s	loc_21D6
	bra.s	loc_2200
loc_21FA:
	movem.l	(a7)+,d2-d6
	rts
loc_2200:
	lea	(dat_220C).l,a0
	jsr	(sub_132A6).l
dat_220C:
	binclude	"data/00220C.bin"
dat_2222:
	binclude	"data/002222.bin"
dat_2240:
	dc.b	$16,$80,$54,$8B,$4E,$75
dat_2246:
	dc.b	$16,$C0,$4E,$75

; ---------------------------------------------------------------------------
sub_224A:
	bsr.w	sub_22FA
	moveq	#$0,d0
	move.b	(a0),d0
	cmp.b	#$3,d0
	bcs.s	loc_225A
	moveq	#$3,d0
loc_225A:
	rts

; ---------------------------------------------------------------------------
sub_225C:
	bsr.w	sub_22FA
	cmp.b	#$3,d0
	bcs.s	loc_2268
	moveq	#$3,d0
loc_2268:
	move.b	d0,(a0)
	cmp.b	(a0),d0
	bne.s	loc_2270
	rts
loc_2270:
	movem.l	d0-d7/a0-a1,-(a7)
	lea	(sub_2284).l,a1
	bsr.w	sub_2288
	movem.l	(a7)+,d0-d7/a0-a1
	bra.s	loc_2268

; ---------------------------------------------------------------------------
sub_2284:
	bcs.s	loc_22F8
	moveq	#$0,d1

; ---------------------------------------------------------------------------
sub_2288:
	move.l	($FFFFD5D6).w,-(a7)
	move.b	d0,d6
	move.l	a0,d7
	jsr	(sub_860E).l
	bsr.w	sub_862A
	bsr.w	sub_8360
	bsr.w	sub_8A76
	bsr.w	sub_8A60
	moveq	#$0,d0
	jsr	(sub_A71E).l
	jsr	(sub_B0DA).l
	moveq	#$0,d0
	bsr.w	sub_8A90
	move.l	#$20002,($FFFFD5D6).w
	movea.l	a1,a0
	move.w	#$E000,($FFFFD5AC).w
	jsr	(sub_11CA4).l
	addq.w	#$1,($FFFFD5D6).w
	move.l	d7,d0
	jsr	(sub_132D6).l
	addq.w	#$1,($FFFFD5D6).w
	move.b	d6,d0
	jsr	(sub_132C6).l
	moveq	#$19,d1
loc_22EA:
	moveq	#-$1,d0
loc_22EC:
	dbf	d0,loc_22EC
	dbf	d1,loc_22EA
	move.l	(a7)+,($FFFFD5D6).w
loc_22F8:
	rts

; ---------------------------------------------------------------------------
sub_22FA:
	tst.b	($FFFFCA21).w
	bne.s	loc_230A
	lea	(dat_FE004).l,a0
	adda.w	d2,a0
	rts
loc_230A:
	lea	($200009).l,a0
	adda.w	d2,a0
	adda.w	d2,a0
	rts

; ---------------------------------------------------------------------------
sub_2316:
	move.l	d2,-(a7)
	moveq	#$2,d2
loc_231A:
	moveq	#$0,d0
	bsr.w	sub_1A3A
	dbf	d2,loc_231A
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_2328:
	moveq	#-$4,d2
	muls.w	d1,d2
	moveq	#$8,d0
loc_232E:
	add.w	d2,(a0)
	move.w	(a0)+,(a5)
	add.w	d2,(a0)
	move.w	(a0)+,(a5)
	add.w	d1,d2
	dbf	d0,loc_232E
	rts

; ---------------------------------------------------------------------------
sub_233E:
	moveq	#$11,d0
loc_2340:
	move.w	(a0)+,d2
	andi.w	#$EFFF,d2
	or.w	d1,d2
	move.w	d2,(a5)
	dbf	d0,loc_2340
	rts

; ---------------------------------------------------------------------------
sub_2350:
	move.l	#$40000000,(a4)
	move.w	#$3FFF,d1
	moveq	#$0,d0
loc_235C:
	move.l	d0,(a5)
	dbf	d1,loc_235C
	rts

; ---------------------------------------------------------------------------
sub_2364:
	movem.w	d0-d7,-(a7)
	move.w	d3,d4
	addi.w	#$20,d3
	moveq	#$20,d5
	sub.w	d1,d5
	asr.w	#$1,d5
	add.w	d5,d4
	sub.w	d5,d3
	addi.w	#$80,d4
	addi.w	#$80,d3
	moveq	#$8,d0
loc_2382:
	move.w	d4,(a5)
	move.w	d3,(a5)
	dbf	d0,loc_2382
	movem.w	(a7)+,d0-d7
	rts

; ---------------------------------------------------------------------------
sub_2390:
	movem.w	d0-d7,-(a7)
	move.w	d3,d4
	addi.w	#$20,d3
	addi.w	#$80,d4
	addi.w	#$80,d3
	moveq	#$8,d0
loc_23A4:
	move.w	d4,(a5)
	move.w	d3,(a5)
	dbf	d0,loc_23A4
	movem.w	(a7)+,d0-d7
	rts

; ---------------------------------------------------------------------------
sub_23B2:
	movem.w	d1-d3,-(a7)
	ori.w	#$C00,d2
	ori.w	#$C00,d3
	bra.s	loc_23C8
loc_23C0:
	move.w	d2,(a5)
	addq.w	#$1,d2
	move.w	d2,(a5)
	addq.w	#$1,d2
loc_23C8:
	dbf	d1,loc_23C0
	move.w	d2,(a5)
	move.w	d3,(a5)
	movem.w	(a7)+,d1-d3
	rts

; ---------------------------------------------------------------------------
sub_23D6:
	tst.w	($FFFFC000).w
	blt.w	loc_2402
	move.w	($FFFFC000).w,d0
	subq.w	#$1,($FFFFC000).w
	move.w	d0,d1
	neg.w	d0
	move.l	#$60000000,(a4)
	moveq	#$6F,d2
loc_23F2:
	move.w	d0,(a5)
	move.w	#$140,(a5)
	move.w	d1,(a5)
	move.w	#$140,(a5)
	dbf	d2,loc_23F2
loc_2402:
	subq.w	#$1,($FFFFC004).w
	bge.w	loc_26E2
	move.w	#$2,($FFFFC004).w
	tst.w	($FFFFC002).w
	bne.s	loc_2422
	tst.w	($FFFFC000).w
	bge.s	loc_2422
	st	($FFFFBA52).w
	rts
loc_2422:
	addq.w	#$1,($FFFFC002).w
	move.w	($FFFFC002).w,d7
	lea	($FFFFD2E4).w,a3
	move.w	#$23F,d0
	move.l	#$49200001,(a4)
loc_2438:
	move.l	(a3)+,(a5)
	dbf	d0,loc_2438
	cmp.w	#$18,d7
	ble.s	loc_2464
	clr.w	($FFFFC002).w
	addq.w	#$1,($FFFFC00A).w
	cmpi.w	#$2,($FFFFC00A).w
	ble.w	loc_26E2
	clr.w	($FFFFC00A).w
	move.w	#$B4,($FFFFC004).w
	bra.w	loc_26E2
loc_2464:
	move.l	#$40000003,(a4)
	move.w	#$8F08,(a4)
	cmp.w	#$D,d7
	bge.w	loc_2538
	cmp.w	#$7,d7
	bne.w	loc_2532
	move.w	#$1000,d1
	cmpi.w	#$0,($FFFFC00A).w
	bne.s	loc_24C0
	move.l	#$C00C0000,($C00004).l
	move.w	#$A0,(a5)
	move.l	#$C0080000,($C00004).l
	move.w	#$A0,(a5)
	move.l	#$C00A0000,($C00004).l
	move.w	#$4E4,(a5)
	lea	($FFFFC030).w,a0
	move.w	#$5C04,(a4)
	bra.w	loc_252E
loc_24C0:
	cmpi.w	#$1,($FFFFC00A).w
	bne.s	loc_24FC
	move.l	#$C0140000,($C00004).l
	move.w	#$A42,(a5)
	move.l	#$C01A0000,($C00004).l
	move.w	#$A42,(a5)
	move.l	#$C0060000,($C00004).l
	move.w	#$E86,(a5)
	lea	($FFFFC0C0).w,a0
	move.w	#$5C94,(a4)
	bra.s	loc_252E
loc_24FC:
	move.l	#$C0160000,($C00004).l
	move.w	#$8A,(a5)
	move.l	#$C01C0000,($C00004).l
	move.w	#$8A,(a5)
	move.l	#$C0040000,($C00004).l
	move.w	#$CE,(a5)
	lea	($FFFFC078).w,a0
	move.w	#$5D24,(a4)
loc_252E:
	bsr.w	sub_233E
loc_2532:
	moveq	#-$1,d1
	bra.w	loc_25F4
loc_2538:
	cmp.w	#$14,d7
	bne.w	loc_25F2
	moveq	#$0,d1
	cmpi.w	#$0,($FFFFC00A).w
	bne.s	loc_2580
	move.l	#$C00C0000,($C00004).l
	move.w	#$4E4,(a5)
	move.l	#$C0080000,($C00004).l
	move.w	#$8E8,(a5)
	move.l	#$C00A0000,($C00004).l
	move.w	#$A0,(a5)
	lea	($FFFFC030).w,a0
	move.w	#$5C04,(a4)
	bra.w	loc_25EE
loc_2580:
	cmpi.w	#$1,($FFFFC00A).w
	bne.s	loc_25BC
	move.l	#$C0140000,($C00004).l
	move.w	#$E86,(a5)
	move.l	#$C01A0000,($C00004).l
	move.w	#$ECA,(a5)
	move.l	#$C0060000,($C00004).l
	move.w	#$A42,(a5)
	lea	($FFFFC0C0).w,a0
	move.w	#$5C94,(a4)
	bra.s	loc_25EE
loc_25BC:
	move.l	#$C0160000,($C00004).l
	move.w	#$CE,(a5)
	move.l	#$C01C0000,($C00004).l
	move.w	#$8EE,(a5)
	move.l	#$C0040000,($C00004).l
	move.w	#$8A,(a5)
	lea	($FFFFC078).w,a0
	move.w	#$5D24,(a4)
loc_25EE:
	bsr.w	sub_233E
loc_25F2:
	moveq	#$1,d1
loc_25F4:
	cmpi.w	#$0,($FFFFC00A).w
	bne.s	loc_2604
	move.w	#$5C00,(a4)
	lea	($FFFFC00C).w,a0
loc_2604:
	cmpi.w	#$1,($FFFFC00A).w
	bne.s	loc_2614
	move.w	#$5C90,(a4)
	lea	($FFFFC09C).w,a0
loc_2614:
	cmpi.w	#$2,($FFFFC00A).w
	bne.s	loc_2624
	move.w	#$5D20,(a4)
	lea	($FFFFC054).w,a0
loc_2624:
	bsr.w	sub_2328
	move.w	d7,d1
	ext.l	d1
	divu.w	#$3,d1
	cmpi.w	#$0,($FFFFC00A).w
	bne.s	loc_2664
	move.w	d1,-(a7)
	asl.w	#$2,d1
	move.w	#$68,d3
	sub.w	d7,d3
	move.w	#$5C06,(a4)
	bsr.w	sub_2364
	move.w	(a7)+,d1
	moveq	#$1,d2
	moveq	#$12,d3
	moveq	#$0,d3
	move.w	#$5C02,(a4)
	bsr.w	sub_23B2
	move.w	#$4E4,d0
	bsr.w	sub_279A
	bra.s	loc_2698
loc_2664:
	cmpi.w	#$2,($FFFFC00A).w
	bne.s	loc_269A
	move.w	d1,-(a7)
	asl.w	#$2,d1
	move.w	#$98,d3
	add.w	d7,d3
	move.w	#$5D26,(a4)
	bsr.w	sub_2390
	move.w	(a7)+,d1
	move.w	#$5D1A,(a4)
	move.w	#$C24,(a5)
	moveq	#$25,d2
	moveq	#$0,d3
	bsr.w	sub_23B2
	move.w	#$CE,d0
	bsr.w	sub_279A
loc_2698:
	bra.s	loc_26E2
loc_269A:
	move.w	#$5C8A,(a4)
	move.w	#$C12,(a5)
	moveq	#$13,d2
	moveq	#$0,d3
	bsr.w	sub_23B2
	move.w	#$E86,d0
	bsr.w	sub_279A
	lea	($FFFFD2E4).w,a3
	moveq	#$0,d2
	move.w	#$23F,d0
loc_26BC:
	move.l	d2,(a3)+
	dbf	d0,loc_26BC
	add.w	d1,d1
	addq.w	#$4,d1
	cmp.w	#$10,d1
	ble.s	loc_26CE
	moveq	#$10,d1
loc_26CE:
	moveq	#$20,d3
	movea.w	d3,a1
	subq.w	#$1,a1
	move.w	#$10,d0
	sub.w	d1,d0
	add.w	d0,d3
	suba.w	d0,a1
	bsr.w	sub_27C0
loc_26E2:
	move.w	#$8F02,(a4)
	moveq	#$0,d0
	rts

; ---------------------------------------------------------------------------
sub_26EA:
	move.w	#$80,(a0)
	add.w	d3,(a0)
	move.w	(a0)+,(a5)
	move.w	#$C00,d0
	or.w	d1,d0
	addq.w	#$1,d1
	move.w	d0,(a5)
	move.w	#$8201,(a1)
	add.w	d4,(a1)
	addq.w	#$4,d4
	move.w	(a1)+,(a5)
	move.w	#$80,d0
	add.w	d2,d0
	rts

; ---------------------------------------------------------------------------
sub_270E:
	moveq	#$7,d7
loc_2710:
	bsr.s	sub_26EA
	move.w	d0,(a5)
	bsr.s	sub_26EA
	addi.w	#$20,d0
	move.w	d0,(a5)
	addq.w	#$6,d3
	dbf	d7,loc_2710
	bsr.s	sub_26EA
	move.w	d0,(a5)
	move.w	d5,d1
	bsr.s	sub_26EA
	addi.w	#$20,d0
	move.w	d0,(a5)
	rts

; ---------------------------------------------------------------------------
sub_2732:
	move.w	d5,d6
	move.w	d4,d7
	asl.w	#$2,d7
	add.w	d7,d6
	rts

; ---------------------------------------------------------------------------
sub_273C:
	move.l	($FFFFC006).w,d3
	move.l	d0,d5
	swap	d5
	move.w	d5,d4
	andi.w	#$7,d5
	asl.w	#$2,d5
	asr.w	#$3,d4
	asl.w	#$5,d4
	rts

; ---------------------------------------------------------------------------
sub_2752:
	movem.l	d0-d7,-(a7)
	cmp.l	d1,d2
	blt.s	loc_2794
	move.l	d2,d0
	bsr.s	sub_273C
	move.l	d3,d6
	move.w	d4,d7
	subi.w	#$1C,d5
	neg.w	d5
	asl.l	d5,d6
	move.l	d1,d0
	bsr.s	sub_273C
	lsr.l	d5,d3
	cmp.w	d7,d4
	bne.s	loc_277C
	and.l	d3,d6
	move.l	d6,(a6,d4.w)
	bra.s	loc_2794
loc_277C:
	move.l	d3,(a6,d4.w)
loc_2780:
	addi.w	#$20,d4
	cmp.w	d4,d7
	beq.s	loc_2790
	move.l	($FFFFC006).w,(a6,d4.w)
	bra.s	loc_2780
loc_2790:
	move.l	d6,(a6,d7.w)
loc_2794:
	movem.l	(a7)+,d0-d7
	rts

; ---------------------------------------------------------------------------
sub_279A:
	cmp.w	#$18,d7
	bne.s	loc_27BE
	move.l	#$C0120000,(a4)
	move.w	d0,(a5)
	move.l	#$C0020000,(a4)
	cmp.w	#$E86,d0
	bne.s	loc_27B8
	move.w	#$E22,d0
loc_27B8:
	andi.w	#$666,d0
	move.w	d0,(a5)
loc_27BE:
	rts

; ---------------------------------------------------------------------------
sub_27C0:
	lea	(dat_2B8E).l,a0
	lea	($FFFFD2E4).w,a6
	lea	(dat_2BBB).l,a2
	lea	(dat_2B97).l,a3
	moveq	#$0,d6
	moveq	#$8,d4
loc_27DA:
	move.b	(a0)+,d5
	ext.w	d5
	moveq	#$5,d0
loc_27E0:
	move.l	#$AAAAAAAA,($FFFFC006).w
	cmp.w	#$1B,d6
	beq.s	loc_27F8
	bgt.s	loc_27F4
	move.b	(a3)+,d7
	bra.s	loc_27F8
loc_27F4:
	move.b	-(a3),d7
	neg.b	d7
loc_27F8:
	ext.w	d7
	sub.w	d7,d3
	adda.w	d7,a1
	addq.w	#$1,d6
	tst.w	d5
	ble.s	loc_2836
	cmp.w	#$1,d5
	bne.s	loc_2812
	move.l	#$33333333,($FFFFC006).w
loc_2812:
	move.l	d3,d1
	move.l	a1,d2
	cmp.w	#$5,d0
	bne.s	loc_282C
	move.l	#$DDDDDDDD,($FFFFC006).w
	cmp.w	#$8,d1
	bge.s	loc_282C
	moveq	#$8,d1
loc_282C:
	swap	d1
	swap	d2
	bsr.w	sub_2752
	bra.s	loc_2850
loc_2836:
	blt.s	loc_2850
	move.l	#$33333333,($FFFFC006).w
	move.l	d3,d1
	move.b	(a2)+,d2
	ext.w	d2
	add.w	d1,d2
	swap	d1
	swap	d2
	bsr.w	sub_2752
loc_2850:
	addq.l	#$4,a6
	subq.w	#$1,d5
	dbf	d0,loc_27E0
	adda.l	#$E8,a6
	dbf	d4,loc_27DA
	rts

; ---------------------------------------------------------------------------
sub_2864:
	move.w	#$3F00,d0
	moveq	#$0,d1
	movea.l	#$FFFF0000,a0
loc_2870:
	move.l	d1,(a0)+
	dbf	d0,loc_2870
	rts

; ---------------------------------------------------------------------------
sub_2878:
	move.w	sr,-(a7)
	ori.w	#$700,sr
	clr.b	($FFFFBA52).w
	movea.l	#$C00004,a4
	movea.l	#$C00000,a5
	bsr.s	sub_2864
	move.w	#$8004,(a4)
	move.w	#$8134,(a4)
	move.w	#$8228,(a4)
	move.w	#$8330,(a4)
	move.w	#$8405,(a4)
	move.w	#$856E,(a4)
	move.w	#$8700,(a4)
	move.w	#$8B03,(a4)
	move.w	#$9003,(a4)
	move.w	#$8C81,(a4)
	move.w	#$8D08,(a4)
	move.w	#$8F02,(a4)
	move.w	#$9100,(a4)
	move.w	#$9200,(a4)
	move.w	#$8A01,(a4)
	bsr.w	sub_2350
	moveq	#$0,d1
	move.l	#$40000010,(a4)
	bsr.s	sub_28E6
	move.l	#$60000000,(a4)
	neg.w	d1
	move.w	(a7)+,sr
	rts

; ---------------------------------------------------------------------------
sub_28E6:
	move.w	d1,(a5)
	move.w	d1,(a5)
	lea	($FFFFC0E4).w,a3
	moveq	#$20,d1
	moveq	#$8,d0
	lea	(dat_2B8E).l,a0
	moveq	#$0,d5
loc_28FA:
	moveq	#$0,d4
	moveq	#$0,d2
	move.b	(a0)+,d2
	bra.s	loc_2936
loc_2902:
	bsr.w	sub_2732
	movea.l	#$66666666,a1
	tst.w	d4
	bne.s	loc_2916
	movea.l	#$44444444,a1
loc_2916:
	moveq	#$7,d7
loc_2918:
	tst.w	d2
	bne.s	loc_292A
	cmpa.l	#$44444444,a1
	beq.s	loc_292A
	movea.l	#$55555555,a1
loc_292A:
	move.l	a1,(a3,d6.w)
	add.w	d1,d6
	dbf	d7,loc_2918
	addq.w	#$1,d4
loc_2936:
	dbf	d2,loc_2902
	tst.w	d0
	beq.s	loc_295A
	bsr.w	sub_2732
	movea.l	#$55555555,a1
	move.l	a1,(a3,d6.w)
	add.w	d1,d6
	move.l	a1,(a3,d6.w)
	addi.w	#$100,d5
	dbf	d0,loc_28FA
loc_295A:
	lea	($FFFFC0E4).w,a3
	move.w	#$23F,d0
	move.l	#$40200001,(a4)
loc_2968:
	move.l	(a3)+,(a5)
	dbf	d0,loc_2968
	move.l	#$97B4,d6
	move.l	a4,-(a7)
	movea.l	d6,a3
	lsr.w	#$1,d6
	lea	(dat_2B8E).l,a0
	lea	($FFFFC9EC).w,a6
	lea	(dat_2BB2).l,a4
	moveq	#$20,d3
	swap	d3
	movea.l	d3,a2
	movea.l	d3,a1
	moveq	#$8,d4
loc_2994:
	move.b	(a0)+,d5
	ext.w	d5
	moveq	#$5,d0
loc_299A:
	move.l	#$BBBBBBBB,($FFFFC006).w
	tst.w	d5
	ble.s	loc_29CA
	cmp.w	#$1,d5
	bne.s	loc_29B4
	move.l	#$22222222,($FFFFC006).w
loc_29B4:
	cmp.w	#$5,d0
	bne.s	loc_29C2
	move.l	#$EEEEEEEE,($FFFFC006).w
loc_29C2:
	move.l	d3,d1
	move.l	a1,d2
	bsr.w	sub_2752
loc_29CA:
	tst.w	d5
	bne.s	loc_29EE
	move.l	#$22222222,($FFFFC006).w
	moveq	#$0,d2
	move.b	(a4)+,d2
	beq.s	loc_29E6
	swap	d2
	add.l	d3,d2
	move.l	d3,d1
	bsr.w	sub_2752
loc_29E6:
	move.l	a2,d1
	move.l	a1,d2
	bsr.w	sub_2752
loc_29EE:
	addq.l	#$4,a6
	subq.w	#$1,d5
	sub.l	a3,d3
	adda.l	a3,a1
	adda.l	d6,a2
	dbf	d0,loc_299A
	adda.l	#$E8,a6
	dbf	d4,loc_2994
	movea.l	(a7)+,a4
	lea	($FFFFC9E4).w,a3
	move.w	#$23F,d0
	move.l	#$52200001,(a4)
loc_2A16:
	move.l	(a3)+,(a5)
	dbf	d0,loc_2A16
	move.l	#$5C000003,(a4)
	lea	($FFFFC00C).w,a0
	lea	($FFFFC030).w,a1
	moveq	#$1,d1
	moveq	#$50,d2
	move.w	#$48,d3
	moveq	#$0,d4
	moveq	#$12,d5
	bsr.w	sub_270E
	lea	($FFFFC09C).w,a0
	lea	($FFFFC0C0).w,a1
	move.w	#$88,d2
	move.w	#$48,d3
	move.w	#$48,d4
	moveq	#$24,d5
	bsr.w	sub_270E
	lea	($FFFFC054).w,a0
	lea	($FFFFC078).w,a1
	move.w	#$B0,d2
	move.w	#$46,d3
	move.w	#$90,d4
	moveq	#$0,d5
	bsr.w	sub_270E
	lea	($FFFFDBE4).w,a1
	lea	(dat_2BC4).l,a3
	moveq	#$0,d2
	move.b	$1(a3),d2
	asl.w	#$8,d2
	move.b	(a3),d2
	addq.w	#$4,a3
	bsr.w	sub_2B02
	lea	($FFFFDBE4).w,a1
	move.w	(a1)+,d0
	move.w	(a1)+,d1
	move.w	(a1)+,d2
	moveq	#$F,d3
	move.l	#$C0000000,(a4)
loc_2A9A:
	move.w	(a1)+,(a5)
	dbf	d3,loc_2A9A
	asl.w	#$3,d0
	subq.w	#$1,d0
	move.l	#$40200000,(a4)
loc_2AAA:
	move.l	(a1)+,(a5)
	dbf	d0,loc_2AAA
	move.l	#$40000002,(a4)
	move.w	#$720C,d6
	subq.w	#$1,d1
	subq.w	#$1,d2
	move.w	d2,d0
	move.w	#$8001,d4
loc_2AC4:
	move.w	d6,(a4)
	addi.w	#$100,d6
	move.w	d2,d0
loc_2ACC:
	move.w	d4,(a5)
	addq.w	#$1,d4
	dbf	d0,loc_2ACC
	dbf	d1,loc_2AC4
	move.w	#$7044,(a4)
	bsr.s	sub_2AF8
	move.w	#$7144,(a4)
	bsr.s	sub_2AF8
	move.w	#$710C,(a4)
	bsr.s	sub_2AF8
	move.w	#$7136,(a4)
	move.w	d4,(a5)
	move.w	#$E2,($FFFFC000).w
	rts

; ---------------------------------------------------------------------------
sub_2AF8:
	move.w	d4,(a5)
	addq.w	#$1,d4
	move.w	d4,(a5)
	addq.w	#$1,d4
	rts

; ---------------------------------------------------------------------------
sub_2B02:
	movem.l	d0-d7/a0-a6,-(a7)
	lea	($FFFFE7E4).w,a2
	movea.l	a2,a0
	move.l	#$20202020,d3
	move.w	#$3FF,d0
loc_2B16:
	move.l	d3,(a0)
	addq.l	#$4,a0
	dbf	d0,loc_2B16
	move.w	#$FEE,d7
	move.w	#$0,d3
	moveq	#$0,d6
loc_2B28:
	dbf	d3,loc_2B34
	move.b	(a3)+,d0
	move.b	d0,d6
	move.w	#$7,d3
loc_2B34:
	move.b	(a3)+,d0
	lsr.b	#$1,d6
	bcc.w	loc_2B50
	move.b	d0,(a1)+
	subq.l	#$1,d2
	beq.w	loc_2B88
	move.b	d0,(a2,d7.w)
	addq.w	#$1,d7
	andi.w	#$FFF,d7
	bra.s	loc_2B28
loc_2B50:
	moveq	#$0,d4
	move.b	d0,d4
	move.b	(a3)+,d0
	move.b	d0,d5
	andi.w	#$F0,d0
	asl.w	#$4,d0
	or.w	d0,d4
	andi.w	#$F,d5
	addq.w	#$2,d5
loc_2B66:
	move.b	(a2,d4.w),d0
	addq.w	#$1,d4
	andi.w	#$FFF,d4
	move.b	d0,(a1)+
	subq.l	#$1,d2
	beq.w	loc_2B88
	move.b	d0,(a2,d7.w)
	addq.w	#$1,d7
	andi.w	#$FFF,d7
	dbf	d5,loc_2B66
	bra.s	loc_2B28
loc_2B88:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
dat_2B8E:
	binclude	"data/002B8E.bin"
dat_2B97:
	binclude	"data/002B97.bin"
dat_2BB2:
	binclude	"data/002BB2.bin"
dat_2BBB:
	binclude	"data/002BBB.bin"
dat_2BC4:
	binclude	"data/002BC4.bin"

; ---------------------------------------------------------------------------
sub_3300:
	movem.l	d2-d7/a2-a3,-(a7)
	clr.b	($FFFFBA59).w
loc_3308:
	cmpa.l	#$FFFF6AF6,a2
	bcs.s	loc_3318
	cmpa.l	#$FFFF96F6,a2
	bcs.s	loc_3334
loc_3318:
	lea	(dat_3324).l,a0
	jsr	(sub_132A6).l
dat_3324:
	binclude	"data/003324.bin"
loc_3334:
	move.l	a2,($FFFFD818).w
	tst.b	($FFFFBA59).w
	bne.s	loc_3368
	tst.b	($FFFFBA53).w
	bne.s	loc_3368
	moveq	#$0,d1
	move.b	(a2)+,d1
	move.l	d1,d7
	tst.b	($FFFF9BB9).w
	beq.s	loc_3354
	bsr.w	sub_438C
loc_3354:
	move.w	d7,d1
	asl.w	#$1,d1
	lea	(jt_336E).l,a3
	move.w	(a3,d1.w),d1
	jsr	(a3,d1.w)
	bra.s	loc_3308
loc_3368:
	movem.l	(a7)+,d2-d7/a2-a3
	rts
jt_336E:
	dc.w	loc_342A-jt_336E
	dc.w	loc_3438-jt_336E
	dc.w	loc_3440-jt_336E
	dc.w	sub_3452-jt_336E
	dc.w	loc_34EE-jt_336E
	dc.w	loc_34F6-jt_336E
	dc.w	loc_3500-jt_336E
	dc.w	loc_3516-jt_336E
	dc.w	loc_351E-jt_336E
	dc.w	loc_3530-jt_336E
	dc.w	loc_353A-jt_336E
	dc.w	loc_3544-jt_336E
	dc.w	loc_3566-jt_336E
	dc.w	loc_3652-jt_336E
	dc.w	loc_3662-jt_336E
	dc.w	loc_3670-jt_336E
	dc.w	loc_368C-jt_336E
	dc.w	loc_3690-jt_336E
	dc.w	loc_36E6-jt_336E
	dc.w	loc_36EE-jt_336E
	dc.w	loc_34B4-jt_336E
	dc.w	loc_3708-jt_336E
	dc.w	loc_370C-jt_336E
	dc.w	loc_3716-jt_336E
	dc.w	loc_3720-jt_336E
	dc.w	loc_372A-jt_336E
	dc.w	loc_3734-jt_336E
	dc.w	loc_373E-jt_336E
	dc.w	sub_3766-jt_336E
	dc.w	loc_377A-jt_336E
	dc.w	loc_377E-jt_336E
	dc.w	loc_3782-jt_336E
	dc.w	loc_383E-jt_336E
	dc.w	loc_3886-jt_336E
	dc.w	loc_38A2-jt_336E
	dc.w	loc_38A8-jt_336E
	dc.w	sub_38BA-jt_336E
	dc.w	loc_38EA-jt_336E
	dc.w	loc_38E2-jt_336E
	dc.w	loc_392C-jt_336E
	dc.w	loc_399A-jt_336E
	dc.w	loc_399E-jt_336E
	dc.w	loc_39B4-jt_336E
	dc.w	loc_39CC-jt_336E
	dc.w	loc_39D0-jt_336E
	dc.w	loc_3A0A-jt_336E
	dc.w	loc_3A0C-jt_336E
	dc.w	loc_3A10-jt_336E
	dc.w	loc_3A22-jt_336E
	dc.w	loc_3A34-jt_336E
	dc.w	loc_3A8E-jt_336E
	dc.w	loc_3AAA-jt_336E
	dc.w	loc_3ACC-jt_336E
	dc.w	loc_3AD0-jt_336E
	dc.w	loc_3AD4-jt_336E
	dc.w	loc_3AD8-jt_336E
	dc.w	loc_3AEC-jt_336E
	dc.w	loc_3B6A-jt_336E
	dc.w	loc_3B74-jt_336E
	dc.w	loc_3B78-jt_336E
	dc.w	loc_3B7C-jt_336E
	dc.w	loc_3B80-jt_336E
	dc.w	loc_3B86-jt_336E
	dc.w	loc_3B90-jt_336E
	dc.w	loc_3A60-jt_336E
	dc.w	loc_3BCE-jt_336E
	dc.w	loc_3C9E-jt_336E
	dc.w	loc_3CBA-jt_336E
	dc.w	loc_3CC4-jt_336E
	dc.w	loc_3CC6-jt_336E
	dc.w	loc_3CE2-jt_336E
	dc.w	loc_3CF8-jt_336E
	dc.w	loc_3D0C-jt_336E
	dc.w	loc_3D38-jt_336E
	dc.w	loc_38B4-jt_336E
	dc.w	loc_3D3C-jt_336E
	dc.w	loc_3DD8-jt_336E
	dc.w	loc_3E28-jt_336E
	dc.w	loc_3E2E-jt_336E
	dc.w	loc_3FA0-jt_336E
	dc.w	loc_3EB2-jt_336E
	dc.w	loc_3EB8-jt_336E
	dc.w	loc_3EC4-jt_336E
	dc.w	loc_3ED0-jt_336E
	dc.w	loc_3F00-jt_336E
	dc.w	loc_3F1A-jt_336E
	dc.w	loc_3F54-jt_336E
	dc.w	loc_3F70-jt_336E
	dc.w	loc_3F7A-jt_336E
	dc.w	loc_3F80-jt_336E
	dc.w	loc_3EA4-jt_336E
	dc.w	loc_3F88-jt_336E
	dc.w	loc_3FB4-jt_336E
	dc.w	loc_3FF4-jt_336E
loc_342A:
	move.l	#$FFFFB9F0,($FFFFB9AC).w
	st	($FFFFBA59).w
	rts
loc_3438:
	bsr.w	sub_404A
	movea.l	a0,a2
	rts
loc_3440:
	bsr.w	sub_404A
	movea.l	($FFFFB9AC).w,a1
	move.l	a2,-(a1)
	move.l	a1,($FFFFB9AC).w
	movea.l	a0,a2
	rts

; ---------------------------------------------------------------------------
sub_3452:
	movem.l	d2/a3,-(a7)
	bsr.w	sub_404A
	move.l	d0,d2
	movea.l	a0,a3
	bsr.w	sub_404A
	tst.b	d1
	bmi.s	loc_349E
	moveq	#$0,d1
	cmp.l	d0,d2
	bhi.s	loc_3476
	bset	#$2,d1
	bset	#$4,d1
	bra.s	loc_347E
loc_3476:
	bset	#$3,d1
	bset	#$5,d1
loc_347E:
	cmp.l	d0,d2
	bne.s	loc_3490
	bset	#$0,d1
	bset	#$5,d1
	bclr	#$2,d1
	bra.s	loc_3494
loc_3490:
	bset	#$1,d1
loc_3494:
	move.b	d1,($FFFFB9F2).w
	movem.l	(a7)+,d2/a3
	rts
loc_349E:
	movea.l	a3,a0
	movea.l	d0,a1
	jsr	(loc_1348C).l
	tst.w	d0
	bne.s	loc_34B0
	moveq	#$1,d1
	bra.s	loc_3494
loc_34B0:
	moveq	#$2,d1
	bra.s	loc_3494
loc_34B4:
	movem.l	d2,-(a7)
	bsr.s	sub_3452
	move.b	($FFFFB9F2).w,d2
	bsr.s	sub_3452
	btst	#$0,d2
	beq.s	loc_34D6
	btst	#$0,($FFFFB9F2).w
	beq.s	loc_34D6
	move.b	#$1,($FFFFB9F2).w
	bra.s	loc_34DC
loc_34D6:
	move.b	#$2,($FFFFB9F2).w
loc_34DC:
	movem.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_34E2:
	bsr.w	sub_404A
	move.l	d0,d2
	bsr.w	sub_404A
	rts
loc_34EE:
	bsr.s	sub_34E2
	add.l	d0,d2
	bra.w	loc_42AA
loc_34F6:
	bsr.s	sub_34E2
	sub.l	d2,d0
	move.l	d0,d2
	bra.w	loc_42AA
loc_3500:
	bsr.s	sub_34E2
	move.l	d0,d1
	move.l	d2,d0
	jsr	(sub_13406).l
	move.l	d0,d2
	move.b	d1,($FFFF9E35).w
	bra.w	loc_42AA
loc_3516:
	bsr.s	sub_34E2
	mulu.w	d0,d2
	bra.w	loc_42AA
loc_351E:
	bsr.w	sub_404A
	addq.l	#$1,d0
	bsr.w	sub_6C94
	moveq	#$0,d2
	move.b	d0,d2
	bra.w	loc_42AA
loc_3530:
	bsr.w	sub_404A
	move.l	d0,d2
	bra.w	loc_42AA
loc_353A:
	bsr.w	sub_404A
	move.b	d0,($FFFF9DA7).w
	rts
loc_3544:
	bsr.w	sub_404A
	move.l	d0,d2
	bsr.w	sub_404A
	move.l	d0,d3
	bsr.w	sub_404A
	move.l	d2,d4
	moveq	#$8,d6
	add.b	($FFFFD49B).w,d6
	addq.b	#$1,($FFFFD49B).w
	bsr.w	sub_48E8
	rts
loc_3566:
	bsr.w	sub_404A
	move.w	d0,($FFFFB528).w
	bsr.w	sub_404A
	move.b	d0,($FFFF9DB7).w
	bsr.w	sub_404A
	move.b	d0,($FFFFB525).w
	bsr.w	sub_404A
	move.b	d0,($FFFFD8CC).l
	bsr.w	sub_4DFA
	moveq	#$0,d7
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$1,d0
	bne.s	loc_359A
	rts
loc_359A:
	lea	(dat_9A14).l,a0
	move.w	($FFFFB528).w,d0
	bmi.s	loc_35BE
loc_35A6:
	cmp.b	$4(a0),d0
	beq.s	loc_35B0
	addq.w	#$8,a0
	bra.s	loc_35A6
loc_35B0:
	move.b	$7(a0),d0
	lsr.b	#$4,d0
	cmp.b	#$3,d0
	bne.s	loc_35BE
	moveq	#$14,d7
loc_35BE:
	move.b	($FFFF9AFA).w,d0
	asl.w	#$1,d0
	bsr.w	sub_4DAA
	move.b	d0,($FFFF9DB6).w
	cmp.b	($FFFF9DB7).w,d0
	bcs.s	loc_35D8
	move.b	($FFFF9DB7).w,($FFFF9DB6).w
loc_35D8:
	moveq	#$0,d2
	move.b	($FFFF9AFA).w,d2
	moveq	#$0,d3
	move.b	($FFFF9DB6).w,d3
	bne.s	loc_3600
loc_35E6:
	cmp.b	#$1,d2
	beq.s	loc_3600
	move.w	d2,d0
	asl.w	#$1,d0
	bsr.w	sub_4DAA
	tst.b	d0
	bne.s	loc_3600
	addq.w	#$1,d2
	andi.w	#$3,d2
	bra.s	loc_35E6
loc_3600:
	tst.b	d7
	beq.s	loc_3638
	cmp.b	#$3,d2
	bne.s	loc_3622
	tst.b	d3
	bne.s	loc_3622
loc_360E:
	move.b	#$2,($FFFF9DB7).w
	moveq	#$4,d0
	bsr.w	sub_6C94
	move.b	d0,($FFFF9AFA).w
	subq.w	#$1,d7
	bra.s	loc_35BE
loc_3622:
	cmp.b	#$1,d2
	bne.s	loc_3638
	moveq	#$2,d0
	bsr.w	sub_4DAA
	cmp.b	d0,d3
	bcs.s	loc_3638
	subq.w	#$1,d3
	bpl.s	loc_3638
	bra.s	loc_360E
loc_3638:
	move.w	($FFFFB528).w,d4
	lea	(dat_364E).l,a0
	move.b	(a0,d2.w),d0
	move.w	d0,d5
	jmp	(sub_C1DE).l
dat_364E:
	dc.b	$0C,$86,$00,$06
loc_3652:
	tst.b	($FFFF9DB6).w
	beq.s	loc_3660
	subq.b	#$1,($FFFF9DB6).w
	bsr.w	sub_4DFA
loc_3660:
	rts
loc_3662:
	bsr.w	sub_404A
	move.b	d0,($FFFFB525).w
	bsr.w	sub_4DFA
	rts
loc_3670:
	bsr.w	sub_404A
	move.l	d0,d2
	move.l	($FFFFD5D6).w,-(a7)
	st	($FFFFD592).w
	jsr	(sub_134F8).l
	move.l	(a7)+,($FFFFD5D6).w
	bra.w	loc_42AA
loc_368C:
	bra.w	loc_4022
loc_3690:
	move.b	#$2,($FFFFB4C7).w
	move.w	#$8000,($FFFFD5AC).w
	move.w	#$F000,($FFFFD5A8).w
	bsr.w	sub_404A
	tst.b	d1
	bmi.s	loc_36DE
	move.w	#$8,($FFFFD5AA).w
	cmp.b	#$4,d1
	bcc.s	loc_36CA
	jsr	(sub_13328).l
	jsr	(sub_1368C).l
	jsr	(sub_11CA0).l
	bra.s	loc_36E4
loc_36CA:
	jsr	(sub_13376).l
	jsr	(sub_1368C).l
	jsr	(sub_11CA0).l
	bra.s	loc_36E4
loc_36DE:
	jsr	(sub_11CA4).l
loc_36E4:
	rts
loc_36E6:
	jsr	(sub_1343E).l
	bra.s	loc_3690
loc_36EE:
	movea.l	($FFFFB9AC).w,a0
	cmpa.l	#$FFFFB9F0,a0
	bne.s	loc_3700
	st	($FFFFBA59).w
	rts
loc_3700:
	movea.l	(a0)+,a2
	move.l	a0,($FFFFB9AC).w
	rts
loc_3708:
	bra.w	loc_4022
loc_370C:
	btst	#$0,($FFFFB9F2).w
	beq.s	loc_3748
	rts
loc_3716:
	btst	#$1,($FFFFB9F2).w
	beq.s	loc_3748
	rts
loc_3720:
	btst	#$2,($FFFFB9F2).w
	beq.s	loc_3748
	rts
loc_372A:
	btst	#$3,($FFFFB9F2).w
	beq.s	loc_3748
	rts
loc_3734:
	btst	#$4,($FFFFB9F2).w
	beq.s	loc_3748
	rts
loc_373E:
	btst	#$5,($FFFFB9F2).w
	beq.s	loc_3748
	rts
loc_3748:
	moveq	#$0,d0
	move.b	(a2)+,d0
	lea	(dat_482E).l,a0
	move.b	(a0,d0.w),d2
	ext.w	d2
	subq.w	#$1,d2
	bmi.s	loc_3764
loc_375C:
	bsr.w	sub_404A
	dbf	d2,loc_375C
loc_3764:
	rts

; ---------------------------------------------------------------------------
sub_3766:
	move.w	#$8,($FFFFBA64).w
	sf	($FFFFD49B).w
	clr.l	($FFFFBA34).w
	clr.b	($FFFFB9F3).w
	rts
loc_377A:
	bra.w	loc_4022
loc_377E:
	bra.w	loc_4022
loc_3782:
	bsr.s	sub_3766
	clr.b	($FFFFD50E).w
	bsr.w	sub_404A
	move.b	d0,($FFFF9924).w
	bsr.w	sub_404A
	move.l	d0,-(a7)
	bsr.w	sub_404A
	move.b	d0,($FFFF9926).w
	bsr.w	sub_404A
	move.b	d0,($FFFF9925).w
	move.b	($FFFFD806).w,($FFFFD809).w
	move.b	#$37,d0
	jsr	(sub_1B900).l
	move.l	(a7)+,d0
	jsr	(sub_17816).l
	move.b	#$2C,d0
	jsr	(sub_1B900).l
	move.b	#$1,($FFFF9930).w
	move.b	($FFFF9927).w,d0
	bmi.s	loc_37F6
	st	($FFFF9930).w
	cmp.b	#$2,d0
	bne.s	loc_37E4
	jmp	(sub_7588).l
loc_37E4:
	jsr	(sub_15FDA).l
	move.b	($FFFFD809).w,d0
	jsr	(sub_1B900).l
	bra.s	loc_383C
loc_37F6:
	jsr	(sub_85D6).l
	clr.w	($FFFFB52A).w
	jsr	(sub_8360).l
	lea	($FFFFB582).w,a0
	jsr	(sub_9784).l
	move.w	#$8,($FFFFB52A).w
	jsr	(sub_8360).l
	move.b	($FFFFB9F0).w,d0
	jsr	(sub_40D0).l
	jsr	(sub_BEF4).l
	clr.b	($FFFFB524).w
	jsr	(sub_82EC).l
	move.b	($FFFF9BBD).w,($FFFFBA5E).w
loc_383C:
	rts
loc_383E:
	move.b	($FFFFB9F0).w,($FFFF97E8).w
	bsr.w	sub_404A
	move.b	d0,($FFFFB9F0).w
	bsr.w	sub_40D0
	jsr	(sub_BEF4).l
	bsr.w	sub_82EC
	lea	($FFFF97F6).w,a0
	moveq	#$7,d0
	moveq	#$0,d1
loc_3862:
	move.l	d1,(a0)+
	dbf	d0,loc_3862
	lea	($FFFF9E6F).w,a0
	moveq	#$9,d0
loc_386E:
	move.b	d1,(a0)+
	dbf	d0,loc_386E
	bsr.w	sub_4284
	st	($FFFFBA59).w
	st	($FFFFB9F1).w
	clr.b	($FFFF9BD5).w
	rts
loc_3886:
	bsr.w	sub_404A
	move.l	d0,d2
	cmp.b	#$7F,d2
	bcc.s	loc_3898
	jsr	(sub_5734).l
loc_3898:
	bsr.w	sub_404A
	bsr.w	sub_404A
	rts
loc_38A2:
	moveq	#$0,d4
	bra.w	sub_4E52
loc_38A8:
	move.b	#$3,($FFFFB4C7).w
	moveq	#$1,d4
	bra.w	sub_4E52
loc_38B4:
	st	($FFFFBA5B).w
	bra.s	loc_38BE

; ---------------------------------------------------------------------------
sub_38BA:
	clr.b	($FFFFBA5B).w
loc_38BE:
	move.b	($FFFFD806).w,($FFFFD809).w
	move.b	#$2C,d0
	jsr	(sub_1B900).l
	jsr	(sub_E394).l
	move.b	($FFFFD809).w,d0
	beq.s	loc_38E0
	jsr	(sub_1B900).l
loc_38E0:
	rts
loc_38E2:
	movem.l	d3-d7,-(a7)
	moveq	#$1,d3
	bra.s	loc_38F0
loc_38EA:
	movem.l	d3-d7,-(a7)
	moveq	#$0,d3
loc_38F0:
	moveq	#$0,d4
	bsr.w	sub_404A
	move.l	d0,d6
	bsr.w	sub_404A
	move.l	d0,d7
	moveq	#$0,d5
loc_3900:
	cmp.w	d7,d5
	beq.s	loc_3912
	bsr.w	sub_404A
	cmp.w	d6,d5
	bne.s	loc_390E
	move.l	a0,d4
loc_390E:
	addq.l	#$1,d5
	bra.s	loc_3900
loc_3912:
	tst.w	d4
	beq.s	loc_3926
	tst.w	d3
	beq.s	loc_3924
	movea.l	($FFFFB9AC).w,a1
	move.l	a2,-(a1)
	move.l	a1,($FFFFB9AC).w
loc_3924:
	movea.l	d4,a2
loc_3926:
	movem.l	(a7)+,d3-d7
	rts
loc_392C:
	bsr.w	sub_404A
	move.l	d0,($FFFFBA34).w
	bsr.w	sub_404A
	move.l	d0,d3
	move.b	d3,($FFFFB9F3).w
	lea	($FFFFB9F4).w,a3
	bra.s	loc_3972
loc_3944:
	bsr.w	sub_404A
	tst.b	d0
	beq.s	loc_3968
	cmp.b	#$5D,d0
	bhi.s	loc_3968
	moveq	#$21,d1
	lea	(dat_3978).l,a0
loc_395A:
	cmp.b	(a0,d1.w),d0
	beq.s	loc_3968
	dbf	d1,loc_395A
	move.b	d0,(a3)+
	bra.s	loc_3972
loc_3968:
	move.b	($FFFFB9F3).w,d0
	subq.b	#$1,d0
	move.b	d0,($FFFFB9F3).w
loc_3972:
	dbf	d3,loc_3944
	rts
dat_3978:
	binclude	"data/003978.bin"
loc_399A:
	bra.w	loc_4022
loc_399E:
	move.l	($FFFFD5D6).w,-(a7)
	move.b	#$40,($FFFFD595).w
	jsr	(sub_14246).l
	move.l	(a7)+,($FFFFD5D6).w
	rts
loc_39B4:
	move.l	a3,-(a7)
	bsr.w	sub_404A
	movea.l	a0,a3
	bsr.w	sub_404A
	adda.l	d0,a3
	bsr.w	sub_404A
	move.b	(a3)+,(a0)+
	movea.l	(a7)+,a3
	rts
loc_39CC:
	bra.w	loc_4324
loc_39D0:
	move.l	($FFFFD5D6).w,-(a7)
	moveq	#$1,d0
	move.b	#$1,($FFFFD592).w
	move.b	#$40,($FFFFD595).w
	clr.b	($FFFFD593).w
	jsr	(sub_136DA).l
	tst.w	d0
	bne.s	loc_39F8
	move.b	#$1,($FFFFB9F2).w
	bra.s	loc_39FE
loc_39F8:
	move.b	#$2,($FFFFB9F2).w
loc_39FE:
	jsr	(sub_1344A).l
	move.l	(a7)+,($FFFFD5D6).w
	rts
loc_3A0A:
	rts
loc_3A0C:
	bra.w	loc_500A
loc_3A10:
	bsr.w	sub_34E2
	and.l	d0,d2
	beq.s	loc_3A2A
loc_3A18:
	move.b	#$2,($FFFFB9F2).w
	bra.w	loc_42AA
loc_3A22:
	bsr.w	sub_34E2
	or.l	d0,d2
	bne.s	loc_3A18
loc_3A2A:
	move.b	#$1,($FFFFB9F2).w
	bra.w	loc_42AA
loc_3A34:
	move.w	($FFFFD5D6).w,d0
	cmp.w	($FFFFD582).w,d0
	beq.s	loc_3A48
	cmp.w	($FFFFD586).w,d0
	beq.s	loc_3A48
	addq.w	#$1,($FFFFD5D6).w
loc_3A48:
	move.w	#$8000,($FFFFD5AC).w
	move.w	#$F000,($FFFFD5A8).w
	moveq	#$2D,d0
	jsr	(sub_11C8E).l
	bra.w	loc_4324
loc_3A60:
	bsr.w	sub_404A
	move.l	d0,d2
	bsr.w	sub_404A
	andi.w	#$7F,d0
	move.l	a2,-(a7)
	bsr.w	sub_76C4
	move.l	a0,d0
	beq.s	loc_3A8A
	move.b	$8(a0),d0
	cmp.b	#$1,d0
	bls.s	loc_3A88
	subq.b	#$1,$8(a0)
	bra.s	loc_3A8A
loc_3A88:
	clr.b	(a0)
loc_3A8A:
	movea.l	(a7)+,a2
	rts
loc_3A8E:
	bsr.w	sub_404A
	move.l	a2,-(a7)
	bsr.w	sub_76C4
	move.l	a0,d0
	beq.s	loc_3AA0
	moveq	#$1,d0
	bra.s	loc_3AA2
loc_3AA0:
	moveq	#$2,d0
loc_3AA2:
	move.b	d0,($FFFFB9F2).w
	movea.l	(a7)+,a2
	rts
loc_3AAA:
	move.b	#$3,($FFFFB4C7).w
	move.w	($FFFFD5D8).w,d0
	addq.w	#$1,d0
	cmp.w	($FFFFD5E0).w,d0
	ble.s	loc_3AC0
	move.w	($FFFFD5DC).w,d0
loc_3AC0:
	move.w	d0,($FFFFD5D8).w
	move.w	($FFFFD5DA).w,($FFFFD5D6).w
	rts
loc_3ACC:
	bra.w	loc_4022
loc_3AD0:
	bra.w	loc_4022
loc_3AD4:
	bra.w	loc_488C
loc_3AD8:
	bsr.w	sub_404A
	move.l	d0,d2
	divu.w	#$3,d2
	move.b	d2,($FFFF9AFB).w
	jmp	(sub_158BA).l
loc_3AEC:
	bsr.w	sub_404A
	asl.w	#$1,d0
	lea	(jt_3B5E).l,a0
	adda.w	(a0,d0.w),a0
	jmp	(a0)
loc_3AFE:
	move.l	a2,($FFFF9BCC).w
	move.b	($FFFFB9F0).w,($FFFF97E8).w
	move.b	($FFFF9BBC).w,($FFFF9BBD).w
	bra.w	loc_569E
loc_3B12:
	jmp	(sub_D77C).l
loc_3B18:
	st	($FFFFBA53).w
	st	($FFFFBA59).w
	rts
loc_3B22:
	bra.w	sub_5C3C
loc_3B26:
	bra.w	loc_60E0
loc_3B2A:
	tst.b	($FFFFCA21).w
	bne.s	loc_3B3A
	lea	(dat_FE000).l,a0
	moveq	#$1,d0
	bra.s	loc_3B42
loc_3B3A:
	lea	($200001).l,a0
	moveq	#$2,d0
loc_3B42:
	move.w	#$1FFF,d1
	moveq	#$0,d2
loc_3B48:
	move.b	d2,(a0)
	adda.w	d0,a0
	dbf	d1,loc_3B48
	moveq	#$2,d2
loc_3B52:
	moveq	#$3,d0
	bsr.w	sub_225C
	dbf	d2,loc_3B52
	rts
jt_3B5E:
	dc.w	loc_3AFE-jt_3B5E
	dc.w	loc_3B22-jt_3B5E
	dc.w	loc_3B26-jt_3B5E
	dc.w	loc_3B18-jt_3B5E
	dc.w	loc_3B12-jt_3B5E
	dc.w	loc_3B2A-jt_3B5E
loc_3B6A:
	bsr.w	sub_404A
	movea.l	a0,a3
	bra.w	loc_53A6
loc_3B74:
	bra.w	sub_75F8
loc_3B78:
	bra.w	loc_4022
loc_3B7C:
	bra.w	loc_4022
loc_3B80:
	bsr.w	sub_8710
	rts
loc_3B86:
	move.b	($FFFF9DA7).w,d0
	bsr.w	sub_10E0
	rts
loc_3B90:
	moveq	#$2E,d0
	jsr	(sub_11C8E).l
	bsr.w	sub_404A
	jsr	(sub_11CA4).l
	moveq	#$2F,d0
	jsr	(sub_11C8E).l
	bsr.w	sub_404A
	jsr	(sub_13328).l
	jsr	(sub_11CA0).l
	move.b	#$40,($FFFFD595).w
	jsr	(sub_14246).l
	jsr	(sub_1344A).l
	rts
loc_3BCE:
	bsr.w	sub_404A
	move.l	d0,d2
	bsr.w	sub_404A
	move.l	d0,d3
	jsr	(sub_1343E).l
	move.w	#$8000,($FFFFD5AC).w
	move.w	#$F000,($FFFFD5A8).w
	move.b	($FFFFD806).w,($FFFFD809).w
	move.w	#$33,d0
	jsr	(sub_1B900).l
	move.w	#$8E,d0
	jsr	(sub_11C8E).l
	tst.b	d2
	beq.s	loc_3C3A
	lea	($FFFFBA68).w,a0
	lea	($FFFFC470).w,a1
	moveq	#$7,d1
loc_3C14:
	move.b	(a1),d0
	beq.s	loc_3C22
	andi.b	#$C0,d0
	bne.s	loc_3C22
	add.l	d3,$1E(a0)
loc_3C22:
	adda.w	#$D6,a0
	adda.w	#$1A,a1
	dbf	d1,loc_3C14
	move.w	#$8F,d0
	jsr	(sub_11C8E).l
	bra.s	loc_3C5C
loc_3C3A:
	move.b	($FFFF9DA7).w,d0
	bsr.w	sub_6F14
	bsr.w	sub_6F02
	move.b	(a0),d0
	beq.s	loc_3C54
	andi.b	#$C0,d0
	bne.s	loc_3C54
	add.l	d3,$1E(a1)
loc_3C54:
	lea	(a1),a0
	jsr	(sub_11CA4).l
loc_3C5C:
	move.w	#$90,d0
	jsr	(sub_11C8E).l
	move.w	#$6,($FFFFD5AA).w
	move.w	d3,d0
	jsr	(sub_13328).l
	jsr	(sub_1368C).l
	move.w	#$186,d0
	jsr	(sub_11BDC).l
	jsr	(sub_11CA0).l
	jsr	(sub_14246).l
	moveq	#$0,d0
	move.b	($FFFFD809).w,d0
	jsr	(sub_1B900).l
	rts
loc_3C9E:
	jsr	(sub_1343E).l
	st	($FFFFB525).w
	bsr.w	sub_4DFA
	move.l	#$FFFFB9F0,($FFFFB9AC).w
	st	($FFFFBA59).w
	rts
loc_3CBA:
	bsr.w	sub_404A
	jmp	(sub_1B900).l
loc_3CC4:
	rts
loc_3CC6:
	bsr.w	sub_404A
	move.l	a0,-(a7)
	move.w	d1,-(a7)
	bsr.w	sub_404A
	asl.w	#$1,d0
	bsr.w	sub_4DAA
	move.w	d0,d2
	move.w	(a7)+,d1
	movea.l	(a7)+,a0
	bra.w	sub_42AE
loc_3CE2:
	bsr.w	sub_404A
	move.b	d0,($FFFF98EC).w
	bsr.w	sub_404A
	move.b	d0,($FFFF98ED).w
	move.l	a2,($FFFFB9A8).w
	rts
loc_3CF8:
	addq.b	#$1,($FFFF98EC).w
	move.b	($FFFF98EC).w,d0
	cmp.b	($FFFF98ED).w,d0
	bhi.s	loc_3D0A
	movea.l	($FFFFB9A8).w,a2
loc_3D0A:
	rts
loc_3D0C:
	bsr.w	sub_404A
	tst.b	d0
	seq	($FFFF97AE).w
	movem.l	d7,-(a7)
	moveq	#$7,d7
loc_3D1C:
	move.l	d7,d0
	bsr.w	sub_6F02
	tst.b	(a0)
	beq.s	loc_3D2E
	bsr.w	sub_6F14
	bsr.w	sub_6D1E
loc_3D2E:
	dbf	d7,loc_3D1C
	movem.l	(a7)+,d7
	rts
loc_3D38:
	bra.w	loc_5B44
loc_3D3C:
	bsr.w	sub_3766
	bsr.w	sub_404A
	ext.w	d0
	lsl.w	#$1,d0
	lea	(dat_3D76).l,a0
	move.w	(a0,d0.w),d0
	adda.w	d0,a0
	moveq	#$0,d1
	move.b	(a0)+,d1
	move.b	d1,($FFFFB9F3).w
	lea	($FFFFB9F4).w,a1
	bra.s	loc_3D64
loc_3D62:
	move.b	(a0)+,(a1)+
loc_3D64:
	dbf	d1,loc_3D62
	st	($FFFFBA60).w
	bsr.w	sub_38BA
	clr.b	($FFFFBA60).w
	rts
dat_3D76:
	binclude	"data/003D76.bin"
loc_3DD8:
	bsr.w	sub_404A
	move.b	d0,($FFFF979C).w
	move.l	d0,d2
	bsr.w	sub_404A
	tst.b	d0
	bmi.s	loc_3E10
	cmp.b	#$4,d2
	bne.s	loc_3E0C
	cmp.b	#$71,d0
	bne.s	loc_3DFE
	move.b	#$A8,($FFFF97DC).w
	bra.s	loc_3E10
loc_3DFE:
	cmp.b	#$72,d0
	bne.s	loc_3E0C
	move.b	#$A2,($FFFF97DC).w
	bra.s	loc_3E10
loc_3E0C:
	move.b	d0,($FFFFB525).w
loc_3E10:
	lea	(dat_3E22).l,a0
	move.b	(a0,d2.w),($FFFFBA5E).w
	bsr.w	sub_AF00
	rts
dat_3E22:
	dc.b	$08,$07,$06,$08,$01,$00
loc_3E28:
	moveq	#$1D,d0
	bra.w	sub_75FA
loc_3E2E:
	bsr.w	sub_91A6
	moveq	#$0,d2
	moveq	#$0,d3
	move.w	#$B8,d4
	move.w	#$A0,d5
	moveq	#$0,d6
	moveq	#$0,d7
	move.w	#$E,($FFFFB434).w
	bsr.w	sub_92FC
	move.l	a0,($FFFFB42E).w
	bsr.w	sub_91C8
	bsr.w	sub_8694
	moveq	#$0,d7
	jsr	(sub_FEA8).l
	jsr	(sub_BEF4).l
	jsr	(sub_C3F0).l
	jsr	(sub_C7A0).l
	addi.w	#$30,d0
	addi.w	#$18,d1
	movem.w	d0-d1,($FFFFB3F0).w
	st	($FFFFB4C8).w
	jsr	(sub_BF0A).l
	bsr.w	sub_5644
	bsr.w	sub_4210
	addq.w	#$1,($FFFFB432).w
	bsr.w	sub_91C8
	clr.l	($FFFFB42E).w
	bsr.w	sub_9240
	rts
loc_3EA4:
	move.b	($FFFF9AFA).w,d0
	addq.b	#$2,d0
	andi.b	#$3,d0
	move.b	d0,($FFFF9AFA).w
loc_3EB2:
	moveq	#$0,d0
	bra.w	sub_53B6
loc_3EB8:
	bsr.w	sub_404A
	move.b	d0,($FFFF9AFB).w
	bra.w	sub_976C
loc_3EC4:
	moveq	#$0,d0
	bsr.w	loc_5BEC
	moveq	#$1,d0
	bra.w	loc_5BEC
loc_3ED0:
	bsr.w	sub_404A
	move.l	d0,d2
	bsr.w	sub_404A
	move.l	d0,d3
	bsr.w	sub_404A
	move.l	d0,d4
	bsr.w	sub_404A
	move.l	d0,d5
	jmp	(sub_C1DE).l

; ---------------------------------------------------------------------------
sub_3EEE:
	moveq	#$10,d5
	bsr.w	sub_6D06
	btst	#$0,d0
	beq.s	loc_3EFE
	addi.b	#$80,d5
loc_3EFE:
	rts
loc_3F00:
	bsr.s	sub_3EEE
	bsr.w	sub_404A
	move.l	d0,d2
	bsr.w	sub_404A
	move.l	d0,d3
	bsr.w	sub_404A
	move.l	d0,d4
	jmp	(sub_C1DE).l
loc_3F1A:
	bsr.w	sub_404A
	move.l	d0,d2
	bsr.w	sub_404A
	move.l	d0,d3
	bsr.w	sub_404A
	move.l	d0,d4
	bsr.w	sub_404A
	move.l	d0,d5
	bsr.w	sub_3F3C
	jmp	(sub_C20E).l

; ---------------------------------------------------------------------------
sub_3F3C:
	move.w	d2,d0
	move.w	d3,d1
	jsr	(sub_C7CE).l
	addi.w	#$30,d0
	addi.w	#$18,d1
	move.w	d0,d2
	move.w	d1,d3
	rts
loc_3F54:
	bsr.w	sub_404A
	move.l	d0,d2
	bsr.w	sub_404A
	move.l	d0,d3
	bsr.w	sub_404A
	move.l	d0,d4
	bsr.s	sub_3EEE
	bsr.s	sub_3F3C
	jmp	(sub_C20E).l
loc_3F70:
	bsr.w	sub_404A
	jmp	(sub_C142).l
loc_3F7A:
	jmp	(sub_C134).l
loc_3F80:
	bsr.w	sub_404A
	bra.w	loc_56C4
loc_3F88:
	tst.b	($FFFFB4C1).w
	bne.s	loc_3F90
	rts
loc_3F90:
	move.b	($FFFF9AFA).w,d0
	addq.b	#$2,d0
	andi.b	#$3,d0
	move.b	d0,($FFFF9AFA).w
	bra.s	loc_3FA4
loc_3FA0:
	st	($FFFFB4C1).w
loc_3FA4:
	bsr.w	sub_5AC2
	moveq	#$1,d0
	moveq	#$1,d1
	bsr.w	sub_5566
	bra.w	sub_5A8A
loc_3FB4:
	bsr.w	sub_404A
	move.b	d0,($FFFF9BC5).w
	bsr.w	sub_404A
	move.l	d0,d2
	move.b	d2,($FFFF9BD5).w
	lea	($FFFF9BD6).w,a3
	bra.s	loc_3FEC
loc_3FCC:
	bsr.w	sub_404A
	subq.w	#$1,d0
	move.w	d0,(a3)+
	bsr.w	sub_404A
	subq.w	#$1,d0
	move.w	d0,(a3)+
	bsr.w	sub_404A
	addq.w	#$1,d0
	move.w	d0,(a3)+
	bsr.w	sub_404A
	addq.w	#$1,d0
	move.w	d0,(a3)+
loc_3FEC:
	dbf	d2,loc_3FCC
	bra.w	loc_574E
loc_3FF4:
	bra.w	sub_59B8

; ---------------------------------------------------------------------------
sub_3FF8:
	movem.l	d2,-(a7)
	bsr.w	sub_438C
	moveq	#$0,d0
	move.b	d7,d0
	lea	(dat_482E).l,a0
	move.b	(a0,d0.w),d2
	ext.w	d2
	subq.l	#$1,d2
	bmi.s	loc_401C
loc_4014:
	bsr.w	sub_404A
	dbf	d2,loc_4014
loc_401C:
	movem.l	(a7)+,d2
	rts
loc_4022:
	bsr.w	sub_438C
	lea	(dat_4032).l,a0
	jsr	(sub_132A6).l
dat_4032:
	binclude	"data/004032.bin"

; ---------------------------------------------------------------------------
sub_404A:
	move.b	(a2)+,d0
	move.b	d0,d1
	clr.l	($FFFFD5F8).w
	move.b	(a2)+,($FFFFD5FB).w
	tst.b	d1
	beq.s	loc_406C
	move.b	(a2)+,($FFFFD5FA).w
	cmp.b	#$4,d1
	bne.s	loc_406C
	move.b	(a2)+,($FFFFD5F9).w
	move.b	(a2)+,($FFFFD5F8).w
loc_406C:
	tst.b	d1
	bmi.s	loc_40AA
	btst	#$0,d1
	beq.s	loc_40A4
	moveq	#-$1,d0
	move.w	($FFFFD5FA).w,d0
	movea.l	d0,a0
	bsr.w	sub_42E0
	movea.l	a0,a1
	clr.l	($FFFFD5F8).w
	move.b	(a1)+,($FFFFD5FB).w
	cmp.b	#$1,d1
	beq.s	loc_40A4
	move.b	(a1)+,($FFFFD5FA).w
	cmp.b	#$3,d1
	beq.s	loc_40A4
	move.b	(a1)+,($FFFFD5F9).w
	move.b	(a1)+,($FFFFD5F8).w
loc_40A4:
	move.l	($FFFFD5F8).w,d0
	bra.s	loc_40CE
loc_40AA:
	cmp.b	#$80,d1
	bne.s	loc_40BC
	move.l	($FFFFD5F8).w,d0
	if DEUTSCH	; DEUTSCH-HOOK 2: Text-Operand ueber Zeigertabelle (8 Byte wie Original)
	jmp	(DE_TextZeiger).l
	dc.w	$4E71
	else
	add.l	($FFFFB9A4).w,d0
	movea.l	d0,a0
	rts
	endif
loc_40BC:
	move.w	#$FFFF,($FFFFD5F8).w
	move.l	($FFFFD5F8).w,d0
	movea.l	d0,a0
	bsr.w	sub_42E0
	move.l	a0,d0
loc_40CE:
	rts

; ---------------------------------------------------------------------------
sub_40D0:
	move.l	d2,-(a7)
	moveq	#$0,d2
	lea	(dat_38CE6).l,a0
loc_40DA:
	move.b	(a0)+,d1
	bpl.s	loc_40F8
	lea	(dat_40EA).l,a0
	jsr	(sub_132A6).l
dat_40EA:
	binclude	"data/0040EA.bin"
loc_40F8:
	cmp.b	d1,d0
	beq.s	loc_4100
	addq.l	#$4,d2
	bra.s	loc_40DA
loc_4100:
	movea.l	(dat_38CE2).l,a0
	adda.l	(a0,d2.w),a0
	bsr.w	sub_9E76
	move.l	#$FFFF6AF6,d0
	move.w	#$2C00,d1
	bsr.w	sub_9ED8
	if DEUTSCH	; DEUTSCH-HOOK 1: Textablage A - Text bleibt in der ROM (32 Byte wie Original)
	lea	(DE_Modultabelle).l,a0
	move.l	(a0,d2.w),($FFFFB9A4).w	; Basis = Zeigertabelle des Moduls
	bra.s	de_hook1_ende
	dc.w	$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71
de_hook1_ende:
	else
	move.l	d0,($FFFFB9A4).w
	movea.l	(dat_42B0A).l,a0
	adda.l	(a0,d2.w),a0
	bsr.w	sub_9E76
	move.l	($FFFFB9A4).w,d0
	move.l	#$2C00,d1
	bsr.w	sub_9ED8
	endif
	move.l	(a7)+,d2
	rts
loc_4140:
	tst.b	($FFFF97E8).w
	bne.s	loc_4168
	tst.b	($FFFFBA5A).w
	beq.s	loc_4154
	move.b	#$3,($FFFFB9F0).w
	bra.s	loc_416E
loc_4154:
	tst.b	($FFFFCA21).w
	if DEUTSCH_TEST	; DEUTSCH-HOOK 10 (nur Testfassung): neues Abenteuer startet im Entwickler-Jumper (ECL 0)
	nop
	else
	bne.s	loc_4160
	endif
	clr.b	($FFFFB9F0).w
	bra.s	loc_416E
loc_4160:
	move.b	#$10,($FFFFB9F0).w
	bra.s	loc_416E
loc_4168:
	move.b	($FFFF97E8).w,($FFFFB9F0).w
loc_416E:
	moveq	#$0,d0
	move.b	($FFFFB9F0).w,d0
	bsr.w	sub_40D0
	bsr.w	sub_4284
	tst.b	($FFFF9D9E).w
	beq.s	loc_418C
	move.b	($FFFF9BBD).w,($FFFFBA5E).w
	bsr.w	sub_AF00
loc_418C:
	clr.b	($FFFFBA55).w
	clr.b	($FFFF9D9E).w
loc_4194:
	bsr.w	loc_424E
loc_4198:
	tst.b	($FFFFBA53).w
	bne.s	loc_41FA
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$0,d0
	bne.s	loc_41B2
	move.b	($FFFF9BBD).w,($FFFFBA5E).w
	bsr.w	sub_AF00
loc_41B2:
	clr.b	($FFFF9DBF).w
	bsr.w	sub_4A58
	tst.b	($FFFFB9F1).w
	bne.s	loc_4140
	movea.l	#$FFFF0000,a2
	adda.w	($FFFFB59A).w,a2
	bsr.w	sub_3300
	tst.b	($FFFFBA53).w
	bne.s	loc_41FA
	tst.b	($FFFFB9F1).w
	bne.s	loc_4194
	bsr.w	sub_4D74
	movea.l	#$FFFF0000,a2
	adda.w	($FFFFB59C).w,a2
	bsr.w	sub_3300
	tst.b	($FFFFBA53).w
	bne.s	loc_41FA
	tst.b	($FFFFB9F1).w
	bne.s	loc_4194
	bra.s	loc_4198
loc_41FA:
	clr.b	($FFFFBA53).w
	lea	($FFFFC470).w,a0
	moveq	#$7,d0
loc_4204:
	clr.l	(a0)
	adda.w	#$1A,a0
	dbf	d0,loc_4204
	rts

; ---------------------------------------------------------------------------
sub_4210:
	moveq	#$0,d0
	move.b	($FFFF9AF6).w,d0
	asl.w	#$4,d0
	add.b	($FFFF9AF7).w,d0
	lea	($FFFFB7A4).w,a0
	move.b	(a0,d0.w),($FFFF9AF9).w
	rts

; ---------------------------------------------------------------------------
sub_4228:
	movem.l	d3-d5,-(a7)
	moveq	#$0,d3
	move.b	($FFFF9AF7).w,d3
	moveq	#$0,d4
	move.b	($FFFF9AF6).w,d4
	move.b	($FFFF9AFA).w,d5
	asl.b	#$1,d5
	jsr	(sub_14CCE).l
	move.b	d0,($FFFF9AF8).w
	movem.l	(a7)+,d3-d5
	rts
loc_424E:
	clr.b	($FFFFB9F1).w
	clr.b	($FFFF9DCB).w
	bsr.s	sub_4210
	bsr.s	sub_4228
	move.l	($FFFF9BCC).w,d0
	beq.s	loc_4268
	movea.l	d0,a2
	clr.l	($FFFF9BCC).w
	bra.s	loc_4272
loc_4268:
	movea.l	#$FFFF0000,a2
	adda.w	($FFFFB5A2).w,a2
loc_4272:
	bsr.w	sub_3300
	tst.b	($FFFFB9F1).w
	bne.s	loc_424E
	move.b	($FFFFB9F0).w,($FFFF97E8).w
	rts

; ---------------------------------------------------------------------------
sub_4284:
	lea	($FFFF6AF6).l,a2
	clr.b	($FFFFBA59).w
	clr.w	($FFFF9DC8).w
	clr.b	($FFFF97DB).w
	lea	($FFFFB59A).w,a3
	moveq	#$4,d2
loc_429C:
	addq.l	#$1,a2
	bsr.w	sub_404A
	move.w	a0,(a3)+
	dbf	d2,loc_429C
	rts
loc_42AA:
	bsr.w	sub_404A

; ---------------------------------------------------------------------------
sub_42AE:
	move.l	d2,($FFFFD5F8).w
	bsr.w	sub_42E0
	tst.b	d1
	bmi.s	loc_42D8
	move.b	($FFFFD5FB).w,(a0)+
	cmp.b	#$3,d1
	bcs.s	loc_42D6
	move.b	($FFFFD5FA).w,(a0)+
	cmp.b	#$5,d1
	bne.s	loc_42D6
	move.b	($FFFFD5F9).w,(a0)+
	move.b	($FFFFD5F8).w,(a0)
loc_42D6:
	rts
loc_42D8:
	movea.l	d2,a1
loc_42DA:
	move.b	(a1)+,(a0)+
	bne.s	loc_42DA
	rts

; ---------------------------------------------------------------------------
sub_42E0:
	cmpa.l	#$FFFF9AFC,a0
	bcs.s	loc_4302
	cmpa.l	#$FFFF9B50,a0
	bcc.s	loc_4302
	adda.w	#$1F6C,a0
	moveq	#$0,d0
	move.b	($FFFF9DA7).w,d0
	mulu.w	#$D6,d0
	adda.w	d0,a0
loc_4300:
	rts
loc_4302:
	cmpa.l	#$FFFF9BF6,a0
	bcs.s	loc_4300
	cmpa.l	#$FFFF9C10,a0
	bcc.s	loc_4300
	adda.w	#$287A,a0
	moveq	#$0,d0
	move.b	($FFFF9DA7).w,d0
	mulu.w	#$1A,d0
	adda.w	d0,a0
	rts
loc_4324:
	movem.l	d6/a3,-(a7)
	move.l	($FFFFD5D6).w,-(a7)
	bsr.w	sub_404A
	movem.l	d1/a0,-(a7)
	lea	($FFFFD5AE).w,a3
	clr.b	(a3)
	bsr.w	sub_404A
	move.l	d0,d6
	subq.l	#$1,d6
	bmi.s	loc_435A
loc_4344:
	bsr.w	sub_404A
loc_4348:
	move.b	(a0)+,(a3)+
	bne.s	loc_4348
	move.b	#$7E,-$1(a3)
	dbf	d6,loc_4344
	clr.b	-$1(a3)
loc_435A:
	moveq	#-$1,d0
	move.b	#$1,($FFFFD592).w
	move.b	#$40,($FFFFD595).w
	clr.b	($FFFFD593).w
	jsr	(sub_136DA).l
	move.l	d0,d2
	movem.l	(a7)+,d1/a0
	bsr.w	sub_42AE
	jsr	(sub_1344A).l
	move.l	(a7)+,($FFFFD5D6).w
	movem.l	(a7)+,d6/a3
	rts

; ---------------------------------------------------------------------------
sub_438C:
	move.l	($FFFFD5DA).w,-(a7)
	move.l	($FFFFD5DE).w,-(a7)
	move.l	#$2001B,($FFFFD5DA).w
	move.l	#$26001C,($FFFFD5DE).w
	move.l	($FFFFD5DA).w,($FFFFD5D6).w
	move.w	#$E000,($FFFFD5AC).w
	move.w	#$F000,($FFFFD5A8).w
	jsr	(sub_1343E).l
	move.l	a2,d0
	subq.l	#$1,d0
	jsr	(sub_133B4).l
	jsr	(sub_11CA0).l
	addq.w	#$1,($FFFFD5D6).w
	move.b	(a2),d0
	jsr	(sub_133AA).l
	jsr	(sub_11CA0).l
	addq.w	#$1,($FFFFD5D6).w
	move.b	$1(a2),d0
	jsr	(sub_133AA).l
	jsr	(sub_11CA0).l
	addq.w	#$1,($FFFFD5D6).w
	move.b	$2(a2),d0
	jsr	(sub_133AA).l
	jsr	(sub_11CA0).l
	addq.w	#$1,($FFFFD5D6).w
	move.b	$3(a2),d0
	jsr	(sub_133AA).l
	jsr	(sub_11CA0).l
	addq.w	#$1,($FFFFD5D6).w
	move.b	$4(a2),d0
	jsr	(sub_133AA).l
	jsr	(sub_11CA0).l
	addq.w	#$1,($FFFFD5D6).w
	move.b	$5(a2),d0
	jsr	(sub_133AA).l
	jsr	(sub_11CA0).l
	addq.w	#$1,($FFFFD5D6).w
	move.l	d7,d1
	asl.w	#$1,d1
	lea	(dat_446E).l,a0
	adda.w	(a0,d1.w),a0
	jsr	(sub_11CA4).l
loc_445A:
	bsr.w	sub_6C64
	btst	#$5,d0
	beq.s	loc_445A
	move.l	(a7)+,($FFFFD5DE).w
	move.l	(a7)+,($FFFFD5DA).w
	rts
dat_446E:
	binclude	"data/00446E.bin"
dat_482E:
	binclude	"data/00482E.bin"
loc_488C:
	bsr.w	sub_404A
	move.l	d0,d2
	bsr.w	sub_404A
	lsr.w	#$1,d0
	bset	#$7,d0
	move.w	d0,d5
	moveq	#$1,d3
	moveq	#$0,d6
	lea	($FFFFC470).w,a0
loc_48A6:
	tst.b	(a0)
	beq.s	loc_48B8
	adda.w	#$1A,a0
	addq.w	#$1,d6
	cmp.w	#$8,d6
	bne.s	loc_48A6
	bra.s	loc_48D8
loc_48B8:
	lea	(dat_48DA).l,a0
loc_48BE:
	cmp.b	(a0)+,d2
	beq.s	loc_48C6
	addq.l	#$1,a0
	bra.s	loc_48BE
loc_48C6:
	moveq	#$0,d4
	move.b	(a0),d4
	bsr.w	sub_48E8
	move.b	d6,d0
	bsr.w	sub_6F14
	move.b	d5,$30(a1)
loc_48D8:
	rts
dat_48DA:
	binclude	"data/0048DA.bin"

; ---------------------------------------------------------------------------
sub_48E8:
	link	a6,#-$42
	movem.l	d2-d7/a2-a3,-(a7)
	lea	(dat_9E77C).l,a0
	bsr.w	sub_9E76
	move.l	a6,d0
	subq.l	#$2,d0
	moveq	#$2,d1
	bsr.w	sub_9ED8
	move.l	a6,d0
	subi.l	#$40,d0
	move.w	-$2(a6),d1
	addq.l	#$1,d1
	bclr	#$0,d1
	bsr.w	sub_9ED8
	lea	-$40(a6),a0
	move.w	-$2(a6),d1
	subq.l	#$1,d1
	moveq	#$0,d5
loc_4926:
	move.b	(a0)+,d0
	cmp.b	d2,d0
	beq.s	loc_4954
	addq.l	#$1,d5
	dbf	d1,loc_4926
	lea	(dat_493E).l,a0
	jsr	(sub_132A6).l
dat_493E:
	binclude	"data/00493E.bin"
loc_4954:
	move.w	d6,-$42(a6)
	mulu.w	#$D6,d6
	addi.l	#$FFFFBA68,d6
	movea.l	d6,a3
loc_4964:
	move.l	d6,d0
	move.l	#$D6,d1
	bsr.w	sub_9ED8
	dbf	d5,loc_4964
	if DEUTSCH	; DEUTSCH-HOOK 12: Monstername aus DE_Monstertabelle (6 Byte wie Original)
	jsr	(DE_Monstername).l
	else
	move.b	d3,$3F(a3)
	moveq	#$0,d0
	endif
	move.b	$24(a3),d0
	asl.b	#$1,d0
	divu.w	#$3,d0
	move.b	d0,$24(a3)
	lea	$54(a3),a0
	lea	(dat_A829).l,a1
	moveq	#$C,d7
loc_4994:
	moveq	#$0,d1
	move.b	(a0),d1
	beq.s	loc_49A2
	move.b	(a1,d1.w),d1
	bmi.s	loc_49A2
	move.b	d1,(a0)
loc_49A2:
	move.b	$8(a0),d1
	cmp.b	#$A,d1
	bls.s	loc_49B0
	clr.b	$8(a0)
loc_49B0:
	moveq	#$0,d0
	move.b	(a0),d0
	beq.s	loc_49EE
	mulu.w	#$8,d0
	lea	(dat_779E).l,a2
	adda.w	d0,a2
	move.b	(a2),d0
	beq.s	loc_49D2
	cmp.b	#$1,d0
	bhi.s	loc_49EE
	lea	$C2(a3),a2
	bra.s	loc_49D6
loc_49D2:
	lea	$AE(a3),a2
loc_49D6:
	tst.b	(a2)
	bne.s	loc_49EE
	moveq	#$9,d0
loc_49DC:
	move.b	(a2,d0.w),d1
	move.b	(a0,d0.w),(a2,d0.w)
	move.b	d1,(a0,d0.w)
	dbf	d0,loc_49DC
loc_49EE:
	adda.w	#$A,a0
	dbf	d7,loc_4994
	lea	($FFFFC470).w,a0
	move.w	-$42(a6),d0
	cmp.w	#$8,d0
	bcs.s	loc_4A16
	move.w	($FFFFBA64).w,d0
	moveq	#$38,d1
	sub.w	d0,d1
	cmp.w	d1,d3
	bls.s	loc_4A12
	move.w	d1,d3
loc_4A12:
	add.w	d3,($FFFFBA64).w
loc_4A16:
	mulu.w	#$1A,d0
	adda.w	d0,a0
	move.b	d4,$42(a3)
	subq.l	#$1,d3
	bmi.s	loc_4A50
loc_4A24:
	move.b	#$1,(a0)
	move.b	$52(a3),$1(a0)
	bset	#$6,$1(a0)
	move.b	-$41(a6),$2(a0)
	move.b	$2E(a3),$E(a0)
	movea.l	a3,a1
	bsr.w	sub_6D1E
	adda.l	#$1A,a0
	dbf	d3,loc_4A24
loc_4A50:
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_4A58:
	movem.l	d2/d7,-(a7)
loc_4A5C:
	jsr	(sub_DEE6).l
	jsr	(sub_6BFE).l
	btst	#$6,d0
	beq.s	loc_4A82
	clr.b	($FFFFD81C).w
	bsr.w	sub_6C54
	moveq	#$6D,d0
	st	($FFFFD596).w
	bsr.w	sub_5308
	bra.s	loc_4A5C
loc_4A82:
	btst	#$7,d0
	beq.s	loc_4A9E
	clr.b	($FFFFD81C).w
	bsr.w	sub_6C54
	bsr.w	sub_4BF0
	tst.b	($FFFFBA55).w
	beq.s	loc_4A5C
	bra.w	loc_4B1A
loc_4A9E:
	tst.b	($FFFFBA5D).w
	beq.s	loc_4AF2
	move.b	($FFFFD81C).w,d2
	and.b	d0,d2
	beq.s	loc_4AAE
	move.b	d1,d0
loc_4AAE:
	move.b	d0,($FFFFD81C).w
	asr.b	#$1,d1
	cmp.b	#$4,d1
	beq.s	loc_4A5C
	move.b	d1,($FFFF9AFA).w
	lea	(dat_146E0).l,a0
	ext.w	d1
	asl.w	#$1,d1
	move.b	(a0,d1.w),d0
	add.b	($FFFF9AF7).w,d0
	cmp.b	#$10,d0
	bcc.s	loc_4AE4
	move.b	$B(a0,d1.w),d0
	add.b	($FFFF9AF6).w,d0
	cmp.b	#$10,d0
	bcs.s	loc_4AEC
loc_4AE4:
	move.b	#$1,($FFFF9DCB).w
	bra.s	loc_4B1A
loc_4AEC:
	clr.b	($FFFF9DCB).w
	bra.s	loc_4B1A
loc_4AF2:
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$6,d0
	bne.s	loc_4B10
	move.b	d1,($FFFF9AFA).w
	bsr.w	sub_B912
	bsr.w	sub_C3F8
	tst.b	d7
	bne.w	loc_4A5C
	bra.s	loc_4B1A
loc_4B10:
	bsr.w	sub_4B20
	tst.b	d7
	bne.w	loc_4A5C
loc_4B1A:
	movem.l	(a7)+,d2/d7
	rts

; ---------------------------------------------------------------------------
sub_4B20:
	movem.l	d2-d6/a2-a3,-(a7)
	moveq	#$0,d7
	move.b	d1,d7
	cmp.b	#$8,d7
	beq.w	loc_4BE0
	asr.b	#$1,d1
	move.b	d1,($FFFF9AFA).w
	lea	(dat_146E0).l,a0
	move.b	(a0,d7.w),d3
	move.b	$B(a0,d7.w),d4
	move.b	d3,d0
	move.b	d4,d1
	add.b	($FFFF97B9).w,d0
	add.b	($FFFF97BA).w,d1
	cmp.b	#$3E,d0
	bcc.w	loc_4BE0
	cmp.b	#$3E,d1
	bcc.w	loc_4BE0
	ext.w	d3
	ext.w	d4
	moveq	#$1,d0
	moveq	#$3,d1
	bsr.w	sub_81AC
	lea	($FFFFB0B4).w,a2
	lea	($FFFFB018).w,a3
	cmp.b	#$5,d7
	bcc.s	loc_4B82
	move.l	#$4BE8,d1
	bra.s	loc_4B88
loc_4B82:
	move.l	#$4BEC,d1
loc_4B88:
	move.l	d1,$4(a3)
	move.w	d3,$4(a2)
	move.w	d4,$6(a2)
	clr.b	$9(a2)
	bsr.w	sub_BF7E
	moveq	#$7,d5
loc_4B9E:
	bsr.w	sub_C3F8
	move.b	#$5,($FFFF9BB7).w
	jsr	(sub_DEC4).l
	moveq	#$0,d7
	add.w	d3,($FFFFB3EC).w
	add.w	d4,($FFFFB3EE).w
	jsr	(sub_FF7C).l
	dbf	d5,loc_4B9E
	clr.l	$4(a2)
	clr.l	$4(a3)
	clr.b	$D(a2)
	add.b	d3,($FFFF97B9).w
	add.b	d4,($FFFF97BA).w
	jsr	(sub_CCB6).l
	moveq	#$0,d7
	bra.s	loc_4BE2
loc_4BE0:
	moveq	#$1,d7
loc_4BE2:
	movem.l	(a7)+,d2-d6/a2-a3
	rts
	dc.b	$00,$01,$FD,$00,$80,$01,$FD,$00

; ---------------------------------------------------------------------------
sub_4BF0:
	lea	(dat_4CA8).l,a0
	bsr.w	sub_A768
	jsr	(sub_1343E).l
	move.l	($FFFFD582).w,-(a7)
	move.l	($FFFFD586).w,-(a7)
	moveq	#$2,d0
	tst.b	($FFFFCA21).w
	beq.s	loc_4C12
	moveq	#$4,d0
loc_4C12:
	clr.b	($FFFFD593).w
	jsr	(sub_13C9C).l
	move.l	(a7)+,($FFFFD586).w
	move.l	(a7)+,($FFFFD582).w
	move.b	d0,($FFFFD593).w
	bmi.s	loc_4C82
	asl.w	#$1,d0
	lea	(jt_4C9C).l,a0
	adda.w	(a0,d0.w),a0
	jmp	(a0)
loc_4C38:
	bsr.w	sub_4C8E
	bsr.w	sub_1930
	bra.s	loc_4C82
loc_4C42:
	bsr.w	sub_4C8E
	bsr.w	sub_19FC
	tst.b	($FFFFBA55).w
	beq.s	loc_4C54
	bra.w	loc_569E
loc_4C54:
	jsr	(sub_AF00).l
	bra.s	loc_4C82
loc_4C5C:
	bsr.w	sub_4CB0
	bra.s	loc_4C82
loc_4C62:
	bchg	#$0,($FFFFB4C3).w
	moveq	#$0,d0
	move.b	($FFFFD806).w,d0
	move.b	#$0,($FFFFD806).w
	jsr	(sub_1B900).l
	bra.s	loc_4C82
loc_4C7C:
	bchg	#$0,($FFFF9BB9).w
loc_4C82:
	jsr	(sub_1343E).l
	jsr	(sub_1344A).l

; ---------------------------------------------------------------------------
sub_4C8E:
	lea	($FFFFB532).w,a0
	bsr.w	sub_9784
	clr.l	($FFFFD57E).w
	rts
jt_4C9C:
	dc.w	loc_4C82-jt_4C9C
	dc.w	loc_4C38-jt_4C9C
	dc.w	loc_4C42-jt_4C9C
	dc.w	loc_4C5C-jt_4C9C
	dc.w	loc_4C62-jt_4C9C
	dc.w	loc_4C7C-jt_4C9C
dat_4CA8:
	dc.b	$00,$02,$03,$04,$26,$43,$FF,$00

; ---------------------------------------------------------------------------
sub_4CB0:
	movem.l	d3-d5/d7/a2,-(a7)
	jsr	(sub_1344A).l
	move.b	($FFFF97F2).w,d7
	ext.w	d7
loc_4CC0:
	jsr	(sub_1343E).l
	addq.w	#$1,($FFFFD5D8).w
	move.w	#$D,($FFFFD5D6).w
	clr.b	($FFFFD5AE).w
	moveq	#$0,d0
	lea	(dat_4D6A).l,a2
	move.b	(a2,d7.w),d0
	beq.s	loc_4CE8
	jsr	(sub_11BDC).l
loc_4CE8:
	moveq	#$0,d0
	move.b	$5(a2,d7.w),d0
	beq.s	loc_4CF6
	jsr	(sub_11BE0).l
loc_4CF6:
	jsr	(sub_11CA0).l
	lea	(sub_4D62).l,a0
	jsr	(sub_1344E).l
	moveq	#$D,d0
	moveq	#$18,d1
	moveq	#$C,d3
	sub.w	d7,d3
	sub.w	d7,d3
	sub.w	d7,d3
	asl.w	#$3,d3
	move.w	d3,d4
	moveq	#$8,d5
	bsr.w	sub_AAA4
loc_4D1E:
	bsr.w	sub_6C64
	btst	#$7,d0
	bne.s	loc_4D5C
	btst	#$2,d0
	beq.s	loc_4D3A
	addq.w	#$1,d7
	cmp.w	#$4,d7
	ble.s	loc_4D50
	moveq	#$4,d7
	bra.s	loc_4D1E
loc_4D3A:
	btst	#$3,d0
	beq.s	loc_4D48
	subq.w	#$1,d7
	bpl.s	loc_4D50
	moveq	#$0,d7
	bra.s	loc_4D1E
loc_4D48:
	btst	#$5,d0
	bne.s	loc_4D58
	bra.s	loc_4D1E
loc_4D50:
	bsr.w	sub_6C3A
	bra.w	loc_4CC0
loc_4D58:
	move.b	d7,($FFFF97F2).w
loc_4D5C:
	movem.l	(a7)+,d3-d5/d7/a2
	rts

; ---------------------------------------------------------------------------
sub_4D62:
	ori.b	#$19,d6
	ori.b	#$19,(a0)
dat_4D6A:
	sub.l	(a4)+,d6
	sub.l	d5,(a2)+
	sub.l	(a5)+,d5
	ori.b	#$9D,d0

; ---------------------------------------------------------------------------
sub_4D74:
	tst.b	($FFFF9DBF).w
	bne.s	loc_4D86
	tst.b	($FFFFBA5D).w
	beq.s	loc_4D86
	moveq	#-$1,d0
	bsr.w	sub_53B6
loc_4D86:
	clr.b	($FFFF9DBF).w
	rts

; ---------------------------------------------------------------------------
sub_4D8C:
	movem.l	d3-d5,-(a7)
	move.b	($FFFF9AF7).w,d3
	move.b	($FFFF9AF6).w,d4
	move.b	($FFFF9AFA).w,d5
	asl.w	#$1,d5
	jsr	(sub_14C9A).l
	movem.l	(a7)+,d3-d5
	rts

; ---------------------------------------------------------------------------
sub_4DAA:
	movem.l	d3-d5/d7/a2,-(a7)
	moveq	#$0,d5
	move.b	d0,d5
	move.b	($FFFF9AF7).w,d3
	move.b	($FFFF9AF6).w,d4
	lea	(dat_146E0).l,a2
	moveq	#$0,d7
	move.b	($FFFF97DC).w,d0
	cmp.b	#$A2,d0
	beq.s	loc_4DD2
	cmp.b	#$A8,d0
	bne.s	loc_4DD6
loc_4DD2:
	moveq	#$2,d7
	bra.s	loc_4DF2
loc_4DD6:
	cmp.w	#$2,d7
	bge.s	loc_4DF2
	jsr	(sub_14CCE).l
	tst.w	d0
	bne.s	loc_4DF2
	addq.l	#$1,d7
	add.b	(a2,d5.w),d3
	add.b	$B(a2,d5.w),d4
	bra.s	loc_4DD6
loc_4DF2:
	move.l	d7,d0
	movem.l	(a7)+,d3-d5/d7/a2
	rts

; ---------------------------------------------------------------------------
sub_4DFA:
	move.b	($FFFFB525).w,d0
	bpl.s	loc_4E04

; ---------------------------------------------------------------------------
sub_4E00:
	bsr.w	sub_82EC
loc_4E04:
	movem.l	d2-d7,-(a7)
	cmp.b	($FFFFB524).w,d0
	beq.s	loc_4E4C
	clr.w	($FFFFB432).w
	clr.b	($FFFFB4C9).w
	movem.w	($FFFFB566).w,d2-d3
	asl.w	#$3,d2
	asl.w	#$3,d3
	moveq	#$57,d4
	moveq	#$57,d5
	add.w	d2,d4
	add.w	d3,d5
	moveq	#$0,d6
	moveq	#$0,d7
	bsr.w	sub_92FC
	move.l	a0,($FFFFB42E).w
	bsr.w	sub_91C8
	bsr.w	sub_8360
	addq.w	#$1,($FFFFB432).w
	bsr.w	sub_91C8
	clr.l	($FFFFB42E).w
	bsr.w	sub_9240
loc_4E4C:
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_4E52:
	link	a6,#-$A
	movem.l	d2/d4-d7/a3,-(a7)
	bsr.w	sub_404A
	move.l	d0,d7
	bsr.w	sub_404A
	move.l	d0,d6
	move.l	a0,-$6(a6)
	bsr.w	sub_404A
	move.l	d0,d5
	move.l	a0,-$A(a6)
	movea.w	#$0,a0
	move.w	d6,d2
	bne.s	loc_4E86
	move.b	($FFFF9DA7).w,d0
	bsr.w	sub_6F14
	movea.l	a1,a0
loc_4E86:
	move.w	d7,d0
	move.w	d5,d1
	bsr.w	sub_4F20
	move.b	d0,-$2(a6)
	movea.l	a0,a3
	tst.w	d4
	beq.s	loc_4F04
	move.w	#$8000,($FFFFD5AC).w
	move.w	#$F000,($FFFFD5A8).w
	jsr	(sub_1343E).l
	move.b	-$2(a6),d0
	cmp.b	#$1,d0
	bls.s	loc_4EC6
	lea	(a3),a0
	jsr	(sub_11CA4).l
	moveq	#$6E,d0
	jsr	(sub_11C8E).l
	bra.s	loc_4EE4
loc_4EC6:
	tst.b	d6
	beq.s	loc_4ED4
	moveq	#$6F,d0
	jsr	(sub_11C8E).l
	bra.s	loc_4EDC
loc_4ED4:
	lea	(a3),a0
	jsr	(sub_11CA4).l
loc_4EDC:
	moveq	#$70,d0
	jsr	(sub_11C8E).l
loc_4EE4:
	moveq	#$54,d0
	add.w	d7,d0
	jsr	(sub_11C8E).l
	move.l	($FFFFD5DA).w,($FFFFD5D6).w
	bsr.w	sub_75F8
	bsr.w	sub_75F8
	bsr.w	sub_75F8
	bsr.w	sub_75F8
loc_4F04:
	movea.l	-$A(a6),a0
	move.b	-$2(a6),(a0)
	movea.l	a3,a0
	bsr.w	sub_6D0A
	movea.l	-$6(a6),a0
	move.b	d0,(a0)
	movem.l	(a7)+,d2/d4-d7/a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_4F20:
	movem.l	d3-d7/a2-a3,-(a7)
	moveq	#$0,d7
	move.l	d1,d3
	move.l	d0,d5
	tst.b	d2
	beq.s	loc_4F4A
	lea	($FFFFBA68).w,a2
	lea	($FFFFC470).w,a0
	moveq	#$7,d6
loc_4F38:
	bsr.w	sub_4F74
	adda.w	#$D6,a2
	adda.w	#$1A,a0
	dbf	d6,loc_4F38
	bra.s	loc_4F6A
loc_4F4A:
	move.l	a0,d0
	bne.s	loc_4F5A
	move.b	($FFFF9DA7).w,d0
	bsr.w	sub_6F14
	movea.l	a1,a2
	bra.s	loc_4F62
loc_4F5A:
	movea.l	a0,a2
	movea.l	a0,a3
	bsr.w	sub_6D0A
loc_4F62:
	bsr.w	sub_6F02
	bsr.w	sub_4F74
loc_4F6A:
	move.l	d7,d0
	movea.l	a3,a0
	movem.l	(a7)+,d3-d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_4F74:
	move.l	d5,d0
	bsr.w	sub_4FB0
	beq.s	loc_4FAE
	move.l	d0,d4
	asl.w	#$2,d4
	asr.w	d3,d4
	bsr.w	sub_6D06
	move.w	d4,d1
	sub.w	d0,d1
	bmi.s	loc_4F9A
	asr.w	#$1,d4
	cmp.w	d4,d1
	bge.s	loc_4F96
	moveq	#$2,d0
	bra.s	loc_4FA6
loc_4F96:
	moveq	#$3,d0
	bra.s	loc_4FA6
loc_4F9A:
	neg.w	d1
	cmp.w	d4,d1
	ble.s	loc_4FA4
	moveq	#$0,d0
	bra.s	loc_4FA6
loc_4FA4:
	moveq	#$1,d0
loc_4FA6:
	cmp.w	d7,d0
	blt.s	loc_4FAE
	move.l	d0,d7
	movea.l	a2,a3
loc_4FAE:
	rts

; ---------------------------------------------------------------------------
sub_4FB0:
	movem.l	d1/d4,-(a7)
	moveq	#$0,d4
	move.l	d0,d1
	move.b	(a0),d0
	bmi.s	loc_4FF2
	beq.s	loc_4FF2
	andi.b	#$C0,d0
	bne.s	loc_4FF2
	moveq	#$0,d4
	move.b	$31(a2,d1.w),d4
	beq.s	loc_4FF2
	move.b	$19(a2),d0
	asl.b	#$1,d0
	cmp.b	d0,d4
	bls.s	loc_4FE0
	sub.b	d0,d4
	asl.b	#$3,d0
	asl.b	#$1,d4
	add.b	d0,d4
	bra.s	loc_4FE2
loc_4FE0:
	asl.w	#$3,d4
loc_4FE2:
	moveq	#$0,d0
	lea	(dat_4FFC).l,a0
	move.b	(a0,d1.w),d0
	add.b	$10(a2,d0.w),d4
loc_4FF2:
	move.l	d4,d0
	movem.l	(a7)+,d1/d4
	tst.b	d0
	rts
dat_4FFC:
	binclude	"data/004FFC.bin"
loc_500A:
	link	a6,#-$16
	bsr.w	sub_404A
	move.b	d0,-$3(a6)
	bsr.w	sub_404A
	move.b	d0,-$4(a6)
	bsr.w	sub_404A
	move.b	d0,-$5(a6)
	bsr.w	sub_404A
	move.b	d0,-$9(a6)
	bsr.w	sub_404A
	move.b	d0,-$8(a6)
	movem.l	d6-d7/a2-a3,-(a7)
	moveq	#$0,d6
	clr.b	-$C(a6)
	clr.b	-$D(a6)
	btst	#$4,-$3(a6)
	sne	-$E(a6)
	btst	#$6,-$3(a6)
	beq.s	loc_505A
	st	-$D(a6)
loc_505A:
	btst	#$7,-$3(a6)
	beq.w	loc_5164
	move.b	-$3(a6),d0
	andi.b	#$1F,d0
	move.b	d0,-$7(a6)
	move.b	-$8(a6),d0
	andi.b	#$7,d0
	move.b	d0,-$B(a6)
	bsr.w	sub_51B8
	tst.b	-$D(a6)
	beq.s	loc_50F0
	lea	($FFFFBA68).w,a2
	lea	($FFFFC470).w,a3
	moveq	#$0,d7
loc_5090:
	move.b	(a3),d0
	beq.s	loc_50DC
	andi.b	#$C0,d0
	bne.s	loc_50DC
	btst	#$5,-$3(a6)
	beq.s	loc_50B0
	move.w	d7,d0
	move.w	-$2(a6),d1
	bsr.w	sub_5216
	moveq	#$1,d6
	bra.s	loc_50DC
loc_50B0:
	move.b	-$7(a6),d0
	bsr.w	sub_6990
	tst.b	d0
	bne.s	loc_50CA
	move.w	d7,d0
	move.w	-$2(a6),d1
	bsr.w	sub_5216
	moveq	#$1,d6
	bra.s	loc_50DC
loc_50CA:
	tst.b	-$E(a6)
	beq.s	loc_50DC
	move.w	d7,d0
	move.w	-$2(a6),d1
	bsr.w	sub_5216
	moveq	#$1,d6
loc_50DC:
	adda.w	#$D6,a2
	adda.w	#$1A,a3
	addq.w	#$1,d7
	cmp.w	#$8,d7
	bne.s	loc_5090
	bra.w	loc_5196
loc_50F0:
	btst	#$7,-$8(a6)
	beq.s	loc_5130
	tst.b	-$B(a6)
	beq.s	loc_5120
	move.b	($FFFF9DA7).w,d0
	bsr.w	sub_6F14
	movea.l	a1,a2
	bsr.w	sub_6F02
	movea.l	a0,a3
	move.b	-$7(a6),d0
	bsr.w	sub_6990
	tst.b	d0
	beq.s	loc_5120
	tst.b	-$E(a6)
	beq.s	loc_5196
loc_5120:
	move.b	($FFFF9DA7).w,d0
	move.w	-$2(a6),d1
	bsr.w	sub_5216
	moveq	#$1,d6
	bra.s	loc_5196
loc_5130:
	bsr.w	sub_51D2
	move.b	-$A(a6),d0
	bsr.w	sub_6F14
	movea.l	a1,a2
	bsr.w	sub_6F02
	movea.l	a0,a3
	move.b	-$7(a6),d0
	bsr.w	sub_6990
	beq.s	loc_5154
	tst.b	-$E(a6)
	beq.s	loc_5196
loc_5154:
	move.b	-$A(a6),d0
	move.w	-$2(a6),d1
	bsr.w	sub_5216
	moveq	#$1,d6
	bra.s	loc_5196
loc_5164:
	moveq	#$0,d7
	move.b	-$3(a6),d7
	bra.s	loc_5192
loc_516C:
	bsr.w	sub_51B8
	bsr.w	sub_51D2
	move.b	-$A(a6),d0
	move.b	-$8(a6),d1
	bsr.w	sub_6946
	tst.b	d0
	beq.s	loc_5192
	move.b	-$A(a6),d0
	move.w	-$2(a6),d1
	bsr.w	sub_5216
	moveq	#$1,d6
loc_5192:
	dbf	d7,loc_516C
loc_5196:
	bsr.w	sub_71B0
	tst.b	d0
	bne.s	loc_51A6
	st	($FFFFBA53).w
	bsr.w	sub_7588
loc_51A6:
	tst.l	d6
	beq.s	loc_51B0
	jsr	(sub_14246).l
loc_51B0:
	movem.l	(a7)+,d6-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_51B8:
	move.b	-$4(a6),d0
	move.b	-$5(a6),d1
	bsr.w	sub_6CE4
	moveq	#$0,d1
	move.b	-$9(a6),d1
	add.w	d1,d0
	move.w	d0,-$2(a6)
	rts

; ---------------------------------------------------------------------------
sub_51D2:
	movem.l	d4-d6,-(a7)
	moveq	#$7,d6
	moveq	#$0,d5
	moveq	#$0,d4
	lea	($FFFFC470).w,a0
	lea	-$16(a6),a1
loc_51E4:
	move.b	(a0),d0
	beq.s	loc_51F2
	andi.b	#$C0,d0
	bne.s	loc_51F2
	move.b	d4,(a1)+
	addq.b	#$1,d5
loc_51F2:
	adda.w	#$1A,a0
	addq.l	#$1,d4
	dbf	d6,loc_51E4
	move.b	d5,d0
	beq.s	loc_520C
	bsr.w	sub_6C94
	lea	-$16(a6),a1
	move.b	(a1,d0.w),d0
loc_520C:
	move.b	d0,-$A(a6)
	movem.l	(a7)+,d4-d6
	rts

; ---------------------------------------------------------------------------
sub_5216:
	movem.l	d2/a2-a3,-(a7)
	move.w	d1,d2
	move.w	#$F000,($FFFFD5A8).w
	bsr.w	sub_6F02
	movea.l	a0,a3
	bsr.w	sub_6F14
	movea.l	a1,a2
	move.b	(a3),d0
	beq.s	loc_5280
	andi.b	#$C0,d0
	bne.s	loc_5280
	jsr	(sub_136A0).l
	move.w	#$8000,($FFFFD5AC).w
	lea	(a2),a0
	jsr	(sub_11CA4).l
	moveq	#$73,d0
	jsr	(sub_11C8E).l
	move.w	d2,d0
	move.w	#$4,($FFFFD5AA).w
	jsr	(sub_13328).l
	jsr	(sub_1368C).l
	jsr	(sub_11CA0).l
	moveq	#$74,d0
	jsr	(sub_11C8E).l
	move.w	d2,d0
	bsr.w	sub_760A
	bsr.w	sub_7684
loc_5280:
	movem.l	(a7)+,d2/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_5286:
	movem.l	d5-d7/a2-a3,-(a7)
	bsr.w	sub_404A
	move.l	d0,d7
	bsr.w	sub_404A
	bclr	#$7,d0
	sne	d6
	move.l	d0,d5
	tst.b	d7
	beq.s	loc_52BC
	moveq	#$7,d7
	lea	($FFFFBA68).w,a2
	lea	($FFFFC470).w,a3
loc_52AA:
	bsr.w	sub_52DE
	adda.w	#$D6,a2
	adda.w	#$1A,a3
	dbf	d7,loc_52AA
	bra.s	loc_52D8
loc_52BC:
	move.b	($FFFF9DA7).w,d0
	bsr.w	sub_6F14
	movea.l	a1,a2
	bsr.w	sub_6F02
	movea.l	a0,a3
	bsr.w	sub_52DE
	movea.l	a3,a0
	movea.l	a2,a1
	bsr.w	sub_6D1E
loc_52D8:
	movem.l	(a7)+,d5-d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_52DE:
	move.l	d7,-(a7)
	moveq	#$F,d7
	lea	$54(a2),a0
loc_52E6:
	cmp.b	(a0),d5
	bne.s	loc_52FC
	tst.b	$8(a0)
	beq.s	loc_52F6
	subq.b	#$1,$8(a0)
	bne.s	loc_52F8
loc_52F6:
	clr.l	(a0)
loc_52F8:
	tst.b	d6
	bne.s	loc_5304
loc_52FC:
	adda.w	#$A,a0
	dbf	d7,loc_52E6
loc_5304:
	move.l	(a7)+,d7
	rts

; ---------------------------------------------------------------------------
sub_5308:
	movem.l	d4-d7,-(a7)
	move.w	d0,d7
	move.b	($FFFF9BBC).w,d4
	move.b	#$B,($FFFF9BBC).w
	bsr.w	sub_85D6
	bsr.w	sub_862A
	moveq	#$0,d5
	bsr.w	sub_A71E
	lea	($FFFFB552).w,a0
	bsr.w	sub_9784
	cmp.b	#$1,d4
	beq.s	loc_533A
	cmp.b	#$6,d4
	bne.s	loc_5342
loc_533A:
	clr.w	($FFFFB52A).w
	bsr.w	sub_8360
loc_5342:
	lea	(dat_FE6C).l,a0
	bsr.w	sub_A768
	bsr.w	sub_8A76
	bsr.w	sub_8A60
	bsr.w	sub_B0DA
	bsr.w	sub_8874
	bsr.w	sub_860E
	moveq	#$1,d0
	bsr.w	sub_982A
	move.w	d7,d0
	bpl.s	loc_5374
	movea.l	a3,a0
	lea	($FFFFD5AE).w,a1
loc_5370:
	move.b	(a0)+,(a1)+
	bne.s	loc_5370
loc_5374:
	movea.w	#$0,a0
	clr.b	($FFFFD593).w
	bsr.w	sub_71D6
	move.w	d0,d5
	lea	($FFFFB582).w,a0
	bsr.w	sub_9784
	lea	($FFFFB532).w,a0
	bsr.w	sub_9784
	clr.l	($FFFFD57E).w
	move.b	d4,($FFFFBA5E).w
	bsr.w	sub_AF00
	move.w	d5,d0
	movem.l	(a7)+,d4-d7
	rts
loc_53A6:
	moveq	#-$1,d0
	st	($FFFFD599).w
	bsr.w	sub_5308
	move.b	d0,($FFFF9DA7).w
	rts

; ---------------------------------------------------------------------------
sub_53B6:
	link	a6,#-$1C
	movem.l	d3-d7/a2,-(a7)
	move.w	d0,d5
	moveq	#$1,d0
	moveq	#$1,d1
	bsr.w	sub_81AC
	move.b	($FFFF9AF7).w,($FFFF97E6).w
	move.b	($FFFF9AF6).w,($FFFF97E7).w
	lea	(dat_146E0).l,a0
	moveq	#$0,d0
	move.b	($FFFF9AFA).w,d0
	asl.b	#$1,d0
	move.b	$B(a0,d0.w),d1
	move.b	(a0,d0.w),d0
	add.b	($FFFF9AF7).w,d0
	add.b	($FFFF9AF6).w,d1
	movem.w	d0-d1,-$1C(a6)
	bsr.w	sub_4D8C
	move.b	d0,($FFFFBA5C).w
	bsr.w	sub_5AC2
	move.w	-$1C(a6),d0
	move.w	-$1A(a6),d1
	cmp.b	#$10,d0
	bcc.s	loc_542A
	cmp.b	#$10,d1
	bcc.s	loc_542A
	move.b	($FFFFBA5C).w,d0
	btst	#$0,d0
	beq.w	loc_54C6
	cmp.b	#$3,d0
	beq.s	loc_544C
loc_542A:
	moveq	#$2,d0
	moveq	#$0,d1
	bsr.w	sub_5566
	move.b	($FFFF9AFA).w,d0
	addq.b	#$2,d0
	andi.b	#$3,d0
	move.b	d0,($FFFF9AFA).w
	moveq	#$2,d0
	move.w	d5,d1
	bsr.w	sub_5566
	bra.w	loc_54E2
loc_544C:
	lea	-$18(a6),a2
	moveq	#$2,d0
	moveq	#$0,d1
	bsr.w	sub_5566
	move.b	($FFFF9AF7).w,d3
	move.b	($FFFF9AF6).w,d4
	moveq	#$0,d7
	move.b	($FFFF9AFA).w,d7
	bsr.w	sub_5504
	lea	(dat_146E0).l,a0
	move.w	d7,d0
	asl.w	#$1,d0
	move.b	(a0,d0.w),d1
	add.b	d1,d3
	move.b	$B(a0,d0.w),d1
	add.b	d1,d4
	addq.b	#$2,d7
	andi.b	#$3,d7
	bsr.w	sub_5504
	lea	(dat_146E0).l,a0
	moveq	#-$1,d7
	jsr	(sub_FF7C).l
	moveq	#$1,d0
	moveq	#$0,d1
	bsr.w	sub_5566
	lea	-$18(a6),a2
	moveq	#$3,d1
loc_54A6:
	movea.l	(a2)+,a1
	move.w	(a2)+,d0
	move.b	d0,(a1)
	dbf	d1,loc_54A6
	moveq	#-$1,d7
	jsr	(sub_FF7C).l
	moveq	#$2,d0
	move.l	d5,d1
	bsr.w	sub_5566
	bsr.w	sub_C134
	bra.s	loc_54CE
loc_54C6:
	moveq	#$0,d0
	move.l	d5,d1
	bsr.w	sub_5566
loc_54CE:
	move.b	-$1B(a6),($FFFF9AF7).w
	move.b	-$19(a6),($FFFF9AF6).w
	bsr.w	sub_4210
	bsr.w	sub_4228
loc_54E2:
	bsr.w	sub_4E00
	tst.b	($FFFFB4C7).w
	beq.s	loc_54F8
	subq.b	#$1,($FFFFB4C7).w
	bne.s	loc_54F8
	jsr	(sub_1343E).l
loc_54F8:
	bsr.w	sub_5A8A
	movem.l	(a7)+,d3-d7/a2
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_5504:
	move.l	d7,-(a7)
	jsr	(sub_14C7E).l
	tst.w	d0
	beq.s	loc_5560
	move.w	d4,d0
	asl.w	#$4,d0
	add.w	d3,d0
	lea	($FFFFB5A4).w,a0
	adda.w	d0,a0
	btst	#$0,d7
	bne.s	loc_5528
	move.b	#$F0,d1
	bra.s	loc_552C
loc_5528:
	move.b	#$F,d1
loc_552C:
	cmp.b	#$1,d7
	bhi.s	loc_553C
	move.l	a0,(a2)+
	move.b	(a0),d0
	move.w	d0,(a2)+
	or.b	d1,(a0)
	bra.s	loc_5548
loc_553C:
	lea	$100(a0),a1
	move.l	a1,(a2)+
	move.b	(a1),d0
	move.w	d0,(a2)+
	or.b	d1,(a1)
loc_5548:
	lea	$300(a0),a1
	move.l	a1,(a2)+
	move.b	(a1),d0
	move.w	d0,(a2)+
	move.b	#$3,d0
	asl.b	#$1,d7
	asl.b	d7,d0
	eori.b	#$FF,d0
	and.b	d0,(a1)
loc_5560:
	movem.l	(a7)+,d7
	rts

; ---------------------------------------------------------------------------
sub_5566:
	movem.l	d2-d7,-(a7)
	move.w	d1,-(a7)
	move.w	d0,d6
	bsr.w	sub_BF0A
	moveq	#$0,d0
	move.b	($FFFF9AFA).w,d0
	asl.w	#$1,d0
	lea	(dat_560E).l,a0
	move.w	$10(a0,d0.w),d5
	andi.w	#$7,d0
	move.w	(a0,d0.w),d3
	move.w	$8(a0,d0.w),d4
	add.w	d4,d3
	asr.w	d6,d5
	move.w	d3,d0
	move.w	d4,d0
loc_5598:
	move.b	#$2,($FFFF9BB7).w
	jsr	(sub_DEC4).l
	moveq	#$0,d7
	add.w	d3,($FFFFB3EC).w
	add.w	d4,($FFFFB3EE).w
	bsr.w	sub_C3F8
	movem.w	($FFFFB3EC).w,d0-d1
	subi.w	#$C,d0
	subi.w	#$C,d1
	movem.w	d0-d1,($FFFFB3F0).w
	jsr	(sub_FF7C).l
	bsr.w	sub_5626
	btst	#$0,($FFFF9AFA).w
	beq.s	loc_55DE
	btst	#$0,d5
	beq.s	loc_55EA
loc_55DE:
	move.b	#$2,($FFFF9BB7).w
	jsr	(sub_DEC4).l
loc_55EA:
	dbf	d5,loc_5598
	move.w	(a7)+,d1
	beq.s	loc_5608
	bpl.s	loc_5600
	jsr	(sub_F1B66).l
	andi.b	#$F,d0
	bne.s	loc_5608
loc_5600:
	clr.b	($FFFFB0AC).w
	bsr.w	sub_5644
loc_5608:
	movem.l	(a7)+,d2-d7
	rts
dat_560E:
	binclude	"data/00560E.bin"

; ---------------------------------------------------------------------------
sub_5626:
	subq.b	#$1,($FFFFB0AD).w
	bpl.s	sub_5644
	move.b	#$5,($FFFFB0AD).w
	move.b	($FFFFB0AC).w,d0
	addq.b	#$1,d0
	cmp.b	#$6,d0
	bls.s	loc_5640
	moveq	#$1,d0
loc_5640:
	move.b	d0,($FFFFB0AC).w

; ---------------------------------------------------------------------------
sub_5644:
	movea.l	($FFFFB0AE).w,a0
	move.w	$2(a0),d0
	asl.w	#$3,d0
	addi.w	#$EC00,d0
	bsr.w	sub_8288
	move.w	($FFFFB3F2).w,d0
	sub.w	($FFFFB416).w,d0
	subq.w	#$8,d0
	addi.w	#$80,d0
	move.w	d0,(a5)
	move.w	#$F00,d0
	or.w	$4(a0),d0
	move.w	d0,(a5)
	moveq	#$0,d0
	move.b	($FFFFB0AC).w,d0
	asl.w	#$4,d0
	addi.w	#$2CA,d0
	move.b	($FFFF9AFA).w,d1
	cmp.b	#$3,d1
	bne.s	loc_568A
	ori.w	#$800,d0
loc_568A:
	move.w	d0,(a5)
	move.w	($FFFFB3F0).w,d0
	sub.w	($FFFFB414).w,d0
	subq.w	#$4,d0
	addi.w	#$80,d0
	move.w	d0,(a5)
	rts
loc_569E:
	bsr.w	sub_85D6
	bsr.w	sub_862A
	bsr.w	sub_8A76
	bsr.w	sub_8A60
	moveq	#$0,d5
	bsr.w	sub_A71E
	bsr.w	sub_B0DA
	clr.w	($FFFFB52A).w
	bsr.w	sub_8360
	bra.w	loc_3AC
loc_56C4:
	move.l	d2,-(a7)
	asl.w	#$1,d0
	lea	(dat_56FE).l,a0
	adda.w	d0,a0
	moveq	#$C,d2
	movem.w	($FFFFB3F0).w,d0-d1
	add.w	d2,d0
	add.w	d2,d1
	sub.w	($FFFFB414).w,d0
	sub.w	($FFFFB416).w,d1
	add.w	($FFFFB3F8).w,d0
	add.w	($FFFFB3FA).w,d1
	add.w	(a0),d0
	add.w	$12(a0),d1
	move.w	$24(a0),d2
	bsr.w	sub_A102
	move.l	(a7)+,d2
	rts
dat_56FE:
	binclude	"data/0056FE.bin"

; ---------------------------------------------------------------------------
sub_5734:
	movem.l	d2-d5/a2,-(a7)
	move.b	d2,($FFFF9BD4).w
	bsr.w	sub_5766
	bsr.w	sub_57DA
	bsr.w	sub_57DA
	movem.l	(a7)+,d2-d5/a2
	rts
loc_574E:
	move.w	d2,-(a7)
	moveq	#$0,d2
	move.b	($FFFF9BD4).w,d2
	bsr.w	sub_5766
	move.w	(a7)+,d2
	bsr.w	sub_57DA
	bsr.w	sub_57DA
	rts

; ---------------------------------------------------------------------------
sub_5766:
	movem.l	d3/a2,-(a7)
	link	a6,#-$22
	lea	(dat_8FA8D).l,a0
	bsr.w	sub_9E76
	moveq	#-$2,d0
	add.l	a6,d0
	moveq	#$2,d1
	bsr.w	sub_9ED8
	moveq	#-$22,d0
	add.l	a6,d0
	move.w	-$2(a6),d1
	bsr.w	sub_9ED8
	moveq	#$0,d3
	lea	-$22(a6),a2
loc_5794:
	move.l	#$FFFFB5A4,d0
	move.w	#$400,d1
	bsr.w	sub_9ED8
	move.b	(a2,d3.w),d0
	cmp.b	d0,d2
	beq.s	loc_57D2
	addq.l	#$1,d3
	cmp.w	-$2(a6),d3
	bne.s	loc_5794
	lea	(dat_57BE).l,a0
	jsr	(sub_132A6).l
dat_57BE:
	binclude	"data/0057BE.bin"
loc_57D2:
	unlk	a6
	movem.l	(a7)+,d3/a2
	rts

; ---------------------------------------------------------------------------
sub_57DA:
	link	a6,#-$2
	movem.l	d2-d7/a2-a4,-(a7)
	lea	($FFFFB6A4).w,a2
	movea.l	($FFFFB41E).w,a3
	moveq	#$F,d7
loc_57EC:
	moveq	#$F,d6
loc_57EE:
	subq.l	#$1,a2
	st	-$1(a6)
	clr.b	-$2(a6)
	moveq	#$0,d1
	move.b	($FFFF9BD5).w,d1
	subq.w	#$1,d1
	bmi.s	loc_581A
	lea	($FFFF9BD6).w,a4
	clr.b	-$1(a6)
loc_580A:
	movem.w	(a4)+,d2-d5
	move.w	d1,-(a7)
	bsr.w	sub_5948
	move.w	(a7)+,d1
	dbf	d1,loc_580A
loc_581A:
	move.b	($FFFF9BC5).w,d1
	beq.s	loc_586C
	move.b	-$2(a6),d0
	move.b	d0,d2
	asl.b	#$2,d0
	eori.b	#$C,d0
	and.b	d0,d2
	btst	#$3,d2
	beq.s	loc_584C
	move.b	(a2),d0
	andi.b	#$F0,d0
	or.b	d1,d0
	move.b	d0,(a2)
	move.b	$101(a2),d0
	andi.b	#$F0,d0
	or.b	d1,d0
	move.b	d0,$101(a2)
loc_584C:
	btst	#$2,d2
	beq.s	loc_586C
	asl.b	#$4,d1
	move.b	(a2),d0
	andi.b	#$F,d0
	or.b	d1,d0
	move.b	d0,(a2)
	move.b	$F0(a2),d0
	andi.b	#$F,d0
	or.b	d1,d0
	move.b	d0,$F0(a2)
loc_586C:
	move.b	-$1(a6),d2
	btst	#$0,d2
	bne.s	loc_588A
	btst	#$1,d2
	bne.s	loc_5880
	clr.b	(a2)
	bra.s	loc_5898
loc_5880:
	move.b	(a2),d0
	andi.b	#$F,d0
	move.b	d0,(a2)
	bra.s	loc_5898
loc_588A:
	btst	#$1,d2
	bne.s	loc_5898
	move.b	(a2),d0
	andi.b	#$F0,d0
	move.b	d0,(a2)
loc_5898:
	btst	#$2,d2
	bne.s	loc_58B8
	btst	#$3,d2
	bne.s	loc_58AA
	clr.b	$100(a2)
	bra.s	loc_58CA
loc_58AA:
	move.b	$100(a2),d0
	andi.b	#$F,d0
	move.b	d0,$100(a2)
	bra.s	loc_58CA
loc_58B8:
	btst	#$3,d2
	bne.s	loc_58CA
	move.b	$100(a2),d0
	andi.b	#$F0,d0
	move.b	d0,$100(a2)
loc_58CA:
	btst	#$4,d2
	bne.s	loc_58D4
	clr.b	$200(a2)
loc_58D4:
	moveq	#$0,d0
	move.b	(a2),d0
	lsr.b	#$4,d0
	move.b	(a3,d0.w),d0
	addq.b	#$1,d0
	cmp.b	#$2,d0
	bne.s	loc_58E8
	moveq	#$1,d0
loc_58E8:
	move.b	d0,d1
	move.b	(a2),d0
	andi.b	#$F,d0
	move.b	(a3,d0.w),d0
	addq.b	#$1,d0
	cmp.b	#$2,d0
	bne.s	loc_58FE
	moveq	#$1,d0
loc_58FE:
	asl.b	#$2,d0
	or.b	d0,d1
	move.b	$100(a2),d0
	lsr.b	#$4,d0
	move.b	(a3,d0.w),d0
	addq.b	#$1,d0
	cmp.b	#$2,d0
	bne.s	loc_5916
	moveq	#$1,d0
loc_5916:
	asl.b	#$4,d0
	or.b	d0,d1
	move.b	$100(a2),d0
	andi.b	#$F,d0
	move.b	(a3,d0.w),d0
	addq.b	#$1,d0
	cmp.b	#$2,d0
	bne.s	loc_5930
	moveq	#$1,d0
loc_5930:
	asl.b	#$6,d0
	or.b	d0,d1
	move.b	d1,$300(a2)
	dbf	d6,loc_57EE
	dbf	d7,loc_57EC
	movem.l	(a7)+,d2-d7/a2-a4
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_5948:
	cmp.b	d2,d6
	blt.s	loc_59B6
	beq.s	loc_596C
	cmp.b	d3,d7
	blt.s	loc_59B6
	beq.s	loc_5982
	cmp.b	d4,d6
	bgt.s	loc_59B6
	beq.s	loc_5992
	cmp.b	d5,d7
	bgt.s	loc_59B6
	beq.s	loc_59A2
	st	-$1(a6)
	ori.b	#$3,-$2(a6)
	bra.s	loc_59B6
loc_596C:
	cmp.b	d3,d7
	ble.s	loc_59B6
	cmp.b	d5,d7
	bge.s	loc_59B6
	bset	#$3,-$2(a6)
	bset	#$1,-$1(a6)
	bra.s	loc_59B6
loc_5982:
	cmp.b	d2,d6
	ble.s	loc_59B6
	cmp.b	d4,d6
	bge.s	loc_59B6
	bset	#$2,-$1(a6)
	bra.s	loc_59B6
loc_5992:
	cmp.b	d3,d7
	ble.s	loc_59B6
	cmp.b	d5,d7
	bge.s	loc_59B6
	bset	#$3,-$1(a6)
	bra.s	loc_59B6
loc_59A2:
	cmp.b	d2,d6
	ble.s	loc_59B6
	cmp.b	d4,d6
	bge.s	loc_59B6
	bset	#$0,-$1(a6)
	bset	#$2,-$2(a6)
loc_59B6:
	rts

; ---------------------------------------------------------------------------
sub_59B8:
	link	a6,#-$1E
	movem.l	d2-d4/a3,-(a7)
	jsr	(sub_1343E).l
	bsr.w	sub_404A
	movem.l	d1/a0,-(a7)
	bsr.w	sub_404A
	move.l	d0,d2
	lea	-$18(a6),a3
	moveq	#$0,d3
	bra.s	loc_59EA
loc_59DC:
	bsr.w	sub_404A
	cmp.b	#$FF,d0
	beq.s	loc_59EA
	addq.w	#$1,d3
	move.b	d0,(a3)+
loc_59EA:
	dbf	d2,loc_59DC
	st	(a3)
	tst.w	d3
	beq.s	loc_5A54
	move.l	a2,-(a7)
	lea	-$12(a6),a2
	lea	-$18(a6),a3
	moveq	#$14,d4
	sub.w	d3,d4
	sub.w	d3,d4
	bra.s	loc_5A10
loc_5A06:
	move.b	d4,(a2)+
	move.b	#$17,(a2)+
	move.b	(a3)+,(a2)+
	addq.w	#$4,d4
loc_5A10:
	dbf	d3,loc_5A06
	st	(a2)
loc_5A16:
	lea	-$18(a6),a0
	bsr.w	sub_A768
	movea.w	#$0,a3
	lea	-$12(a6),a2
	tst.b	-$18(a6)
	sne	($FFFFD592).w
	clr.b	($FFFFD593).w
	move.b	#$40,($FFFFD595).w
	jsr	(sub_1391A).l
	move.w	d0,d2
	cmp.w	#$FFFF,d2
	beq.s	loc_5A54
	tst.w	d2
	bpl.s	loc_5A56
	st	($FFFFD596).w
	bsr.w	sub_5308
	bra.s	loc_5A16
loc_5A54:
	moveq	#$0,d0
loc_5A56:
	move.w	d0,d2
	movea.l	(a7)+,a2
	movem.l	(a7)+,d1/a0
	bsr.w	sub_42AE
	lea	($FFFFB532).w,a0
	bsr.w	sub_9784
	clr.l	($FFFFD57E).w
	jsr	(sub_1343E).l
	movem.l	(a7)+,d2-d4/a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_5A7C:
	move.w	#$8000,($FFFFB512).w
	move.w	#$FFFF,($FFFFB510).w
	bra.s	loc_5AA0

; ---------------------------------------------------------------------------
sub_5A8A:
	tst.b	($FFFFB522).w
	bne.s	loc_5A92
	rts
loc_5A92:
	clr.b	($FFFFB522).w
	clr.w	($FFFFB512).w
	move.w	#$7FFF,($FFFFB510).w
loc_5AA0:
	move.l	a6,-(a7)
	movea.l	($FFFFB51A).w,a0
	move.w	($FFFFB51E).w,d0
	move.w	($FFFFB520).w,d1
	move.w	#$A000,d6
	clr.w	($FFFFB50E).w
	clr.l	($FFFFB50A).w
	bsr.w	sub_C9B0
	movea.l	(a7)+,a6
	rts

; ---------------------------------------------------------------------------
sub_5AC2:
	movem.l	d2-d3,-(a7)
	tst.b	($FFFFBA5C).w
	sne	($FFFFB522).w
	beq.s	loc_5B18
	moveq	#$0,d0
	move.b	($FFFF9AFA).w,d0
	lea	(dat_5B1E).l,a0
	move.b	(a0,d0.w),d0
	adda.w	d0,a0
	move.l	a0,($FFFFB51A).w
	moveq	#$0,d0
	move.b	($FFFF9AF7).w,d0
	mulu.w	#$9,d0
	moveq	#$0,d1
	move.b	($FFFF9AF6).w,d1
	mulu.w	#$6,d1
	add.w	d1,d0
	move.w	($FFFFB408).w,d2
	move.w	($FFFFB40A).w,d3
	asr.w	#$3,d2
	asr.w	#$3,d3
	sub.w	d2,d0
	sub.w	d3,d1
	move.w	d0,($FFFFB51E).w
	move.w	d1,($FFFFB520).w
	bsr.w	sub_5A7C
loc_5B18:
	movem.l	(a7)+,d2-d3
	rts
dat_5B1E:
	binclude	"data/005B1E.bin"
loc_5B44:
	link	a6,#-$C
	movem.l	d2/d5-d7/a3,-(a7)
	bsr.w	sub_404A
	move.w	d0,-$2(a6)
	bsr.w	sub_404A
	move.w	d0,-$4(a6)
	bsr.w	sub_404A
	move.w	d0,-$6(a6)
	bsr.w	sub_404A
	move.w	d0,-$8(a6)
	bsr.w	sub_404A
	move.w	d0,-$A(a6)
	bsr.w	sub_404A
	move.w	d0,-$C(a6)
	moveq	#$1,d6
	tst.w	-$4(a6)
	beq.s	loc_5B8E
	lea	($FFFFBA68).w,a3
	moveq	#$7,d7
	moveq	#$0,d5
	bra.s	loc_5B9A
loc_5B8E:
	move.b	($FFFF9DA7).w,d5
	move.b	d5,d0
	bsr.w	sub_6F14
	movea.l	a1,a3
loc_5B9A:
	move.w	-$2(a6),d0
	move.w	-$6(a6),d1
	moveq	#$0,d2
	movea.l	a3,a0
	bsr.w	sub_4F20
	cmp.b	#$2,d0
	bcc.s	loc_5BD4
	tst.l	d6
	beq.s	loc_5BBC
	jsr	(sub_1343E).l
	clr.l	d6
loc_5BBC:
	move.w	-$8(a6),d0
	move.w	-$A(a6),d1
	bsr.w	sub_6CE4
	add.w	-$C(a6),d0
	move.b	d0,d1
	move.b	d5,d0
	bsr.w	sub_5216
loc_5BD4:
	tst.w	-$4(a6)
	beq.s	loc_5BE4
	addq.l	#$1,d5
	adda.w	#$D6,a3
	dbf	d7,loc_5B9A
loc_5BE4:
	movem.l	(a7)+,d2/d5-d7/a3
	unlk	a6
	rts
loc_5BEC:
	movem.l	d2-d3,-(a7)
	move.b	($FFFF9AF7).w,d2
	moveq	#$0,d3
	move.b	($FFFF9AF6).w,d3
	moveq	#$0,d1
	move.b	($FFFF9AFA).w,d1
	asl.b	#$1,d1
	tst.b	d0
	beq.s	loc_5C1A
	lea	(dat_146E0).l,a0
	add.b	(a0,d1.w),d2
	add.b	$B(a0,d1.w),d3
	addq.w	#$4,d1
	andi.w	#$7,d1
loc_5C1A:
	asl.b	#$4,d3
	add.b	d2,d3
	lea	($FFFFB8A4).w,a0
	move.b	(a0,d3.w),d2
	move.b	#$3,d0
	asl.b	d1,d0
	eori.b	#$FF,d0
	and.b	d0,d2
	move.b	d2,(a0,d3.w)
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_5C3C:
	link	a6,#-$38
	movem.l	d2-d5/a2,-(a7)
	bsr.w	sub_85D6
	move.b	($FFFF9BBC).w,($FFFF9BBD).w
	move.b	#$4,($FFFF9BBC).w
	bsr.w	sub_862A
	move.w	#$9100,(a4)
	move.w	#$9297,(a4)
	clr.w	($FFFFB52A).w
	bsr.w	sub_8360
	bsr.w	sub_8A76
	bsr.w	sub_8A60
	lea	(dat_711E4).l,a0
	bsr.w	sub_9DD4
	move.l	a0,-$4(a6)
	move.l	$2(a0),$8(a0)
	moveq	#$0,d0
	moveq	#$2,d1
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$28,d4
	moveq	#$1C,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	bsr.w	sub_95BE
	lea	(dat_733C1).l,a0
	bsr.w	sub_9DD4
	move.l	a0,-$C(a6)
	bsr.w	sub_97CC
	move.l	a1,$8(a2)
	move.w	d0,d5
	addi.w	#$90,d0
	move.w	d0,$6(a2)
	move.l	a2,-$10(a6)
	lea	(dat_72A03).l,a0
	bsr.w	sub_9DD4
	move.l	a0,-$8(a6)
	movea.l	$2(a0),a0
	moveq	#$3,d7
loc_5CDA:
	moveq	#$17,d6
loc_5CDC:
	move.w	(a0)+,d0
	asl.w	#$5,d0
	bsr.w	sub_829C
	moveq	#$7,d4
	lea	-$38(a6),a1
loc_5CEA:
	move.l	(a5),(a1)+
	dbf	d4,loc_5CEA
	move.w	d5,d0
	asl.w	#$5,d0
	bsr.w	sub_8288
	moveq	#$7,d4
	lea	-$38(a6),a1
loc_5CFE:
	move.l	(a1)+,(a5)
	dbf	d4,loc_5CFE
	addq.w	#$4,d5
	dbf	d6,loc_5CDC
	addi.w	#$FFA1,d5
	dbf	d7,loc_5CDA
	addi.w	#$5C,d5
	moveq	#$1,d7
loc_5D18:
	moveq	#$17,d6
loc_5D1A:
	move.w	(a0)+,d0
	asl.w	#$5,d0
	bsr.w	sub_829C
	moveq	#$7,d4
	lea	-$38(a6),a1
loc_5D28:
	move.l	(a5),(a1)+
	dbf	d4,loc_5D28
	move.w	d5,d0
	asl.w	#$5,d0
	bsr.w	sub_8288
	moveq	#$7,d4
	lea	-$38(a6),a1
loc_5D3C:
	move.l	(a1)+,(a5)
	dbf	d4,loc_5D3C
	addq.w	#$2,d5
	dbf	d6,loc_5D1A
	addi.w	#$FFD1,d5
	dbf	d7,loc_5D18
	lea	-$8(a6),a0
	bsr.w	sub_9784
	lea	(dat_9B0B9).l,a0
	bsr.w	sub_9DD4
	move.l	a0,-$14(a6)
	lea	(dat_9607B).l,a0
	bsr.w	sub_9DD4
	move.l	a0,-$18(a6)
	bsr.w	sub_8A6E
	moveq	#$0,d0
	moveq	#$1,d1
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$1E,d4
	moveq	#$17,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	movea.l	-$C(a6),a0
	bsr.w	sub_95BE
	moveq	#$0,d0
	moveq	#$4,d1
	moveq	#$C,d2
	moveq	#$17,d3
	moveq	#$F,d4
	moveq	#$4,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	movea.l	-$14(a6),a0
	bsr.w	sub_95BE
	move.l	#$12B,d7
loc_5DC2:
	move.l	d7,d0
	divu.w	#$3C,d0
	move.l	d0,d1
	swap	d1
	cmp.w	#$3B,d1
	bne.s	loc_5E04
	movem.l	d0-d1/a0-a1,-(a7)
	move.w	#$1D,d0
	jsr	(sub_1B900).l
	movem.l	(a7)+,d0-d1/a0-a1
	moveq	#$4,d1
	moveq	#$18,d2
	moveq	#$17,d3
	moveq	#$3,d4
	moveq	#$4,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	movea.l	-$18(a6),a0
	bsr.w	sub_95BE
loc_5E04:
	move.l	d7,d0
	divu.w	#$12,d0
	neg.w	d0
	move.l	#$60000003,(a4)
	move.w	d0,(a5)
	move.l	#$40000010,(a4)
	move.w	d0,(a5)
	cmp.w	#$12B,d7
	bne.s	loc_5E26
	bsr.w	sub_860E
loc_5E26:
	jsr	(sub_DEE6).l
	dbf	d7,loc_5DC2
	move.w	#$9200,(a4)
	move.w	#$58,d0
	move.w	#$50,d1
	moveq	#$11,d2
	bsr.w	sub_A102
	move.w	#$58,d0
	move.w	#$50,d1
	moveq	#$12,d2
	bsr.w	sub_A102
	move.l	#$20,(a4)
	moveq	#$F,d7
	lea	-$38(a6),a0
loc_5E5C:
	move.w	(a5),(a0)+
	dbf	d7,loc_5E5C
	move.l	#$C0200000,(a4)
	moveq	#$F,d7
	lea	-$38(a6),a0
loc_5E6E:
	move.w	(a0)+,(a5)
	dbf	d7,loc_5E6E
	moveq	#$1,d0
	moveq	#$1,d1
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$1E,d4
	moveq	#$17,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	movea.l	-$C(a6),a0
	bsr.w	sub_95BE
	move.w	#$12,d0
	jsr	(sub_1B900).l
	movea.l	-$10(a6),a2
	bsr.w	sub_5ED4
	lea	(dat_5ECA).l,a2
	moveq	#$4,d7
loc_5EB0:
	movea.l	a6,a0
	adda.w	(a2)+,a0
	bsr.w	sub_9784
	dbf	d7,loc_5EB0
	move.b	($FFFF9BBD).w,($FFFFBA5E).w
	movem.l	(a7)+,d2-d5/a2
	unlk	a6
	rts
dat_5ECA:
	binclude	"data/005ECA.bin"

; ---------------------------------------------------------------------------
sub_5ED4:
	link	a6,#-$2D0
	movem.l	d2-d6,-(a7)
	lea	-$2D0(a6),a0
	lea	(dat_60C8).l,a1
	moveq	#$2,d7
loc_5EE8:
	movem.w	(a1)+,d2-d5
	moveq	#$1,d6
	bsr.w	sub_6044
	moveq	#$0,d6
	move.w	d5,d4
	bsr.w	sub_6044
	dbf	d7,loc_5EE8
	move.l	#$168,d7
loc_5F04:
	bsr.w	sub_DEE6
	move.w	#$168,d0
	sub.w	d7,d0
	divu.w	#$12,d0
	move.l	#$60000003,(a4)
	move.w	d0,(a5)
	move.l	#$40000010,(a4)
	move.w	d0,(a5)
	move.w	d7,d0
	andi.w	#$7,d0
	bne.s	loc_5F46
	moveq	#$4,d0
	moveq	#$8,d6
	bsr.w	sub_5F82
	moveq	#$6,d0
	moveq	#$48,d6
	bsr.w	sub_5F82
	moveq	#$C,d0
	move.l	#$44E,d6
	bsr.w	sub_5F82
loc_5F46:
	move.l	#$6C000003,(a4)
	lea	-$2D0(a6),a0
	moveq	#$1,d5
	moveq	#$3B,d6
loc_5F54:
	bsr.w	sub_5FB2
	addq.l	#$1,d5
	cmp.w	#$3C,d5
	bne.s	loc_5F62
	moveq	#$0,d5
loc_5F62:
	adda.w	#$C,a0
	dbf	d6,loc_5F54
	dbf	d7,loc_5F04
	move.l	#$6C000003,(a4)
	moveq	#$0,d0
	move.l	d0,(a5)
	move.l	d0,(a5)
	movem.l	(a7)+,d2-d6
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_5F82:
	asl.w	#$1,d0
	addi.w	#$20,d0
	bsr.w	sub_8278
	moveq	#$7,d0
	bsr.w	sub_6C94
	subq.w	#$3,d0
	asl.w	#$1,d0
	move.w	d6,d1
	andi.w	#$E,d1
	add.w	d0,d1
	cmp.w	#$E,d1
	bls.s	loc_5FA6
	moveq	#$E,d1
loc_5FA6:
	move.w	d6,d0
	andi.w	#$EE0,d0
	or.w	d1,d0
	move.w	d0,(a5)
	rts

; ---------------------------------------------------------------------------
sub_5FB2:
	movem.w	(a0),d2-d3
	movem.w	$4(a0),d0-d1
	add.w	d0,d2
	add.w	d1,d3
	cmp.w	#$1800,d2
	bls.s	loc_5FD8
	cmp.w	#$7000,d2
	bcc.s	loc_5FD8
	cmp.w	#$1800,d3
	bls.s	loc_5FD8
	cmp.w	#$5800,d3
	bcs.s	loc_5FE0
loc_5FD8:
	clr.l	$4(a0)
	clr.l	(a0)
	bra.s	loc_5FE6
loc_5FE0:
	dc.w	$48A8,$000C,$0000	; movem.w d2-d3,$0(a0)
loc_5FE6:
	lsr.w	#$6,d2
	lsr.w	#$6,d3
	move.w	d3,(a5)
	move.b	$B(a0),d0
	add.b	d0,$8(a0)
	move.w	(a2),d1
	moveq	#$0,d0
	move.b	$A(a0),d0
	tst.b	$9(a0)
	beq.s	loc_6018
	asl.w	#$5,d0
	add.w	d0,d1
	btst	#$6,$8(a0)
	beq.s	loc_6012
	addi.w	#$10,d1
loc_6012:
	move.w	#$F00,d0
	bra.s	loc_602E
loc_6018:
	asl.w	#$3,d0
	add.w	d0,d1
	btst	#$6,$8(a0)
	beq.s	loc_6026
	addq.w	#$4,d1
loc_6026:
	move.w	#$500,d0
	addi.w	#$60,d1
loc_602E:
	add.w	d5,d0
	move.w	d0,(a5)
	btst	#$7,$8(a0)
	beq.s	loc_603E
	ori.w	#$1800,d1
loc_603E:
	move.w	d1,(a5)
	move.w	d2,(a5)
	rts

; ---------------------------------------------------------------------------
sub_6044:
	movem.l	d4-d5,-(a7)
	bra.s	loc_609E
loc_604A:
	move.w	d2,d0
	bsr.w	sub_60A8
	move.w	d0,(a0)
	move.w	d1,$4(a0)
	move.w	d3,d0
	bsr.w	sub_60A8
	move.w	d0,$2(a0)
	move.w	d1,$6(a0)
	move.l	#$80,d0
	bsr.w	sub_6C94
	asl.b	#$1,d0
	move.b	d0,$8(a0)
	moveq	#$4,d0
	bsr.w	sub_6C8C
	move.w	d0,d5
	bsr.w	sub_6C8C
	mulu.w	d5,d0
	move.b	d0,$B(a0)
	move.b	d6,$9(a0)
	beq.s	loc_6090
	moveq	#$3,d0
	bra.s	loc_6092
loc_6090:
	moveq	#$6,d0
loc_6092:
	bsr.w	sub_6C94
	move.b	d0,$A(a0)
	adda.w	#$C,a0
loc_609E:
	dbf	d4,loc_604A
	movem.l	(a7)+,d4-d5
	rts

; ---------------------------------------------------------------------------
sub_60A8:
	move.w	d0,-(a7)
	moveq	#$29,d0
	bsr.w	sub_6C94
	subi.w	#$18,d0
	bpl.s	loc_60BA
	subq.w	#$4,d0
	bra.s	loc_60BC
loc_60BA:
	addq.w	#$4,d0
loc_60BC:
	move.w	d0,d1
	muls.w	#$3,d1
	add.w	(a7)+,d0
	asl.w	#$6,d0
	rts
dat_60C8:
	binclude	"data/0060C8.bin"
loc_60E0:
	link	a6,#-$392
	move.b	#$10,($FFFFBA5E).w
	bsr.w	sub_85D6
	bsr.w	sub_862A
	move.w	#$9100,(a4)
	move.w	#$920E,(a4)
	clr.w	($FFFFB52A).w
	move.w	#$9,($FFFFB52A).w
	bsr.w	sub_8360
	move.l	#$20002,($FFFFB566).w
	moveq	#$0,d5
	bsr.w	sub_A71E
	bsr.w	sub_8A6E
	bsr.w	sub_8A76
	bsr.w	sub_8A60
	move.l	#$60000003,(a4)
	move.w	#$140,(a5)
	lea	(dat_711E4).l,a0
	bsr.w	sub_9DD4
	move.l	a0,-$4(a6)
	movea.l	$2(a0),a1
	move.l	a1,$8(a0)
	move.w	#$45F,d2
	move.w	#$6000,d3
	move.w	#$9FFF,d4
	move.w	#$4000,d5
loc_6152:
	move.w	(a1),d0
	move.w	d0,d1
	and.w	d3,d1
	cmp.w	d3,d1
	bne.s	loc_6160
	and.w	d4,d0
	or.w	d5,d0
loc_6160:
	move.w	d0,(a1)+
	dbf	d2,loc_6152
	moveq	#$0,d0
	moveq	#$2,d1
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$28,d4
	moveq	#$1C,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	bsr.w	sub_95BE
	if DEUTSCH	; DEUTSCH-HOOK 18: Grafik G6 aus DE_Grafik_G6 (Abspann-Kopf CREATED BY THE -> ENTWICKELT VOM, 6 Byte wie Original)
	lea	(DE_Grafik_G6).l,a0
	else
	lea	(dat_725C6).l,a0
	endif
	bsr.w	sub_9DD4
	move.l	a0,-$8(a6)
	movea.l	-$8(a6),a0
	moveq	#$0,d0
	moveq	#$4,d1
	moveq	#$0,d2
	moveq	#$1,d3
	moveq	#$28,d4
	moveq	#$A,d5
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	bsr.w	sub_95BE
	moveq	#$9,d0
	bsr.w	sub_8A90
	move.w	#$A000,($FFFFD5A8).w
	clr.w	-$38A(a6)
	if DEUTSCH	; DEUTSCH-HOOK 13: Abspann aus DE_Abspann (6 Byte wie Original)
	lea	(DE_Abspann).l,a2
	else
	lea	(dat_632E).l,a2
	endif
loc_61CA:
	move.b	(a2)+,d0
	cmp.b	#$FF,d0
	beq.s	loc_61F8
	cmp.b	#$FE,d0
	beq.s	loc_6212
	cmp.b	#$FD,d0
	beq.s	loc_6226
	cmp.b	#$FC,d0
	beq.s	loc_622C
	move.w	#$C000,($FFFFD5AC).w
	subq.l	#$1,a2
	move.w	#$3,($FFFFD5D6).w
	bsr.w	sub_631C
	bra.s	loc_61CA
loc_61F8:
	bsr.w	sub_6246
	move.b	(a2)+,($FFFFB525).w
	bsr.w	sub_4DFA
	bsr.w	sub_8A6E
	move.l	#$E,($FFFFD5D6).w
	bra.s	loc_61CA
loc_6212:
	move.w	#$E000,($FFFFD5AC).w
	addq.w	#$1,($FFFFD5D8).w
	clr.w	($FFFFD5D6).w
	bsr.w	sub_631C
	bra.s	loc_61CA
loc_6226:
	bsr.w	sub_6246
	bra.s	loc_6242
loc_622C:
	move.b	(a2)+,($FFFFB524).w
	bsr.w	sub_B7B4
	bsr.w	sub_860E
	move.l	#$E,($FFFFD5D6).w
	bra.s	loc_61CA
loc_6242:
	jmp	($352).w

; ---------------------------------------------------------------------------
sub_6246:
	move.l	#$60000003,(a4)
	move.w	#$DF,d2
	move.l	#$FF400000,d0
loc_6256:
	move.l	d0,(a5)
	dbf	d2,loc_6256
	move.w	#$8B03,(a4)
	move.w	#$FF40,d6
	moveq	#$0,d7
	bsr.w	sub_628C
	move.w	#$168,d0
	bsr.w	sub_75FA
	moveq	#$0,d6
	move.w	#$140,d7
	bsr.w	sub_628C
	move.l	#$60000003,(a4)
	move.w	#$140,(a5)
	move.w	#$8B00,(a4)
	rts

; ---------------------------------------------------------------------------
sub_628C:
	asl.w	#$4,d6
	asl.w	#$4,d7
	move.w	d6,-$392(a6)
	move.w	d7,-$38E(a6)
	sub.w	d6,d7
	move.w	d7,d4
	asr.w	#$7,d4
	move.l	#$DF,d5
	lea	-$1C8(a6),a0
	lea	-$388(a6),a1
loc_62AC:
	move.w	d6,(a0)+
	move.w	#$77,d0
	sub.w	d5,d0
	bpl.s	loc_62BA
	moveq	#$0,d0
	bra.s	loc_62D4
loc_62BA:
	moveq	#$0,d2
	sub.w	d0,d2
	asr.w	#$1,d2
	addi.w	#$30,d2
	moveq	#$21,d0
	bsr.w	sub_6C94
	mulu.w	d4,d0
	asr.w	#$5,d0
	add.w	d0,d2
	add.w	d4,d2
	move.w	d2,d0
loc_62D4:
	move.w	d0,(a1)+
	dbf	d5,loc_62AC
	move.w	#$FF,d5
loc_62DE:
	bsr.w	sub_DEE6
	move.l	#$60000003,(a4)
	move.l	#$DF,d4
	lea	-$1C8(a6),a0
	lea	-$388(a6),a1
loc_62F6:
	move.w	(a0),d0
	add.w	(a1)+,d0
	cmp.w	-$38E(a6),d0
	blt.s	loc_6308
	move.w	-$38E(a6),d0
	clr.w	-$2(a1)
loc_6308:
	move.w	d0,(a0)+
	asr.w	#$4,d0
	move.w	d0,(a5)
	move.w	#$0,(a5)
	dbf	d4,loc_62F6
	dbf	d5,loc_62DE
	rts

; ---------------------------------------------------------------------------
sub_631C:
	movea.l	a2,a0
	jsr	(sub_11CA4).l
loc_6324:
	tst.b	(a2)+
	bne.s	loc_6324
	addq.w	#$1,($FFFFD5D8).w
	rts
dat_632E:
	binclude	"data/00632E.bin"

; ---------------------------------------------------------------------------
sub_664E:
	move.l	a6,-(a7)
	lea	(dat_6670).l,a6
	cmp.b	#$17,d0
	bcc.s	loc_666C
	asl.w	#$1,d0
	adda.w	(a6,d0.w),a6
loc_6662:
	move.b	(a6)+,d0
	bmi.s	loc_666C
	bsr.w	sub_66D2
	bra.s	loc_6662
loc_666C:
	movea.l	(a7)+,a6
	rts
dat_6670:
	binclude	"data/006670.bin"

; ---------------------------------------------------------------------------
sub_66D2:
	movem.l	d2-d7/a2-a3,-(a7)
	move.b	d0,d2
	bsr.w	sub_69DA
	tst.b	d0
	beq.s	loc_66F2
	moveq	#$0,d0
	move.b	d2,d0
	asl.w	#$1,d0
	lea	(jt_66F8).l,a0
	adda.w	(a0,d0.w),a0
	jsr	(a0)
loc_66F2:
	movem.l	(a7)+,d2-d7/a2-a3
	rts
jt_66F8:
	dc.w	loc_673A-jt_66F8
	dc.w	loc_673C-jt_66F8
	dc.w	loc_6740-jt_66F8
	dc.w	loc_6742-jt_66F8
	dc.w	loc_6758-jt_66F8
	dc.w	loc_6758-jt_66F8
	dc.w	loc_6758-jt_66F8
	dc.w	loc_6758-jt_66F8
	dc.w	loc_6758-jt_66F8
	dc.w	loc_6758-jt_66F8
	dc.w	loc_6758-jt_66F8
	dc.w	loc_6758-jt_66F8
	dc.w	loc_6758-jt_66F8
	dc.w	loc_675A-jt_66F8
	dc.w	loc_676A-jt_66F8
	dc.w	loc_6778-jt_66F8
	dc.w	loc_6778-jt_66F8
	dc.w	loc_6778-jt_66F8
	dc.w	loc_6778-jt_66F8
	dc.w	loc_6778-jt_66F8
	dc.w	loc_677A-jt_66F8
	dc.w	loc_678A-jt_66F8
	dc.w	loc_679A-jt_66F8
	dc.w	loc_67AA-jt_66F8
	dc.w	loc_67CE-jt_66F8
	dc.w	loc_67E6-jt_66F8
	dc.w	loc_6814-jt_66F8
	dc.w	loc_683C-jt_66F8
	dc.w	loc_685A-jt_66F8
	dc.w	sub_6884-jt_66F8
	dc.w	loc_68AE-jt_66F8
	dc.w	loc_68D2-jt_66F8
	dc.w	loc_68D4-jt_66F8
loc_673A:
	rts
loc_673C:
	bra.w	loc_6A24
loc_6740:
	rts
loc_6742:
	clr.b	($FFFFD55E).w
	move.b	($FFFFD497).w,d0
	cmp.b	$E(a3),d0
	bcs.s	loc_6756
	move.b	$E(a3),($FFFFD497).w
loc_6756:
	rts
loc_6758:
	rts
loc_675A:
	subq.b	#$2,$5(a3)
	move.b	$5(a3),$4(a3)
	subq.b	#$4,$3(a3)
	rts
loc_676A:
	subq.b	#$2,$5(a3)
	move.b	$5(a3),$4(a3)
	bra.w	loc_6A24
loc_6778:
	rts
loc_677A:
	jsr	(sub_1062C).l
	tst.b	d0
	beq.s	loc_6788
	st	($FFFFD4FC).w
loc_6788:
	rts
loc_678A:
	move.b	($FFFFD55E).w,d0
	cmp.b	#$D,d0
	bne.s	loc_6798
	clr.b	($FFFFD55E).w
loc_6798:
	rts
loc_679A:
	move.b	($FFFFD55E).w,d0
	cmp.b	#$E,d0
	bne.s	loc_67A8
	clr.b	($FFFFD55E).w
loc_67A8:
	rts
loc_67AA:
	movem.l	a2-a3,-(a7)
	bsr.w	sub_6ACC
	tst.b	d0
	beq.s	loc_67C8
	move.b	(a0),d0
	cmp.b	#$E,d0
	beq.s	loc_67C4
	cmp.b	#$11,d0
	bne.s	loc_67C8
loc_67C4:
	clr.b	($FFFFD497).w
loc_67C8:
	movem.l	(a7)+,a2-a3
	rts
loc_67CE:
	bsr.w	sub_6ACC
	tst.b	d0
	beq.s	loc_67E4
	move.b	$1(a1),d0
	cmp.b	#$3,d0
	bne.s	loc_67E4
	clr.b	($FFFFD497).w
loc_67E4:
	rts
loc_67E6:
	bsr.w	sub_6ACC
	tst.b	d0
	beq.s	loc_6812
	move.b	$1(a1),d0
	cmp.b	#$1,d0
	beq.s	loc_6804
	cmp.b	#$2,d0
	beq.s	loc_6804
	cmp.b	#$5,d0
	bne.s	loc_6812
loc_6804:
	bsr.w	sub_6D06
	cmp.b	#$32,d0
	bcs.s	loc_6812
	clr.b	($FFFFD497).w
loc_6812:
	rts
loc_6814:
	bsr.w	sub_6ACC
	tst.b	d0
	beq.s	loc_683A
	move.b	$1(a1),d0
	cmp.b	#$1,d0
	bcs.s	loc_683A
	cmp.b	#$5,d0
	bhi.s	loc_683A
	bsr.w	sub_6D06
	cmp.b	#$32,d0
	bcs.s	loc_683A
	clr.b	($FFFFD497).w
loc_683A:
	rts
loc_683C:
	bsr.w	sub_6ACC
	tst.b	d0
	beq.s	loc_6858
	tst.b	$1(a1)
	bne.s	loc_6858
	bsr.w	sub_6D06
	cmp.b	#$32,d0
	bcs.s	loc_6858
	clr.b	($FFFFD497).w
loc_6858:
	rts
loc_685A:
	movem.l	a2-a3,-(a7)
	move.b	($FFFFD513).w,d0
	bsr.w	sub_6EF0
	moveq	#$0,d0
	bsr.w	sub_6990
	move.b	d0,d2
	bne.s	loc_687E
	bsr.w	sub_6884
	moveq	#$1D,d0
	moveq	#$5,d1
	moveq	#$2,d3
	bsr.w	sub_6A34
loc_687E:
	movem.l	(a7)+,a2-a3
	rts

; ---------------------------------------------------------------------------
sub_6884:
	move.b	$F(a3),d0
	asr.b	#$1,d0
	move.b	d0,$F(a3)
	move.b	$16(a3),d0
	asr.b	#$1,d0
	move.b	d0,$16(a3)
	move.b	$6(a3),d0
	asr.b	#$1,d0
	move.b	d0,$6(a3)
	move.b	$7(a3),d0
	asr.b	#$1,d0
	move.b	d0,$7(a3)
	rts
loc_68AE:
	movem.l	a2-a3,-(a7)
	move.b	($FFFFD513).w,d0
	bsr.w	sub_6EF0
	moveq	#$0,d0
	bsr.w	sub_6990
	tst.b	d0
	bne.s	loc_68CC
	move.b	#$86,(a3)
	clr.b	$E(a3)
loc_68CC:
	movem.l	(a7)+,a2-a3
	rts
loc_68D2:
	rts
loc_68D4:
	movem.l	d2-d4/a2-a3,-(a7)
	bsr.w	sub_6EEC
	move.b	$12(a3),d2
	move.b	$13(a3),d3
	moveq	#$C,d4
	clr.l	($FFFFD48E).w
	clr.l	($FFFFD492).w
	moveq	#$2,d0
	moveq	#$8,d1
	bsr.w	sub_6CE4
	move.b	d0,($FFFFD48E).w
	move.b	$17(a3),d0
	bmi.s	loc_6940
	move.b	d0,($FFFFD513).w
	bsr.w	sub_6EF0
	move.b	$12(a3),d0
	move.b	$13(a3),d1
	jsr	(sub_15B5A).l
	tst.b	d0
	beq.s	loc_6940
	bsr.w	sub_CA7E
	bsr.w	sub_6D06
	cmp.b	#$23,d0
	bcs.s	loc_692C
	moveq	#$0,d0
	bra.s	loc_692E
loc_692C:
	moveq	#$1,d0
loc_692E:
	moveq	#$0,d1
	moveq	#$0,d4
	jsr	(sub_108AA).l
	lea	($FFFFB58A).w,a0
	bsr.w	sub_9784
loc_6940:
	movem.l	(a7)+,d2-d4/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_6946:
	movem.l	d2/a2-a3,-(a7)
	bsr.w	sub_6F02
	movea.l	a0,a3
	bsr.w	sub_6F14
	movea.l	a1,a2
	move.w	d1,d2
	moveq	#$14,d0
	bsr.w	sub_6C8C
	cmp.b	#$1,d0
	beq.s	loc_6988
	cmp.b	#$14,d0
	bne.s	loc_696C
	moveq	#$64,d0
loc_696C:
	move.b	d0,($FFFFD498).w
	moveq	#$10,d0
	bsr.w	sub_664E
	move.b	($FFFFD498).w,d0
	bmi.s	loc_6988
	add.b	d2,d0
	cmp.b	$4(a3),d0
	ble.s	loc_6988
	moveq	#$1,d0
	bra.s	loc_698A
loc_6988:
	moveq	#$0,d0
loc_698A:
	movem.l	(a7)+,d2/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_6990:
	move.l	d2,-(a7)
	move.w	d0,d2
	moveq	#$14,d0
	bsr.w	sub_6C8C
	move.b	d0,($FFFFD55D).w
	cmp.b	#$1,d0
	beq.s	loc_69C2
	cmp.b	#$14,d0
	beq.s	loc_69BE
	add.b	d2,($FFFFD55D).w
	moveq	#$C,d0
	bsr.w	sub_664E
	move.b	($FFFFD55D).w,d0
	cmp.b	$15(a2),d0
	blt.s	loc_69C2
loc_69BE:
	moveq	#$1,d0
	bra.s	loc_69C4
loc_69C2:
	moveq	#$0,d0
loc_69C4:
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_69C8:
	move.w	d0,-(a7)
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	move.w	(a7)+,d0
	bra.s	loc_69EC

; ---------------------------------------------------------------------------
sub_69DA:
	move.w	d0,d1
	move.w	a3,d0
	subi.w	#$C470,d0
	ext.l	d0
	divu.w	#$1A,d0
	movea.l	a3,a0
	movea.l	a2,a1
loc_69EC:
	movem.l	d2,-(a7)
	moveq	#$9,d2
	lea	$43(a1),a0
loc_69F6:
	cmp.b	(a0)+,d1
	beq.s	loc_6A18
	dbf	d2,loc_69F6
	moveq	#$1F,d2
	lea	($FFFFD49C).w,a0
loc_6A04:
	cmp.b	$1(a0),d1
	bne.s	loc_6A0E
	cmp.b	(a0),d0
	beq.s	loc_6A1C
loc_6A0E:
	addq.w	#$3,a0
	dbf	d2,loc_6A04
	moveq	#$0,d0
	bra.s	loc_6A1E
loc_6A18:
	movea.w	#$0,a0
loc_6A1C:
	moveq	#$1,d0
loc_6A1E:
	movem.l	(a7)+,d2
	rts
loc_6A24:
	clr.b	$14(a3)
	bclr	#$4,$1(a3)
	clr.b	$16(a3)
	rts

; ---------------------------------------------------------------------------
sub_6A34:
	link	a6,#-$2
	move.l	d7,-(a7)
	move.b	d1,-$2(a6)
	move.b	d0,($FFFFD55E).w
	moveq	#$9,d0
	bsr.w	sub_664E
	tst.b	($FFFFD55E).w
	beq.s	loc_6A9E
	cmp.b	#$2,d3
	bne.s	loc_6A58
	tst.b	d2
	bne.s	loc_6A9E
loc_6A58:
	move.b	($FFFFD55E).w,d0
	bsr.w	sub_69DA
	tst.b	d0
	beq.s	loc_6A7A
	move.l	a0,d0
	beq.s	loc_6A7A
	move.b	-$2(a6),d0
	beq.s	loc_6A74
	cmp.b	$2(a0),d0
	bcs.s	loc_6A78
loc_6A74:
	move.b	d0,$2(a0)
loc_6A78:
	bra.s	loc_6A9E
loc_6A7A:
	lea	($FFFFD49C).w,a0
	moveq	#$1F,d7
loc_6A80:
	tst.b	$1(a0)
	bne.s	loc_6A98
	move.b	($FFFFD513).w,(a0)
	move.b	($FFFFD55E).w,$1(a0)
	move.b	-$2(a6),$2(a0)
	bra.s	loc_6A9E
loc_6A98:
	addq.w	#$3,a0
	dbf	d7,loc_6A80
loc_6A9E:
	move.l	(a7)+,d7
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_6AA4:
	movem.l	d0/d7/a0,-(a7)
	lea	($FFFFD49C).w,a0
	moveq	#$1F,d7
loc_6AAE:
	move.b	$2(a0),d0
	beq.s	loc_6AC0
	subq.b	#$1,d0
	move.b	d0,$2(a0)
	bne.s	loc_6AC0
	clr.b	$1(a0)
loc_6AC0:
	addq.w	#$3,a0
	dbf	d7,loc_6AAE
	movem.l	(a7)+,d0/d7/a0
	rts

; ---------------------------------------------------------------------------
sub_6ACC:
	movem.l	a2-a3,-(a7)
	tst.b	($FFFF97AE).w
	beq.s	loc_6AE0
	move.b	($FFFFCA20).w,d0
	cmp.b	#$8,d0
	bcs.s	loc_6AFC
loc_6AE0:
	bsr.w	sub_6EEC
	lea	$AE(a2),a0
	moveq	#$0,d0
	move.b	(a0),d0
	beq.s	loc_6AFC
	lea	(dat_779E).l,a1
	asl.w	#$3,d0
	adda.w	d0,a1
	moveq	#$1,d0
	bra.s	loc_6AFE
loc_6AFC:
	moveq	#$0,d0
loc_6AFE:
	movem.l	(a7)+,a2-a3
	rts

; ---------------------------------------------------------------------------
sub_6B04:
	movem.l	d2-d3,-(a7)
	move.b	d0,d2
	bsr.w	sub_6B22
	move.w	d0,d3
	move.b	d2,d0
	addi.b	#$40,d0
	bsr.w	sub_6B22
	move.w	d3,d1
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_6B22:
	cmp.b	#$80,d0
	bcc.s	loc_6B2C
	bra.w	sub_6B38
loc_6B2C:
	subi.b	#$80,d0
	bsr.w	sub_6B38
	neg.w	d0
	rts

; ---------------------------------------------------------------------------
sub_6B38:
	cmp.b	#$40,d0
	bls.s	loc_6B44
	neg.b	d0
	addi.b	#$80,d0
loc_6B44:
	ext.w	d0
	asl.w	#$1,d0
	lea	(dat_6B54).l,a0
	move.w	(a0,d0.w),d0
	rts
dat_6B54:
	binclude	"data/006B54.bin"

; ---------------------------------------------------------------------------
sub_6BD6:
	movem.l	d2,-(a7)
	ext.l	d0
	move.l	d0,d1
	asr.l	#$1,d0
loc_6BE0:
	move.w	d0,d2
	beq.s	loc_6BF8
	mulu.w	d0,d2
	add.l	d1,d2
	add.l	d0,d2
	divu.w	d0,d2
	asr.w	#$1,d2
	cmp.w	d0,d2
	beq.s	loc_6BF8
	move.w	d2,d0
	ext.l	d0
	bra.s	loc_6BE0
loc_6BF8:
	movem.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_6BFE:
	jsr	(sub_F1B66).l
	lea	(dat_6C34).l,a0
	btst	#$0,d0
	beq.s	loc_6C12
	subq.l	#$3,a0
loc_6C12:
	btst	#$1,d0
	beq.s	loc_6C1A
	addq.l	#$3,a0
loc_6C1A:
	btst	#$2,d0
	beq.s	loc_6C22
	subq.l	#$1,a0
loc_6C22:
	btst	#$3,d0
	beq.s	loc_6C2A
	addq.l	#$1,a0
loc_6C2A:
	move.b	(a0),d1
	ext.w	d1
	rts
	dc.b	$07,$00,$01,$06
dat_6C34:
	dc.b	$08,$02,$05,$04,$03,$00

; ---------------------------------------------------------------------------
sub_6C3A:
	move.l	d6,-(a7)
	moveq	#$9,d6
loc_6C3E:
	jsr	(sub_F1B66).l
	tst.b	d0
	beq.s	loc_6C50
	bsr.w	sub_DEE6
	dbf	d6,loc_6C3E
loc_6C50:
	move.l	(a7)+,d6
	rts

; ---------------------------------------------------------------------------
sub_6C54:
	bsr.w	sub_DF08
	jsr	(sub_F1B66).l
	tst.b	d0
	bne.s	sub_6C54
	rts

; ---------------------------------------------------------------------------
sub_6C64:
	bsr.w	sub_DF08
	jsr	(sub_F1B66).l
	tst.b	d0
	beq.s	sub_6C64
	move.w	d0,-(a7)
loc_6C74:
	andi.b	#$F0,d0
	beq.s	loc_6C88
	bsr.w	sub_DF08
	jsr	(sub_F1B66).l
	tst.b	d0
	bne.s	loc_6C74
loc_6C88:
	move.w	(a7)+,d0
	rts

; ---------------------------------------------------------------------------
sub_6C8C:
	bsr.w	sub_6C94
	addq.l	#$1,d0
	rts

; ---------------------------------------------------------------------------
sub_6C94:
	movem.l	d1-d3/a0,-(a7)
	ext.w	d0
	tst.w	d0
	beq.s	loc_6CDE
	lea	($FFFFD604).w,a0
	moveq	#$0,d1
	move.b	($FFFFD804).w,d1
	addq.b	#$1,($FFFFD804).w
	move.w	d1,d2
	subi.b	#$67,d2
	move.w	d1,d3
	subi.b	#$CD,d3
	asl.w	#$1,d1
	asl.w	#$1,d2
	asl.w	#$1,d3
	move.w	(a0,d2.w),d2
	move.w	(a0,d3.w),d3
	eor.w	d3,d2
	move.w	(a0,d1.w),d3
	eor.w	d3,d2
	move.w	d2,(a0,d1.w)
	moveq	#$0,d1
	move.w	d2,d1
	divu.w	d0,d1
	swap	d1
	move.w	d1,d0
	ext.l	d0
loc_6CDE:
	movem.l	(a7)+,d1-d3/a0
	rts

; ---------------------------------------------------------------------------
sub_6CE4:
	movem.l	d2-d4,-(a7)
	moveq	#$0,d2
	moveq	#$0,d4
	move.b	d0,d2
	move.b	d1,d3
	subq.l	#$1,d2
	bmi.s	loc_6CFE
loc_6CF4:
	move.b	d3,d0
	bsr.s	sub_6C8C
	add.w	d0,d4
	dbf	d2,loc_6CF4
loc_6CFE:
	move.w	d4,d0
	movem.l	(a7)+,d2-d4
	rts

; ---------------------------------------------------------------------------
sub_6D06:
	moveq	#$64,d0
	bra.s	sub_6C8C

; ---------------------------------------------------------------------------
sub_6D0A:
	move.l	a0,d0
	beq.s	loc_6D1C
	subi.l	#$FFFFBA68,d0
	ext.l	d0
	divu.w	#$D6,d0
	ext.w	d0
loc_6D1C:
	rts

; ---------------------------------------------------------------------------
sub_6D1E:
	movem.l	d4-d6/a2-a3,-(a7)
	moveq	#$0,d5
	move.l	$26(a1),$6(a0)
	move.l	$2A(a1),$A(a0)
	move.b	$22(a1),$3(a0)
	clr.b	$2F(a1)
	move.b	$2(a0),d6
	tst.b	($FFFF97AE).w
	beq.s	loc_6D4A
	cmp.b	#$8,d6
	bcs.s	loc_6D8A
loc_6D4A:
	lea	$54(a1),a2
	moveq	#$0,d4
loc_6D50:
	tst.b	(a2)
	beq.s	loc_6D74
	addq.l	#$1,d5
	bsr.w	sub_6E70
	cmpi.b	#$3,(a3)
	bne.s	loc_6D68
	bset	#$0,$2F(a1)
	bra.s	loc_6D74
loc_6D68:
	cmpi.b	#$7,(a3)
	bne.s	loc_6D74
	bset	#$1,$2F(a1)
loc_6D74:
	adda.l	#$A,a2
	addq.l	#$1,d4
	cmp.w	#$D,d4
	bne.s	loc_6D50
	lea	$AE(a1),a2
	tst.b	(a2)
	bne.s	loc_6D98
loc_6D8A:
	bsr.w	sub_6E9E
	add.b	d0,$3(a0)
	add.b	d1,$C(a0)
	bra.s	loc_6DE2
loc_6D98:
	bsr.w	sub_6E70
	move.b	$2(a3),$6(a0)
	move.b	$3(a3),$8(a0)
	move.b	$4(a3),$A(a0)
	move.b	$5(a3),$C(a0)
	tst.b	$1(a3)
	bne.s	loc_6DC8
	bsr.w	sub_6E9E
	add.b	d0,$3(a0)
	add.b	d1,$C(a0)
	bra.s	loc_6DD0
loc_6DC8:
	bsr.w	sub_6EBC
	add.b	d0,$3(a0)
loc_6DD0:
	move.b	(a2),d0
	bsr.w	sub_6E80
	add.b	$4(a2),d0
	add.b	d0,$C(a0)
	add.b	d0,$3(a0)
loc_6DE2:
	btst	#$0,$1(a0)
	beq.s	loc_6DF0
	move.b	($FFFFD49A).w,d0
	bra.s	loc_6DF4
loc_6DF0:
	move.b	($FFFFD499).w,d0
loc_6DF4:
	add.b	d0,$3(a0)
	move.b	$25(a1),$4(a0)
	tst.b	($FFFF97AE).w
	beq.s	loc_6E0A
	cmp.b	#$8,d6
	bcs.s	loc_6E32
loc_6E0A:
	lea	$C2(a1),a2
	tst.b	(a2)
	beq.s	loc_6E32
	bsr.w	sub_6E70
	move.b	$1(a3),d0
	subi.b	#$32,d0
	add.b	$4(a2),d0
	add.b	d0,$4(a0)
	moveq	#$18,d0
	cmp.b	(a2),d0
	bne.s	loc_6E32
	ori.b	#$6,$2F(a1)
loc_6E32:
	move.b	$24(a1),d0
	subq.l	#$6,d5
	bmi.s	loc_6E44
	sub.b	d5,d0
	cmp.b	#$3,d0
	bge.s	loc_6E44
	moveq	#$3,d0
loc_6E44:
	move.b	d0,$F(a0)
	btst	#$5,$1(a0)
	beq.s	loc_6E58
	subq.b	#$2,$3(a0)
	subq.b	#$2,$4(a0)
loc_6E58:
	move.b	$4(a0),d0
	subq.l	#$2,d0
	move.b	d0,$5(a0)
	bsr.w	sub_6EBC
	add.b	d1,$4(a0)
	movem.l	(a7)+,d4-d6/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_6E70:
	move.b	(a2),d0
	ext.w	d0
	asl.w	#$3,d0
	lea	(dat_779E).l,a3
	adda.w	d0,a3
	rts

; ---------------------------------------------------------------------------
sub_6E80:
	movem.l	d2-d3/a3,-(a7)
	lea	$4D(a1),a3
	moveq	#$4,d2
	move.b	d0,d3
	moveq	#$0,d0
loc_6E8E:
	cmp.b	(a3)+,d3
	bne.s	loc_6E94
	addq.l	#$1,d0
loc_6E94:
	dbf	d2,loc_6E8E
	movem.l	(a7)+,d2-d3/a3
	rts

; ---------------------------------------------------------------------------
sub_6E9E:
	move.l	a2,-(a7)
	lea	(dat_7741).l,a2
	move.b	$10(a1),d0
	ext.w	d0
	move.b	(a2,d0.w),d1
	move.b	$17(a2,d0.w),d0
	ext.w	d0
	ext.w	d1
	movea.l	(a7)+,a2
	rts

; ---------------------------------------------------------------------------
sub_6EBC:
	move.l	a2,-(a7)
	lea	(dat_776F).l,a2
	move.b	$11(a1),d0
	ext.w	d0
	move.b	(a2,d0.w),d1
	move.b	$17(a2,d0.w),d0
	ext.w	d0
	ext.w	d1
	movea.l	(a7)+,a2
	rts

; ---------------------------------------------------------------------------
sub_6EDA:
	movem.l	a2-a3,-(a7)
	bsr.w	sub_6EEC
	lea	$AE(a2),a0
	movem.l	(a7)+,a2-a3
	rts

; ---------------------------------------------------------------------------
sub_6EEC:
	move.b	($FFFFCA20).w,d0

; ---------------------------------------------------------------------------
sub_6EF0:
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	movea.l	a0,a3
	movea.l	a1,a2
	rts

; ---------------------------------------------------------------------------
sub_6F02:
	move.l	d0,-(a7)
	lea	($FFFFC470).w,a0
	ext.w	d0
	mulu.w	#$1A,d0
	adda.w	d0,a0
	move.l	(a7)+,d0
	rts

; ---------------------------------------------------------------------------
sub_6F14:
	move.l	d0,-(a7)
	lea	($FFFFBA68).w,a1
	ext.w	d0
	mulu.w	#$D6,d0
	adda.w	d0,a1
	move.l	(a7)+,d0
	rts

; ---------------------------------------------------------------------------
sub_6F26:
	movem.l	d2/a2-a3,-(a7)
	move.b	($FFFFCA20).w,d0
	bsr.s	sub_6F02
	move.b	$2(a0),d0
	bsr.s	sub_6F14
	movea.l	a1,a2
	moveq	#$15,d2
	moveq	#$4,d3
	moveq	#$32,d0
	add.b	$16(a2),d0
	bsr.w	sub_A85A
	moveq	#$11,d2
	move.b	$17(a2),d0
	cmp.b	#$5,d0
	bne.s	loc_6F56
	moveq	#$45,d0
	bra.s	loc_6F5A
loc_6F56:
	addi.b	#$33,d0
loc_6F5A:
	bsr.w	sub_A85A
	moveq	#$D,d2
	moveq	#$1F,d0
	add.b	$18(a2),d0
	bsr.w	sub_A85A
	movem.l	(a7)+,d2/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_6F70:
	movem.l	d3-d7/a2,-(a7)
	move.w	#$C000,($FFFFD5AC).w
	move.w	#$2,($FFFFD5AA).w
	moveq	#$4,d7
	move.w	#$B,($FFFFD5D8).w
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	lea	$10(a1),a2
loc_6F9C:
	move.w	#$A,($FFFFD5D6).w
	move.b	(a2)+,d3
	move.b	d3,d0
	jsr	(sub_13322).l
	jsr	(sub_11CA0).l
	addq.w	#$1,($FFFFD5D8).w
	subi.b	#$A,d3
	bhi.s	loc_6FBE
	moveq	#$1,d3
loc_6FBE:
	ext.w	d3
	moveq	#$B,d6
	sub.w	d3,d6
	subq.l	#$1,d6
	bmi.s	loc_6FE2
	move.w	#$2000,($FFFFD5AE).w
	move.w	#$10,($FFFFD5D6).w
	sub.w	d6,($FFFFD5D6).w
loc_6FD8:
	jsr	(sub_11CA0).l
	dbf	d6,loc_6FD8
loc_6FE2:
	asl.w	#$3,d3
	move.l	d3,d4
	moveq	#$6,d0
	move.w	($FFFFD5D8).w,d1
	moveq	#$8,d5
	bsr.w	sub_AAA4
	addq.w	#$2,($FFFFD5D8).w
	dbf	d7,loc_6F9C
	movem.l	(a7)+,d3-d7/a2
	rts

; ---------------------------------------------------------------------------
sub_7000:
	bsr.w	sub_89A2
	bsr.w	sub_700A
	rts

; ---------------------------------------------------------------------------
sub_700A:
	movem.l	a2-a3,-(a7)
	lea	(dat_717A).l,a2
	jsr	(sub_11C28).l
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	movea.l	a0,a3
	move.b	$2(a3),d0
	bsr.w	sub_6F14
	movea.l	a1,a2
	move.l	#$1E0004,($FFFFD5D6).w
	move.w	#$6,($FFFFD5AA).w
	move.b	$19(a2),d0
	jsr	(sub_132DE).l
	move.l	#$1E0006,($FFFFD5D6).w
	move.l	$1E(a2),d0
	jsr	(sub_13306).l
	move.l	#$1E000C,($FFFFD5D6).w
	move.b	$F(a3),d0
	jsr	(sub_132F6).l
	move.l	#$1D000E,($FFFFD5D6).w
	move.b	$3(a3),d0
	subi.b	#$28,d0
	cmp.b	#$1,d0
	bge.s	loc_7082
	moveq	#$1,d0
loc_7082:
	cmp.b	#$14,d0
	ble.s	loc_708A
	moveq	#$14,d0
loc_708A:
	ext.w	d0
	mulu.w	#$5,d0
	jsr	(sub_132F6).l
	move.w	#$2500,($FFFFD5AE).w
	jsr	(sub_11CA0).l
	move.l	#$1E0010,($FFFFD5D6).w
	move.b	$6(a3),d0
	lsr.b	#$1,d0
	jsr	(sub_132F6).l
	move.w	#$12,($FFFFD5D8).w
	moveq	#$0,d0
	move.b	$A(a3),d0
	moveq	#$0,d1
	move.b	$8(a3),d1
	mulu.w	d1,d0
	add.b	$C(a3),d0
	bpl.s	loc_70D2
	moveq	#$0,d0
loc_70D2:
	movem.l	d6-d7,-(a7)
	move.l	d0,d7
	jsr	(sub_13322).l
	jsr	(sub_1368C).l
	lea	($FFFFD5AE).w,a0
	jsr	(sub_11C18).l
	addq.b	#$1,d0
	move.l	d0,-(a7)
	move.b	$8(a3),d0
	add.b	$C(a3),d0
	bpl.s	loc_70FE
	moveq	#$0,d0
loc_70FE:
	move.l	d0,d6
	jsr	(sub_13322).l
	jsr	(sub_1368C).l
	lea	($FFFFD5AE).w,a0
	jsr	(sub_11C18).l
	move.l	(a7)+,d1
	cmp.b	d6,d7
	beq.s	loc_711E
	add.b	d1,d0
loc_711E:
	moveq	#$24,d1
	sub.b	d0,d1
	move.w	d1,($FFFFD5D6).w
	jsr	(sub_11CA0).l
	cmp.b	d6,d7
	beq.s	loc_713C
	move.w	#$2D00,($FFFFD5AE).w
	jsr	(sub_11CA0).l
loc_713C:
	move.l	d7,d0
	move.l	d6,d1
	movem.l	(a7)+,d6-d7
	cmp.b	d0,d1
	beq.s	loc_715A
	jsr	(sub_13322).l
	jsr	(sub_1368C).l
	jsr	(sub_11CA0).l
loc_715A:
	moveq	#$15,d2
	moveq	#$8,d3
	bsr.w	sub_751C
	moveq	#$19,d2
	bsr.w	sub_752E
	moveq	#$1D,d2
	bsr.w	sub_7522
	moveq	#$21,d2
	bsr.w	sub_7528
	movem.l	(a7)+,a2-a3
	rts
dat_717A:
	binclude	"data/00717A.bin"

; ---------------------------------------------------------------------------
sub_7194:
	move.l	d2,-(a7)
	lea	($FFFFC470).w,a0
	moveq	#$0,d0
	moveq	#$7,d2
loc_719E:
	tst.b	(a0)
	beq.s	loc_71A4
	addq.w	#$1,d0
loc_71A4:
	adda.w	#$1A,a0
	dbf	d2,loc_719E
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_71B0:
	move.l	d2,-(a7)
	lea	($FFFFC470).w,a0
	moveq	#$0,d0
	moveq	#$0,d2
loc_71BA:
	move.b	(a0),d1
	beq.s	loc_71C6
	andi.b	#$C0,d1
	bne.s	loc_71C6
	addq.l	#$1,d0
loc_71C6:
	adda.w	#$1A,a0
	addq.l	#$1,d2
	cmp.w	#$8,d2
	bne.s	loc_71BA
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_71D6:
	link	a6,#-$58
	movem.l	d2-d7/a2-a3,-(a7)
	move.b	($FFFFD596).w,-$58(a6)
	moveq	#$0,d4
	moveq	#-$1,d3
	move.l	a0,-$54(a6)
	move.w	d0,-$50(a6)
	bpl.s	loc_71FE
	lea	($FFFFD5AE).w,a0
	lea	-$28(a6),a1
loc_71FA:
	move.b	(a0)+,(a1)+
	bne.s	loc_71FA
loc_71FE:
	moveq	#-$1,d2
	bsr.s	sub_7194
	tst.b	d0
	beq.w	loc_7400
loc_7208:
	bsr.w	sub_C8FC
	tst.b	($FFFFBA58).w
	beq.s	loc_721E
	movea.l	-$54(a6),a0
	bsr.w	sub_7418
	move.b	d0,-$55(a6)
loc_721E:
	lea	($FFFFC470).w,a0
	moveq	#$0,d6
	lea	-$46(a6),a1
	lea	-$4E(a6),a2
	moveq	#$0,d5
loc_722E:
	tst.b	(a0)
	beq.s	loc_725E
	cmp.b	d3,d6
	bne.s	loc_723A
	move.b	d5,($FFFFD593).w
loc_723A:
	move.b	d6,(a2)+
	btst	#$0,d6
	bne.s	loc_7248
	move.b	#$2,(a1)+
	bra.s	loc_724C
loc_7248:
	move.b	#$15,(a1)+
loc_724C:
	move.w	d6,d0
	lsr.w	#$1,d0
	mulu.w	#$5,d0
	addq.l	#$2,d0
	move.b	d0,(a1)+
	move.b	#$7F,(a1)+
	addq.l	#$1,d5
loc_725E:
	adda.w	#$1A,a0
	addq.l	#$1,d6
	cmp.w	#$8,d6
	bcs.s	loc_722E
	move.b	d5,-$57(a6)
	tst.b	($FFFFD599).w
	bne.s	loc_727E
	move.b	#$2,(a1)+
	move.b	#$16,(a1)+
	clr.b	(a1)+
loc_727E:
	st	(a1)
loc_7280:
	move.w	#$1,d0
	bsr.w	sub_8A90
	bsr.w	sub_8A44
	moveq	#$8,d7
	bsr.w	sub_AB5A
	jsr	(sub_13DA2).l
	move.l	-$54(a6),d0
	beq.s	loc_72B2
	lea	-$46(a6),a0
	movea.l	d0,a2
loc_72A4:
	moveq	#$0,d0
	move.b	(a2)+,d0
	bmi.s	loc_72B2
	jsr	(sub_13E56).l
	bra.s	loc_72A4
loc_72B2:
	move.w	#$E000,($FFFFD5AC).w
	st	($FFFFD5E2).w
	move.l	#$19,($FFFFD5D6).w
	tst.b	d4
	beq.s	loc_72D2
	moveq	#$7D,d0
	jsr	(sub_11C8E).l
	bra.s	loc_7302
loc_72D2:
	tst.b	($FFFFBA58).w
	beq.s	loc_72EA
	tst.b	-$55(a6)
	bne.s	loc_72EA
	move.w	#$A6,d0
	jsr	(sub_11C8E).l
	bra.s	loc_7302
loc_72EA:
	move.w	-$50(a6),d0
	bmi.s	loc_72F8
	jsr	(sub_11C8E).l
	bra.s	loc_7302
loc_72F8:
	lea	-$28(a6),a0
	jsr	(sub_11CA4).l
loc_7302:
	lea	-$46(a6),a2
	movea.w	#$0,a3
	tst.b	d4
	bne.s	loc_7312
	moveq	#$50,d0
	bra.s	loc_7314
loc_7312:
	moveq	#$5F,d0
loc_7314:
	move.b	d0,($FFFFD595).w
	move.b	($FFFFD599).w,($FFFFD592).w
	move.b	-$58(a6),($FFFFD596).w
	jsr	(sub_1391A).l
	move.w	d0,d2
	cmp.b	-$57(a6),d2
	bne.w	loc_7336
	moveq	#-$1,d2
loc_7336:
	cmp.w	#$FFFF,d2
	beq.w	loc_7400
	move.w	d2,d0
	bpl.w	loc_73F8
	asr.w	#$8,d0
	cmp.b	#$FF,d0
	bne.s	loc_736E
	moveq	#$0,d4
	ext.w	d2
	move.b	-$4E(a6,d2.w),d0
	move.b	d0,($FFFFCA20).w
	jsr	(sub_13DD6).l
	bsr.w	sub_C8FC
	bsr.w	sub_748C
	move.b	d2,($FFFFD593).w
	bra.w	loc_7280
loc_736E:
	cmp.b	#$FE,d0
	bne.s	loc_7384
	bchg	#$0,d4
	move.b	($FFFFD594).w,($FFFFD593).w
	moveq	#-$1,d3
	bra.w	loc_7208
loc_7384:
	move.b	($FFFFD594).w,d0
	ext.w	d0
	move.b	-$4E(a6,d0.w),d0
	move.b	d0,d3
	btst	#$0,d2
	beq.s	loc_739A
	subq.b	#$2,d3
	bra.s	loc_73A8
loc_739A:
	btst	#$1,d2
	beq.s	loc_73A4
	addq.b	#$2,d3
	bra.s	loc_73A8
loc_73A4:
	bchg	#$0,d3
loc_73A8:
	andi.w	#$7,d3
	move.w	d0,d2
	bsr.w	sub_6F14
	movea.l	a1,a0
	move.b	d3,d0
	bsr.w	sub_6F14
	moveq	#$6A,d0
loc_73BC:
	move.w	(a0),d1
	move.w	(a1),(a0)+
	move.w	d1,(a1)+
	dbf	d0,loc_73BC
	move.w	d2,d0
	bsr.w	sub_6F02
	movea.l	a0,a1
	move.w	d3,d0
	bsr.w	sub_6F02
	moveq	#$C,d0
loc_73D6:
	move.w	(a1),d1
	move.w	(a0),(a1)+
	move.w	d1,(a0)+
	dbf	d0,loc_73D6
	move.b	d2,d0
	bsr.w	sub_6F02
	move.b	d2,$2(a0)
	move.b	d3,d0
	bsr.w	sub_6F02
	move.b	d3,$2(a0)
	bra.w	loc_7208
loc_73F8:
	moveq	#$0,d4
	move.b	-$4E(a6,d2.w),d2
	ext.w	d2
loc_7400:
	jsr	(sub_13DD6).l
	clr.b	($FFFFD599).w
	clr.b	($FFFFD596).w
	move.w	d2,d0
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_7418:
	movem.l	d2-d4/a2-a3,-(a7)
	movea.l	a0,a3
	lea	($FFFFC470).w,a0
	lea	($FFFFBA68).w,a1
	lea	($C16).w,a2
	moveq	#$0,d3
	moveq	#$0,d2
	moveq	#$0,d0
loc_7430:
	move.b	(a0),d1
	cmp.b	#$0,d1
	beq.s	loc_7472
	cmp.b	#$1,d1
	bne.s	loc_746E
	moveq	#$0,d1
	move.b	$18(a1),d1
	asl.w	#$3,d1
	add.b	$19(a1),d1
	subi.w	#$9,d1
	asl.w	#$2,d1
	move.l	$1E(a1),d4
	cmp.l	(a2,d1.w),d4
	bcs.s	loc_746E
	cmp.l	$4(a2,d1.w),d4
	bcs.s	loc_746A
	move.l	$4(a2,d1.w),d4
	subq.l	#$1,d4
	move.l	d4,$1E(a1)
loc_746A:
	moveq	#$1,d2
	bra.s	loc_7470
loc_746E:
	move.b	d3,(a3)+
loc_7470:
	addq.l	#$1,d3
loc_7472:
	adda.w	#$1A,a0
	adda.w	#$D6,a1
	addq.l	#$1,d0
	cmp.w	#$8,d0
	bne.s	loc_7430
	st	(a3)
	move.l	d2,d0
	movem.l	(a7)+,d2-d4/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_748C:
	movem.l	d2/a2-a3,-(a7)
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	bsr.w	sub_6D1E
	bsr.w	sub_7000
	move.b	#$2,($FFFFD593).w
loc_74AE:
	lea	(dat_7508).l,a2
	lea	(dat_7512).l,a3
	st	($FFFFD597).w
	move.l	($FFFFD582).w,-(a7)
	move.l	($FFFFD586).w,-(a7)
	jsr	(sub_138AC).l
	jsr	(sub_1391A).l
	jsr	(sub_138FC).l
	move.l	(a7)+,($FFFFD586).w
	move.l	(a7)+,($FFFFD582).w
	tst.w	d0
	ble.s	loc_74FE
	move.b	d0,($FFFFD593).w
	cmp.b	#$1,d0
	bne.s	loc_74F4
	bsr.w	sub_8034
	bra.s	loc_74AE
loc_74F4:
	bsr.w	sub_C8FC
	bsr.w	sub_78D6
	bra.s	loc_74AE
loc_74FE:
	bsr.w	sub_C8FC
	movem.l	(a7)+,d2/a2-a3
	rts
dat_7508:
	binclude	"data/007508.bin"
dat_7512:
	binclude	"data/007512.bin"

; ---------------------------------------------------------------------------
sub_751C:
	lea	$AE(a2),a0
	bra.s	loc_7532

; ---------------------------------------------------------------------------
sub_7522:
	lea	$B8(a2),a0
	bra.s	loc_7532

; ---------------------------------------------------------------------------
sub_7528:
	lea	$CC(a2),a0
	bra.s	loc_7532

; ---------------------------------------------------------------------------
sub_752E:
	lea	$C2(a2),a0
loc_7532:
	tst.b	($FFFF97AE).w
	beq.s	loc_7542
	move.b	$2(a3),d0
	cmp.b	#$8,d0
	bcs.s	loc_754A
loc_7542:
	tst.b	(a0)
	beq.s	loc_754A
	bsr.w	sub_A850
loc_754A:
	rts

; ---------------------------------------------------------------------------
sub_754C:
	movem.l	d2/a2,-(a7)
	lea	($FFFFD8CA).l,a0
	clr.w	(a0)
	move.w	($FFFFBA64).w,d2
	subq.w	#$1,d2
	bmi.s	loc_7582
	lea	($FFFFC470).w,a2
loc_7564:
	move.b	(a2),d0
	beq.s	loc_757A
	andi.b	#$C0,d0
	bne.s	loc_757A
	move.b	$1(a2),d0
	andi.w	#$1,d0
	addq.b	#$1,(a0,d0.w)
loc_757A:
	adda.w	#$1A,a2
	dbf	d2,loc_7564
loc_7582:
	movem.l	(a7)+,d2/a2
	rts

; ---------------------------------------------------------------------------
sub_7588:
	move.w	#$31,d0
	jsr	(sub_1B900).l
	bsr.w	sub_85D6
	move.b	#$0,($FFFF9BBC).w
	bsr.w	sub_862A
	bsr.w	sub_8A76
	bsr.w	sub_8A60
	moveq	#$0,d5
	bsr.w	sub_A71E
	moveq	#$0,d0
	bsr.w	sub_8A90
	bsr.w	sub_B0DA
	move.w	#$8000,($FFFFD5AC).w
	move.l	($FFFFD5DA).w,($FFFFD5D6).w
	addi.w	#$A,($FFFFD5D8).w
	moveq	#$71,d0
	st	($FFFFD5E2).w
	jsr	(sub_11C8E).l
	clr.w	($FFFFD5D6).w
	addq.w	#$2,($FFFFD5D8).w
	moveq	#$72,d0
	st	($FFFFD5E2).w
	jsr	(sub_11C8E).l
	bsr.w	sub_860E
	jsr	(sub_14246).l
	jmp	($200).w

; ---------------------------------------------------------------------------
sub_75F8:
	moveq	#$3C,d0

; ---------------------------------------------------------------------------
sub_75FA:
	move.b	#$5,($FFFF9BB7).w
	bsr.w	sub_DEC4
	dbf	d0,sub_75FA
	rts

; ---------------------------------------------------------------------------
sub_760A:
	movem.l	a2,-(a7)
	andi.w	#$FF,d0
	tst.b	(a3)
	bmi.w	loc_767E
	moveq	#$0,d1
	move.b	$E(a3),d1
	cmp.w	d1,d0
	bge.s	loc_762A
	sub.b	d0,$E(a3)
	bra.w	loc_767E
loc_762A:
	clr.b	$E(a3)
	sub.w	d1,d0
	bne.s	loc_7638
	move.b	#$4,(a3)
	bra.s	loc_7658
loc_7638:
	cmp.w	#$A,d0
	bcc.s	loc_7648
	move.b	d0,$E(a3)
	move.b	#$3,(a3)
	bra.s	loc_7658
loc_7648:
	cmp.w	#$19,d0
	bcc.s	loc_7654
	move.b	#$7,(a3)
	bra.s	loc_7658
loc_7654:
	move.b	#$2,(a3)
loc_7658:
	bset	#$7,(a3)
	moveq	#$2,d0
	cmp.b	($FFFF9BBC).w,d0
	bne.s	loc_767E
	lea	($FFFFD8CA).l,a0
	move.b	$1(a3),d0
	andi.w	#$1,d0
	subq.b	#$1,(a0,d0.w)
	movea.l	a3,a2
	jsr	(sub_142A8).l
loc_767E:
	movem.l	(a7)+,a2
	rts

; ---------------------------------------------------------------------------
sub_7684:
	move.l	d2,-(a7)
	move.b	(a3),d0
	andi.w	#$F,d0
	beq.s	loc_76B8
	lea	(dat_76BC).l,a0
	moveq	#$0,d2
	move.b	(a0,d0.w),d2
	bmi.s	loc_76B8
	jsr	(sub_136A0).l
	move.w	#$8000,($FFFFD5AC).w
	lea	(a2),a0
	jsr	(sub_11CA4).l
	move.l	d2,d0
	jsr	(sub_11C8E).l
loc_76B8:
	move.l	(a7)+,d2
	rts
dat_76BC:
	dc.b	$FF,$FF,$76,$78,$78,$FF,$79,$7A

; ---------------------------------------------------------------------------
sub_76C4:
	movem.l	d2/d7,-(a7)
	move.w	d0,d2
	moveq	#$7,d7
	lea	($FFFFBA68).w,a2
	lea	($FFFFC470).w,a1
loc_76D4:
	move.b	(a1),d1
	beq.s	loc_76E0
	move.w	d2,d0
	bsr.w	sub_76FA
	bne.s	loc_76F4
loc_76E0:
	adda.w	#$D6,a2
	adda.w	#$1A,a1
	dbf	d7,loc_76D4
	moveq	#$0,d0
	movea.l	d0,a0
	movea.l	d0,a1
	movea.l	d0,a2
loc_76F4:
	movem.l	(a7)+,d2/d7
	rts

; ---------------------------------------------------------------------------
sub_76FA:
	movem.l	d7,-(a7)
	tst.b	($FFFF97AE).w
	beq.s	loc_770C
	cmpa.l	#$FFFFC118,a2
	bcs.s	loc_771E
loc_770C:
	lea	$54(a2),a0
	moveq	#$C,d7
loc_7712:
	cmp.b	(a0),d0
	beq.s	loc_7722
	adda.w	#$A,a0
	dbf	d7,loc_7712
loc_771E:
	moveq	#$0,d0
	bra.s	loc_7724
loc_7722:
	moveq	#$1,d0
loc_7724:
	movem.l	(a7)+,d7
	rts
	binclude	"data/00772A.bin"
dat_7741:
	binclude	"data/007741.bin"
dat_776F:
	binclude	"data/00776F.bin"
dat_779E:
	binclude	"data/00779E.bin"

; ---------------------------------------------------------------------------
sub_78D6:
	link	a6,#-$50
	movem.l	d2-d7/a2-a3,-(a7)
	move.l	a6,($FFFFD59C).w
	move.l	#$7E6E,($FFFFD5A0).l
	clr.b	($FFFFD593).w
	bsr.w	sub_8A44
loc_78F4:
	bsr.w	sub_6EEC
	tst.b	$16(a2)
	bne.s	loc_7906
	lea	(dat_8E0C4).l,a0
	bra.s	loc_790C
loc_7906:
	lea	(dat_8D2D4).l,a0
loc_790C:
	bsr.w	sub_9DD4
	move.l	a0,-$4(a6)
	move.l	#$967E,($FFFFB516).l
	moveq	#$4,d1
	moveq	#$C,d2
	moveq	#$4,d3
	moveq	#$17,d4
	moveq	#$13,d5
	moveq	#$0,d0
	bsr.w	sub_95BE
	bsr.w	sub_7BA6
	moveq	#$45,d0
	lea	-$4A(a6),a0
	lea	(dat_7FEE).l,a1
loc_793E:
	move.b	(a1)+,(a0)+
	dbf	d0,loc_793E
	bsr.w	sub_7BB6
	bsr.w	sub_7FC8
	tst.b	($FFFFBA60).w
	beq.s	loc_7958
	move.b	#$5,-$21(a6)
loc_7958:
	st	-$4C(a6)
loc_795C:
	bsr.w	sub_7BEE
loc_7960:
	jsr	(sub_13DA2).l
	lea	-$4A(a6),a0
	moveq	#$0,d7
	move.b	-$4C(a6),d7
	bpl.s	loc_7978
	bsr.w	sub_7C38
	bra.s	loc_797C
loc_7978:
	bsr.w	sub_7CA0
loc_797C:
	lea	-$4A(a6),a2
	movea.w	#$0,a3
	jsr	(sub_1391A).l
	tst.w	d0
	bmi.w	loc_7B76
	move.w	d0,d2
	move.b	d0,($FFFFD593).w
	cmp.w	#$E,d0
	beq.w	loc_7B76
	moveq	#$0,d0
	move.b	-$4C(a6),d0
	bpl.w	loc_79EE
	cmp.b	#$F,d2
	bcs.s	loc_79D0
	jsr	(sub_13DD6).l
	subi.w	#$F,d2
	move.b	d2,($FFFFCA20).w
	lea	-$4(a6),a0
	bsr.w	sub_9784
	bsr.w	sub_C8FC
	bsr.w	sub_8A44
	bra.w	loc_78F4
loc_79D0:
	move.b	d2,-$4C(a6)
	moveq	#$0,d3
	move.b	d2,d3
	mulu.w	#$3,d3
	move.b	-$48(a6,d3.w),d0
	move.b	d0,($FFFFD59A).w
	move.b	#$4E,-$48(a6,d3.w)
	bra.w	loc_7960
loc_79EE:
	cmp.b	d0,d2
	beq.w	loc_7B6A
	cmp.b	#$D,d2
	bge.s	loc_7A32
	bsr.w	sub_7D7C
	tst.b	$6(a3)
	beq.s	loc_7A0E
	cmp.b	#$9,d2
	bne.s	loc_7A0E
	clr.w	$14(a0)
loc_7A0E:
	movea.l	a2,a0
	move.l	d2,d0
	mulu.w	#$A,d0
	lea	$54(a1,d0.w),a2
	moveq	#$9,d0
loc_7A1C:
	move.b	(a0,d0.w),d1
	move.b	(a2,d0.w),(a0,d0.w)
	move.b	d1,(a2,d0.w)
	dbf	d0,loc_7A1C
	bra.w	loc_7B50
loc_7A32:
	cmp.b	#$D,d2
	bne.w	loc_7AD0
	tst.b	($FFFFBA60).w
	bne.s	loc_7A84
	bsr.w	sub_7D7C
	move.l	d1,d4
	move.b	$8(a2),d2
	cmp.b	#$1,d2
	bls.s	loc_7A58
	bsr.w	sub_7DE6
	beq.w	loc_797C
loc_7A58:
	move.l	d4,d0
	bsr.w	sub_7D7C
	move.b	$8(a2),d0
	sub.b	d2,d0
	move.b	d0,$8(a2)
	bne.s	loc_7A6C
	clr.b	(a2)
loc_7A6C:
	jsr	(sub_13DD6).l
	moveq	#$24,d0
	move.l	#$B4,d1
	moveq	#$7,d2
	bsr.w	sub_A102
	bra.w	loc_7B50
loc_7A84:
	bsr.w	sub_7D7C
	moveq	#$0,d5
	move.w	$6(a2),d5
	lsr.l	#$1,d5
	move.l	d1,d4
	move.b	$8(a2),d2
	cmp.b	#$1,d2
	bls.s	loc_7AA6
	bsr.w	sub_7DE6
	beq.w	loc_797C
	mulu.w	d2,d5
loc_7AA6:
	move.l	d4,d0
	bsr.w	sub_7D7C
	moveq	#$0,d0
	move.w	d5,d0
	add.l	($FFFF9BD0).w,d0
	move.l	d0,($FFFF9BD0).w
	move.b	$8(a2),d0
	sub.b	d2,d0
	move.b	d0,$8(a2)
	bne.w	loc_7AC8
	clr.b	(a2)
loc_7AC8:
	bsr.w	sub_7FC8
	bra.w	loc_7B50
loc_7AD0:
	move.l	d0,d3
	bsr.w	sub_7DB0
	move.l	d3,d0
	move.l	a1,d4
	bsr.w	sub_7D7C
	movea.l	d4,a1
	movea.l	a2,a0
	bsr.w	sub_81E6
	move.b	$8(a2),d0
	cmp.b	#$1,d0
	bhi.s	loc_7AF8
	bsr.w	sub_7E42
	clr.b	(a2)
	bra.s	loc_7B50
loc_7AF8:
	moveq	#$0,d0
	move.b	$8(a2),d0
	tst.b	(a0)
	beq.s	loc_7B16
	move.l	#$FA,d0
	sub.b	$8(a0),d0
	cmp.b	$8(a2),d0
	bcs.s	loc_7B16
	move.b	$8(a2),d0
loc_7B16:
	move.l	a0,d6
	move.l	a2,d5
	move.l	d0,d2
	bsr.w	sub_7DE6
	beq.w	loc_797C
	movea.l	d6,a0
	movea.l	d5,a2
	tst.b	$8(a0)
	bne.s	loc_7B38
	bsr.w	sub_7E42
	move.b	#$0,$8(a0)
loc_7B38:
	move.b	$8(a0),d0
	add.b	d2,d0
	move.b	d0,$8(a0)
	move.b	$8(a2),d0
	sub.b	d2,d0
	move.b	d0,$8(a2)
	bne.s	loc_7B50
	clr.b	(a2)
loc_7B50:
	moveq	#$0,d0
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	bsr.w	sub_6D1E
	bsr.w	sub_7BA6
loc_7B6A:
	clr.b	($FFFFD59A).w
	st	-$4C(a6)
	bra.w	loc_795C
loc_7B76:
	tst.b	-$4C(a6)
	bpl.s	loc_7B6A
	jsr	(sub_13DD6).l
	clr.l	($FFFFD5A0).w
	clr.b	($FFFFD59A).w
	clr.b	($FFFFD593).w
	movea.l	-$4(a6),a0
	bsr.w	sub_978C
	bsr.w	sub_C8FC
	bsr.w	sub_7000
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_7BA6:
	moveq	#$3,d2
	moveq	#$3,d3
	move.b	($FFFFCA20).w,d6
	moveq	#$0,d4
	bsr.w	sub_AB9C
	rts

; ---------------------------------------------------------------------------
sub_7BB6:
	moveq	#$0,d2
	lea	($FFFFC470).w,a3
	lea	-$1D(a6),a0
	move.l	a0,-$50(a6)
loc_7BC4:
	move.b	(a3),d0
	beq.s	loc_7BDC
	btst	#$6,d0
	bne.s	loc_7BDC
	movea.l	-$50(a6),a0
	move.l	d2,d0
	addi.b	#$80,d0
	move.b	d0,$2(a0)
loc_7BDC:
	addq.l	#$3,-$50(a6)
	adda.w	#$1A,a3
	addq.l	#$1,d2
	cmp.w	#$8,d2
	bcs.s	loc_7BC4
	rts

; ---------------------------------------------------------------------------
sub_7BEE:
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	lea	$54(a1),a2
	lea	-$4A(a6),a3
	moveq	#$0,d2
loc_7C08:
	tst.b	($FFFF97AE).w
	beq.s	loc_7C18
	move.b	($FFFFCA20).w,d0
	cmp.b	#$8,d0
	bcs.s	loc_7C20
loc_7C18:
	movea.l	a2,a0
	bsr.w	sub_A7BC
	bne.s	loc_7C24
loc_7C20:
	move.b	#$4E,d0
loc_7C24:
	move.b	d0,$2(a3)
	addq.w	#$3,a3
	adda.w	#$A,a2
	addq.b	#$1,d2
	cmp.b	#$D,d2
	bcs.s	loc_7C08
	rts

; ---------------------------------------------------------------------------
sub_7C38:
	lea	-$4A(a6),a0
	moveq	#$D,d0
	jsr	(sub_13E56).l
	moveq	#$F,d3
loc_7C46:
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$9,d0
	beq.s	loc_7C74
	move.w	d3,d0
	subi.w	#$F,d0
	cmp.b	($FFFFCA20).w,d0
	beq.s	loc_7C74
	move.l	d3,d0
	mulu.w	#$3,d0
	lea	-$4A(a6,d0.w),a0
	move.b	$2(a0),d0
	lea	-$4A(a6),a0
	cmp.b	#$4E,d0
	bne.s	loc_7C7C
loc_7C74:
	move.l	d3,d0
	jsr	(sub_13E56).l
loc_7C7C:
	addq.l	#$1,d3
	cmp.b	#$17,d3
	bcs.s	loc_7C46
	moveq	#$C,d3
loc_7C86:
	move.l	d3,d0
	bsr.w	sub_7D7C
	bne.s	loc_7C9A
	lea	-$4A(a6),a0
	move.l	d3,d0
	jsr	(sub_13E56).l
loc_7C9A:
	dbf	d3,loc_7C86
	rts

; ---------------------------------------------------------------------------
sub_7CA0:
	moveq	#$0,d3
	move.l	d7,d4
loc_7CA4:
	bsr.w	sub_7D2E
	beq.s	loc_7CBA
	move.l	a1,-(a7)
	move.l	d3,d0
	lea	-$4A(a6),a0
	jsr	(sub_13E56).l
	movea.l	(a7)+,a1
loc_7CBA:
	addq.l	#$1,d3
	cmp.b	#$D,d3
	bcs.s	loc_7CA4
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$9,d0
	beq.s	loc_7CEA
	moveq	#$0,d0
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	btst	#$6,$1(a0)
	beq.s	loc_7D04
	move.b	(a0),d0
	andi.b	#$F,d0
	cmp.b	#$1,d0
	bne.s	loc_7D04
loc_7CEA:
	lea	-$4A(a6),a0
	moveq	#$F,d3
loc_7CF0:
	move.l	d3,d0
	jsr	(sub_13E56).l
	addq.l	#$1,d3
	cmp.b	#$17,d3
	bcs.s	loc_7CF0
	bra.w	loc_7D2C
loc_7D04:
	moveq	#$F,d3
loc_7D06:
	movea.l	a2,a0
	move.l	d3,d2
	bsr.w	sub_7DB0
	bmi.s	loc_7D18
	bsr.w	sub_81E6
	bne.w	loc_7D24
loc_7D18:
	lea	-$4A(a6),a0
	move.l	d3,d0
	jsr	(sub_13E56).l
loc_7D24:
	addq.l	#$1,d3
	cmp.b	#$17,d3
	bcs.s	loc_7D06
loc_7D2C:
	rts

; ---------------------------------------------------------------------------
sub_7D2E:
	movem.l	d3-d6,-(a7)
	cmp.b	d3,d4
	beq.w	loc_7D6E
	cmp.b	#$9,d4
	bcc.s	loc_7D46
	exg	d4,d3
	cmp.b	#$9,d4
	bcs.s	loc_7D6E
loc_7D46:
	cmp.b	#$9,d3
	bcc.s	loc_7D6A
	move.l	d3,d0
	bsr.w	sub_7D7C
	beq.s	loc_7D6E
	moveq	#$0,d1
	move.b	d4,d1
	subi.b	#$9,d1
	lea	(dat_7D78).l,a0
	move.b	(a0,d1.w),d0
	cmp.b	(a3),d0
	beq.s	loc_7D6E
loc_7D6A:
	moveq	#$1,d0
	bra.s	loc_7D70
loc_7D6E:
	moveq	#$0,d0
loc_7D70:
	movem.l	(a7)+,d3-d6
	tst.b	d0
	rts
dat_7D78:
	dc.b	$00,$03,$01,$07

; ---------------------------------------------------------------------------
sub_7D7C:
	move.l	d0,d1
	moveq	#$0,d0
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	move.l	d1,d0
	mulu.w	#$A,d0
	lea	$54(a1,d0.w),a2
	tst.b	(a2)
	beq.s	loc_7DAC
	tst.b	($FFFF97AE).w
	bne.s	loc_7DAC
	bsr.w	sub_6E70
	tst.b	(a2)
	rts
loc_7DAC:
	moveq	#$0,d0
	rts

; ---------------------------------------------------------------------------
sub_7DB0:
	move.l	a0,-(a7)
	moveq	#$0,d0
	move.w	d2,d0
	subi.w	#$F,d0
	bsr.w	sub_6F02
	move.b	(a0),d1
	beq.s	loc_7DDE
	btst	#$6,d1
	bne.s	loc_7DDE
	move.w	d0,d1
	mulu.w	#$D6,d1
	lea	($FFFFBA68).w,a1
	adda.l	d1,a1
	cmp.b	($FFFFCA20).w,d0
	beq.s	loc_7DDE
	moveq	#$0,d1
	bra.s	loc_7DE0
loc_7DDE:
	moveq	#-$1,d1
loc_7DE0:
	movea.l	(a7)+,a0
	tst.b	d1
	rts

; ---------------------------------------------------------------------------
sub_7DE6:
	bsr.w	sub_7E0C
	move.w	#$8B,d0
	jsr	(sub_11C8E).l
	move.l	#$200017,($FFFFD5D6).w
	jsr	(sub_134B0).l
	move.l	d0,d2
	bsr.w	sub_7E20
	tst.l	d2
	rts

; ---------------------------------------------------------------------------
sub_7E0C:
	moveq	#$7,d0
	bsr.w	sub_8A90
	bsr.w	sub_7E2A
	move.l	#$E0017,($FFFFD5D6).w
	rts

; ---------------------------------------------------------------------------
sub_7E20:
	bsr.w	sub_7E2A
	bsr.w	sub_7FC8
	rts

; ---------------------------------------------------------------------------
sub_7E2A:
	move.l	#$D0016,($FFFFD582).w
	move.l	#$210018,($FFFFD586).w
	jsr	(sub_1344A).l
	rts

; ---------------------------------------------------------------------------
sub_7E42:
	moveq	#$9,d0
loc_7E44:
	move.b	(a2,d0.w),(a0,d0.w)
	dbf	d0,loc_7E44
	movem.l	d0-d1/a0-a1,-(a7)
	moveq	#$0,d0
	move.b	($FFFFD593).w,d0
	subi.w	#$F,d0
	jsr	($6F14).w
	jsr	($6F02).w
	jsr	($6D1E).w
	movem.l	(a7)+,d0-d1/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_7E6E:
	movem.l	d2/a2-a3,-(a7)
	lea	(sub_7FC0).l,a0
	jsr	(sub_1344E).l
	clr.b	($FFFFD5AE).w
	moveq	#$0,d0
	move.w	d2,d0
	mulu.w	#$3,d0
	lea	-$4A(a6,d0.w),a0
	move.b	$2(a0),d0
	cmp.b	#$4E,d0
	beq.w	loc_7FBA
	cmp.b	#$D,d2
	bge.w	loc_7F26
	cmp.b	#$9,d2
	blt.s	loc_7EB2
	move.w	#$99,d0
	jsr	(sub_11BDC).l
loc_7EB2:
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	move.w	d2,d0
	mulu.w	#$A,d0
	lea	$54(a1,d0.w),a2
	move.b	$8(a2),d0
	beq.s	loc_7EE4
	move.w	#$3,($FFFFD5AA).w
	jsr	(sub_13376).l
	jsr	(sub_1368C).l
loc_7EE4:
	if DEUTSCH	; DEUTSCH-HOOK 6: Gegenstandsname (Inventar) ueber Namenstabelle (66 Byte wie Original)
	movea.l	a2,a0
	move.b	$8(a2),d1
	jsr	(DE_Gegenstandsname).l
	bra.w	loc_7FA6
	dc.w	$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71
	else
	moveq	#$2,d2
loc_7EE6:
	moveq	#$0,d0
	move.b	$1(a2,d2.w),d0
	beq.s	loc_7EF4
	jsr	(sub_11BDC).l
loc_7EF4:
	dbf	d2,loc_7EE6
	move.b	$8(a2),d0
	cmp.b	#$2,d0
	bcs.w	loc_7FA6
	lea	($FFFFD5AE).w,a0
	jsr	(sub_11C18).l
	move.b	#$73,d1
	cmp.b	-$1(a0,d0.w),d1
	beq.w	loc_7FA6
	move.b	d1,(a0,d0.w)
	clr.b	$1(a0,d0.w)
	bra.w	loc_7FA6
	endif
loc_7F26:
	bne.s	loc_7F74
	move.w	#$A0,d0
	tst.b	($FFFFBA60).w
	beq.s	loc_7F6A
	move.w	#$A1,d0
	tst.b	($FFFFD59A).w
	beq.s	loc_7F6A
	moveq	#$0,d0
	move.b	-$4C(a6),d0
	bsr.w	sub_7D7C
	moveq	#$0,d0
	move.w	$6(a2),d0
	lsr.w	#$1,d0
	jsr	(sub_13268).l
	move.w	#$B3,d0
	jsr	(sub_11B9A).l
	tst.b	$8(a2)
	beq.w	loc_7FA6
	move.w	#$B2,d0
loc_7F6A:
	jsr	(sub_11BDC).l
	bra.w	loc_7FA6
loc_7F74:
	cmp.b	#$E,d2
	bne.s	loc_7F88
	move.w	#$4F,d0
	jsr	(sub_11BDC).l
	bra.w	loc_7FA6
loc_7F88:
	move.w	#$B4,d0
	tst.b	($FFFFD59A).w
	bne.s	loc_7F96
	move.w	#$E4,d0
loc_7F96:
	jsr	(sub_11BDC).l
	bsr.w	sub_7DB0
	jsr	(sub_11BF2).l
loc_7FA6:
	move.w	#$C000,($FFFFD5AC).w
	move.l	#$120019,($FFFFD5D6).w
	jsr	(sub_11C4C).l
loc_7FBA:
	movem.l	(a7)+,d2/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_7FC0:
	ori.b	#$19,d2
	ori.b	#$19,-(a2)

; ---------------------------------------------------------------------------
sub_7FC8:
	moveq	#$7,d0
	bsr.w	sub_8A90
	move.w	#$C000,($FFFFD5AC).w
	move.l	($FFFF9BD0).w,d0
	jsr	(sub_13268).l
	move.l	#$170017,($FFFFD5D6).w
	jsr	(sub_11C4C).l
	rts
dat_7FEE:
	binclude	"data/007FEE.bin"

; ---------------------------------------------------------------------------
sub_8034:
	link	a6,#-$70
	movem.l	d2-d5/a2-a3,-(a7)
	bsr.w	sub_85D6
	bsr.w	sub_8A44
	move.w	#$F000,($FFFFB436).w
	moveq	#$A,d0
	bsr.w	sub_8A90
	lea	(dat_9E6AC).l,a0
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB54E).w
	lea	(dat_EC100).l,a0
	bsr.w	sub_9DD4
	move.l	a0,-$4(a6)
	move.l	#$967E,($FFFFB516).l
	moveq	#$2,d1
	moveq	#$2,d2
	moveq	#$2,d3
	moveq	#$24,d4
	moveq	#$17,d5
	moveq	#$0,d0
	bsr.w	sub_95BE
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	move.l	a1,-$8(a6)
	movem.l	a4-a5,-(a7)
	move.l	#$21A251A,-$54(a6)
	lea	$31(a1),a1
	lea	-$34(a6),a0
	lea	-$50(a6),a2
	lea	-$70(a6),a3
	lea	(dat_8174).l,a4
	moveq	#$0,d0
loc_80BE:
	moveq	#$0,d1
	move.b	(a1)+,d1
	beq.s	loc_80E0
	cmp.w	#$C,d1
	bls.s	loc_80CC
	moveq	#$C,d1
loc_80CC:
	move.b	(a4)+,(a0)+
	move.b	(a4)+,(a0)+
	moveq	#$20,d2
	add.w	d0,d2
	move.b	d2,(a0)+
	moveq	#$54,d2
	add.w	d0,d2
	move.w	d2,(a2)+
	move.b	d0,(a3)+
	move.b	d1,(a3)+
loc_80E0:
	addq.w	#$1,d0
	cmp.b	#$E,d0
	bne.s	loc_80BE
	movea.l	-$8(a6),a1
	moveq	#$5,d1
	lea	(dat_8194).l,a5
loc_80F4:
	move.b	$3(a5),d0
	bsr.w	sub_6E80
	tst.b	d0
	beq.s	loc_8110
	move.b	(a4)+,(a0)+
	move.b	(a4)+,(a0)+
	move.b	$2(a5),(a0)+
	move.w	(a5),(a2)+
	move.b	#$0,(a3)+
	move.b	d0,(a3)+
loc_8110:
	addq.l	#$4,a5
	dbf	d1,loc_80F4
	move.b	#$FF,(a0)
	movem.l	(a7)+,a4-a5
	lea	-$34(a6),a2
	lea	-$70(a6),a3
	bsr.w	sub_A9EA
	bsr.w	sub_860E
	lea	-$34(a6),a2
	lea	-$54(a6),a3
	clr.b	($FFFFD593).w
	jsr	(sub_1391A).l
	movea.l	-$4(a6),a0
	bsr.w	sub_978C
	lea	($FFFFB54E).w,a0
	bsr.w	sub_9784
	bsr.w	sub_85D6
	jsr	(sub_C8FC).l
	jsr	(sub_1344A).l
	bsr.w	sub_B0DA
	bsr.w	sub_7000
	bsr.w	sub_860E
	movem.l	(a7)+,d2-d5/a2-a3
	unlk	a6
	rts
dat_8174:
	binclude	"data/008174.bin"
dat_8194:
	binclude	"data/008194.bin"

; ---------------------------------------------------------------------------
sub_81AC:
	movem.l	d2-d3,-(a7)
	lea	($FFFF97BC).w,a0
	add.b	d0,(a0,d1.w)
	lea	(dat_81DE).l,a1
	moveq	#$6,d3
loc_81C0:
	move.b	(a0),d2
	cmp.b	(a1),d2
	bcs.s	loc_81D0
	sub.b	(a1),d2
	move.b	d2,(a0)
	addq.b	#$1,$1(a0)
	bra.s	loc_81C0
loc_81D0:
	addq.l	#$1,a0
	addq.l	#$1,a1
	dbf	d3,loc_81C0
	movem.l	(a7)+,d2-d3
	rts
dat_81DE:
	dc.b	$0A,$0A,$06,$18,$1E,$0C,$FA,$00

; ---------------------------------------------------------------------------
sub_81E6:
	movem.l	d5-d6/a2-a3,-(a7)
	movea.l	a0,a2
	tst.b	$8(a2)
	beq.s	loc_8224
	moveq	#$0,d0
	move.b	(a2),d6
	move.b	$4(a2),d5
	lea	$54(a1),a0
loc_81FE:
	cmp.b	(a0),d6
	bne.s	loc_8218
	cmp.b	$4(a0),d5
	bne.s	loc_8218
	move.b	$8(a0),d1
	cmp.b	#$FA,d1
	bcs.w	loc_8270
	bra.w	loc_826A
loc_8218:
	adda.w	#$A,a0
	addq.l	#$1,d0
	cmp.b	#$D,d0
	bne.s	loc_81FE
loc_8224:
	bsr.w	sub_6E70
	move.b	(a3),d0
	lea	$CC(a1),a0
	cmp.b	#$7,d0
	beq.s	loc_824E
	lea	$B8(a1),a0
	cmp.b	#$3,d0
	bhi.s	loc_8254
	beq.s	loc_824E
	lea	$C2(a1),a0
	cmp.b	#$1,d0
	beq.s	loc_824E
	lea	$AE(a1),a0
loc_824E:
	tst.b	(a0)
	beq.w	loc_8270
loc_8254:
	moveq	#$0,d0
	lea	$54(a1),a0
loc_825A:
	tst.b	(a0)
	beq.s	loc_8270
	adda.w	#$A,a0
	addq.l	#$1,d0
	cmp.b	#$9,d0
	bne.s	loc_825A
loc_826A:
	movea.l	#$0,a0
loc_8270:
	movem.l	(a7)+,d5-d6/a2-a3
	move.l	a0,d0
	rts

; ---------------------------------------------------------------------------
sub_8278:
	andi.w	#$7F,d0
	ori.w	#$C000,d0
	move.w	d0,(a4)
	move.w	#$0,(a4)
	rts

; ---------------------------------------------------------------------------
sub_8288:
	move.w	d0,d1
	andi.w	#$3FFF,d1
	ori.w	#$4000,d1
	move.w	d1,(a4)
	lsr.w	#$8,d0
	lsr.w	#$6,d0
	move.w	d0,(a4)
	rts

; ---------------------------------------------------------------------------
sub_829C:
	move.w	d0,d1
	andi.w	#$3FFF,d1
	move.w	d1,(a4)
	lsr.w	#$8,d0
	lsr.w	#$6,d0
	move.w	d0,(a4)
	rts

; ---------------------------------------------------------------------------
sub_82AC:
	move.b	($FFFF9BBC).w,d1
	cmp.b	#$6,d1
	bne.s	loc_82BA
	moveq	#$7,d0
	bra.s	loc_82E6
loc_82BA:
	cmp.b	#$10,d1
	bne.s	loc_82C4
	moveq	#$9,d0
	bra.s	loc_82E6
loc_82C4:
	move.b	($FFFF97DC).w,d0
	cmp.b	#$A2,d0
	bne.s	loc_82D2
	moveq	#$1,d0
	bra.s	loc_82DE
loc_82D2:
	cmp.b	#$A8,d0
	bne.s	loc_82DC
	moveq	#$2,d0
	bra.s	loc_82DE
loc_82DC:
	moveq	#$3,d0
loc_82DE:
	cmp.b	#$2,d1
	bne.s	loc_82E6
	addq.w	#$3,d0
loc_82E6:
	move.w	d0,($FFFFB52A).w
	rts

; ---------------------------------------------------------------------------
sub_82EC:
	move.b	($FFFFB9F0).w,d0
	lea	(dat_8336).l,a0
loc_82F6:
	move.b	(a0)+,d1
	bmi.s	loc_8306
	cmp.b	d1,d0
	beq.s	loc_8302
	addq.l	#$1,a0
	bra.s	loc_82F6
loc_8302:
	move.b	(a0),d0
	bra.s	loc_832A
loc_8306:
	lea	(dat_8330).l,a0
	cmp.b	#$63,d0
	bne.s	loc_8318
	lea	(dat_8359).l,a0
loc_8318:
	move.b	($FFFF979B).w,d1
	ext.w	d1
	cmp.w	#$5,d1
	bls.s	loc_8326
	moveq	#$5,d1
loc_8326:
	move.b	(a0,d1.w),d0
loc_832A:
	move.b	d0,($FFFFB525).w
	rts
dat_8330:
	dc.b	$5C,$46,$47,$48,$49,$4A
dat_8336:
	binclude	"data/008336.bin"
dat_8359:
	dc.b	$5C,$59,$58,$5A,$57,$4A,$00

; ---------------------------------------------------------------------------
sub_8360:
	link	a6,#-$4
	movem.l	d2-d4/a2,-(a7)
	tst.b	($FFFFB525).w
	bpl.s	loc_8372
	bsr.w	sub_82EC
loc_8372:
	lea	($FFFFB552).w,a0
	bsr.w	sub_9784
	move.w	($FFFFB52A).w,d3
	move.b	($FFFF9BBE).w,d0
	cmp.b	($FFFFBA5F).w,d0
	bne.s	loc_8390
	cmp.w	($FFFFB530).w,d3
	beq.w	loc_8516
loc_8390:
	move.b	($FFFF9BBE).w,($FFFFBA5F).w
	tst.w	($FFFFB530).w
	beq.s	loc_83C4
	lea	(dat_83AE).l,a2
loc_83A2:
	move.w	(a2)+,d0
	beq.s	loc_83C4
	movea.w	d0,a0
	bsr.w	sub_9784
	bra.s	loc_83A2
dat_83AE:
	binclude	"data/0083AE.bin"
loc_83C4:
	move.w	d3,($FFFFB530).w
	asl.w	#$1,d3
	lea	(jt_83D8).l,a0
	move.w	(a0,d3.w),d0
	jmp	(a0,d0.w)
jt_83D8:
	dc.w	loc_8516-jt_83D8
	dc.w	loc_83F4-jt_83D8
	dc.w	loc_8400-jt_83D8
	dc.w	loc_8496-jt_83D8
	dc.w	loc_84BC-jt_83D8
	dc.w	loc_84DA-jt_83D8
	dc.w	loc_84F8-jt_83D8
	dc.w	loc_83EC-jt_83D8
	dc.w	loc_850E-jt_83D8
	dc.w	loc_8516-jt_83D8
loc_83EC:
	lea	(dat_EA350).l,a0
	bra.s	loc_840A
loc_83F4:
	lea	($2F9A).w,a1
	lea	(dat_EF2EA).l,a0
	bra.s	loc_840A
loc_8400:
	lea	($2FC6).w,a1
	lea	(dat_9CF13).l,a0
loc_840A:
	move.l	a1,($FFFFB556).w
	bsr.w	sub_9DD4
	move.l	$2(a0),$8(a0)
	move.l	a0,($FFFFB55A).w
	movem.l	d2-d5,-(a7)
	moveq	#$0,d0
	moveq	#$11,d1
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$40,d4
	moveq	#$40,d5
	movea.l	($FFFFB55A).w,a0
	move.w	#$7FFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	clr.w	($FFFFB514).w
	bsr.w	sub_95BE
	movem.l	(a7)+,d2-d5
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$1,d0
	bne.s	loc_8462
	lea	(dat_5198A).l,a0
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB562).w
loc_8462:
	st	($FFFF9AFB).w
	st	($FFFFB524).w
	bsr.w	sub_82EC
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$6,d0
	bne.s	loc_848E
	lea	(dat_EA76B).l,a0
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB55E).w
	if DEUTSCH	; DEUTSCH-HOOK 19: Grafik G7 aus DE_Grafik_G7 (Raumkampf WEAP/CNTL/ENGN/HULL, 6 Byte wie Original)
	lea	(DE_Grafik_G7).l,a0
	else
	lea	(dat_E8BF4).l,a0
	endif
	bra.s	loc_84A2
loc_848E:
	lea	(dat_F0F3F).l,a0
	bra.s	loc_84A2
loc_8496:
	jsr	(sub_15268).l
	lea	(dat_918A8).l,a0
loc_84A2:
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB53E).w
	lea	(dat_EBE89).l,a0
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB542).w
	bra.w	loc_8516
loc_84BC:
	lea	(dat_6B888).l,a0
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB536).w
	lea	(dat_ECFCE).l,a0
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB53A).w
	bra.s	loc_8516
loc_84DA:
	lea	(dat_6B888).l,a0
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB536).w
	lea	(dat_9B47A).l,a0
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB53A).w
	bra.s	loc_8516
loc_84F8:
	lea	(dat_6B888).l,a0
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB536).w
	jsr	(sub_15436).l
	bra.s	loc_8516
loc_850E:
	lea	(dat_918A8).l,a0
	bra.s	loc_84A2
loc_8516:
	move.b	($FFFFB525).w,d3
	move.b	d3,($FFFFB524).w
	cmp.w	#$70,d3
	bcc.s	loc_8556
	move.w	($FFFFB530).w,d0
	beq.s	loc_855A
	cmp.w	#$4,d0
	bcs.s	loc_8536
	cmp.w	#$6,d0
	bls.s	loc_855A
loc_8536:
	clr.b	($FFFFB4D0).w
	bsr.w	sub_8562
	bsr.w	sub_C7F6
	move.w	($FFFFB530).w,d0
	cmp.w	#$7,d0
	bne.s	loc_8550
	bsr.w	sub_E208
loc_8550:
	bsr.w	sub_B7B4
	bra.s	loc_855A
loc_8556:
	bsr.w	sub_B766
loc_855A:
	movem.l	(a7)+,d2-d4/a2
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_8562:
	movem.l	d2-d5,-(a7)
	move.l	($FFFFB542).w,d0
	beq.s	loc_858E
	movea.l	d0,a0
	move.w	#$FFFF,($FFFFB510).w
	move.w	#$8000,($FFFFB512).w
	clr.w	($FFFFB50E).w
	moveq	#$4,d1
	moveq	#$16,d2
	moveq	#$0,d3
	moveq	#$11,d4
	moveq	#$14,d5
	moveq	#$0,d0
	bsr.w	sub_95BE
loc_858E:
	movem.l	(a7)+,d2-d5
	rts

; ---------------------------------------------------------------------------
sub_8594:
	movem.l	d2-d5,-(a7)
	bsr.w	sub_9222
	moveq	#$0,d2
	moveq	#$0,d3
	move.w	#$13F,d4
	move.w	#$DF,d5
	bsr.w	sub_92FC
	move.l	a0,($FFFFB42E).w
	movem.l	(a7)+,d2-d5
	rts

; ---------------------------------------------------------------------------
sub_85B6:
	movem.l	d6-d7,-(a7)
	move.w	#$F,($FFFFB434).w
	move.w	#$8000,d6
	moveq	#$0,d7
	clr.w	($FFFFB432).w
	bsr.s	sub_8594
	bsr.w	sub_91C8
	movem.l	(a7)+,d6-d7
	rts

; ---------------------------------------------------------------------------
sub_85D6:
	bsr.w	sub_91A6

; ---------------------------------------------------------------------------
sub_85DA:
	bclr	#$0,($FFFFB433).w
	movem.l	d6-d7,-(a7)
	move.w	#$8000,d6
	moveq	#$0,d7
	bsr.s	sub_8594
	bsr.w	sub_91C8
	movem.l	(a7)+,d6-d7

; ---------------------------------------------------------------------------
sub_85F4:
	move.w	#$8124,(a4)
	move.b	($FFFFBA5E).w,d0
	beq.s	loc_8606
	move.b	d0,($FFFF9BBC).w
	clr.b	($FFFFBA5E).w
loc_8606:
	rts

; ---------------------------------------------------------------------------
sub_8608:
	move.w	#$8164,(a4)
	rts

; ---------------------------------------------------------------------------
sub_860E:
	bsr.s	sub_8608
	bset	#$0,($FFFFB433).w
	tst.l	($FFFFB42E).w
	beq.s	loc_8624
	bsr.w	sub_91C8
	clr.l	($FFFFB42E).w
loc_8624:
	bsr.w	sub_9222
	rts

; ---------------------------------------------------------------------------
sub_862A:
	move.w	#$9114,(a4)
	move.w	#$921C,(a4)
	clr.b	($FFFFBA5D).w
	move.l	#$20002,($FFFFD5DA).w
	move.l	#$250018,($FFFFD5DE).w
	move.l	#$20019,($FFFFD582).w
	move.l	#$250019,($FFFFD586).w
	clr.l	($FFFFD5D6).w
	move.w	#$F000,($FFFFD5A8).w
	clr.l	($FFFFB410).w
	clr.l	($FFFFB414).w
	clr.l	($FFFFB404).w
	clr.l	($FFFFB408).w
	moveq	#$0,d0
	moveq	#$0,d1
	clr.b	($FFFFB4BF).w
	bsr.w	loc_96A6
	move.w	#$F000,($FFFFB436).w
	move.l	#$190002,($FFFFB566).w
	bsr.w	sub_96D8
	clr.l	($FFFFD58A).w
	rts

; ---------------------------------------------------------------------------
sub_8694:
	movem.l	d2/d5,-(a7)
	bsr.w	sub_C77E
	move.b	($FFFF9BBC).w,d2
	cmp.b	#$8,d2
	bne.s	loc_86AC
	moveq	#$C,d2
	add.w	d2,d0
	add.w	d2,d1
loc_86AC:
	clr.b	($FFFFB4C1).w
	movem.w	d0-d1,($FFFFB3EC).w
	movem.w	d0-d1,($FFFFB3F0).w
	subi.w	#$58,d0
	bpl.s	loc_86C4
	moveq	#$0,d0
loc_86C4:
	move.w	($FFFFB400).w,d2
	sub.w	($FFFFB3FC).w,d2
	cmp.w	d2,d0
	bls.s	loc_86D2
	move.w	d2,d0
loc_86D2:
	subi.w	#$54,d1
	bpl.s	loc_86DA
	moveq	#$0,d1
loc_86DA:
	move.w	($FFFFB402).w,d2
	sub.w	($FFFFB3FE).w,d2
	cmp.w	d2,d1
	bls.s	loc_86E8
	move.w	d2,d1
loc_86E8:
	movem.w	d0-d1,($FFFFB414).w
	move.b	($FFFF9BBC).w,d2
	cmp.b	#$8,d2
	bne.s	loc_8706
	moveq	#-$8,d5
	and.w	d5,d0
	and.w	d5,d1
	movem.w	d0-d1,($FFFFB408).w
	bra.s	loc_870A
loc_8706:
	clr.l	($FFFFB408).w
loc_870A:
	movem.l	(a7)+,d2/d5
	rts

; ---------------------------------------------------------------------------
sub_8710:
	movem.l	d5/d7,-(a7)
	bsr.w	sub_85D6
	bsr.w	sub_862A
	bsr.w	sub_82AC
	move.w	#$F000,($FFFFB436).w
	moveq	#$3,d0
	bsr.w	sub_8A90
	move.w	#$918B,(a4)
	move.w	#$9294,(a4)
	move.l	#$20015,($FFFFD5DA).w
	move.l	#$250018,($FFFFD5DE).w
	move.l	#$20019,($FFFFD582).w
	move.l	#$250019,($FFFFD586).w
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$1,d0
	bne.s	loc_8768
	move.l	#$2000200,($FFFFB400).w
	bra.s	loc_8782
loc_8768:
	move.l	#$7B00330,($FFFFB400).w
	st	($FFFFBA5D).w
	andi.b	#$3,($FFFF9AFA).w
	bsr.w	sub_4210
	bsr.w	sub_4228
loc_8782:
	move.l	#$B000A8,($FFFFB3FC).w
	move.l	#$0,($FFFFB3F8).w
	bsr.w	sub_8694
	move.b	($FFFFB525).w,d0
	cmp.b	#$70,d0
	bcs.s	loc_87A4
	bsr.w	sub_82EC
loc_87A4:
	bsr.w	sub_8360
	bsr.w	sub_CCB6
	moveq	#$1,d5
	bsr.w	sub_A71E
	move.b	($FFFF9AFB).w,d0
	bmi.s	loc_87BC
	bsr.w	sub_976C
loc_87BC:
	moveq	#$1,d7
	bsr.w	sub_FEA8
	bsr.w	sub_860E
	bsr.w	sub_C002
	movem.l	(a7)+,d5/d7
	rts

; ---------------------------------------------------------------------------
sub_87D0:
	movem.l	d5/d7,-(a7)
	bsr.w	sub_85D6
	bsr.w	sub_862A
	move.w	#$F000,($FFFFB436).w
	moveq	#$3,d0
	bsr.w	sub_8A90
	move.w	#$918B,(a4)
	move.w	#$9294,(a4)
	move.l	#$20015,($FFFFD5DA).w
	move.l	#$250019,($FFFFD5DE).w
	move.l	#$20019,($FFFFD582).w
	move.l	#$250019,($FFFFD586).w
	move.l	#$2000200,($FFFFB400).w
	move.l	#$B000A0,($FFFFB3FC).w
	move.l	#$0,($FFFFB3F8).w
	clr.b	($FFFF979B).w
	bsr.w	sub_8694
	tst.b	($FFFFB525).w
	bpl.s	loc_883A
	bsr.w	sub_82EC
loc_883A:
	move.w	#$7,($FFFFB52A).w
	bsr.w	sub_8360
	moveq	#$1,d5
	bsr.w	sub_A71E
	moveq	#$1,d7
	bsr.w	sub_FEA8
	bsr.w	sub_E19C
	bsr.w	sub_C7F6
	bsr.w	sub_860E
	bsr.w	sub_B846
	lea	($FFFFBA42).w,a0
	moveq	#$1,d0
	move.w	d0,(a0)+
	move.w	d0,(a0)+
	move.w	d0,(a0)+
	move.w	d0,(a0)+
	movem.l	(a7)+,d5/d7
	rts

; ---------------------------------------------------------------------------
sub_8874:
	move.w	#$F000,($FFFFB436).w
	moveq	#$1,d0
	bsr.w	sub_8A90
	rts

; ---------------------------------------------------------------------------
sub_8882:
	bsr.w	sub_85D6
	bsr.w	sub_862A
	moveq	#$0,d5
	bsr.w	sub_A71E
	move.l	#$20012,($FFFFD5DA).w
	move.l	#$250018,($FFFFD5DE).w
	move.l	#$20019,($FFFFD582).w
	move.l	#$250019,($FFFFD586).w
	moveq	#$4,d0
	bsr.w	sub_8A90
	bsr.w	sub_8A76
	bsr.w	sub_8360
	bsr.w	sub_860E
	rts

; ---------------------------------------------------------------------------
sub_88C4:
	movem.l	d2-d7/a2,-(a7)
	bsr.w	sub_85F4
	moveq	#$2,d7
	move.w	#$8000,d6
	bsr.w	sub_8594
	bsr.w	sub_862A
	move.l	#$1,($FFFFD5DA).w
	move.l	#$27001B,($FFFFD5DE).w
	moveq	#$0,d5
	bsr.w	sub_A71E
	bsr.w	sub_8A76
	bsr.w	sub_8A60
	lea	(dat_6494C).l,a0
	st	($FFFFB4BD).w
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB54A).w
	moveq	#$0,d0
	moveq	#$4,d1
	moveq	#$2,d2
	moveq	#$2,d3
	moveq	#$24,d4
	moveq	#$10,d5
	move.w	#$FFFF,($FFFFB510).w
	move.w	#$8000,($FFFFB512).w
	clr.w	($FFFFB50E).w
	bsr.w	sub_95BE
	lea	(dat_8962).l,a2
	moveq	#$5,d2
	move.l	#$12,($FFFFD5D6).w
	move.w	#$C000,($FFFFD5AC).w
loc_8940:
	move.w	(a2)+,d0
	st	($FFFFD5E2).w
	clr.w	($FFFFD5D6).w
	addq.w	#$1,($FFFFD5D8).w
	jsr	(sub_11C8E).l
	dbf	d2,loc_8940
	bsr.w	sub_860E
	movem.l	(a7)+,d2-d7/a2
	rts
dat_8962:
	binclude	"data/008962.bin"

; ---------------------------------------------------------------------------
sub_896E:
	movem.l	d2-d4/a2,-(a7)
	bsr.w	sub_89A2
	move.w	#$E000,($FFFFD5AC).w
	lea	(dat_8994).l,a2
	jsr	(sub_11C28).l
	moveq	#$5,d0
	bsr.w	sub_8A90
	movem.l	(a7)+,d2-d4/a2
	rts
dat_8994:
	binclude	"data/008994.bin"

; ---------------------------------------------------------------------------
sub_89A2:
	movem.l	d2-d4/d6/a2-a3,-(a7)
	bsr.w	sub_862A
	moveq	#$1,d0
	bsr.w	sub_8A90
	bsr.w	sub_8A44
	lea	(dat_8A2B).l,a2
	bsr.w	sub_A9B8
	bsr.w	sub_6F26
	moveq	#$3,d2
	moveq	#$3,d3
	moveq	#$0,d4
	move.b	($FFFFCA20).w,d6
	bsr.w	sub_AB9C
	move.w	#$C000,($FFFFD5AC).w
	move.w	#$F000,($FFFFD5A8).w
	lea	(dat_8A16).l,a2
	jsr	(sub_11C28).l
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	move.l	#$30007,($FFFFD5D6).w
	move.b	(a0),d0
	andi.w	#$F,d0
	subq.w	#$2,d0
	bmi.s	loc_8A0C
	addi.w	#$A9,d0
	jsr	(sub_11C8E).l
loc_8A0C:
	bsr.w	sub_6F70
	movem.l	(a7)+,d2-d4/d6/a2-a3
	rts
dat_8A16:
	binclude	"data/008A16.bin"
dat_8A2B:
	binclude	"data/008A2B.bin"

; ---------------------------------------------------------------------------
sub_8A44:
	moveq	#$20,d1
	movem.l	d2-d5,-(a7)
	clr.w	($FFFFB514).w
	moveq	#$2,d2
	moveq	#$2,d3
	moveq	#$24,d4
	moveq	#$18,d5
	bsr.w	sub_95BE
	movem.l	(a7)+,d2-d5
	rts

; ---------------------------------------------------------------------------
sub_8A60:
	move.l	#$70000003,(a4)
	move.l	#$3FF,d1
	bra.s	loc_8A86

; ---------------------------------------------------------------------------
sub_8A6E:
	move.l	#$60000002,(a4)
	bra.s	loc_8A80

; ---------------------------------------------------------------------------
sub_8A76:
	clr.w	($FFFFB1C2).w
	move.l	#$40000003,(a4)
loc_8A80:
	move.l	#$7FF,d1
loc_8A86:
	moveq	#$0,d0
loc_8A88:
	move.l	d0,(a5)
	dbf	d1,loc_8A88
	rts

; ---------------------------------------------------------------------------
sub_8A90:
	movem.l	d2-d7/a2-a3,-(a7)
	move.w	#$9FFF,($FFFFB510).w
	move.w	#$8000,($FFFFB512).w
	clr.b	($FFFFD5FB).w
	lea	($FFFFD604).w,a3
	lea	(dat_8B68).l,a2
	asl.w	#$1,d0
	move.w	(a2,d0.w),d1
	adda.w	d1,a2
loc_8AB6:
	move.b	(a2)+,d2
	bpl.w	loc_8B4C
	cmp.b	#$FF,d2
	bne.s	loc_8AFC
	cmpa.w	#$D5FC,a3
	bhi.s	loc_8AF2
	lea	(dat_8AD4).l,a0
	jsr	(sub_132A6).l
dat_8AD4:
	binclude	"data/008AD4.bin"
loc_8AF2:
	move.l	a2,-(a3)
	move.b	(a2)+,d2
	ext.w	d2
	adda.w	d2,a2
	bra.s	loc_8AB6
loc_8AFC:
	cmp.b	#$FE,d2
	bne.s	loc_8B0E
	cmpa.w	#$D604,a3
	beq.s	loc_8B62
	movea.l	(a3)+,a2
	addq.l	#$1,a2
	bra.s	loc_8AB6
loc_8B0E:
	cmp.b	#$FD,d2
	bne.s	loc_8B1C
	move.l	#$60006,d3
	bra.s	loc_8B2E
loc_8B1C:
	cmp.b	#$FB,d2
	bne.s	loc_8B28
	st	($FFFFD5FB).w
	bra.s	loc_8AB6
loc_8B28:
	move.l	#$87748774,d3
loc_8B2E:
	move.w	#$7FF,d2
	move.w	($FFFFB436).w,d0
	cmp.w	#$F000,d0
	bne.s	loc_8B3E
	lsr.w	#$1,d2
loc_8B3E:
	bsr.w	sub_8288
loc_8B42:
	move.l	d3,(a5)
	dbf	d2,loc_8B42
	bra.w	loc_8AB6
loc_8B4C:
	move.b	(a2)+,d3
	move.b	(a2)+,d4
	move.b	(a2)+,d5
	move.b	(a2)+,($FFFFD5F9).w
	move.b	(a2)+,($FFFFD5FA).w
	bsr.w	sub_8C6C
	bra.w	loc_8AB6
loc_8B62:
	movem.l	(a7)+,d2-d7/a2-a3
	rts
dat_8B68:
	binclude	"data/008B68.bin"

; ---------------------------------------------------------------------------
sub_8C6C:
	movem.l	d2-d7,-(a7)
	cmp.b	d3,d5
	bne.s	loc_8C86
	clr.b	($FFFFD5F8).w
	cmp.b	d4,d2
	bls.s	loc_8C7E
	exg	d2,d4
loc_8C7E:
	move.b	d4,d7
	sub.b	d2,d7
	addq.l	#$1,d7
	bra.s	loc_8C98
loc_8C86:
	move.b	#$1,($FFFFD5F8).w
	cmp.b	d5,d3
	bls.s	loc_8C92
	exg	d3,d5
loc_8C92:
	move.b	d5,d7
	sub.b	d3,d7
	addq.l	#$1,d7
loc_8C98:
	move.b	($FFFFD5F9).w,d6
	bsr.w	sub_8CF8
	moveq	#$A,d6
	sub.b	($FFFFD5F8).w,d6
	bsr.w	sub_8CF8
	cmp.b	#$1,d7
	beq.s	loc_8CEA
	moveq	#-$1,d6
	bsr.w	sub_8CF8
loc_8CB6:
	cmp.b	#$3,d7
	ble.s	loc_8CC8
	moveq	#$A,d6
	sub.b	($FFFFD5F8).w,d6
	bsr.w	sub_8CF8
	bra.s	loc_8CB6
loc_8CC8:
	cmp.b	#$3,d7
	bne.s	loc_8CD4
	moveq	#-$1,d6
	bsr.w	sub_8CF8
loc_8CD4:
	cmp.b	#$2,d7
	bne.s	loc_8CE4
	moveq	#$A,d6
	sub.b	($FFFFD5F8).w,d6
	bsr.w	sub_8CF8
loc_8CE4:
	cmp.b	#$1,d7
	bne.s	loc_8CF2
loc_8CEA:
	move.b	($FFFFD5FA).w,d6
	bsr.w	sub_8CF8
loc_8CF2:
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_8CF8:
	tst.b	d6
	bpl.s	loc_8D08
	tst.b	($FFFFD5FB).w
	beq.s	loc_8D5C
	moveq	#$A,d6
	sub.b	($FFFFD5F8).w,d6
loc_8D08:
	move.b	d6,d4
	bsr.w	sub_8D6C
	tst.b	($FFFFD5FB).w
	bne.s	loc_8D5C
	move.w	#$1F8,d0
	btst	d6,d0
	beq.s	loc_8D26
	moveq	#$B,d4
	subq.l	#$2,d3
	bsr.w	sub_8D6C
	addq.l	#$2,d3
loc_8D26:
	move.w	#$3F,d0
	btst	d6,d0
	beq.s	loc_8D38
	moveq	#$B,d4
	addq.l	#$2,d3
	bsr.w	sub_8D6C
	subq.l	#$2,d3
loc_8D38:
	move.w	#$1B6,d0
	btst	d6,d0
	beq.s	loc_8D4A
	moveq	#$C,d4
	subq.l	#$2,d2
	bsr.w	sub_8D6C
	addq.l	#$2,d2
loc_8D4A:
	move.w	#$DB,d0
	btst	d6,d0
	beq.s	loc_8D5C
	moveq	#$C,d4
	addq.l	#$2,d2
	bsr.w	sub_8D6C
	subq.l	#$2,d2
loc_8D5C:
	tst.b	($FFFFD5F8).w
	beq.s	loc_8D66
	addq.l	#$1,d3
	bra.s	loc_8D68
loc_8D66:
	addq.l	#$1,d2
loc_8D68:
	subq.b	#$1,d7
	rts

; ---------------------------------------------------------------------------
sub_8D6C:
	movea.l	($FFFFB546).w,a0
	ext.w	d4
	add.w	(a0),d4
	and.w	($FFFFB510).w,d4
	or.w	($FFFFB512).w,d4
	ext.w	d3
	move.w	d3,d0
	asl.w	#$6,d0
	ext.w	d2
	add.w	d2,d0
	asl.w	#$1,d0
	add.w	($FFFFB436).w,d0
	bsr.w	sub_8288
	move.w	d4,(a5)
	rts

; ---------------------------------------------------------------------------
sub_8D94:
	move.w	d1,d2
	asl.w	#$4,d2
	or.w	d1,d2
	move.w	d2,d1
	asl.w	#$8,d2
	or.w	d1,d2
	move.w	d2,d1
	swap	d2
	move.w	d1,d2
	rts

; ---------------------------------------------------------------------------
sub_8DA8:
	movem.l	d2-d7,-(a7)
	lea	(dat_8E58).l,a1
	move.w	(a0),d3
	asl.w	#$5,d3
	asl.w	#$8,d1
	asl.w	#$4,d1
	move.w	d1,-$C(a6)
	move.w	d0,d2
	bclr	#$0,d0
	move.w	(a1,d0.w),-$A(a6)
	btst	#$0,d2
	bne.s	loc_8DDC
	moveq	#$1F,d7
loc_8DD2:
	bsr.w	sub_8DF0
	dbf	d7,loc_8DD2
	bra.s	loc_8DEA
loc_8DDC:
	moveq	#$0,d7
loc_8DDE:
	bsr.w	sub_8DF0
	addq.l	#$1,d7
	cmp.w	#$20,d7
	bne.s	loc_8DDE
loc_8DEA:
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_8DF0:
	move.b	#$0,($FFFF9BB7).w
	bsr.w	sub_DEC4
	moveq	#$1F,d6
loc_8DFC:
	movem.l	d6-d7,-(a7)
	move.w	-$A(a6),d0
	jsr	(a1,d0.w)
	andi.w	#$1F,d5
	move.w	d5,d1
	andi.w	#$3,d1
	asl.w	#$2,d1
	move.w	-$C(a6),d4
	lsr.w	d1,d4
	move.l	#$FFFF0FFF,d2
	asr.l	d1,d2
	move.w	d5,d1
	andi.w	#$4,d1
	asr.w	#$1,d1
	andi.w	#$18,d5
	asl.w	#$4,d5
	add.w	d1,d5
	move.w	d6,d1
	asl.w	#$2,d1
	add.w	d1,d5
	add.w	d3,d5
	move.w	d5,d0
	bsr.w	sub_829C
	move.w	d5,d0
	move.w	(a5),d5
	bsr.w	sub_8288
	and.w	d2,d5
	or.w	d4,d5
	move.w	d5,(a5)
	movem.l	(a7)+,d6-d7
	dbf	d6,loc_8DFC
	rts
dat_8E58:
	binclude	"data/008E58.bin"

; ---------------------------------------------------------------------------
sub_8EC8:
	movem.l	d2-d3/d6-d7,-(a7)
	bsr.w	sub_8D94
	move.w	(a0),d6
	asl.w	#$5,d6
	tst.w	d0
	bne.s	loc_8EE4
	moveq	#$F,d7
loc_8EDA:
	bsr.w	sub_8F3C
	dbf	d7,loc_8EDA
	bra.s	loc_8F16
loc_8EE4:
	subq.w	#$1,d0
	bne.s	loc_8EF8
	moveq	#$0,d7
loc_8EEA:
	bsr.w	sub_8F3C
	addq.l	#$1,d7
	cmp.w	#$10,d7
	bne.s	loc_8EEA
	bra.s	loc_8F16
loc_8EF8:
	subq.w	#$1,d0
	bne.s	loc_8F08
	moveq	#$F,d7
loc_8EFE:
	bsr.w	sub_8F1C
	dbf	d7,loc_8EFE
	bra.s	loc_8F16
loc_8F08:
	moveq	#$0,d7
loc_8F0A:
	bsr.w	sub_8F1C
	addq.l	#$1,d7
	cmp.w	#$10,d7
	bne.s	loc_8F0A
loc_8F16:
	movem.l	(a7)+,d2-d3/d6-d7
	rts

; ---------------------------------------------------------------------------
sub_8F1C:
	move.b	#$0,($FFFF9BB7).w
	bsr.w	sub_DEC4
	move.w	d7,d3
	asl.w	#$2,d3
	add.w	d6,d3
	bsr.w	loc_8F60
	move.w	d7,d3
	asl.w	#$2,d3
	add.w	d6,d3
	addi.w	#$80,d3
	bra.s	loc_8F60

; ---------------------------------------------------------------------------
sub_8F3C:
	move.b	#$0,($FFFF9BB7).w
	bsr.w	sub_DEC4
	move.w	d7,d3
	asl.w	#$2,d3
	add.w	d6,d3
	bsr.w	loc_8F60
	move.w	d7,d3
	addq.w	#$8,d3
	andi.w	#$F,d3
	asl.w	#$2,d3
	addi.w	#$80,d3
	add.w	d6,d3
loc_8F60:
	move.w	d3,d0
	bsr.w	sub_8288
	move.l	d2,(a5)
	addi.w	#$40,d3
	move.w	d3,d0
	bsr.w	sub_8288
	move.l	d2,(a5)
	addi.w	#$C0,d3
	move.w	d3,d0
	bsr.w	sub_8288
	move.l	d2,(a5)
	addi.w	#$40,d3
	move.w	d3,d0
	bsr.w	sub_8288
	move.l	d2,(a5)
	rts

; ---------------------------------------------------------------------------
sub_8F8E:
	movem.l	d2-d7,-(a7)
	move.w	(a0),d2
	asl.w	#$5,d2
	move.w	d2,-$C(a6)
	move.w	d1,d2
	asl.w	#$8,d2
	asl.w	#$4,d2
	move.w	d2,-$A(a6)
	tst.w	d0
	beq.s	loc_8FB4
	moveq	#$7,d7
loc_8FAA:
	bsr.w	sub_8FC8
	dbf	d7,loc_8FAA
	bra.s	loc_8FC2
loc_8FB4:
	moveq	#$0,d7
loc_8FB6:
	bsr.w	sub_8FC8
	addq.l	#$1,d7
	cmp.w	#$8,d7
	bne.s	loc_8FB6
loc_8FC2:
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_8FC8:
	move.b	#$0,($FFFF9BB7).w
	bsr.w	sub_DEC4
	bsr.w	sub_DEC4
	moveq	#$7,d4
	sub.w	d7,d4
	move.l	d4,d3
	move.l	d7,d6
	asl.w	#$1,d6
	addq.l	#$1,d6
loc_8FE2:
	bsr.w	sub_9006
	addq.l	#$1,d3
	dbf	d6,loc_8FE2
	moveq	#$8,d4
	add.w	d7,d4
	moveq	#$7,d3
	sub.w	d7,d3
	move.l	d7,d6
	asl.w	#$1,d6
	addq.l	#$1,d6
loc_8FFA:
	bsr.w	sub_9006
	addq.l	#$1,d3
	dbf	d6,loc_8FFA
	rts

; ---------------------------------------------------------------------------
sub_9006:
	move.w	d3,d0
	move.w	d4,d3
	move.w	d0,d4
	bsr.w	sub_9016
	move.w	d3,d0
	move.w	d4,d3
	move.w	d0,d4

; ---------------------------------------------------------------------------
sub_9016:
	movem.l	d2/d5,-(a7)
	move.w	d3,d0
	asr.w	#$1,d0
	andi.w	#$2,d0
	move.w	d4,d2
	asl.w	#$2,d2
	add.w	d0,d2
	move.w	d3,d0
	andi.w	#$18,d0
	asl.w	#$4,d0
	add.w	d0,d2
	add.w	-$C(a6),d2
	move.w	d2,d0
	bsr.w	sub_829C
	move.w	d2,d0
	move.w	(a5),d5
	bsr.w	sub_8288
	move.l	#$FFFF0FFF,d1
	move.w	d3,d0
	asl.w	#$2,d0
	andi.w	#$C,d0
	asr.l	d0,d1
	and.w	d1,d5
	move.w	-$A(a6),d1
	lsr.w	d0,d1
	or.w	d1,d5
	move.w	d2,d0
	bsr.w	sub_8288
	move.w	d5,(a5)
	addi.w	#$40,d2
	move.w	d2,d0
	bsr.w	sub_8288
	move.w	d5,(a5)
	addi.w	#$C0,d2
	move.w	d2,d0
	bsr.w	sub_8288
	move.w	d5,(a5)
	addi.w	#$40,d2
	move.w	d2,d0
	bsr.w	sub_8288
	move.w	d5,(a5)
	movem.l	(a7)+,d2/d5
	rts

; ---------------------------------------------------------------------------
sub_9090:
	movem.l	d2-d3/d7,-(a7)
	bsr.w	sub_8D94
	lea	(dat_90CE).l,a1
	move.w	(a0),d3
	asl.w	#$5,d3
	moveq	#$F,d7
loc_90A4:
	move.b	#$0,($FFFF9BB7).w
	bsr.w	sub_DEC4
	move.b	(a1,d7.w),d0
	ext.w	d0
	asl.w	#$5,d0
	add.w	d3,d0
	bsr.w	sub_8288
	moveq	#$7,d1
loc_90BE:
	move.l	d2,(a5)
	dbf	d1,loc_90BE
	dbf	d7,loc_90A4
	movem.l	(a7)+,d2-d3/d7
	rts
dat_90CE:
	binclude	"data/0090CE.bin"

; ---------------------------------------------------------------------------
sub_90DE:
	movem.l	d2-d7,-(a7)
	move.w	(a0),d2
	asl.w	#$5,d2
	move.w	d2,-$C(a6)
	asl.w	#$8,d1
	asl.w	#$4,d1
	move.w	d1,-$8(a6)
	lea	(sub_91A0).l,a1
	moveq	#$0,d3
	moveq	#$0,d4
	moveq	#$3,d7
loc_90FE:
	move.l	d7,d0
	moveq	#$0,d1
	bsr.w	sub_9186
	moveq	#$3,d6
loc_9108:
	move.l	d6,d0
	moveq	#$1,d1
	bsr.w	sub_9186
	moveq	#$3,d5
loc_9112:
	move.l	d5,d0
	moveq	#$2,d1
	bsr.w	sub_9186
	move.b	#$FE,($FFFF9BB7).w
	bsr.w	sub_DEC4
	move.w	#$8F20,(a4)
	move.l	d3,d0
	asr.w	#$1,d0
	bclr	#$0,d0
	move.l	d4,d2
	asl.w	#$2,d2
	add.w	d0,d2
	add.w	-$C(a6),d2
	move.w	d2,d0
	bsr.w	sub_829C
	move.w	(a5),-$A(a6)
	move.w	d2,d0
	bsr.w	sub_8288
	move.l	#$FFFF0FFF,d0
	move.w	d3,d1
	asl.w	#$2,d1
	andi.w	#$F,d1
	asr.l	d1,d0
	and.w	-$A(a6),d0
	move.w	-$8(a6),d2
	lsr.w	d1,d2
	or.w	d2,d0
	move.w	#$F,d1
loc_916A:
	move.w	d0,(a5)
	dbf	d1,loc_916A
	move.w	#$8F02,(a4)
	dbf	d5,loc_9112
	dbf	d6,loc_9108
	dbf	d7,loc_90FE
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_9186:
	tst.b	$2(a1,d0.w)
	bne.s	loc_9190
	bclr	d1,d3
	bra.s	loc_9192
loc_9190:
	bset	d1,d3
loc_9192:
	tst.b	(a1,d0.w)
	bne.s	loc_919C
	bclr	d1,d4
	bra.s	loc_919E
loc_919C:
	bset	d1,d4
loc_919E:
	rts

; ---------------------------------------------------------------------------
sub_91A0:
	ori.b	#$1,d1
	btst	d0,d0

; ---------------------------------------------------------------------------
sub_91A6:
	moveq	#$13,d0
	bsr.w	sub_6C94
	asl.w	#$1,d0
	move.w	d0,($FFFFB432).w
	clr.b	($FFFFB4C9).w
	cmp.w	#$E,d0
	bcs.s	loc_91C6
	cmp.w	#$26,d0
	bcc.s	loc_91C6
	st	($FFFFB4C9).w
loc_91C6:
	rts

; ---------------------------------------------------------------------------
sub_91C8:
	link	a6,#-$C
	movea.l	($FFFFB42E).w,a0
	move.w	($FFFFB432).w,d0
	moveq	#$0,d1
	btst	#$0,d0
	bne.s	loc_91E6
	move.w	($FFFFB434).w,d1
	move.w	#$2,($FFFFB434).w
loc_91E6:
	asr.w	#$1,d0
	bne.s	loc_91F0
	bsr.w	sub_90DE
	bra.s	loc_921E
loc_91F0:
	cmp.w	#$3,d0
	bcc.s	loc_91FE
	subq.l	#$1,d0
	bsr.w	sub_8F8E
	bra.s	loc_921E
loc_91FE:
	cmp.w	#$7,d0
	bcc.s	loc_920C
	subq.l	#$3,d0
	bsr.w	sub_8EC8
	bra.s	loc_921E
loc_920C:
	cmp.w	#$11,d0
	bcc.s	loc_921A
	subq.l	#$7,d0
	bsr.w	sub_8DA8
	bra.s	loc_921E
loc_921A:
	bsr.w	sub_9090
loc_921E:
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_9222:
	move.l	#$6C000003,(a4)
	moveq	#$0,d0
	move.l	d0,(a5)
	clr.l	($FFFFB488).w
	rts

; ---------------------------------------------------------------------------
sub_9232:
	move.l	(a0),d0
	beq.s	loc_923E
	clr.l	(a0)
	movea.l	d0,a0
	bra.w	sub_9240
loc_923E:
	rts

; ---------------------------------------------------------------------------
sub_9240:
	movem.l	d2-d4/a2,-(a7)
	move.l	($FFFFB488).w,d0
	beq.w	loc_92A4
	cmp.w	#$B48C,d0
	beq.w	loc_92A4
	subq.l	#$6,d0
	move.l	d0,($FFFFB488).w
	cmp.l	a0,d0
	bne.s	loc_927C
	move.w	$4(a0),d0
	move.l	#$2C020003,(a4)
	move.w	(a5),d1
	andi.w	#$FF80,d1
	or.w	d0,d1
	move.l	#$6C020003,(a4)
	move.w	d1,(a5)
	bra.w	loc_92A4
loc_927C:
	lea	(dat_9288).l,a0
	jsr	(sub_132A6).l
dat_9288:
	binclude	"data/009288.bin"
loc_92A4:
	movem.l	(a7)+,d2-d4/a2
	rts

; ---------------------------------------------------------------------------
sub_92AA:
	movem.l	d2/d5,-(a7)
	movea.l	($FFFFB488).w,a0
	move.l	a0,d2
	bne.s	loc_92CC
	lea	($FFFFB48C).w,a0
	move.l	a0,($FFFFB488).w
	move.w	#$701,d5
	move.w	d5,(a0)
	moveq	#$1,d2
	move.w	d2,$2(a0)
	bra.s	loc_92D2
loc_92CC:
	move.w	(a0),d5
	move.w	$2(a0),d2
loc_92D2:
	move.w	d5,$6(a0)
	add.w	d1,$6(a0)
	move.w	d2,$8(a0)
	add.w	d0,$8(a0)
	addq.l	#$6,($FFFFB488).w
	move.l	#$2C020003,(a4)
	move.w	(a5),d0
	andi.w	#$7F,d0
	move.w	d0,$4(a0)
	movem.l	(a7)+,d2/d5
	rts

; ---------------------------------------------------------------------------
sub_92FC:
	link	a6,#-$E
	movem.l	d2-d7/a2-a3,-(a7)
	move.w	d2,-$2(a6)
	moveq	#$8,d0
	bsr.w	sub_6C94
	asl.w	#$3,d0
	lea	(dat_9490).l,a3
	tst.b	($FFFFB4C9).w
	beq.s	loc_931E
	adda.w	d0,a3
loc_931E:
	move.w	d4,d0
	sub.w	d2,d0
	asr.w	#$5,d0
	move.w	d0,-$4(a6)
	addq.l	#$1,d0
	cmp.w	#$A,d0
	bcc.s	loc_9336
	lea	(dat_9490).l,a3
loc_9336:
	move.w	d5,d1
	sub.w	d3,d1
	asr.w	#$5,d1
	move.w	d1,-$A(a6)
	addq.l	#$1,d1
	cmp.w	#$A,d0
	bcc.s	loc_934E
	lea	(dat_9490).l,a3
loc_934E:
	mulu.w	d1,d0
	addq.l	#$1,d0
	moveq	#$10,d1
	bsr.w	sub_92AA
	movea.l	a0,a2
	move.w	(a2),d0
	asl.w	#$5,d0
	bsr.w	sub_8288
	move.w	d7,d1
	bsr.w	sub_8D94
	move.w	#$7F,d1
loc_936C:
	move.l	d2,(a5)
	dbf	d1,loc_936C
	move.w	#$EC02,d0
	bsr.w	sub_829C
	move.w	(a5),d0
	andi.w	#$7F,d0
	move.w	d0,-$6(a6)
	move.w	$2(a2),d0
	move.w	d0,-$8(a6)
	addq.w	#$1,-$8(a6)
	asl.w	#$3,d0
	addi.w	#$EC00,d0
	bsr.w	sub_8288
	move.w	d5,d0
	addi.l	#$81,d0
	move.w	d0,(a5)
	move.w	d5,d0
	sub.w	d3,d0
	andi.w	#$18,d0
	move.w	#$10,d1
	sub.w	d0,d1
	asl.w	#$5,d1
	move.w	d1,(a5)
	move.w	(a2),d0
	add.w	d6,d0
	move.w	d0,(a5)
	tst.w	d1
	bmi.s	loc_93C6
	move.w	#$0,(a5)
	bra.s	loc_93CA
loc_93C6:
	move.w	#$1,(a5)
loc_93CA:
	move.w	-$A(a6),d7
	clr.w	-$C(a6)
loc_93D2:
	move.w	-$4(a6),d1
	move.w	-$2(a6),d2
	clr.w	-$E(a6)
loc_93DE:
	move.w	d3,d0
	addi.w	#$80,d0
	move.w	d0,(a5)
	move.w	d4,d0
	sub.w	d2,d0
	cmp.w	#$1F,d0
	bls.s	loc_93F2
	moveq	#$18,d0
loc_93F2:
	andi.w	#$18,d0
	asl.w	#$7,d0
	ori.w	#$300,d0
	or.w	-$6(a6),d0
	move.w	d0,(a5)
	move.w	-$8(a6),-$6(a6)
	addq.w	#$1,-$8(a6)
	move.w	-$E(a6),d0
	add.w	-$C(a6),d0
	move.w	(a3,d0.w),d0
	or.w	(a2),d0
	or.w	d6,d0
	ori.w	#$2000,d0
	move.w	d0,(a5)
	move.w	d2,d0
	addi.w	#$80,d0
	move.w	d0,(a5)
	addi.l	#$20,d2
	bchg	#$1,-$D(a6)
	dbf	d1,loc_93DE
	addi.l	#$20,d3
	bchg	#$2,-$B(a6)
	dbf	d7,loc_93D2
	move.w	$2(a2),d2
	asl.w	#$3,d2
	addi.w	#$EC02,d2
	move.w	d2,d0
	bsr.w	sub_829C
	move.w	(a5),d6
	andi.w	#$FF80,d6
	or.w	-$6(a6),d6
	move.w	d2,d0
	bsr.w	sub_8288
	move.w	d6,(a5)
	move.w	#$EC02,d0
	bsr.w	sub_829C
	move.w	(a5),d6
	andi.w	#$FF80,d6
	or.w	$2(a2),d6
	move.w	#$EC02,d0
	bsr.w	sub_8288
	move.w	d6,(a5)
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts
dat_9490:
	binclude	"data/009490.bin"

; ---------------------------------------------------------------------------
sub_94DC:
	move.w	#$F000,d1
	movem.l	d4-d5,-(a7)
	moveq	#$3,d4
	moveq	#$3,d5
	tst.b	($FFFFB523).w
	beq.s	loc_94FA
	move.l	#$969C,($FFFFB516).l
	bra.s	loc_9504
loc_94FA:
	move.l	#$9682,($FFFFB516).l
loc_9504:
	bsr.w	sub_961C
	movem.l	(a7)+,d4-d5
	rts

; ---------------------------------------------------------------------------
sub_950E:
	movem.l	d2-d5/a2,-(a7)
	moveq	#$0,d5
	move.b	($FFFFB4CE).w,d5
	beq.s	loc_9564
	moveq	#$0,d4
	bra.s	loc_955C
loc_951E:
	move.w	d5,d0
	lea	($FFFFB4D0).w,a0
	move.b	(a0,d0.w),d0
	bne.s	loc_952E
	tst.b	d4
	bne.s	loc_955C
loc_952E:
	mulu.w	#$F2,d0
	lea	($FFFFA0F6).w,a0
	adda.w	d0,a0
	lea	($FFFFAF24).w,a1
	lea	($FFFFA0F6).w,a2
	moveq	#$78,d3
loc_9542:
	move.w	(a0)+,d0
	move.w	(a2)+,d1
	cmp.w	d0,d1
	bne.s	loc_9550
	tst.b	d4
	bne.s	loc_9554
	move.w	d1,d0
loc_9550:
	move.w	d0,(a1)+
	bra.s	loc_9556
loc_9554:
	addq.l	#$2,a1
loc_9556:
	dbf	d3,loc_9542
	moveq	#$1,d4
loc_955C:
	dbf	d5,loc_951E
	moveq	#$F,d0
	bra.s	loc_956A
loc_9564:
	moveq	#$0,d0
	move.b	($FFFFB4D0).w,d0
loc_956A:
	move.w	#$7FFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	moveq	#$4,d1
	movem.w	($FFFFB566).w,d2-d3
	moveq	#$B,d4
	moveq	#$B,d5
	lea	($FFFFB56A).w,a0
	bsr.w	sub_95BE
	movem.l	(a7)+,d2-d5/a2
	rts

; ---------------------------------------------------------------------------
sub_9592:
	movem.l	d2-d5,-(a7)
	moveq	#$0,d0
	moveq	#$4,d1
	moveq	#$2,d2
	moveq	#$2,d3
	moveq	#$24,d4
	moveq	#$F,d5
	movea.l	($FFFFB552).w,a0
	move.w	#$FFFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	bsr.w	sub_95BE
	movem.l	(a7)+,d2-d5
	rts

; ---------------------------------------------------------------------------
sub_95BE:
	movem.l	d7/a2-a3,-(a7)
	movem.w	d0-d1,-(a7)
	moveq	#$0,d7
	lea	(dat_9616).l,a2
	lea	(sub_9682).l,a3
loc_95D4:
	btst	d7,d1
	beq.s	loc_95F2
	move.l	d7,d1
	divu.w	#$3,d1
	swap	d1
	asl.w	#$1,d1
	move.w	(a2,d1.w),d1
	move.l	a3,($FFFFB516).w
	bsr.w	sub_961C
	movem.w	(a7),d0-d1
loc_95F2:
	addq.l	#$1,d7
	cmp.w	#$6,d7
	beq.s	loc_960C
	cmp.w	#$3,d7
	bne.s	loc_95D4
	adda.w	#$14,a3
	movea.l	#$0,a0
	bra.s	loc_95D4
loc_960C:
	movem.w	(a7)+,d0-d1
	movem.l	(a7)+,d7/a2-a3
	rts
dat_9616:
	dc.b	$A0,$00,$C0,$00,$F0,$00

; ---------------------------------------------------------------------------
sub_961C:
	movem.l	d2-d7/a2,-(a7)
	movea.l	($FFFFB516).w,a2
	asl.w	#$7,d3
	asl.w	#$1,d2
	add.w	d2,d3
	add.w	d1,d3
	cmpa.l	#$9696,a2
	beq.s	loc_9644
	movea.l	$2(a0),a1
	tst.w	d0
	beq.s	loc_9644
	mulu.w	d4,d0
	mulu.w	d5,d0
	asl.w	#$1,d0
	adda.w	d0,a1
loc_9644:
	moveq	#$0,d7
	tst.b	($FFFFB523).w
	beq.s	loc_9658
	clr.b	($FFFFB523).w
	move.w	d4,d7
	asl.w	#$1,d7
	adda.w	d7,a1
	asl.w	#$1,d7
loc_9658:
	move.l	#$80,d2
	subq.l	#$1,d4
	subq.l	#$1,d5
loc_9662:
	move.w	d3,d0
	bsr.w	sub_8288
	move.w	d4,d1
loc_966A:
	jsr	(a2)
	dbf	d1,loc_966A
	adda.w	d7,a1
	add.w	d2,d3
	dbf	d5,loc_9662
	movem.l	(a7)+,d2-d7/a2
	rts

; ---------------------------------------------------------------------------
sub_967E:
	move.w	(a1)+,(a5)
	rts

; ---------------------------------------------------------------------------
sub_9682:
	move.w	(a1)+,d0
	move.w	($FFFFB50E).w,d6
	eor.w	d6,d0
	and.w	($FFFFB510).w,d0
	or.w	($FFFFB512).w,d0
	move.w	d0,(a5)
	rts

; ---------------------------------------------------------------------------
sub_9696:
	move.w	($FFFFB514).w,(a5)
	rts

; ---------------------------------------------------------------------------
sub_969C:
	move.w	-(a1),d0
	eori.w	#$800,d0
	move.w	d0,(a5)
	rts
loc_96A6:
	btst	#$0,($FFFFB4BF).w
	bne.s	loc_96BE
	move.l	#$60000003,(a4)
	move.w	d0,(a5)
	move.l	#$40000010,(a4)
	move.w	d1,(a5)
loc_96BE:
	btst	#$1,($FFFFB4BF).w
	bne.s	loc_96D6
	move.l	#$60020003,(a4)
	move.w	d0,(a5)
	move.l	#$40020010,(a4)
	move.w	d1,(a5)
loc_96D6:
	rts

; ---------------------------------------------------------------------------
sub_96D8:
	movem.l	d5-d7,-(a7)
	lea	(dat_9710).l,a0
	lea	(dat_9708).l,a1
	moveq	#$3,d7
	moveq	#$0,d5
loc_96EC:
	move.w	(a1)+,d6
	move.w	d5,d0
	bsr.w	sub_8278
loc_96F4:
	move.w	(a0)+,(a5)
	dbf	d6,loc_96F4
	addi.w	#$20,d5
	dbf	d7,loc_96EC
	movem.l	(a7)+,d5-d7
	rts
dat_9708:
	dc.b	$00,$0F,$00,$0F,$00,$02,$00,$02
dat_9710:
	binclude	"data/009710.bin"

; ---------------------------------------------------------------------------
sub_975C:
	move.b	#$8,($FFFFB4BE).w
	bsr.w	sub_976C
	clr.b	($FFFFB4BE).w
	rts

; ---------------------------------------------------------------------------
sub_976C:
	lea	(dat_F16AA).l,a0
	ext.w	d0
	asl.w	#$2,d0
	movea.l	(a0,d0.w),a0
	bsr.w	sub_9DD4
	bsr.w	sub_978C
	rts

; ---------------------------------------------------------------------------
sub_9784:
	move.l	(a0),d0
	clr.l	(a0)
	movea.l	d0,a0
	nop

; ---------------------------------------------------------------------------
sub_978C:
	move.l	a0,d1
	bne.w	loc_9794
	rts
loc_9794:
	move.l	($FFFFB43C).w,d0
	subq.l	#$6,d0
	cmp.l	a0,d0
	bne.s	loc_97A4
	subq.l	#$6,($FFFFB43C).w
	rts
loc_97A4:
	lea	(dat_97B0).l,a0
	jsr	(sub_132A6).l
dat_97B0:
	binclude	"data/0097B0.bin"

; ---------------------------------------------------------------------------
sub_97CC:
	movea.l	($FFFFB43C).w,a2
	move.w	a2,d1
	bne.s	loc_97EE
	lea	($FFFFB440).w,a2
	move.l	a2,($FFFFB43C).w
	lea	($FFFF4AF6).l,a1
	move.w	#$46,d0
	move.l	a1,$2(a2)
	move.w	d0,(a2)
	bra.s	loc_981C
loc_97EE:
	cmp.w	#$B482,d1
	bcs.s	loc_9816
	lea	(dat_9800).l,a0
	jsr	(sub_132A6).l
dat_9800:
	binclude	"data/009800.bin"
loc_9816:
	move.w	(a2),d0
	movea.l	$2(a2),a1
loc_981C:
	move.w	d0,$6(a2)
	move.l	a1,$8(a2)
	addq.l	#$6,($FFFFB43C).w
	rts

; ---------------------------------------------------------------------------
sub_982A:
	link	a6,#-$20
	movem.l	d6-d7/a2-a3,-(a7)
	tst.b	d0
	seq	($FFFFB4C6).w
	bne.s	loc_9842
	lea	(dat_98DC).l,a3
	bra.s	loc_9848
loc_9842:
	lea	(dat_98E1).l,a3
loc_9848:
	move.l	a3,-$20(a6)
	lea	($FFFFB582).w,a0
	bsr.w	sub_9784
	lea	($FFFFC470).w,a3
	move.w	($FFFFBA64).w,d7
	lea	-$E(a6),a0
	st	(a0)
	moveq	#$0,d6
	bra.s	loc_98C0
loc_9866:
	move.b	(a3),d0
	beq.s	loc_98BC
	andi.b	#$40,d0
	bne.s	loc_98BC
	move.b	$2(a3),d0
	bsr.w	sub_6F14
	move.b	$42(a1),d0
	lea	-$E(a6),a1
	lea	-$1C(a6),a2
loc_9884:
	move.b	(a1)+,d1
	cmp.b	#$FF,d1
	beq.s	loc_989A
	cmp.b	d0,d1
	beq.s	loc_9894
	addq.l	#$1,a2
	bra.s	loc_9884
loc_9894:
	move.b	(a2),$11(a3)
	bra.s	loc_98BC
loc_989A:
	move.b	d0,-$1(a1)
	st	(a1)
	move.b	d6,(a2)
	move.b	d6,$11(a3)
	move.b	$2(a3),d0
	bsr.w	sub_6F14
	addq.w	#$1,d6
	move.b	$23(a1),d0
	cmp.b	#$1,d0
	bls.s	loc_98BC
	addq.w	#$1,d6
loc_98BC:
	adda.w	#$1A,a3
loc_98C0:
	dbf	d7,loc_9866
	lea	-$E(a6),a0
	movea.l	-$20(a6),a3
	bsr.w	sub_9934
	move.l	a0,($FFFFB582).w
	movem.l	(a7)+,d6-d7/a2-a3
	unlk	a6
	rts
dat_98DC:
	dc.b	$00,$06,$0C,$10,$FF
dat_98E1:
	dc.b	$06,$10,$FF

; ---------------------------------------------------------------------------
sub_98E4:
	move.l	a3,-(a7)
	bsr.w	sub_6EEC
	lea	($FFFFB58A).w,a0
	bsr.w	sub_9784
	st	($FFFFB526).w
	move.l	($FFFFB586).w,d0
	beq.s	loc_990C
	move.b	$42(a2),d1
	cmp.b	($FFFFB4C5).w,d1
	beq.s	loc_9922
	movea.l	d0,a0
	bsr.w	sub_978C
loc_990C:
	move.b	$42(a2),d0
	move.b	d0,($FFFFB4C5).w
	lea	(dat_9926).l,a3
	bsr.w	sub_99BC
	move.l	a0,($FFFFB586).w
loc_9922:
	movea.l	(a7)+,a3
	rts
dat_9926:
	binclude	"data/009926.bin"

; ---------------------------------------------------------------------------
sub_9934:
	movem.l	a2/a6,-(a7)
	movea.l	a0,a6
	bsr.w	sub_97CC
loc_993E:
	move.b	(a6)+,d0
	cmp.b	#$FF,d0
	beq.s	loc_995C
	bsr.w	sub_99BC
	move.w	$6(a0),$6(a2)
	move.l	$8(a0),$8(a2)
	subq.l	#$6,($FFFFB43C).w
	bra.s	loc_993E
loc_995C:
	movea.l	a2,a0
	movem.l	(a7)+,a2/a6
	rts
loc_9964:
	movem.l	d3-d4,-(a7)
	ext.w	d0
	movea.l	a3,a1
	moveq	#-$1,d4
loc_996E:
	addq.l	#$1,d4
	tst.b	(a1)+
	bpl.s	loc_996E
	asl.w	#$2,d0
	lea	(dat_998C).l,a0
	movea.l	(a0,d0.w),a0
	moveq	#$12,d3
	bsr.w	sub_9BB6
	movem.l	(a7)+,d3-d4
	rts
dat_998C:
	binclude	"data/00998C.bin"

; ---------------------------------------------------------------------------
sub_99BC:
	bclr	#$7,d0
	bne.s	loc_9964
	movem.l	d3-d4,-(a7)
	lea	(dat_9A14).l,a1
loc_99CC:
	move.b	$4(a1),d1
	bmi.s	loc_99F6
	cmp.b	d0,d1
	beq.s	loc_99DA
	addq.l	#$8,a1
	bra.s	loc_99CC
loc_99DA:
	move.b	$5(a1),d3
	movea.l	(a1),a0
	ext.w	d3
	movea.l	a3,a1
	moveq	#-$1,d4
loc_99E6:
	addq.l	#$1,d4
	tst.b	(a1)+
	bpl.s	loc_99E6
	bsr.w	sub_9BB6
	movem.l	(a7)+,d3-d4
	rts
loc_99F6:
	lea	(dat_9A02).l,a0
	jsr	(sub_132A6).l
dat_9A02:
	binclude	"data/009A02.bin"
dat_9A14:
	binclude	"data/009A14.bin"

; ---------------------------------------------------------------------------
sub_9BB6:
	link	a6,#-$814
	movem.l	d2-d6/a2-a3,-(a7)
	bsr.w	sub_9D56
	ext.l	d3
	tst.b	($FFFFB4CB).w
	beq.s	loc_9BF8
	lea	($FFFF6AF6).l,a2
	lea	($FFFF6B02).l,a1
	move.l	a1,$2(a2)
	move.l	a1,$8(a2)
	move.w	d4,d0
	addq.w	#$1,d0
	mulu.w	d3,d0
	movea.l	a1,a0
	adda.w	d0,a0
	move.l	a0,-$10(a6)
	clr.w	-$C(a6)
	clr.w	(a2)
	clr.w	$6(a2)
	bra.s	loc_9C00
loc_9BF8:
	bsr.w	sub_97CC
	move.w	d0,-$C(a6)
loc_9C00:
	move.l	a1,-$A(a6)
	moveq	#$0,d5
	move.l	$2(a2),$8(a2)
	move.w	-$4(a6),d6
loc_9C10:
	move.l	$8(a2),d0
	move.w	d3,d1
	bsr.w	sub_9ED8
	cmp.b	(a3),d5
	bne.s	loc_9C24
	add.l	d3,$8(a2)
	addq.l	#$1,a3
loc_9C24:
	addq.l	#$1,d5
	sub.w	d3,d6
	bmi.w	loc_9CF6
	bne.s	loc_9C10
	move.w	#$1FF,d6
	lea	-$814(a6),a0
	moveq	#-$1,d0
loc_9C38:
	move.l	d0,(a0)+
	dbf	d6,loc_9C38
	move.w	d4,d6
	mulu.w	d3,d6
	asr.w	#$1,d6
	subq.w	#$1,d6
	moveq	#$0,d5
	lea	-$814(a6),a0
	movea.l	$2(a2),a1
loc_9C50:
	move.w	(a1),d0
	move.w	d0,d1
	andi.w	#$7FF,d0
	andi.w	#$F800,d1
	asl.w	#$1,d0
	cmp.w	#$800,d0
	bcc.w	loc_9D36
	move.w	(a0,d0.w),d2
	bpl.s	loc_9C74
	move.w	d5,(a0,d0.w)
	move.w	d5,d2
	addq.w	#$1,d5
loc_9C74:
	add.w	(a2),d2
	or.w	d1,d2
	move.w	d2,(a1)+
	dbf	d6,loc_9C50
	bsr.w	sub_9D66
	tst.b	($FFFFB4CB).w
	beq.s	loc_9C98
	move.w	d5,d0
	asl.w	#$5,d0
	ext.l	d0
	add.l	-$10(a6),d0
	move.l	d0,-$14(a6)
	bra.s	loc_9CA0
loc_9C98:
	move.w	(a2),d0
	add.w	d5,d0
	move.w	d0,$6(a2)
loc_9CA0:
	moveq	#$0,d6
	lea	-$814(a6),a3
loc_9CA6:
	tst.w	d5
	ble.s	loc_9CE4
	moveq	#$0,d0
	move.w	(a3,d6.w),d0
	bpl.s	loc_9CC4
	tst.b	($FFFFB4CB).w
	beq.s	loc_9CBE
	move.l	-$14(a6),d0
	bra.s	loc_9CDA
loc_9CBE:
	move.w	$6(a2),d0
	bra.s	loc_9CD8
loc_9CC4:
	tst.b	($FFFFB4CB).w
	beq.s	loc_9CD4
	asl.w	#$5,d0
	add.l	-$10(a6),d0
	subq.w	#$1,d5
	bra.s	loc_9CDA
loc_9CD4:
	add.w	(a2),d0
	subq.w	#$1,d5
loc_9CD8:
	asl.w	#$5,d0
loc_9CDA:
	moveq	#$20,d1
	bsr.w	sub_9ED8
	addq.l	#$2,d6
	bra.s	loc_9CA6
loc_9CE4:
	clr.b	($FFFFB4CB).w
	movea.l	a2,a0
	move.l	-$10(a6),d0
	movem.l	(a7)+,d2-d6/a2-a3
	unlk	a6
	rts
loc_9CF6:
	lea	(dat_9D02).l,a0
	jsr	(sub_132A6).l
dat_9D02:
	binclude	"data/009D02.bin"
loc_9D36:
	lea	(dat_9D42).l,a0
	jsr	(sub_132A6).l
dat_9D42:
	binclude	"data/009D42.bin"

; ---------------------------------------------------------------------------
sub_9D56:
	bsr.w	sub_9E76
	moveq	#-$6,d0
	add.l	a6,d0
	moveq	#$6,d1
	bsr.w	sub_9ED8
	rts

; ---------------------------------------------------------------------------
sub_9D66:
	movem.l	d2-d3/a2,-(a7)
	moveq	#$0,d2
	move.b	($FFFFB4BD).w,d3
loc_9D70:
	move.b	($FFFFB4BE).w,d0
	bne.s	loc_9D7A
	move.w	-$2(a6),d0
loc_9D7A:
	btst	d2,d0
	beq.s	loc_9DC6
	move.l	#$FFFFD5AE,d0
	moveq	#$20,d1
	bsr.w	sub_9ED8
	tst.b	d3
	bne.s	loc_9DA4
	cmp.w	#$2,d2
	bne.s	loc_9DA4
	lea	($FFFFD5B0).w,a0
	lea	($FFFFB4EC).w,a2
	moveq	#$E,d0
loc_9D9E:
	move.w	(a0)+,(a2)+
	dbf	d0,loc_9D9E
loc_9DA4:
	move.w	d2,d0
	asl.w	#$5,d0
	tst.b	d3
	bne.s	loc_9DAE
	addq.w	#$6,d0
loc_9DAE:
	bsr.w	sub_8278
	moveq	#$F,d1
	lea	($FFFFD5AE).w,a0
	tst.b	d3
	bne.s	loc_9DC0
	subq.l	#$3,d1
	addq.l	#$6,a0
loc_9DC0:
	move.w	(a0)+,(a5)
	dbf	d1,loc_9DC0
loc_9DC6:
	addq.l	#$1,d2
	cmp.w	#$4,d2
	bne.s	loc_9D70
	movem.l	(a7)+,d2-d3/a2
	rts

; ---------------------------------------------------------------------------
sub_9DD4:
	link	a6,#-$C
	movem.l	d2/a2,-(a7)
	tst.b	($FFFFB4CD).w
	beq.s	loc_9E02
	lea	($FFFFB56A).w,a2
	lea	($FFFFA0F6).w,a1
	move.l	a1,$2(a2)
	move.l	a1,$8(a2)
	move.w	#$370,d0
	move.w	d0,-$C(a6)
	move.w	d0,(a2)
	move.w	d0,$6(a2)
	bra.s	loc_9E06
loc_9E02:
	bsr.w	sub_97CC
loc_9E06:
	move.w	d0,-$C(a6)
	move.l	a1,-$A(a6)
	bsr.w	sub_9D56
	move.l	$2(a2),d0
	move.w	-$4(a6),d1
	bsr.w	sub_9ED8
	bsr.w	sub_9D66
	moveq	#$0,d0
	move.w	(a2),d0
	asl.w	#$5,d0
	move.w	-$6(a6),d1
	asl.w	#$5,d1
	bsr.w	sub_9ED8
	move.w	-$6(a6),d0
	add.w	d0,$6(a2)
	moveq	#$0,d0
	move.w	-$4(a6),d0
	add.l	d0,$8(a2)
	asr.l	#$1,d0
	subq.l	#$1,d0
	bmi.s	loc_9E64
	movea.l	$2(a2),a1
loc_9E4E:
	move.w	(a1),d1
	move.w	d1,d2
	andi.w	#$3FF,d1
	andi.w	#$FC00,d2
	add.w	(a2),d1
	or.w	d1,d2
	move.w	d2,(a1)+
	dbf	d0,loc_9E4E
loc_9E64:
	movea.l	a2,a0
	clr.b	($FFFFB4BD).w
	clr.b	($FFFFB4CD).w
	movem.l	(a7)+,d2/a2
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_9E76:
	movem.l	d2-d7/a2-a3/a5,-(a7)
	move.l	a0,d0
	andi.l	#$FF0000,d0
	cmp.l	#$200000,d0
	bne.s	loc_9E8C
	moveq	#$1,d0
loc_9E8C:
	move.w	d0,($FFFFD830).w
	move.l	a0,($FFFFD81E).w
	lea	($FFFF0000).l,a2
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$0,d4
	move.b	d2,($FFFFD857).w
	move.w	#$102,($FFFFD822).l
	move.w	#$2,($FFFFD824).l
	move.b	#$1,($FFFFD82A).w
	move.w	#$9,($FFFFD82E).l
	move.w	#$1FF,($FFFFD82C).l
	movem.l	d2-d7/a2-a3/a5,($FFFFD832).l
	movem.l	(a7)+,d2-d7/a2-a3/a5
	rts

; ---------------------------------------------------------------------------
sub_9ED8:
	movem.l	d2-d7/a2-a3/a5,-(a7)
	movem.l	($FFFFD832).w,d2-d7/a2-a3/a5
	move.w	d1,d6
	beq.w	loc_9FF2
	swap	d0
	tst.w	d0
	bne.s	loc_9EFE
	movea.l	#$C00000,a5
	swap	d0
	bsr.w	sub_8288
	moveq	#$0,d7
	bra.s	loc_9F04
loc_9EFE:
	moveq	#$2,d7
	swap	d0
	movea.l	d0,a5
loc_9F04:
	tst.w	d2
	bne.w	loc_9F8A
loc_9F0A:
	bsr.w	sub_A092
	move.w	d0,d5
	cmp.w	#$101,d5
	beq.w	loc_9FF2
	tst.b	($FFFFD82A).w
	beq.s	loc_9F30
	clr.b	($FFFFD82A).w
	move.w	d5,($FFFFD826).w
	move.b	d5,($FFFFD828).w
	bsr.w	sub_A0DC
	bra.s	loc_9F0A
loc_9F30:
	cmp.w	#$100,d5
	bne.s	loc_9F56
	move.b	#$1,($FFFFD82A).w
	move.w	#$9,($FFFFD82E).w
	move.w	#$102,($FFFFD822).w
	move.w	#$2,($FFFFD824).w
	move.w	#$1FF,($FFFFD82C).w
	bra.s	loc_9F0A
loc_9F56:
	cmp.w	($FFFFD822).w,d5
	bcs.s	loc_9F70
	move.b	($FFFFD828).w,(a2)
	movea.l	a2,a0
	addq.l	#$1,a0
	move.w	($FFFFD826).w,d0
	bsr.w	sub_A00C
	movea.l	a0,a3
	bra.s	loc_9F7A
loc_9F70:
	movea.l	a2,a0
	move.w	d5,d0
	bsr.w	sub_A00C
	movea.l	a0,a3
loc_9F7A:
	move.b	(a3),($FFFFD828).w
	moveq	#$1,d2
loc_9F80:
	cmpa.l	a2,a3
	bcs.s	loc_9F8E
	move.b	(a3),d0
	bsr.w	sub_A0DC
loc_9F8A:
	subq.l	#$1,a3
	bra.s	loc_9F80
loc_9F8E:
	moveq	#$0,d2
	move.w	($FFFFD822).w,d0
	cmp.w	($FFFFD82C).w,d0
	bhi.s	loc_9FEA
	lea	($FFFF23BC).l,a0
	move.w	d0,d1
	asl.w	#$1,d0
	move.w	($FFFFD826).w,(a0,d0.w)
	lea	($FFFF1000).l,a0
	move.b	($FFFFD828).w,(a0,d1.w)
	addq.w	#$1,($FFFFD822).w
	addq.w	#$1,($FFFFD824).w
	move.w	($FFFFD822).w,d0
	cmp.w	($FFFFD82C).w,d0
	bne.s	loc_9FEA
	move.w	($FFFFD82E).w,d0
	cmp.w	#$C,d0
	bcc.s	loc_9FEA
	addq.w	#$1,($FFFFD82E).w
	moveq	#$1,d0
	move.w	($FFFFD82E).w,d1
	asl.l	d1,d0
	subq.l	#$1,d0
	move.w	d0,($FFFFD82C).w
	move.w	#$FFFF,($FFFFD824).w
loc_9FEA:
	move.w	d5,($FFFFD826).w
	bra.w	loc_9F0A
loc_9FF2:
	bclr	#$0,($FFFFD857).w
	beq.s	loc_9FFE
	move.b	($FFFFD856).w,(a5)
loc_9FFE:
	move.l	a5,d0
	movem.l	d2-d7/a2-a3/a5,($FFFFD832).w
	movem.l	(a7)+,d2-d7/a2-a3/a5
	rts

; ---------------------------------------------------------------------------
sub_A00C:
	movem.l	a2,-(a7)
	moveq	#$0,d1
	lea	($FFFF1000).l,a1
	lea	($FFFF23BC).l,a2
loc_A01E:
	cmp.w	#$FF,d0
	bls.s	loc_A03E
	move.b	(a1,d0.w),(a0)+
	asl.w	#$1,d0
	move.w	(a2,d0.w),d0
	addq.l	#$1,d1
	cmp.w	#$1000,d1
	bcc.s	loc_A046
	cmp.w	($FFFFD82C).w,d0
	bhi.s	loc_A06C
	bra.s	loc_A01E
loc_A03E:
	move.b	d0,(a0)
	movem.l	(a7)+,a2
	rts
loc_A046:
	lea	(dat_A052).l,a0
	jsr	(sub_132A6).l
dat_A052:
	binclude	"data/00A052.bin"
loc_A06C:
	lea	(dat_A078).l,a0
	jsr	(sub_132A6).l
dat_A078:
	binclude	"data/00A078.bin"

; ---------------------------------------------------------------------------
sub_A092:
	movea.l	($FFFFD81E).w,a0
loc_A096:
	cmp.w	#$18,d3
	bhi.s	loc_A0B0
	moveq	#$0,d0
	move.b	(a0)+,d0
	adda.w	($FFFFD830).w,a0
	moveq	#$18,d1
	sub.w	d3,d1
	asl.l	d1,d0
	or.l	d0,d4
	addq.l	#$8,d3
	bra.s	loc_A096
loc_A0B0:
	move.l	a0,($FFFFD81E).w
	moveq	#$21,d1
	sub.w	($FFFFD82E).w,d1
	move.l	d4,d0
	lsr.l	d1,d0
	move.w	($FFFFD82E).w,d1
	cmp.w	($FFFFD824).w,d0
	bhi.s	loc_A0D4
	asl.l	d1,d4
	bcc.s	loc_A0D8
	subq.w	#$1,d1
	bset	d1,d0
	addq.w	#$1,d1
	bra.s	loc_A0D8
loc_A0D4:
	subq.w	#$1,d1
	asl.l	d1,d4
loc_A0D8:
	sub.w	d1,d3
	rts

; ---------------------------------------------------------------------------
sub_A0DC:
	bchg	#$0,($FFFFD857).w
	bne.s	loc_A0EA
	move.b	d0,($FFFFD856).w
	bra.s	loc_A0F6
loc_A0EA:
	move.b	($FFFFD856).w,d1
	asl.w	#$8,d1
	move.b	d0,d1
	move.w	d1,(a5)
	adda.l	d7,a5
loc_A0F6:
	subq.w	#$1,d6
	beq.s	loc_A0FC
	rts
loc_A0FC:
	addq.l	#$4,a7
	bra.w	loc_9FF2

; ---------------------------------------------------------------------------
sub_A102:
	link	a6,#-$24
	movem.l	d2-d7/a2-a3,-(a7)
	move.b	($FFFF9BCB).w,-$20(a6)
	clr.b	($FFFF9BCB).w
	move.l	($FFFFB414).w,-$24(a6)
	asl.w	#$6,d0
	move.w	d0,-$8(a6)
	asl.w	#$6,d1
	move.w	d1,-$6(a6)
	lea	(dat_75910).l,a0
	bsr.w	sub_9DD4
	move.l	a0,-$12(a6)
	move.w	(a0),-$14(a6)
	lea	(dat_A668).l,a0
	move.b	(a0,d2.w),d0
	jsr	(sub_1B900).l
	lea	(dat_A5AA).l,a2
	mulu.w	#$A,d2
	adda.w	d2,a2
	move.b	$9(a2),d0
	beq.s	loc_A15E
	bsr.w	sub_975C
loc_A15E:
	clr.w	-$1E(a6)
	clr.w	-$1C(a6)
	btst	#$0,$5(a2)
	beq.w	loc_A1FC
	move.l	#$20,(a4)
	moveq	#$3F,d7
	lea	($FFFF0180).l,a0
	lea	($FFFF0240).l,a1
loc_A184:
	move.w	(a5),d0
	move.w	d0,(a1)+
	move.b	d0,d1
	andi.b	#$E,d1
	move.b	d1,(a0)+
	move.b	d0,d1
	lsr.b	#$4,d1
	move.b	d1,(a0)+
	lsr.w	#$8,d0
	move.b	d0,(a0)+
	dbf	d7,loc_A184
	moveq	#$3F,d7
	lea	($FFFF0180).l,a0
	lea	($FFFF00C0).l,a1
	lea	($FFFF0000).l,a3
	moveq	#$0,d3
loc_A1B4:
	move.b	(a0)+,d0
	move.b	(a0)+,d1
	move.b	(a0)+,d2
	move.b	d0,d3
	add.b	d1,d3
	add.b	d2,d3
	cmp.b	#$6,d3
	ble.s	loc_A1CA
	moveq	#$E,d4
	bra.s	loc_A1CC
loc_A1CA:
	moveq	#$0,d4
loc_A1CC:
	move.b	d4,(a3)+
	move.b	d4,(a3)+
	move.b	d4,(a3)+
	divu.w	#$3,d3
	asl.w	#$1,d3
	subq.b	#$8,d3
	bpl.s	loc_A1DE
	moveq	#$0,d3
loc_A1DE:
	cmp.b	#$E,d3
	bcs.s	loc_A1E6
	moveq	#$E,d3
loc_A1E6:
	move.b	d0,(a1)+
	move.b	d1,(a1)+
	move.b	d2,(a1)+
	dbf	d7,loc_A1B4
	move.w	#$4,-$1E(a6)
	move.w	#$10,-$1C(a6)
loc_A1FC:
	move.b	$3(a2),d6
	ext.w	d6
	ext.l	d6
	move.b	$4(a2),d0
	ext.w	d0
	ext.l	d0
	asl.l	#$8,d0
	asl.l	#$4,d0
	move.l	d0,d1
	divu.w	d6,d0
	neg.w	d0
	move.w	d0,-$A(a6)
	asl.l	#$1,d1
	move.w	d6,d0
	mulu.w	d0,d0
	divu.w	d0,d1
	move.w	d1,-$C(a6)
	clr.w	-$18(a6)
	move.b	(a2),d0
	asl.b	#$2,d0
	add.b	$1(a2),d0
	ext.w	d0
	move.w	d0,d1
	subq.l	#$1,d1
	move.w	d1,-$16(a6)
	moveq	#$9,d1
	bsr.w	sub_92AA
	movea.l	a0,a3
	move.w	$2(a3),d0
	add.w	d0,-$16(a6)
	moveq	#$0,d0
	moveq	#$0,d0
	move.b	(a2),d0
	add.b	$1(a2),d0
	move.w	d0,-$E(a6)
	subq.l	#$1,d0
	lea	($FFFF02C8).l,a0
loc_A262:
	move.w	#$FFFF,(a0)
	adda.w	#$E,a0
	dbf	d0,loc_A262
loc_A26E:
	bsr.w	sub_DEE6
	btst	#$2,$5(a2)
	beq.s	loc_A29C
	move.l	-$24(a6),($FFFFB414).w
	moveq	#$7,d0
	bsr.w	sub_6C94
	subq.w	#$3,d0
	add.w	d0,($FFFFB414).w
	moveq	#$7,d0
	bsr.w	sub_6C94
	subq.w	#$3,d0
	add.w	d0,($FFFFB416).w
	bsr.w	sub_100AC
loc_A29C:
	tst.w	-$1C(a6)
	beq.s	loc_A2D0
	bsr.w	sub_A68E
	cmpi.w	#$C,-$1C(a6)
	bhi.s	loc_A2CC
	tst.w	-$1E(a6)
	beq.s	loc_A2CC
	moveq	#$A,d0
	bsr.w	sub_6C8C
	cmp.w	-$1E(a6),d0
	bhi.s	loc_A2CC
	move.w	#$10,-$1C(a6)
	subq.w	#$1,-$1E(a6)
	bra.s	loc_A2D0
loc_A2CC:
	subq.w	#$1,-$1C(a6)
loc_A2D0:
	move.w	$2(a3),d0
	asl.w	#$3,d0
	addi.w	#$EC00,d0
	bsr.w	sub_8288
	moveq	#$0,d7
	move.w	$2(a3),d5
	lea	($FFFF02C0).l,a1
loc_A2EA:
	moveq	#$0,d4
	cmp.b	(a2),d7
	bcs.s	loc_A2F6
	move.w	#$C0,d4
	bra.s	loc_A2FA
loc_A2F6:
	move.w	#$100,d4
loc_A2FA:
	move.w	$8(a1),d0
	beq.w	loc_A402
	bpl.w	loc_A3AC
loc_A306:
	cmp.b	$8(a2),d6
	bcs.w	loc_A402
	clr.l	(a1)
	moveq	#$4,d0
	bsr.w	sub_6C94
	move.b	d0,$C(a1)
	moveq	#$41,d0
	bsr.w	sub_6C94
	move.w	d0,d2
	mulu.w	d0,d0
	subi.w	#$1000,d0
	neg.w	d0
	bsr.w	sub_6BD6
	move.w	d0,d3
	moveq	#$0,d0
	move.b	$2(a2),d0
	move.w	d0,d1
	lsr.w	#$2,d1
	sub.w	d1,d0
	move.w	d1,-(a7)
	bsr.w	sub_6C8C
	add.w	(a7)+,d0
	mulu.w	d0,d2
	mulu.w	d0,d3
	moveq	#$4,d0
	bsr.w	sub_6C94
	btst	#$0,d0
	beq.s	loc_A356
	neg.w	d2
loc_A356:
	btst	#$1,d0
	beq.s	loc_A35E
	neg.w	d3
loc_A35E:
	btst	#$1,$5(a2)
	beq.s	loc_A372
	move.w	d2,(a1)
	move.w	d3,$2(a1)
	clr.l	$4(a1)
	bra.s	loc_A382
loc_A372:
	ext.l	d2
	ext.l	d3
	divs.w	d6,d2
	divs.w	d6,d3
	move.w	d2,$4(a1)
	move.w	d3,$6(a1)
loc_A382:
	move.w	#$1,$8(a1)
	move.l	d4,d2
	move.l	d6,d3
	move.b	$7(a2),d0
	bsr.w	sub_6C94
	add.b	$6(a2),d0
	ext.w	d0
	mulu.w	d0,d3
	lsr.w	#$6,d3
	bne.s	loc_A3A2
	moveq	#$1,d3
loc_A3A2:
	divu.w	d3,d2
	addq.l	#$1,d2
	move.w	d2,$A(a1)
	bra.s	loc_A3CA
loc_A3AC:
	move.w	$4(a1),d0
	add.w	d0,(a1)
	move.w	$6(a1),d0
	add.w	d0,$2(a1)
	move.w	$A(a1),d0
	add.w	d0,$8(a1)
	cmp.w	$8(a1),d4
	bcs.w	loc_A306
loc_A3CA:
	move.w	$8(a1),d0
	lsr.w	#$6,d0
	cmp.w	#$3,d0
	bcc.s	loc_A3F2
	cmp.b	(a2),d7
	bcs.s	loc_A3E0
	bsr.w	sub_A4C4
	bra.s	loc_A41A
loc_A3E0:
	bsr.w	sub_A4C4
	moveq	#$2,d2
loc_A3E6:
	moveq	#-$1,d0
	bsr.w	sub_A4C4
	dbf	d2,loc_A3E6
	bra.s	loc_A41A
loc_A3F2:
	moveq	#$3,d2
loc_A3F4:
	move.l	d2,d0
	addq.l	#$3,d0
	bsr.w	sub_A4C4
	dbf	d2,loc_A3F4
	bra.s	loc_A41A
loc_A402:
	cmp.b	(a2),d7
	bcs.s	loc_A40E
	moveq	#-$1,d0
	bsr.w	sub_A4C4
	bra.s	loc_A41A
loc_A40E:
	moveq	#$3,d2
loc_A410:
	moveq	#-$1,d0
	bsr.w	sub_A4C4
	dbf	d2,loc_A410
loc_A41A:
	adda.w	#$E,a1
	addq.l	#$1,d7
	cmp.w	-$E(a6),d7
	bne.w	loc_A2EA
	move.w	-$C(a6),d0
	add.w	d0,-$A(a6)
	move.w	-$A(a6),d0
	asr.w	#$4,d0
	add.w	d0,-$6(a6)
	tst.w	-$18(a6)
	bne.s	loc_A45C
	st	-$18(a6)
	move.l	#$2C020003,(a4)
	move.w	(a5),d2
	andi.w	#$FF80,d2
	or.w	$2(a3),d2
	move.l	#$6C020003,(a4)
	move.w	d2,(a5)
loc_A45C:
	dbf	d6,loc_A26E
	move.l	#$2C020003,(a4)
	move.w	(a5),d2
	andi.w	#$FF80,d2
	or.w	$4(a3),d2
	move.l	#$6C020003,(a4)
	move.w	d2,(a5)
	movea.l	a3,a0
	bsr.w	sub_9240
	lea	-$12(a6),a0
	bsr.w	sub_9784
	btst	#$0,$5(a2)
	beq.w	loc_A4A4
	move.l	#$C0000000,(a4)
	moveq	#$3F,d7
	lea	($FFFF0240).l,a1
loc_A49E:
	move.w	(a1)+,(a5)
	dbf	d7,loc_A49E
loc_A4A4:
	btst	#$2,$5(a2)
	beq.s	loc_A4B6
	move.l	-$24(a6),($FFFFB414).w
	bsr.w	sub_100AC
loc_A4B6:
	move.b	-$20(a6),($FFFF9BCB).w
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_A4C4:
	movem.l	d2/d4,-(a7)
	tst.b	$9(a2)
	bne.s	loc_A4D6
	move.w	#$A000,-$1A(a6)
	bra.s	loc_A4DC
loc_A4D6:
	move.w	#$E000,-$1A(a6)
loc_A4DC:
	lea	(dat_A57A).l,a0
	move.w	d5,d2
	addq.l	#$1,d2
	cmp.w	-$16(a6),d5
	bne.s	loc_A4F0
	move.w	$4(a3),d2
loc_A4F0:
	tst.w	d0
	bmi.s	loc_A564
	move.w	d0,d1
	move.w	$2(a1),d4
	btst	#$1,$C(a1)
	beq.s	loc_A504
	addq.l	#$8,d1
loc_A504:
	move.b	$18(a0,d1.w),d1
	ext.w	d1
	asl.w	#$6,d1
	add.w	d1,d4
	add.w	-$6(a6),d4
	asr.w	#$6,d4
	addi.w	#$80,d4
	move.w	d4,(a5)
	move.b	$28(a0,d0.w),d1
	asl.w	#$8,d1
	add.w	d2,d1
	move.w	d1,(a5)
	move.b	$C(a1),d1
	asl.w	#$8,d1
	asl.w	#$3,d1
	or.w	-$1A(a6),d1
	add.w	-$14(a6),d1
	move.b	(a0,d0.w),d4
	ext.w	d4
	add.w	d4,d1
	move.w	d1,(a5)
	move.w	d0,d1
	move.w	(a1),d4
	btst	#$0,$C(a1)
	beq.s	loc_A54C
	addq.l	#$8,d1
loc_A54C:
	move.b	$8(a0,d1.w),d1
	ext.w	d1
	asl.w	#$6,d1
	add.w	d1,d4
	add.w	-$8(a6),d4
	asr.w	#$6,d4
	addi.w	#$80,d4
	move.w	d4,(a5)
	bra.s	loc_A572
loc_A564:
	move.w	#$160,(a5)
	move.w	d2,(a5)
	move.w	#$0,(a5)
	move.w	#$1,(a5)
loc_A572:
	addq.l	#$1,d5
	movem.l	(a7)+,d2/d4
	rts
dat_A57A:
	binclude	"data/00A57A.bin"
dat_A5AA:
	binclude	"data/00A5AA.bin"
dat_A668:
	binclude	"data/00A668.bin"

; ---------------------------------------------------------------------------
sub_A68E:
	movem.l	d2-d7,-(a7)
	move.l	#$C0000000,(a4)
	move.w	-$1C(a6),d6
	subq.l	#$8,d6
	bmi.s	loc_A6AE
	lea	($FFFF0000).l,a0
	lea	($FFFF00C0).l,a1
	bra.s	loc_A6BC
loc_A6AE:
	lea	($FFFF00C0).l,a0
	lea	($FFFF0180).l,a1
	addq.l	#$8,d6
loc_A6BC:
	moveq	#$3F,d7
loc_A6BE:
	moveq	#$0,d0
	moveq	#$0,d1
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$0,d4
	moveq	#$0,d5
	move.b	(a0)+,d0
	move.b	(a0)+,d1
	move.b	(a0)+,d2
	mulu.w	d6,d0
	mulu.w	d6,d1
	mulu.w	d6,d2
	neg.w	d6
	addq.l	#$8,d6
	move.b	(a1)+,d3
	move.b	(a1)+,d4
	move.b	(a1)+,d5
	mulu.w	d6,d3
	mulu.w	d6,d4
	mulu.w	d6,d5
	add.w	d3,d0
	add.w	d4,d1
	add.w	d5,d2
	lsr.w	#$3,d0
	cmp.w	#$E,d0
	bls.s	loc_A6F6
	moveq	#$E,d0
loc_A6F6:
	lsr.w	#$3,d1
	cmp.w	#$E,d1
	bls.s	loc_A700
	moveq	#$E,d1
loc_A700:
	lsr.w	#$3,d2
	cmp.w	#$E,d2
	bls.s	loc_A70A
	moveq	#$E,d2
loc_A70A:
	asl.w	#$4,d1
	asl.w	#$8,d2
	add.w	d2,d1
	add.w	d1,d0
	move.w	d0,(a5)
	dbf	d7,loc_A6BE
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_A71E:
	movem.l	d2-d6,-(a7)
	move.b	d5,($FFFFD5E4).w
	lea	(dat_51102).l,a0
	move.l	#$40C00000,(a4)
	move.w	#$1FF,d1
loc_A736:
	move.b	(a0)+,d0
	moveq	#$7,d2
	move.w	#$1C,d4
	move.w	#$1D,d6
	sub.l	d3,d3
loc_A744:
	btst	d2,d0
	beq.w	loc_A74E
	bset	d4,d3
	bra.s	loc_A754
loc_A74E:
	tst.w	d5
	beq.s	loc_A754
	bset	d6,d3
loc_A754:
	subq.l	#$4,d4
	subq.l	#$4,d6
	dbf	d2,loc_A744
	move.l	d3,(a5)
	dbf	d1,loc_A736
	movem.l	(a7)+,d2-d6
	rts

; ---------------------------------------------------------------------------
sub_A768:
	movem.l	d2-d4/a2-a3,-(a7)
	movea.l	a0,a3
	cmpa.l	($FFFFD57E).w,a3
	beq.s	loc_A7B6
	lea	($FFFFB532).w,a0
	bsr.w	sub_9784
	move.l	a3,($FFFFD57E).w
	beq.s	loc_A7B6
	bsr.w	sub_97CC
loc_A786:
	moveq	#$0,d0
	move.b	(a3)+,d0
	cmp.b	#$FF,d0
	beq.s	loc_A7B2
	asl.w	#$2,d0
	lea	(dat_F14F2).l,a0
	movea.l	(a0,d0.w),a0
	bsr.w	sub_9DD4
	move.l	$6(a0),$6(a2)
	move.l	$8(a0),$8(a2)
	subq.l	#$6,($FFFFB43C).w
	bra.s	loc_A786
loc_A7B2:
	move.l	a2,($FFFFB532).w
loc_A7B6:
	movem.l	(a7)+,d2-d4/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_A7BC:
	moveq	#$0,d0
	move.b	(a0),d0
	lea	(dat_A802).l,a1
	move.b	(a1,d0.w),d0
	cmp.b	#$13,d0
	beq.s	loc_A7EE
	cmp.b	#$14,d0
	beq.s	loc_A7EE
	tst.b	d0
	bpl.s	loc_A7FC
	cmp.b	#$FF,d0
	beq.s	loc_A7FC
	moveq	#$0,d1
	move.b	$4(a0),d1
	mulu.w	#$12,d1
	add.b	d1,d0
	bra.s	loc_A7FC
loc_A7EE:
	move.b	$5(a0),d1
	andi.b	#$30,d1
	beq.s	loc_A7FC
	addi.b	#$59,d0
loc_A7FC:
	cmp.b	#$FF,d0
	rts
dat_A802:
	binclude	"data/00A802.bin"
dat_A829:
	binclude	"data/00A829.bin"

; ---------------------------------------------------------------------------
sub_A850:
	bsr.w	sub_A7BC
	beq.s	loc_A858
	bra.s	sub_A85A
loc_A858:
	rts

; ---------------------------------------------------------------------------
sub_A85A:
	movem.l	d4-d7,-(a7)
	cmp.b	#$FF,d0
	beq.w	loc_A990
	cmp.b	#$80,d0
	bcc.s	loc_A8AE
loc_A86C:
	movea.l	($FFFFD57E).w,a1
	moveq	#$0,d4
loc_A872:
	move.b	(a1)+,d5
	bmi.w	loc_A990
	cmp.b	d0,d5
	beq.s	loc_A880
	addq.l	#$1,d4
	bra.s	loc_A872
loc_A880:
	move.l	d4,d0
	movea.l	($FFFFB532).w,a0
	move.w	#$F000,d1
	moveq	#$3,d4
	moveq	#$3,d5
	move.w	#$FFFF,($FFFFB510).w
	move.w	#$8000,($FFFFB512).w
	clr.w	($FFFFB50E).w
	move.l	#$9682,($FFFFB516).w
	bsr.w	sub_961C
	bra.w	loc_A990
loc_A8AE:
	cmp.b	#$8C,d0
	bcc.s	loc_A904
	cmp.b	#$88,d0
	bcc.s	loc_A8C2
	subi.b	#$80,d0
	bsr.w	sub_6F02
loc_A8C2:
	tst.b	(a0)
	beq.s	loc_A8FE
	move.b	$11(a0),d0
	bmi.s	loc_A8FE
	ext.w	d0
	tst.b	($FFFFB4C6).w
	bne.s	loc_A8DE
	asl.w	#$1,d0
	tst.b	(a0)
	bpl.s	loc_A8E8
	addq.w	#$1,d0
	bra.s	loc_A8E8
loc_A8DE:
	asl.w	#$2,d0
	addq.w	#$1,d0
	tst.b	(a0)
	bpl.s	loc_A8E8
	addq.w	#$2,d0
loc_A8E8:
	movea.l	($FFFFB582).w,a0
	bsr.w	sub_94DC
	move.w	#$1,($FFFFB514).w
	bsr.w	sub_A9A4
	bra.w	loc_A990
loc_A8FE:
	moveq	#$4E,d0
	bra.w	loc_A86C
loc_A904:
	subi.b	#$8C,d0
	ext.w	d0
	ext.l	d0
	divu.w	#$12,d0
	move.w	d0,d6
	cmp.w	#$5,d6
	bcs.s	loc_A91A
	moveq	#$4,d6
loc_A91A:
	swap	d0
	move.w	d0,d7
	addq.w	#$8,d7
	addq.w	#$1,d6
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$2,d0
	beq.s	loc_A93A
	move.w	d6,($FFFFB514).w
	bsr.w	sub_A9A4
	move.w	d7,d0
	bra.w	loc_A86C
loc_A93A:
	movea.l	($FFFFB422).w,a0
	move.w	$2(a0),d5
	cmp.w	#$A,d2
	bcs.s	loc_A94A
	addq.w	#$1,d5
loc_A94A:
	asl.w	#$3,d5
	addi.w	#$EC00,d5
	move.w	d3,d4
	move.w	d5,d0
	bsr.w	sub_A996
	addq.w	#$6,d5
	move.w	d2,d4
	move.w	d5,d0
	bsr.w	sub_A996
	asl.w	#$5,d6
	move.w	d6,d0
	bsr.w	sub_829C
	move.l	(a5),d5
	move.l	(a5),d6
	move.w	(a0),d0
	cmp.w	#$A,d2
	bcs.s	loc_A97A
	addi.w	#$9,d0
loc_A97A:
	asl.w	#$5,d0
	bsr.w	sub_8288
	moveq	#$23,d0
loc_A982:
	move.l	d5,(a5)
	move.l	d6,(a5)
	dbf	d0,loc_A982
	move.w	d7,d0
	bra.w	loc_A86C
loc_A990:
	movem.l	(a7)+,d4-d7
	rts

; ---------------------------------------------------------------------------
sub_A996:
	bsr.w	sub_8288
	asl.w	#$3,d4
	addi.w	#$80,d4
	move.w	d4,(a5)
	rts

; ---------------------------------------------------------------------------
sub_A9A4:
	bsr.w	sub_C87A
	moveq	#$0,d0
	movea.l	d0,a0
	moveq	#$10,d1
	moveq	#$3,d4
	moveq	#$3,d5
	bsr.w	sub_95BE
	rts

; ---------------------------------------------------------------------------
sub_A9B8:
	movem.l	d2-d4/a2,-(a7)
	moveq	#$0,d4
loc_A9BE:
	move.b	(a2)+,d2
	bmi.s	loc_A9E4
	ext.w	d2
	move.b	(a2)+,d3
	ext.w	d3
	move.b	(a2)+,d0
	tst.b	($FFFFD59A).w
	beq.s	loc_A9DA
	cmp.b	($FFFFD593).w,d4
	bne.s	loc_A9DA
	move.b	($FFFFD59A).w,d0
loc_A9DA:
	ext.w	d0
	bsr.w	sub_A85A
	addq.l	#$1,d4
	bra.s	loc_A9BE
loc_A9E4:
	movem.l	(a7)+,d2-d4/a2
	rts

; ---------------------------------------------------------------------------
sub_A9EA:
	movem.l	d2-d6/a2-a3,-(a7)
	bsr.s	sub_A9B8
loc_A9F0:
	move.b	(a2)+,d2
	bmi.s	loc_AA46
	subq.b	#$1,d2
	ext.w	d2
	move.b	(a2)+,d3
	subq.b	#$2,d3
	ext.w	d3
	addq.l	#$1,a2
	addq.l	#$1,a3
	moveq	#$0,d6
	move.b	(a3)+,d6
	bgt.s	loc_AA18
	moveq	#$20,d1
	moveq	#$5,d4
	moveq	#$2,d5
	clr.w	($FFFFB514).w
	bsr.w	sub_95BE
	bra.s	loc_AA28
loc_AA18:
	movea.l	($FFFFB54E).w,a0
	moveq	#$4,d1
	moveq	#$5,d4
	moveq	#$2,d5
	moveq	#$0,d0
	bsr.w	sub_95BE
loc_AA28:
	addq.w	#$2,d3
	addq.w	#$4,d2
	move.w	d6,d4
	cmp.w	#$6,d4
	bls.s	loc_AA36
	moveq	#$6,d4
loc_AA36:
	bsr.w	sub_AA4C
	subq.w	#$4,d2
	move.w	d6,d4
	subq.w	#$6,d4
	bsr.w	sub_AA4C
	bra.s	loc_A9F0
loc_AA46:
	movem.l	(a7)+,d2-d6/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_AA4C:
	movem.l	d2-d6,-(a7)
	moveq	#$2,d6
	movea.l	($FFFFB54E).w,a0
	move.w	(a0),d5
	asl.w	#$1,d2
	asl.w	#$7,d3
	add.w	d2,d3
	addi.w	#$F000,d3
loc_AA62:
	tst.w	d4
	ble.s	loc_AA7C
	subq.w	#$2,d4
	bmi.s	loc_AA74
	move.w	#$8,d2
	bsr.w	sub_AA94
	bra.s	loc_AA86
loc_AA74:
	moveq	#$9,d2
	bsr.w	sub_AA94
	bra.s	loc_AA86
loc_AA7C:
	move.w	d3,d0
	bsr.w	sub_8288
	move.w	#$0,(a5)
loc_AA86:
	addi.w	#$80,d3
	dbf	d6,loc_AA62
	movem.l	(a7)+,d2-d6
	rts

; ---------------------------------------------------------------------------
sub_AA94:
	move.w	d3,d0
	bsr.w	sub_8288
	add.w	d5,d2
	ori.w	#$8000,d2
	move.w	d2,(a5)
	rts

; ---------------------------------------------------------------------------
sub_AAA4:
	movem.l	d2-d5,-(a7)
	asl.w	#$7,d1
	asl.w	#$1,d0
	add.w	d1,d0
	addi.w	#$F000,d0
	bsr.w	sub_8288
	movea.l	($FFFFB546).w,a0
	move.w	(a0),d0
	addi.w	#$800D,d0
	move.w	d3,d1
	asr.w	#$3,d1
	subq.w	#$1,d1
	bmi.s	loc_AAD6
loc_AAC8:
	move.w	d0,(a5)
	tst.w	d5
	beq.s	loc_AAD2
	subq.l	#$1,d5
	addq.l	#$1,d0
loc_AAD2:
	dbf	d1,loc_AAC8
loc_AAD6:
	move.w	d3,d2
	andi.w	#$7,d2
	beq.s	loc_AAE6
	subq.l	#$8,d2
	neg.w	d2
	add.w	d0,d2
	move.w	d2,(a5)
loc_AAE6:
	addq.l	#$7,d3
	asr.w	#$3,d3
	asr.w	#$3,d4
	sub.w	d3,d4
	ble.s	loc_AAFA
	subq.l	#$1,d4
	addq.l	#$8,d0
loc_AAF4:
	move.w	d0,(a5)
	dbf	d4,loc_AAF4
loc_AAFA:
	movem.l	(a7)+,d2-d5
	rts

; ---------------------------------------------------------------------------
sub_AB00:
	movem.l	d3-d6/a2-a3,-(a7)
	move.w	d0,d6
	bsr.w	sub_6F02
	move.b	$2(a0),d0
	bsr.w	sub_6F14
	movea.l	a0,a3
	movea.l	a1,a2
	bset	#$7,d0
	bsr.w	sub_A85A
	move.w	d6,d0
	moveq	#$0,d4
	move.b	$E(a3),d4
	move.b	(a3),d0
	beq.s	loc_AB30
	andi.b	#$C0,d0
	beq.s	loc_AB32
loc_AB30:
	moveq	#$0,d4
loc_AB32:
	mulu.w	#$18,d4
	moveq	#$0,d1
	move.b	$2E(a2),d1
	beq.s	loc_AB42
	divu.w	d1,d4
	bra.s	loc_AB44
loc_AB42:
	moveq	#$0,d4
loc_AB44:
	move.l	d2,d0
	move.l	d3,d1
	addq.l	#$3,d1
	move.w	d4,d3
	moveq	#$18,d4
	moveq	#$0,d5
	bsr.w	sub_AAA4
	movem.l	(a7)+,d3-d6/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_AB5A:
	movem.l	d2-d4/d6-d7,-(a7)
	tst.w	d7
	smi	d4
	bpl.s	loc_AB66
	neg.w	d7
loc_AB66:
	moveq	#$0,d6
loc_AB68:
	move.l	d6,d0
	bsr.w	sub_6F02
	move.b	(a0),d0
	cmp.b	#$0,d0
	beq.s	loc_AB90
	btst	#$0,d6
	bne.s	loc_AB80
	moveq	#$2,d2
	bra.s	loc_AB82
loc_AB80:
	moveq	#$15,d2
loc_AB82:
	move.w	d6,d3
	asr.w	#$1,d3
	mulu.w	#$5,d3
	addq.l	#$2,d3
	bsr.w	sub_AC6C
loc_AB90:
	addq.l	#$1,d6
	cmp.w	d6,d7
	bne.s	loc_AB68
	movem.l	(a7)+,d2-d4/d6-d7
	rts

; ---------------------------------------------------------------------------
sub_AB9C:
	movem.l	d2-d3/a2-a3,-(a7)
	move.w	#$3,($FFFFD5AA).w
	move.l	d6,d0
	bsr.w	sub_6EF0
	tst.b	d4
	bne.s	loc_ABB8
	bset	#$7,d0
	bsr.w	sub_A85A
loc_ABB8:
	move.w	d2,($FFFFD5D6).w
	move.w	d3,($FFFFD5D8).w
	addq.w	#$3,($FFFFD5D8).w
	move.b	d6,d0
	bsr.w	sub_11C5E
	move.w	d2,d0
	addq.l	#$4,d0
	move.w	d3,d1
	bsr.w	sub_AC2A
	move.w	d2,($FFFFD5D6).w
	addq.w	#$4,($FFFFD5D6).w
	move.w	d3,($FFFFD5D8).w
	addq.w	#$1,($FFFFD5D8).w
	moveq	#$35,d0
	bsr.w	sub_11C8E
	move.b	$E(a3),d0
	tst.b	(a3)
	bpl.s	loc_ABF4
	moveq	#$0,d0
loc_ABF4:
	jsr	(sub_13322).l
	bsr.w	sub_11CA0
	tst.b	d4
	bne.s	loc_AC24
	move.w	d2,($FFFFD5D6).w
	addq.w	#$4,($FFFFD5D6).w
	addq.w	#$1,($FFFFD5D8).w
	moveq	#$36,d0
	bsr.w	sub_11C8E
	moveq	#$3C,d0
	sub.b	$4(a3),d0
	jsr	(sub_1330E).l
	bsr.w	sub_11CA0
loc_AC24:
	movem.l	(a7)+,d2-d3/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_AC2A:
	movem.l	d3-d5,-(a7)
	move.b	$2E(a2),d4
	cmp.b	#$70,d4
	bls.s	loc_AC3A
	moveq	#$70,d4
loc_AC3A:
	addq.w	#$7,d4
	andi.w	#$F8,d4
	moveq	#$0,d3
	move.b	(a3),d5
	beq.s	loc_AC50
	andi.b	#$C0,d5
	bne.s	loc_AC50
	move.b	$E(a3),d3
loc_AC50:
	mulu.w	d4,d3
	moveq	#$0,d5
	move.b	$2E(a2),d5
	bne.s	loc_AC5E
	moveq	#$0,d3
	bra.s	loc_AC60
loc_AC5E:
	divu.w	d5,d3
loc_AC60:
	moveq	#$0,d5
	bsr.w	sub_AAA4
	movem.l	(a7)+,d3-d5
	rts

; ---------------------------------------------------------------------------
sub_AC6C:
	movem.l	d2-d3/a2-a3,-(a7)
	bsr.w	sub_AB9C
	tst.b	d4
	bne.s	loc_AC96
	move.b	d6,d0
	bsr.w	sub_6EF0
	addi.l	#$A,d2
	addq.l	#$1,d3
	moveq	#$1F,d0
	add.b	$18(a2),d0
	bsr.w	sub_A85A
	addq.l	#$4,d2
	bsr.w	sub_751C
loc_AC96:
	movem.l	(a7)+,d2-d3/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_AC9C:
	movem.l	d2-d7/a2-a3,-(a7)
	moveq	#$0,d7
	movea.l	($FFFFB582).w,a0
	movem.w	($FFFFB40C).w,d4-d5
	tst.w	d4
	bmi.s	loc_ACBA
	lea	(sub_AE92).l,a2
	bsr.w	sub_ACD8
loc_ACBA:
	move.w	($FFFFB408).w,d4
	move.w	($FFFFB40A).w,d5
	movem.w	d4-d5,($FFFFB40C).w
	lea	(sub_AE9E).l,a2
	bsr.w	sub_ACD8
	movem.l	(a7)+,d2-d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_ACD8:
	link	a6,#-$A
	move.w	#$A000,-$A(a6)
	divu.w	#$18,d4
	divu.w	#$18,d5
	move.w	($FFFFBA64).w,d6
	lea	($FFFFC470).w,a3
	bra.s	loc_AD0E
loc_ACF4:
	move.b	(a3),d0
	bpl.s	loc_AD0A
	andi.b	#$40,d0
	bne.s	loc_AD0A
	btst	#$2,$1(a3)
	bne.s	loc_AD0A
	bsr.w	sub_AD92
loc_AD0A:
	adda.w	#$1A,a3
loc_AD0E:
	dbf	d6,loc_ACF4
	move.w	($FFFFBA64).w,d6
	lea	($FFFFC470).w,a3
	bra.s	loc_AD36
loc_AD1C:
	move.b	(a3),d0
	ble.s	loc_AD32
	andi.b	#$40,d0
	bne.s	loc_AD32
	btst	#$2,$1(a3)
	bne.s	loc_AD32
	bsr.w	sub_AD92
loc_AD32:
	adda.w	#$1A,a3
loc_AD36:
	dbf	d6,loc_AD1C
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_AD3E:
	lea	(sub_AE92).l,a0
	bra.s	loc_AD60

; ---------------------------------------------------------------------------
sub_AD46:
	lea	(sub_AEC6).l,a0
	move.w	#$9FFF,($FFFFB510).w
	move.w	#$6000,($FFFFB512).w
	bra.s	loc_AD60

; ---------------------------------------------------------------------------
sub_AD5A:
	lea	(sub_AE9E).l,a0
loc_AD60:
	link	a6,#-$A
	move.w	#$A000,-$A(a6)
	movem.l	d2-d7/a2,-(a7)
	movea.l	a0,a2
	movea.l	($FFFFB582).w,a0
	move.w	($FFFFB408).w,d4
	move.w	($FFFFB40A).w,d5
	divu.w	#$18,d4
	divu.w	#$18,d5
	moveq	#$0,d7
	bsr.w	sub_AD92
	movem.l	(a7)+,d2-d7/a2
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_AD92:
	move.l	d6,-(a7)
	btst	#$2,$1(a3)
	bne.w	loc_AE8E
	move.b	$2(a3),d0
	bsr.w	sub_6F14
	move.b	$23(a1),d0
	cmp.b	#$3,d0
	bne.s	loc_ADC8
	move.w	#$2,-$6(a6)
	move.w	#$5,-$8(a6)
	move.w	#$C,-$4(a6)
	st	-$2(a6)
	bra.s	loc_ADFC
loc_ADC8:
	cmp.b	#$2,d0
	bne.s	loc_ADE6
	move.w	#$5,-$6(a6)
	move.w	#$2,-$8(a6)
	move.w	#$6,-$4(a6)
	st	-$2(a6)
	bra.s	loc_ADFC
loc_ADE6:
	move.w	#$2,-$6(a6)
	move.w	#$2,-$8(a6)
	move.w	#$6,-$4(a6)
	clr.b	-$2(a6)
loc_ADFC:
	moveq	#$0,d2
	move.b	$12(a3),d2
	sub.w	d4,d2
	cmp.w	#$15,d2
	bcc.w	loc_AE8E
	moveq	#$0,d3
	move.b	$13(a3),d3
	sub.w	d5,d3
	cmp.w	#$15,d3
	bcc.s	loc_AE8E
	asl.w	#$7,d3
	asl.w	#$1,d2
	add.w	d2,d3
	mulu.w	#$3,d3
	add.w	-$A(a6),d3
	moveq	#$0,d6
	move.b	$11(a3),d0
	asl.b	#$2,d0
	btst	#$7,(a3)
	beq.s	loc_AE44
	tst.b	-$2(a6)
	bne.s	loc_AE40
	addq.b	#$3,d0
	bra.s	loc_AE6A
loc_AE40:
	addq.b	#$6,d0
	bra.s	loc_AE6A
loc_AE44:
	lea	(dat_FDBF).l,a1
	moveq	#$0,d1
	move.b	$10(a3),d1
	move.b	(a1,d1.w),d1
	cmp.b	#$2,d1
	bls.s	loc_AE60
	moveq	#$1,d1
	move.w	#$800,d6
loc_AE60:
	add.b	d1,d0
	tst.b	-$2(a6)
	beq.s	loc_AE6A
	add.b	d1,d0
loc_AE6A:
	ext.w	d0
	movea.l	$2(a0),a1
	tst.w	d0
	beq.s	loc_AE7A
	mulu.w	#$12,d0
	adda.w	d0,a1
loc_AE7A:
	move.w	-$6(a6),d2
loc_AE7E:
	move.w	d3,d0
	bsr.w	sub_8288
	jsr	(a2)
	addi.w	#$80,d3
	dbf	d2,loc_AE7E
loc_AE8E:
	move.l	(a7)+,d6
	rts

; ---------------------------------------------------------------------------
sub_AE92:
	move.w	-$8(a6),d0
loc_AE96:
	move.w	d7,(a5)
	dbf	d0,loc_AE96
	rts

; ---------------------------------------------------------------------------
sub_AE9E:
	tst.w	d6
	bne.s	loc_AEAE
	move.w	-$8(a6),d0
loc_AEA6:
	move.w	(a1)+,(a5)
	dbf	d0,loc_AEA6
	rts
loc_AEAE:
	move.w	-$8(a6),d0
	asl.w	#$1,d0
loc_AEB4:
	move.w	(a1,d0.w),d1
	eor.w	d6,d1
	move.w	d1,(a5)
	subq.w	#$2,d0
	bpl.s	loc_AEB4
	adda.w	-$4(a6),a1
	rts

; ---------------------------------------------------------------------------
sub_AEC6:
	tst.w	d6
	bne.s	loc_AEE0
	move.w	-$8(a6),d1
loc_AECE:
	move.w	(a1)+,d0
	and.w	($FFFFB510).w,d0
	or.w	($FFFFB512).w,d0
	move.w	d0,(a5)
	dbf	d1,loc_AECE
	rts
loc_AEE0:
	move.w	-$8(a6),d0
	asl.w	#$1,d0
loc_AEE6:
	move.w	(a1,d0.w),d1
	eor.w	d6,d1
	and.w	($FFFFB510).w,d1
	or.w	($FFFFB512).w,d1
	move.w	d1,(a5)
	subq.w	#$2,d0
	bpl.s	loc_AEE6
	adda.w	-$4(a6),a1
	rts

; ---------------------------------------------------------------------------
sub_AF00:
	move.b	($FFFFBA5E).w,d0
	bne.s	loc_AF0A
	move.b	($FFFF9BBC).w,d0
loc_AF0A:
	cmp.b	#$7,d0
	bne.s	loc_AF16
	bsr.w	sub_8882
	bra.s	loc_AF5C
loc_AF16:
	cmp.b	#$6,d0
	bne.s	loc_AF22
	bsr.w	sub_87D0
	bra.s	loc_AF5C
loc_AF22:
	cmp.b	#$0,d0
	bne.s	loc_AF52
	bsr.w	sub_85D6
	bsr.w	sub_862A
	bsr.w	sub_8360
	bsr.w	sub_8A76
	bsr.w	sub_8A60
	moveq	#$0,d0
	bsr.w	sub_A71E
	bsr.w	sub_B0DA
	moveq	#$0,d0
	bsr.w	sub_8A90
	bsr.w	sub_860E
	bra.s	loc_AF5C
loc_AF52:
	jsr	(sub_BEFC).l
	bsr.w	sub_8710
loc_AF5C:
	rts

; ---------------------------------------------------------------------------
sub_AF5E:
	link	a6,#-$2
	movem.l	d2-d7/a2-a3,-(a7)
	sub.w	d0,d2
	sub.w	d1,d3
	asl.w	#$1,d0
	asl.w	#$7,d1
	add.w	d0,d1
	addi.w	#$C000,d1
	move.w	d1,d5
	ext.w	d4
	tst.w	d4
	bpl.s	loc_AFC8
	lea	($FFFFD5AE).w,a2
	moveq	#$4,d0
	bsr.w	sub_6C8C
	addq.w	#$1,d0
	move.b	d0,(a2)
	moveq	#$4,d0
	bsr.w	sub_6C8C
	addq.w	#$1,d0
	move.b	d0,$1(a2)
	bsr.w	sub_6C94
	move.b	d0,$2(a2)
	lea	($FFFFD5B1).w,a3
	moveq	#$0,d0
	move.b	(a2),d0
	moveq	#$0,d1
	move.b	$1(a2),d1
	mulu.w	d0,d1
	move.l	d1,d7
	subq.l	#$1,d7
	move.l	($FFFFD604).w,d1
loc_AFB6:
	moveq	#$0,d0
	btst	d7,d1
	beq.s	loc_AFBE
	moveq	#$1,d0
loc_AFBE:
	move.b	d0,(a3,d7.w)
	dbf	d7,loc_AFB6
	bra.s	loc_AFDA
loc_AFC8:
	lea	(dat_B05A).l,a2
	move.b	(a2,d4.w),d4
	ext.w	d4
	adda.w	d4,a2
	movea.l	a2,a3
	addq.w	#$3,a3
loc_AFDA:
	clr.w	-$2(a6)
loc_AFDE:
	move.w	d2,d4
	move.w	d5,d0
	bsr.w	sub_8288
	moveq	#$0,d6
	move.w	-$2(a6),d7
loc_AFEC:
	moveq	#$0,d0
	move.b	(a2),d0
	mulu.w	d7,d0
	add.w	d6,d0
	move.b	(a3,d0.w),d0
	cmp.b	#$0,d0
	bne.s	loc_B004
	move.w	#$277E,(a5)
	bra.s	loc_B014
loc_B004:
	cmp.b	#$1,d0
	bne.s	loc_B010
	move.w	#$2F7E,(a5)
	bra.s	loc_B014
loc_B010:
	move.w	#$774,(a5)
loc_B014:
	addq.l	#$1,d6
	cmp.b	(a2),d6
	bne.s	loc_B034
	moveq	#$0,d6
	moveq	#$0,d0
	sub.b	$2(a2),d7
	bpl.s	loc_B028
	add.b	$1(a2),d7
loc_B028:
	cmp.b	$1(a2),d7
	bcs.s	loc_B032
	sub.b	$1(a2),d7
loc_B032:
	ext.w	d7
loc_B034:
	dbf	d4,loc_AFEC
	addi.w	#$80,d5
	move.w	-$2(a6),d0
	addq.w	#$1,d0
	cmp.b	$1(a2),d0
	bcs.s	loc_B04A
	moveq	#$0,d0
loc_B04A:
	move.w	d0,-$2(a6)
	dbf	d3,loc_AFDE
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts
dat_B05A:
	binclude	"data/00B05A.bin"

; ---------------------------------------------------------------------------
sub_B0DA:
	movem.l	d2-d4,-(a7)
	moveq	#$1E,d0
	bsr.w	sub_6C8C
	subi.w	#$14,d0
	move.w	d0,d4
	moveq	#$2,d0
	moveq	#$2,d1
	moveq	#$25,d2
	moveq	#$19,d3
	bsr.w	sub_AF5E
	clr.w	($FFFFB1C2).w
	movem.l	(a7)+,d2-d4
	rts

; ---------------------------------------------------------------------------
sub_B100:
	link	a6,#-$52
	movem.l	d2-d7/a2-a3,-(a7)
	move.l	#$3297,($FFFFD810).w
	clr.l	($FFFFD814).w
	tst.b	($FFFFD4FE).w
	beq.s	loc_B122
	tst.b	($FFFFD8CC).l
	beq.s	loc_B126
loc_B122:
	moveq	#$4,d1
	bra.s	loc_B12C
loc_B126:
	moveq	#$0,d1
	move.b	($FFFF9AFA).w,d1
loc_B12C:
	lea	(dat_B332).l,a0
	move.b	($FFFF9AF7).w,d0
	add.b	(a0,d1.w),d0
	ext.w	d0
	move.w	d0,-$34(a6)
	move.b	($FFFF9AF6).w,d0
	add.b	$5(a0,d1.w),d0
	ext.w	d0
	move.w	d0,-$2C(a6)
	move.w	#$FFFD,-$36(a6)
	move.w	#$FFFE,-$30(a6)
loc_B15A:
	move.w	-$34(a6),-$2E(a6)
	move.w	-$36(a6),-$32(a6)
	subq.w	#$1,-$2E(a6)
	bsr.w	sub_B396
	addq.w	#$1,-$2E(a6)
loc_B172:
	move.w	-$32(a6),d4
	move.w	-$30(a6),d5
	move.w	d5,d2
	mulu.w	#$15,d2
	add.w	d4,d2
	lea	($FFFFCACA).w,a2
	adda.w	d2,a2
	lea	-$22(a6),a0
	move.w	(a0)+,(a0)+
	move.w	(a0)+,(a0)+
	bsr.w	sub_B396
	bsr.w	sub_B3FA
	lea	(dat_B33C).l,a3
	moveq	#$4,d7
loc_B1A0:
	moveq	#$5,d6
	move.w	d4,d3
loc_B1A4:
	move.b	(a3)+,d0
	move.b	(a3)+,d1
	move.b	(a3)+,d2
	cmp.w	#$15,d3
	bcc.w	loc_B2E8
	cmp.w	#$15,d5
	bcc.w	loc_B2E8
	tst.b	d1
	bmi.s	loc_B20A
	tst.b	-$44(a6)
	bmi.s	loc_B20A
	tst.b	d0
	bne.s	loc_B1EC
	tst.b	-$42(a6)
	bmi.s	loc_B1EC
	moveq	#$64,d0
	move.b	-$44(a6),d1
	cmp.b	#$1,d1
	bne.s	loc_B1DC
	addq.w	#$2,d0
loc_B1DC:
	move.b	-$42(a6),d1
	cmp.b	#$1,d1
	bne.s	loc_B1E8
	addq.w	#$1,d0
loc_B1E8:
	bra.w	loc_B2E2
loc_B1EC:
	ext.w	d1
	move.b	-$44(a6),d0
	ext.w	d0
	mulu.w	#$6,d0
	add.w	d1,d0
	tst.w	-$1C(a6)
	beq.s	loc_B204
	addi.w	#$12,d0
loc_B204:
	addq.w	#$4,d0
	bra.w	loc_B2E2
loc_B20A:
	tst.b	d0
	bmi.w	loc_B29E
	cmp.b	#$9,d0
	bne.s	loc_B21C
	move.b	-$43(a6),d1
	bra.s	loc_B220
loc_B21C:
	move.b	-$42(a6),d1
loc_B220:
	ext.w	d1
	tst.w	d1
	bmi.s	loc_B29E
	cmp.w	#$2,d1
	bne.s	loc_B270
	cmp.b	#$4,d2
	bne.s	loc_B270
	cmp.b	#$5,d0
	beq.s	loc_B29E
	move.w	-$22(a6),d2
	sub.w	-$20(a6),d2
	beq.s	loc_B26E
	cmp.b	#$3,d0
	bne.s	loc_B25A
	tst.w	-$22(a6)
	bne.s	loc_B254
	moveq	#$69,d0
	bra.w	loc_B2E2
loc_B254:
	moveq	#$68,d0
	bra.w	loc_B2E2
loc_B25A:
	cmp.b	#$7,d0
	bne.s	loc_B26E
	tst.w	-$22(a6)
	bne.s	loc_B26A
	moveq	#$6B,d0
	bra.s	loc_B2E2
loc_B26A:
	moveq	#$6A,d0
	bra.s	loc_B2E2
loc_B26E:
	moveq	#$4,d2
loc_B270:
	ext.w	d0
	mulu.w	#$A,d1
	add.w	d1,d0
	ext.w	d2
	cmp.b	#$4,d2
	bne.s	loc_B284
	moveq	#$1,d2
	bra.s	loc_B28C
loc_B284:
	cmp.b	#$5,d2
	bne.s	loc_B28C
	moveq	#$3,d2
loc_B28C:
	asl.w	#$1,d2
	move.w	-$22(a6,d2.w),d2
	beq.s	loc_B296
	moveq	#$1E,d2
loc_B296:
	add.w	d2,d0
	addi.w	#$28,d0
	bra.s	loc_B2E2
loc_B29E:
	cmp.b	#$4,d2
	bne.s	loc_B2AE
	move.w	-$22(a6),d0
	move.w	-$20(a6),d1
	bra.s	loc_B2BC
loc_B2AE:
	cmp.b	#$5,d2
	bne.s	loc_B2D6
	move.w	-$1E(a6),d0
	move.w	-$1C(a6),d1
loc_B2BC:
	tst.w	d0
	bne.s	loc_B2CA
	tst.w	d1
	bne.s	loc_B2C6
	bra.s	loc_B2E2
loc_B2C6:
	moveq	#$3,d0
	bra.s	loc_B2E2
loc_B2CA:
	tst.w	d1
	bne.s	loc_B2D2
	moveq	#$2,d0
	bra.s	loc_B2E2
loc_B2D2:
	moveq	#$1,d0
	bra.s	loc_B2E2
loc_B2D6:
	ext.w	d2
	asl.w	#$1,d2
	move.w	-$22(a6,d2.w),d0
	beq.s	loc_B2E2
	moveq	#$1,d0
loc_B2E2:
	addq.b	#$2,d0
	move.b	d0,(a2)+
	bra.s	loc_B2EA
loc_B2E8:
	addq.l	#$1,a2
loc_B2EA:
	addq.w	#$1,d3
	dbf	d6,loc_B1A4
	adda.w	#$F,a2
	addq.w	#$1,d5
	dbf	d7,loc_B1A0
	addq.w	#$1,-$2E(a6)
	addq.w	#$6,-$32(a6)
	move.w	-$32(a6),d0
	cmp.w	#$15,d0
	blt.w	loc_B172
	addq.w	#$1,-$2C(a6)
	subq.w	#$1,-$34(a6)
	addq.w	#$5,-$30(a6)
	subq.w	#$1,-$36(a6)
	move.w	-$30(a6),d0
	cmp.w	#$15,d0
	bcs.w	loc_B15A
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts
dat_B332:
	binclude	"data/00B332.bin"
dat_B33C:
	binclude	"data/00B33C.bin"

; ---------------------------------------------------------------------------
sub_B396:
	movem.l	d2-d3,-(a7)
	move.w	-$2E(a6),d2
	move.w	-$2C(a6),d3
	bsr.w	sub_B3D4
	tst.b	d0
	bne.s	loc_B3B0
	clr.w	-$22(a6)
	bra.s	loc_B3B6
loc_B3B0:
	move.w	#$12,-$22(a6)
loc_B3B6:
	addq.w	#$1,d2
	subq.w	#$1,d3
	bsr.w	sub_B3D4
	tst.b	d0
	bne.s	loc_B3C8
	clr.w	-$1E(a6)
	bra.s	loc_B3CE
loc_B3C8:
	move.w	#$12,-$1E(a6)
loc_B3CE:
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_B3D4:
	move.w	d2,d0
	cmp.b	#$10,d0
	bcc.s	loc_B3F6
	move.w	d3,d1
	cmp.b	#$10,d1
	bcc.s	loc_B3F6
	lea	($FFFFB7A4).w,a0
	asl.w	#$4,d1
	add.w	d0,d1
	tst.b	(a0,d1.w)
	bpl.s	loc_B3F6
	moveq	#$1,d0
	rts
loc_B3F6:
	moveq	#$0,d0
	rts

; ---------------------------------------------------------------------------
sub_B3FA:
	movem.l	d2/a2-a3,-(a7)
	moveq	#-$1,d2
	lea	($FFFFB5A4).w,a0
	lea	($FFFFB6A4).w,a1
	movea.l	($FFFFB41A).w,a2
	movea.l	($FFFFB41E).w,a3
	move.w	-$2C(a6),d1
	cmp.w	#$10,d1
	bcc.s	loc_B464
	move.w	-$2E(a6),d0
	cmp.w	#$10,d0
	bhi.s	loc_B464
	beq.s	loc_B454
	asl.w	#$4,d1
	add.w	d0,d1
	move.b	(a1,d1.w),d0
	andi.w	#$F,d0
loc_B432:
	move.b	(a3,d0.w),-$42(a6)
	move.b	(a2,d0.w),d0
	bmi.s	loc_B464
	ext.w	d0
	move.w	d0,d1
	mulu.w	#$3A,d0
	move.w	d0,-$10(a6)
	mulu.w	#$70,d1
	move.w	d1,-$12(a6)
	bra.s	loc_B470
loc_B454:
	asl.w	#$4,d1
	addi.w	#$F,d1
	move.b	(a0,d1.w),d0
	andi.w	#$F,d0
	bra.s	loc_B432
loc_B464:
	move.w	d2,-$10(a6)
	move.w	d2,-$12(a6)
	move.b	d2,-$42(a6)
loc_B470:
	move.w	-$2C(a6),d1
	subq.w	#$1,d1
	cmp.w	#$10,d1
	bcc.s	loc_B4C6
	move.w	-$2E(a6),d0
	cmp.w	#$FFFF,d0
	beq.s	loc_B4BA
	cmp.w	#$10,d0
	bcc.s	loc_B4C6
	asl.w	#$4,d1
	add.w	d0,d1
	move.b	(a0,d1.w),d0
	andi.w	#$F,d0
loc_B498:
	move.b	(a3,d0.w),-$43(a6)
	move.b	(a2,d0.w),d0
	bmi.s	loc_B4C6
	ext.w	d0
	move.w	d0,d1
	mulu.w	#$3A,d0
	move.w	d0,-$16(a6)
	mulu.w	#$70,d1
	move.w	d1,-$18(a6)
	bra.s	loc_B4D2
loc_B4BA:
	asl.w	#$4,d1
	move.b	(a1,d1.w),d0
	andi.w	#$F,d0
	bra.s	loc_B498
loc_B4C6:
	move.w	d2,-$16(a6)
	move.w	d2,-$18(a6)
	move.b	d2,-$43(a6)
loc_B4D2:
	move.w	-$2E(a6),d0
	cmp.w	#$10,d0
	bcc.s	loc_B526
	move.w	-$2C(a6),d1
	cmp.w	#$10,d1
	bhi.s	loc_B526
	beq.s	loc_B516
	asl.w	#$4,d1
	add.w	d0,d1
	move.b	(a0,d1.w),d0
	lsr.b	#$4,d0
	ext.w	d0
loc_B4F4:
	move.b	(a3,d0.w),-$44(a6)
	move.b	(a2,d0.w),d0
	bmi.s	loc_B526
	ext.w	d0
	move.w	d0,d1
	mulu.w	#$E,d0
	move.w	d0,-$1A(a6)
	mulu.w	#$42,d1
	move.w	d1,-$E(a6)
	bra.s	loc_B532
loc_B516:
	move.w	#$F0,d1
	add.w	d0,d1
	move.b	(a1,d1.w),d0
	lsr.b	#$4,d0
	ext.w	d0
	bra.s	loc_B4F4
loc_B526:
	move.w	d2,-$1A(a6)
	move.w	d2,-$E(a6)
	move.b	d2,-$44(a6)
loc_B532:
	movem.l	(a7)+,d2/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_B538:
	link	a6,#-$2A
	movem.l	d4-d7/a2-a3,-(a7)
	move.w	d1,-$26(a6)
	move.l	a0,-$24(a6)
	moveq	#$10,d7
	move.l	#$B57A,d6
loc_B550:
	movea.l	-$24(a6),a0
	move.l	a3,d1
	beq.s	loc_B55E
	moveq	#$0,d0
	move.b	(a3)+,d0
	bmi.s	loc_B572
loc_B55E:
	mulu.w	d7,d0
	asl.w	#$1,d0
	movea.l	$2(a0),a0
	adda.w	d0,a0
	movea.l	d6,a1
	bsr.w	sub_B670
	move.l	a3,d1
	bne.s	loc_B550
loc_B572:
	movem.l	(a7)+,d4-d7/a2-a3
	unlk	a6
	rts
	binclude	"data/00B57A.bin"

; ---------------------------------------------------------------------------
sub_B58A:
	link	a6,#-$2A
	movem.l	d4-d7/a2-a3,-(a7)
	move.w	d1,-$26(a6)
	move.l	a0,-$24(a6)
	cmp.b	#$2,d0
	bne.s	loc_B5AA
	moveq	#$12,d7
	move.l	#$B742,d6
	bra.s	loc_B5C2
loc_B5AA:
	cmp.b	#$3,d0
	bne.s	loc_B5BA
	moveq	#$12,d7
	move.l	#$B754,d6
	bra.s	loc_B5C2
loc_B5BA:
	moveq	#$9,d7
	move.l	#$B742,d6
loc_B5C2:
	movea.l	-$24(a6),a0
	moveq	#$0,d0
	move.b	(a3)+,d0
	bmi.s	loc_B5EE
	tst.b	($FFFFD858).w
	bne.s	loc_B5DC
	bclr	#$6,d0
	beq.s	loc_B5DC
	movea.l	($FFFFB582).w,a0
loc_B5DC:
	mulu.w	#$12,d0
	movea.l	$2(a0),a0
	adda.w	d0,a0
	movea.l	d6,a1
	bsr.w	sub_B670
	bra.s	loc_B5C2
loc_B5EE:
	clr.b	($FFFFD858).w
	movem.l	(a7)+,d4-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_B5FA:
	link	a6,#-$2A
	movem.l	d4-d7/a2-a3,-(a7)
	move.l	a0,-$24(a6)
	cmp.b	#$2,d0
	bne.s	loc_B616
	moveq	#$12,d7
	move.l	#$B742,d6
	bra.s	loc_B62E
loc_B616:
	cmp.b	#$3,d0
	bne.s	loc_B626
	moveq	#$12,d7
	move.l	#$B754,d6
	bra.s	loc_B62E
loc_B626:
	moveq	#$9,d7
	move.l	#$B742,d6
loc_B62E:
	moveq	#$2,d0
	move.l	d7,d1
	bsr.w	sub_92AA
	movea.l	a0,a2
	move.w	(a2),d0
	move.w	d0,$6(a2)
	move.w	d0,-$26(a6)
loc_B642:
	moveq	#$0,d0
	move.b	(a3)+,d0
	bmi.s	loc_B660
	beq.s	loc_B64E
	mulu.w	d7,d0
	asl.w	#$1,d0
loc_B64E:
	movea.l	-$24(a6),a0
	movea.l	$2(a0),a0
	adda.w	d0,a0
	movea.l	d6,a1
	bsr.w	sub_B670
	bra.s	loc_B642
loc_B660:
	move.w	-$26(a6),$6(a2)
	movea.l	a2,a0
	movem.l	(a7)+,d4-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_B670:
	move.l	a3,-(a7)
	moveq	#$0,d4
	move.w	d7,d5
	subq.w	#$1,d5
loc_B678:
	move.b	(a1)+,d4
	move.w	(a0,d4.w),d0
	btst	#$C,d0
	bne.s	loc_B69A
	btst	#$B,d0
	bne.s	loc_B692
	lea	(sub_B6D4).l,a3
	bra.s	loc_B6AE
loc_B692:
	lea	(sub_B70E).l,a3
	bra.s	loc_B6AE
loc_B69A:
	btst	#$B,d0
	bne.s	loc_B6A8
	lea	(sub_B6E2).l,a3
	bra.s	loc_B6AE
loc_B6A8:
	lea	(sub_B720).l,a3
loc_B6AE:
	asl.w	#$5,d0
	bsr.w	sub_829C
	move.l	a0,-(a7)
	jsr	(a3)
	movea.l	(a7)+,a0
	move.w	-$26(a6),d0
	addq.w	#$1,-$26(a6)
	asl.w	#$5,d0
	bsr.w	sub_8288
	bsr.w	sub_B730
	dbf	d5,loc_B678
	movea.l	(a7)+,a3
	rts

; ---------------------------------------------------------------------------
sub_B6D4:
	lea	-$20(a6),a0
	moveq	#$7,d0
loc_B6DA:
	move.l	(a5),(a0)+
	dbf	d0,loc_B6DA
	rts

; ---------------------------------------------------------------------------
sub_B6E2:
	lea	(a6),a0
	moveq	#$7,d0
loc_B6E6:
	move.l	(a5),-(a0)
	dbf	d0,loc_B6E6
	rts

; ---------------------------------------------------------------------------
sub_B6EE:
	movem.l	d2-d4,-(a7)
	moveq	#$7,d4
	moveq	#$0,d3
loc_B6F6:
	move.b	d1,d2
	andi.b	#$F,d2
	or.b	d2,d3
	lsr.l	#$4,d1
	asl.l	#$4,d3
	dbf	d4,loc_B6F6
	move.l	d3,d1
	movem.l	(a7)+,d2-d4
	rts

; ---------------------------------------------------------------------------
sub_B70E:
	lea	-$20(a6),a0
	moveq	#$7,d0
loc_B714:
	move.l	(a5),d1
	bsr.s	sub_B6EE
	move.l	d1,(a0)+
	dbf	d0,loc_B714
	rts

; ---------------------------------------------------------------------------
sub_B720:
	lea	(a6),a0
	moveq	#$7,d0
loc_B724:
	move.l	(a5),d1
	bsr.s	sub_B6EE
	move.l	d1,-(a0)
	dbf	d0,loc_B724
	rts

; ---------------------------------------------------------------------------
sub_B730:
	move.l	a0,-(a7)
	lea	-$20(a6),a0
	moveq	#$7,d0
loc_B738:
	move.l	(a0)+,(a5)
	dbf	d0,loc_B738
	movea.l	(a7)+,a0
	rts
	binclude	"data/00B742.bin"

; ---------------------------------------------------------------------------
sub_B766:
	lea	(dat_51302).l,a0
	lea	(dat_5130A).l,a1
loc_B772:
	move.b	(a0)+,d0
	bmi.w	loc_B796
	cmp.b	d3,d0
	beq.s	loc_B780
	tst.l	(a1)+
	bra.s	loc_B772
loc_B780:
	movea.l	(a1),a0
	st	($FFFFB4BD).w
	bsr.w	sub_9DD4
	move.l	a0,($FFFFB552).w
	moveq	#$0,d0
	bsr.w	sub_9592
	rts
loc_B796:
	lea	(dat_B7A2).l,a0
	jsr	(sub_132A6).l
dat_B7A2:
	binclude	"data/00B7A2.bin"

; ---------------------------------------------------------------------------
sub_B7B4:
	link	a6,#-$4
	movem.l	d3-d4/a2-a3,-(a7)
loc_B7BC:
	move.b	($FFFFB524).w,d1
	lea	(dat_51326).l,a0
	lea	(dat_51360).l,a1
	lea	(dat_51444).l,a2
loc_B7D2:
	move.b	(a0)+,d0
	bpl.s	loc_B7E2
	bsr.w	sub_82EC
	move.b	($FFFFB525).w,($FFFFB524).w
	bra.s	loc_B7BC
loc_B7E2:
	cmp.b	d1,d0
	beq.s	loc_B7EC
	addq.l	#$4,a1
	addq.l	#$4,a2
	bra.s	loc_B7D2
loc_B7EC:
	movea.l	(a2),a2
	move.b	(a2),d0
	move.b	d0,($FFFFB4CE).w
	beq.s	loc_B810
	lea	($FFFFB4D4).w,a3
	ext.w	d0
	bra.s	loc_B80A
loc_B7FE:
	moveq	#$0,d1
	move.b	$1(a2,d0.w),d1
	lea	(a2,d1.w),a0
	move.l	a0,(a3)+
loc_B80A:
	dbf	d0,loc_B7FE
	bra.s	loc_B816
loc_B810:
	addq.l	#$1,a2
	move.l	a2,($FFFFB4D4).w
loc_B816:
	clr.l	($FFFFB4E4).w
	clr.l	($FFFFB4E8).w
	movea.l	(a1),a0
	st	($FFFFB4CD).w
	bsr.w	sub_9DD4
	bsr.w	sub_950E
	movem.l	(a7)+,d3-d4/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_B834:
	move.w	#$4A6,($FFFFB1C6).w
	move.w	#$2,($FFFFB1C4).w
	bsr.w	sub_BFC2
	rts

; ---------------------------------------------------------------------------
sub_B846:
	link	a6,#-$4
	movem.l	d7/a2-a3,-(a7)
	move.w	#$259,($FFFFB1C6).w
	move.w	#$F,($FFFFB1C4).w
	move.w	#$2,($FFFFB016).w
	move.w	#$F,($FFFFB0B2).w
	moveq	#$0,d1
	lea	($FFFFB018).w,a0
	moveq	#$8,d0
loc_B86E:
	move.l	d1,(a0)+
	dbf	d0,loc_B86E
	lea	($FFFFB0B4).w,a0
	move.w	#$86,d0
loc_B87C:
	move.w	d1,(a0)+
	dbf	d0,loc_B87C
	lea	($FFFFB1B0).w,a0
	move.b	#$E,$C(a0)
	move.b	#$1E,$A(a0)
	clr.l	(a0)
	move.l	#$FFFF0001,$4(a0)
	move.w	#$4000,$10(a0)
	move.b	#$1,$8(a0)
	move.b	#$1,$B(a0)
	moveq	#$1E,d0
	move.b	d0,($FFFFB01A).w
	move.b	d0,($FFFFB02C).w
	bsr.w	sub_BFC2
	lea	(dat_E8F2E).l,a0
	bsr.w	sub_9DD4
	move.l	a0,-$4(a6)
	moveq	#$0,d0
	move.w	($FFFFB1C6).w,d1
	lea	(dat_B8F2).l,a3
	bsr.w	sub_B58A
	lea	-$4(a6),a0
	bsr.w	sub_9784
	bsr.w	sub_B91A
	bsr.w	sub_C0E4
	movem.l	(a7)+,d7/a2-a3
	unlk	a6
	rts
dat_B8F2:
	binclude	"data/00B8F2.bin"

; ---------------------------------------------------------------------------
sub_B912:
	move.b	($FFFF9AFA).w,d0
	ext.w	d0
	bra.s	loc_B91C

; ---------------------------------------------------------------------------
sub_B91A:
	moveq	#$8,d0
loc_B91C:
	link	a6,#-$16
	movem.l	d2-d6/a2-a3,-(a7)
	move.l	($FFFFB3E4).w,($FFFFB596).w
	bsr.w	sub_BCA4
	addq.w	#$1,($FFFF9BBA).w
	move.l	#$BE9A,-$4(a6)
	move.w	#$C,-$14(a6)
	moveq	#$0,d6
	lea	($FFFFB0B4).w,a3
loc_B946:
	move.w	($FFFF9BBA).w,d5
	lea	(dat_BE6A).l,a1
	mulu.w	(a1,d6.w),d5
	move.w	$C(a1,d6.w),d7
	bra.w	loc_BA20
loc_B95C:
	movea.l	-$4(a6),a0
	move.w	d5,d4
	add.w	(a0)+,d4
	move.l	a0,-$4(a6)
	moveq	#$0,d3
	move.b	d4,d3
	lsr.w	#$8,d4
	move.w	d4,d0
	bsr.w	sub_6B04
	movem.w	d0-d1,-$8(a6)
	move.w	d4,d0
	addq.w	#$1,d0
	bsr.w	sub_6B04
	muls.w	d3,d0
	muls.w	d3,d1
	movem.l	d0-d1,-$10(a6)
	move.w	#$FF,d2
	sub.w	d3,d2
	movem.w	-$8(a6),d0-d1
	muls.w	d2,d0
	muls.w	d2,d1
	add.l	-$10(a6),d0
	add.l	-$C(a6),d1
	asr.l	#$8,d0
	asr.l	#$8,d1
	lea	(dat_BE5E).l,a1
	move.w	(a1,d6.w),d2
	muls.w	d2,d0
	muls.w	d2,d1
	asr.l	#$6,d0
	asr.l	#$6,d1
	asr.l	#$8,d0
	asr.l	#$8,d1
	move.w	d0,d2
	move.w	d1,d3
	move.w	#$F8,d0
	move.w	#$F8,d1
	add.w	d0,d2
	add.w	d0,d3
	movem.w	d2-d3,(a3)
	jsr	(sub_15D36).l
	lea	(dat_BE56).l,a0
	move.b	(a0,d0.w),d0
	add.b	-$13(a6),d0
	move.b	d0,$A(a3)
	move.b	-$14(a6),$C(a3)
	addq.b	#$1,-$14(a6)
	lea	(dat_BE8E).l,a1
	move.w	(a1,d6.w),$10(a3)
	cmp.b	#$4,d6
	bne.s	loc_BA18
	tst.b	($FFFF9BBF).w
	beq.s	loc_BA18
	move.l	(a3),($FFFFB3F0).w
	move.l	(a3),($FFFF9BC6).w
	clr.b	($FFFF9BBF).w
loc_BA18:
	bsr.w	sub_BC2C
	adda.w	#$12,a3
loc_BA20:
	dbf	d7,loc_B95C
	addq.b	#$3,-$13(a6)
	addq.w	#$2,d6
	cmp.w	#$C,d6
	bne.w	loc_B946
	bsr.w	sub_BC16
	move.b	-$14(a6),$C(a3)
	addq.b	#$1,-$14(a6)
	move.w	-$12(a6),d0
	lea	(dat_BE56).l,a0
	move.b	(a0,d0.w),$A(a3)
	tst.b	-$16(a6)
	beq.s	loc_BA62
	moveq	#$3,d0
	bsr.w	sub_6C94
	mulu.w	#$3,d0
	bra.s	loc_BA64
loc_BA62:
	moveq	#$9,d0
loc_BA64:
	add.b	d0,$A(a3)
	clr.l	($FFFFB3F4).w
	tst.b	-$16(a6)
	beq.s	loc_BAA8
	moveq	#$0,d2
	move.w	($FFFF9920).w,d2
	move.w	($FFFF98F8).w,d1
	beq.s	loc_BA86
	asl.w	#$1,d2
	divu.w	d1,d2
	addq.w	#$3,d2
	bra.s	loc_BA88
loc_BA86:
	moveq	#$3,d2
loc_BA88:
	lea	(dat_146E0).l,a0
	adda.w	-$12(a6),a0
	move.b	(a0),d0
	ext.w	d0
	move.b	$B(a0),d1
	ext.w	d1
	muls.w	d2,d0
	muls.w	d2,d1
	add.w	d0,($FFFFB3E4).w
	add.w	d1,($FFFFB3E6).w
loc_BAA8:
	move.w	($FFFFB3E4).w,d0
	move.w	($FFFFB3E6).w,d1
	bsr.w	sub_BD10
	cmp.w	#$80,d0
	ble.s	loc_BABE
	move.w	#$80,d0
loc_BABE:
	cmp.w	#$FF80,d0
	bge.s	loc_BAC8
	move.w	#$FF80,d0
loc_BAC8:
	cmp.w	#$80,d1
	ble.s	loc_BAD2
	move.w	#$80,d1
loc_BAD2:
	cmp.w	#$FF80,d1
	bge.s	loc_BADC
	move.w	#$FF80,d1
loc_BADC:
	movem.w	d0-d1,($FFFFB3E4).w
	add.w	d0,($FFFFB3E8).w
	add.w	d1,($FFFFB3EA).w
	move.b	($FFFFB3E8).w,d0
	ext.w	d0
	move.w	d0,($FFFFB3F4).w
	add.w	d0,($FFFFB590).w
	clr.b	($FFFFB3E8).w
	move.b	($FFFFB3EA).w,d0
	ext.w	d0
	move.w	d0,($FFFFB3F6).w
	add.w	d0,($FFFFB592).w
	clr.b	($FFFFB3EA).w
	cmpi.w	#$12C,($FFFFB594).w
	bcs.s	loc_BB32
	move.w	($FFFFB590).w,d0
	add.w	d0,($FFFFB3F0).w
	asr.w	($FFFFB3F0).w
	move.w	($FFFFB592).w,d0
	add.w	d0,($FFFFB3F2).w
	asr.w	($FFFFB3F2).w
	clr.l	($FFFFB3F4).w
loc_BB32:
	bsr.w	sub_10006
	move.l	($FFFFB3F0).w,($FFFF9BC6).w
	movem.w	($FFFFB3F0).w,d0-d1
	move.w	#$1EC,d2
	cmp.w	d2,d0
	ble.s	loc_BB4C
	move.w	d2,d0
loc_BB4C:
	cmp.w	d2,d1
	ble.s	loc_BB52
	move.w	d2,d1
loc_BB52:
	movem.w	d0-d1,(a3)
	clr.w	$10(a3)
	adda.w	#$12,a3
	move.w	#$FE00,d2
	move.w	(a3),d0
	cmp.w	d2,d0
	bge.s	loc_BB7A
	bsr.w	sub_6D06
	mulu.w	#$A,d0
	add.w	d2,d0
	move.w	d0,$2(a3)
	move.w	#$200,(a3)
loc_BB7A:
	moveq	#$1C,d5
	bsr.w	sub_D736
	move.b	($FFFFB58E).w,d0
	bne.s	loc_BB88
	move.b	d7,d0
loc_BB88:
	cmp.b	($FFFF9BB8).w,d0
	beq.s	loc_BB9A
	move.b	d0,($FFFF9BB8).w
	bsr.w	sub_D52A
	clr.b	($FFFFBA57).w
loc_BB9A:
	moveq	#$C,d5
	bsr.w	sub_D736
	tst.b	d7
	bne.s	loc_BBCE
	move.w	($FFFFBA62).w,d0
	beq.s	loc_BBB2
	subq.w	#$1,d0
	move.w	d0,($FFFFBA62).w
	bra.s	loc_BBF8
loc_BBB2:
	bsr.w	sub_6D06
	cmp.b	#$1,d0
	bne.s	loc_BBF8
	bsr.w	sub_6D06
	cmp.b	#$A,d0
	bhi.s	loc_BBF8
	move.w	#$12C,($FFFFBA62).w
	bra.s	loc_BBE6
loc_BBCE:
	jsr	(sub_F1B66).l
	btst	#$5,d0
	beq.s	loc_BBF8
	clr.l	($FFFFB3E4).w
	clr.l	($FFFFB3E8).w
	bsr.w	sub_1343E
loc_BBE6:
	move.b	d7,($FFFF979B).w
	move.b	#$78,($FFFFBA57).w
	bsr.w	sub_6C54
	moveq	#$0,d7
	bra.s	loc_BBFA
loc_BBF8:
	moveq	#$1,d7
loc_BBFA:
	subq.b	#$1,($FFFFBA57).w
	bne.s	loc_BC0E
	bsr.w	sub_D52A
	move.b	#$5C,($FFFFB525).w
	jsr	($4DFA).w
loc_BC0E:
	movem.l	(a7)+,d2-d6/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_BC16:
	movem.l	d2-d7,-(a7)
	move.w	#$F,d2
	move.l	#$F8,d3
	move.l	#$F8,d4
	bra.s	loc_BC42

; ---------------------------------------------------------------------------
sub_BC2C:
	movem.l	d2-d7,-(a7)
	lea	(dat_BE82).l,a1
	move.w	(a1,d6.w),d2
	beq.s	loc_BC74
	move.w	(a3),d3
	move.w	$2(a3),d4
loc_BC42:
	sub.w	($FFFF9BC6).w,d3
	sub.w	($FFFF9BC8).w,d4
	move.w	d3,d5
	move.w	d4,d6
	muls.w	d3,d5
	muls.w	d4,d6
	add.l	d5,d6
	asr.l	#$3,d6
	cmp.w	#$6400,d6
	bhi.s	loc_BC74
	tst.w	d6
	beq.s	loc_BC74
	move.w	d3,d0
	bsr.w	sub_BC7A
	add.w	d0,($FFFFB3E4).w
	move.w	d4,d0
	bsr.w	sub_BC7A
	add.w	d0,($FFFFB3E6).w
loc_BC74:
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_BC7A:
	move.w	d0,d1
	bpl.s	loc_BC80
	neg.w	d1
loc_BC80:
	cmp.w	#$6,d1
	bhi.s	loc_BC8A
	moveq	#$0,d0
	bra.s	loc_BCA2
loc_BC8A:
	cmp.w	#$C,d1
	bhi.s	loc_BC9E
	asl.w	#$1,d1
	subi.w	#$C,d1
	tst.w	d0
	bpl.s	loc_BC9C
	neg.w	d1
loc_BC9C:
	move.w	d1,d0
loc_BC9E:
	muls.w	d2,d0
	divs.w	d6,d0
loc_BCA2:
	rts

; ---------------------------------------------------------------------------
sub_BCA4:
	movem.l	d2-d3,-(a7)
	clr.b	-$16(a6)
	cmp.b	#$8,d0
	beq.s	loc_BCFA
	st	-$16(a6)
	move.b	($FFFF9BC4).w,d1
	cmp.b	d0,d1
	beq.s	loc_BCFA
	subq.b	#$1,($FFFF9BC3).w
	bpl.s	loc_BCFA
	moveq	#$0,d2
	move.w	($FFFF991C).w,d2
	move.w	($FFFF98F8).w,d3
	beq.s	loc_BCDE
	asl.w	#$4,d2
	divu.w	d3,d2
	moveq	#$14,d3
	sub.w	d2,d3
	add.b	d3,($FFFF9BC3).w
	bra.s	loc_BCE4
loc_BCDE:
	move.b	#$14,($FFFF9BC3).w
loc_BCE4:
	sub.b	d0,d1
	andi.w	#$7,d1
	cmp.b	#$4,d1
	bge.s	loc_BCF6
	subq.b	#$1,($FFFF9BC4).w
	bra.s	loc_BCFA
loc_BCF6:
	addq.b	#$1,($FFFF9BC4).w
loc_BCFA:
	move.b	($FFFF9BC4).w,d0
	andi.w	#$7,d0
	move.b	d0,($FFFF9BC4).w
	move.w	d0,-$12(a6)
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_BD10:
	movem.l	d2/d6-d7/a0,-(a7)
	tst.b	-$16(a6)
	bne.w	loc_BDD0
	bsr.w	sub_BDFE
	tst.b	d0
	beq.w	loc_BDD0
	cmp.b	($FFFFB58E).w,d0
	beq.s	loc_BD34
	move.b	d0,($FFFFB58E).w
	bra.w	loc_BDD4
loc_BD34:
	move.b	($FFFFB58E).w,d0
	ext.w	d0
	subq.w	#$1,d0
	mulu.w	#$12,d0
	lea	($FFFFB0B4).w,a0
	adda.l	d0,a0
	move.w	(a0),d6
	move.w	$2(a0),d7
	cmpi.w	#$78,($FFFFB594).w
	bcc.s	loc_BD62
	addq.w	#$1,($FFFFB594).w
	move.l	($FFFFB3F0).w,($FFFFB590).w
	bra.w	loc_BDD8
loc_BD62:
	addq.b	#$1,($FFFFB58F).w
	moveq	#$0,d0
	moveq	#$0,d1
	moveq	#$0,d2
	move.b	($FFFFB58F).w,d2
	lsr.b	#$1,d2
	move.w	d2,d0
	andi.w	#$1F,d0
	btst	#$5,d2
	beq.s	loc_BD86
	move.w	#$1F,d1
	sub.w	d0,d1
	move.w	d1,d0
loc_BD86:
	lea	(dat_BEB4).l,a0
	move.b	$20(a0,d0.w),d1
	ext.w	d1
	move.b	(a0,d0.w),d0
	btst	#$6,d2
	beq.s	loc_BD9E
	neg.w	d1
loc_BD9E:
	lsr.b	#$5,d2
	beq.s	loc_BDA8
	cmp.b	#$3,d2
	bne.s	loc_BDAA
loc_BDA8:
	neg.w	d0
loc_BDAA:
	add.w	d6,d0
	add.w	d7,d1
	move.l	($FFFFB596).w,($FFFFB3E4).w
	move.w	($FFFFB3F0).w,d2
	bsr.w	sub_BDE4
	move.w	d0,($FFFFB3E4).w
	move.w	($FFFFB3F2).w,d2
	move.w	d1,d0
	bsr.w	sub_BDE4
	move.w	d0,($FFFFB3E6).w
	bra.s	loc_BDD8
loc_BDD0:
	clr.b	($FFFFB58E).w
loc_BDD4:
	clr.w	($FFFFB594).w
loc_BDD8:
	movem.w	($FFFFB3E4).w,d0-d1
	movem.l	(a7)+,d2/d6-d7/a0
	rts

; ---------------------------------------------------------------------------
sub_BDE4:
	move.l	d1,-(a7)
	moveq	#$0,d1
	cmp.w	d0,d2
	beq.s	loc_BDF8
	blt.s	loc_BDF4
	move.w	#$FF80,d1
	bra.s	loc_BDF8
loc_BDF4:
	move.w	#$80,d1
loc_BDF8:
	move.w	d1,d0
	move.l	(a7)+,d1
	rts

; ---------------------------------------------------------------------------
sub_BDFE:
	movem.l	d1-d4/a0,-(a7)
	moveq	#$0,d3
	move.l	#$3E8,d4
	moveq	#$3,d2
loc_BE0C:
	move.l	d2,d0
	mulu.w	#$12,d0
	lea	($FFFFB0B4).w,a0
	adda.l	d0,a0
	move.w	(a0),d0
	sub.w	($FFFF9BC6).w,d0
	muls.w	d0,d0
	move.w	$2(a0),d1
	sub.w	($FFFF9BC8).w,d1
	muls.w	d1,d1
	add.l	d0,d1
	cmp.l	#$310,d1
	bhi.s	loc_BE4A
	move.l	d2,d0
	addq.l	#$1,d0
	cmp.b	($FFFFB58E).w,d0
	bne.s	loc_BE42
	move.l	d0,d3
	bra.s	loc_BE4E
loc_BE42:
	cmp.l	d4,d1
	bcc.s	loc_BE4A
	move.l	d0,d3
	move.l	d1,d4
loc_BE4A:
	dbf	d2,loc_BE0C
loc_BE4E:
	move.l	d3,d0
	movem.l	(a7)+,d1-d4/a0
	rts
dat_BE56:
	dc.b	$00,$01,$02,$41,$40,$C1,$82,$81
dat_BE5E:
	binclude	"data/00BE5E.bin"
dat_BE6A:
	binclude	"data/00BE6A.bin"
dat_BE82:
	binclude	"data/00BE82.bin"
dat_BE8E:
	binclude	"data/00BE8E.bin"
dat_BEB4:
	binclude	"data/00BEB4.bin"

; ---------------------------------------------------------------------------
sub_BEF4:
	clr.w	($FFFFB016).w
	clr.w	($FFFFB0B2).w

; ---------------------------------------------------------------------------
sub_BEFC:
	move.w	#$33A,($FFFFB1C6).w
	move.w	#$F,($FFFFB1C4).w
	rts

; ---------------------------------------------------------------------------
sub_BF0A:
	movem.l	d7/a2-a3,-(a7)
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$1,d0
	beq.s	loc_BF58
	move.b	($FFFF9AFA).w,d0
	cmp.b	#$3,d0
	bne.s	loc_BF24
	moveq	#$1,d0
loc_BF24:
	cmp.b	($FFFFB4C8).w,d0
	beq.s	loc_BF64
	move.b	d0,($FFFFB4C8).w
	ext.w	d0
	asl.w	#$2,d0
	lea	(dat_BF6A).l,a0
	movea.l	(a0,d0.w),a0
	bsr.w	sub_9DD4
	movea.l	a0,a2
	lea	(dat_BF76).l,a3
	move.w	#$2CA,d1
	bsr.w	sub_B538
	movea.l	a2,a0
	bsr.w	sub_978C
	bra.s	loc_BF64
loc_BF58:
	moveq	#$0,d7
	move.b	($FFFF9AFA).w,d7
	asl.w	#$1,d7
	bsr.w	sub_BF7E
loc_BF64:
	movem.l	(a7)+,d7/a2-a3
	rts
dat_BF6A:
	binclude	"data/00BF6A.bin"
dat_BF76:
	dc.b	$00,$01,$02,$03,$04,$05,$06,$FF

; ---------------------------------------------------------------------------
sub_BF7E:
	link	a6,#-$4
	move.l	a3,-(a7)
	lea	(dat_BFB8).l,a0
	move.b	(a0,d7.w),d0
	cmp.b	($FFFFB4C8).w,d0
	beq.s	loc_BFB2
	move.b	d0,($FFFFB4C8).w
	move.b	d0,-$4(a6)
	st	-$3(a6)
	movea.l	($FFFFB562).w,a0
	lea	-$4(a6),a3
	moveq	#$1,d0
	move.w	($FFFFB1C6).w,d1
	bsr.w	sub_B58A
loc_BFB2:
	movea.l	(a7)+,a3
	unlk	a6
	rts
dat_BFB8:
	binclude	"data/00BFB8.bin"

; ---------------------------------------------------------------------------
sub_BFC2:
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$8,d0
	bne.s	loc_BFF0
	moveq	#$1,d0
	moveq	#$0,d1
	bsr.w	sub_92AA
	move.l	a0,($FFFFB0AE).w
	st	($FFFFB4C8).w
	bsr.w	sub_BF0A
	bsr.w	sub_5644
	move.w	#$EC02,d0
	bsr.w	sub_8288
	move.w	$2(a0),(a5)
loc_BFF0:
	move.w	($FFFFB1C4).w,d0
	addq.w	#$2,d0
	moveq	#$0,d1
	bsr.w	sub_92AA
	move.l	a0,($FFFFB0A8).w
	rts

; ---------------------------------------------------------------------------
sub_C002:
	link	a6,#-$1C
	movem.l	d5-d7/a2-a3,-(a7)
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$1,d0
	bne.s	loc_C062
	moveq	#$1,d0
	move.w	d0,($FFFFB0B2).w
	move.w	d0,($FFFFB016).w
	lea	($FFFFB018).w,a0
	moveq	#$0,d0
	moveq	#$3,d1
loc_C026:
	move.l	d0,(a0)+
	dbf	d1,loc_C026
	move.b	#$1,($FFFFB01A).w
	lea	($FFFFB0B4).w,a0
	moveq	#$0,d0
	moveq	#$8,d1
loc_C03A:
	move.w	d0,(a0)+
	dbf	d1,loc_C03A
	lea	($FFFFB0B4).w,a0
	bsr.w	sub_C77E
	move.w	d0,(a0)
	move.w	d1,$2(a0)
	bsr.w	sub_BFC2
	st	($FFFFB4C8).w
	clr.b	($FFFF9AFA).w
	bsr.w	sub_BF0A
	bra.w	loc_C0D0
loc_C062:
	bsr.w	sub_C77E
	movem.w	d0-d1,($FFFFB3F0).l
	bsr.w	sub_BFC2
	moveq	#$0,d5
	lea	($FFFFB018).w,a2
	move.w	($FFFFB016).w,d7
	bra.s	loc_C0CC
loc_C07E:
	move.b	(a2),d0
	lea	$8(a2),a3
	bsr.w	sub_99BC
	move.l	a0,d6
	move.l	$8(a2),-$1C(a6)
	lea	-$1C(a6),a3
	movea.l	a3,a1
	moveq	#$2,d0
	moveq	#$0,d1
loc_C09A:
	tst.b	(a1)
	bmi.s	loc_C0A6
	move.b	d1,(a1)+
	addq.b	#$1,d1
	dbf	d0,loc_C09A
loc_C0A6:
	st	(a1)
	move.b	(a2),d1
	bsr.w	sub_C3CA
	movea.l	d6,a0
	moveq	#$0,d1
	move.b	$1(a2),d1
	mulu.w	#$9,d1
	add.w	($FFFFB1C6).w,d1
	bsr.w	sub_B58A
	movea.l	d6,a0
	bsr.w	sub_978C
	adda.w	#$12,a2
loc_C0CC:
	dbf	d7,loc_C07E
loc_C0D0:
	bsr.w	sub_C0E4
	movem.l	(a7)+,d5-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_C0DC:
	movem.l	d6-d7,-(a7)
	moveq	#$1,d6
	bra.s	loc_C0EA

; ---------------------------------------------------------------------------
sub_C0E4:
	movem.l	d6-d7,-(a7)
	moveq	#$0,d6
loc_C0EA:
	movea.l	($FFFFB0A8).w,a0
	move.w	$2(a0),d7
	add.w	($FFFFB1C4).w,d7
	move.w	d7,d0
	asl.w	#$3,d0
	addi.w	#$EC00,d0
	bsr.w	sub_8288
	moveq	#$1,d0
	move.w	d0,(a5)
	move.w	$2(a0),(a5)
	move.w	d0,(a5)
	move.w	d0,(a5)
	move.w	d0,(a5)
	move.w	$4(a0),(a5)
	move.w	d0,(a5)
	move.w	d0,(a5)
	tst.b	d6
	bne.s	loc_C122
	bsr.w	sub_C3F0
	bra.s	loc_C126
loc_C122:
	bsr.w	sub_C3EA
loc_C126:
	move.l	#$6C020003,(a4)
	move.w	d7,(a5)
	movem.l	(a7)+,d6-d7
	rts

; ---------------------------------------------------------------------------
sub_C134:
	clr.w	($FFFFB0B2).w
	clr.w	($FFFFB016).w
	bsr.w	sub_C3F0
	rts

; ---------------------------------------------------------------------------
sub_C142:
	link	a6,#-$4
	movem.l	d6-d7/a2-a3,-(a7)
	move.w	d0,d7
	move.w	($FFFFB0B2).w,d0
	subq.w	#$1,d0
	mulu.w	#$12,d0
	lea	($FFFFB0B4).w,a2
	adda.w	d0,a2
	moveq	#$0,d0
	move.b	$B(a2),d0
	mulu.w	#$12,d0
	lea	($FFFFB018).w,a3
	adda.w	d0,a3
	move.b	d7,d0
	andi.b	#$C0,d0
	move.b	d0,$A(a2)
	clr.b	$8(a2)
	move.b	d7,d0
	andi.b	#$3F,d0
	move.b	d0,$8(a3)
	st	$9(a3)
	movea.l	a3,a2
	move.b	(a2),d0
	lea	$8(a2),a3
	bsr.w	sub_99BC
	move.l	a0,d6
	move.w	#$FF,-$4(a6)
	lea	-$4(a6),a3
	moveq	#$1,d0
	moveq	#$0,d1
	move.b	$1(a2),d1
	mulu.w	#$9,d1
	add.w	($FFFFB1C6).w,d1
	bsr.w	sub_B58A
	movea.l	d6,a0
	bsr.w	sub_978C
	move.w	($FFFFB0B2).w,d6
	subq.w	#$1,d6
	mulu.w	#$12,d6
	lea	($FFFFB0B4).w,a3
	adda.w	d6,a3
	andi.b	#$C0,d7
	move.b	d7,$A(a3)
	bsr.w	sub_C3F0
	movem.l	(a7)+,d6-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_C1DE:
	addq.b	#$1,d3
	asl.w	#$1,d2
	lea	(dat_146E0).l,a0
	adda.w	d2,a0
	move.b	(a0),d2
	move.b	$B(a0),d1
	ext.w	d2
	ext.w	d1
	muls.w	d3,d2
	muls.w	d1,d3
	muls.w	#$18,d2
	muls.w	#$18,d3
	add.w	d3,d2
	bsr.w	sub_C77E
	add.w	d0,d2
	add.w	d1,d3
	bra.w	sub_C20E

; ---------------------------------------------------------------------------
sub_C20E:
	link	a6,#-$6
	movem.l	d2-d7/a2-a3,-(a7)
	move.b	d4,d1
	bsr.w	sub_C3CA
	move.b	d0,-$6(a6)
	moveq	#$0,d7
	move.b	d5,d6
	andi.w	#$3F,d6
	lea	($FFFFB018).w,a2
loc_C22C:
	cmp.w	($FFFFB016).w,d7
	beq.s	loc_C246
	cmp.b	(a2),d4
	bne.s	loc_C23E
	cmp.b	$8(a2),d6
	beq.w	loc_C2D2
loc_C23E:
	adda.w	#$12,a2
	addq.w	#$1,d7
	bra.s	loc_C22C
loc_C246:
	cmp.w	#$8,d7
	bcc.w	loc_C38E
	addq.w	#$1,($FFFFB016).w
	move.b	d4,(a2)
	tst.b	d7
	bne.s	loc_C25C
	moveq	#$0,d0
	bra.s	loc_C264
loc_C25C:
	move.b	-$11(a2),d0
	add.b	-$10(a2),d0
loc_C264:
	move.b	d0,$1(a2)
	move.b	-$6(a6),d1
	cmp.b	#$1,d1
	bhi.s	loc_C276
	moveq	#$1,d1
	bra.s	loc_C278
loc_C276:
	moveq	#$2,d1
loc_C278:
	move.b	d1,$2(a2)
	clr.b	$3(a2)
	clr.l	$4(a2)
	move.b	d6,$8(a2)
	st	$9(a2)
	move.b	d4,d0
	lea	$8(a2),a3
	bsr.w	sub_99BC
	move.l	a0,d6
	move.l	$8(a2),-$4(a6)
	lea	-$4(a6),a3
	movea.l	a3,a1
	moveq	#$2,d0
	moveq	#$0,d1
loc_C2A8:
	tst.b	(a1)
	bmi.s	loc_C2B4
	move.b	d1,(a1)+
	addq.b	#$1,d1
	dbf	d0,loc_C2A8
loc_C2B4:
	st	(a1)
	move.b	-$6(a6),d0
	moveq	#$0,d1
	move.b	$1(a2),d1
	mulu.w	#$9,d1
	add.w	($FFFFB1C6).w,d1
	bsr.w	sub_B58A
	movea.l	d6,a0
	bsr.w	sub_978C
loc_C2D2:
	move.w	($FFFFB0B2).w,d6
	move.b	-$6(a6),d4
	cmp.b	#$1,d4
	bhi.s	loc_C2EE
	cmp.w	($FFFFB1C4).w,d6
	beq.w	loc_C3AC
	addq.w	#$1,($FFFFB0B2).w
	bra.s	loc_C2FE
loc_C2EE:
	move.w	d6,d0
	subq.w	#$1,d0
	cmp.w	($FFFFB1C4).w,d0
	bge.w	loc_C3AC
	addq.w	#$2,($FFFFB0B2).w
loc_C2FE:
	move.l	d6,d0
	mulu.w	#$12,d0
	lea	($FFFFB0B4).w,a3
	adda.w	d0,a3
	bsr.w	sub_C358
	cmp.b	#$1,d4
	bls.s	loc_C31E
	addq.w	#$1,d6
	adda.w	#$12,a3
	bsr.w	sub_C32A
loc_C31E:
	bsr.w	sub_C3F0
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_C32A:
	cmp.b	#$2,d4
	bne.s	loc_C33C
	addi.w	#$18,d3
	addq.b	#$1,d5
	move.b	d5,$A(a3)
	bra.s	loc_C36A
loc_C33C:
	tst.b	d5
	bpl.s	loc_C34C
	move.b	d5,$A(a3)
	addq.b	#$1,d5
	move.b	d5,-$8(a3)
	bra.s	loc_C352
loc_C34C:
	addq.b	#$1,d5
	move.b	d5,$A(a3)
loc_C352:
	addi.w	#$18,d2
	bra.s	loc_C36A

; ---------------------------------------------------------------------------
sub_C358:
	cmp.b	#$2,d4
	bne.s	loc_C362
	subi.w	#$18,d3
loc_C362:
	andi.b	#$C0,d5
	move.b	d5,$A(a3)
loc_C36A:
	move.w	d2,(a3)
	move.w	d3,$2(a3)
	clr.l	$4(a3)
	st	$8(a3)
	clr.b	$9(a3)
	move.b	d7,$B(a3)
	move.b	d6,$C(a3)
	clr.b	$D(a3)
	clr.w	$10(a3)
	rts
loc_C38E:
	lea	(dat_C39A).l,a0
	jsr	(sub_132A6).l
dat_C39A:
	binclude	"data/00C39A.bin"
loc_C3AC:
	lea	(dat_C3B8).l,a0
	jsr	(sub_132A6).l
dat_C3B8:
	binclude	"data/00C3B8.bin"

; ---------------------------------------------------------------------------
sub_C3CA:
	tst.b	d1
	bpl.s	loc_C3D2
	moveq	#$1,d0
	bra.s	loc_C3E8
loc_C3D2:
	lea	(dat_9A14).l,a0
loc_C3D8:
	cmp.b	$4(a0),d1
	beq.s	loc_C3E2
	addq.w	#$8,a0
	bra.s	loc_C3D8
loc_C3E2:
	move.b	$7(a0),d0
	lsr.b	#$4,d0
loc_C3E8:
	rts

; ---------------------------------------------------------------------------
sub_C3EA:
	st	($FFFFB4BC).w
	bra.s	sub_C3F8

; ---------------------------------------------------------------------------
sub_C3F0:
	st	($FFFFB4BC).w
	moveq	#$0,d0
	bra.s	loc_C3FA

; ---------------------------------------------------------------------------
sub_C3F8:
	moveq	#$1,d0
loc_C3FA:
	link	a6,#-$6
	move.b	d0,-$2(a6)
	movem.l	d2-d7/a2-a3,-(a7)
	move.w	#$80,d0
	move.w	d0,d1
	move.w	d0,d2
	move.w	d0,d3
	add.w	($FFFFB3FC).w,d0
	add.w	($FFFFB3FE).w,d1
	move.w	d0,-$4(a6)
	move.w	d1,-$6(a6)
	sub.w	($FFFFB414).w,d2
	sub.w	($FFFFB416).w,d3
	add.w	($FFFFB3F8).w,d2
	add.w	($FFFFB3FA).w,d3
	move.w	($FFFFB1C4).w,d5
	addq.w	#$1,d5
	move.w	($FFFFB0B2).w,d7
	subq.w	#$1,d7
	bmi.w	loc_C61A
	lea	($FFFFB0B4).w,a2
loc_C444:
	move.b	$A(a2),d0
	cmp.b	#$FF,d0
	beq.w	loc_C560
	move.b	$8(a2),d0
	bmi.w	loc_C560
	move.b	-$2(a6),d1
	sub.b	d1,$D(a2)
	bpl.w	loc_C560
	add.b	d0,$D(a2)
	moveq	#$0,d0
	move.b	$B(a2),d0
	mulu.w	#$12,d0
	lea	($FFFFB018).w,a3
	adda.w	d0,a3
	move.l	$4(a3),d0
	beq.w	loc_C546
	movea.l	d0,a0
	tst.b	$3(a3)
	beq.s	loc_C494
	movea.l	$4(a3),a0
	jsr	(a0)
	move.l	a0,d0
	beq.w	loc_C546
loc_C494:
	moveq	#$64,d5
	moveq	#$0,d6
	move.b	$9(a2),d6
loc_C49C:
	subq.w	#$1,d5
	bmi.w	loc_C656
	move.b	(a0,d6.w),d0
	cmp.b	#$F8,d0
	bcc.w	loc_C4C0
	move.b	d0,$A(a2)
	move.b	$1(a0,d6.w),d0
	add.b	d0,$D(a2)
	addq.w	#$2,d6
	bra.w	loc_C542
loc_C4C0:
	subi.b	#$F8,d0
	ext.w	d0
	asl.w	#$1,d0
	lea	(jt_C4D4).l,a1
	adda.w	(a1,d0.w),a1
	jmp	(a1)
jt_C4D4:
	dc.w	loc_C4E4-jt_C4D4
	dc.w	loc_C4FA-jt_C4D4
	dc.w	loc_C506-jt_C4D4
	dc.w	loc_C512-jt_C4D4
	dc.w	loc_C51C-jt_C4D4
	dc.w	loc_C52E-jt_C4D4
	dc.w	loc_C536-jt_C4D4
	dc.w	loc_C53C-jt_C4D4
loc_C4E4:
	bsr.w	sub_6D06
	btst	#$0,d0
	beq.s	loc_C4F4
	move.b	$1(a0,d6.w),d6
	bra.s	loc_C49C
loc_C4F4:
	move.b	$2(a0,d6.w),d6
	bra.s	loc_C49C
loc_C4FA:
	move.b	$1(a0,d6.w),d0
	ext.w	d0
	move.w	d0,$4(a2)
	bra.s	loc_C528
loc_C506:
	move.b	$1(a0,d6.w),d0
	ext.w	d0
	move.w	d0,$6(a2)
	bra.s	loc_C528
loc_C512:
	move.b	$1(a0,d6.w),d0
	move.b	d0,$8(a2)
	bra.s	loc_C528
loc_C51C:
	move.b	$1(a0,d6.w),d0
	bsr.w	sub_6C8C
	add.b	d0,$D(a2)
loc_C528:
	addq.w	#$2,d6
	bra.w	loc_C49C
loc_C52E:
	move.b	$1(a0,d6.w),d6
	bra.w	loc_C49C
loc_C536:
	st	$A(a2)
	bra.s	loc_C560
loc_C53C:
	st	$8(a2)
	bra.s	loc_C560
loc_C542:
	move.b	d6,$9(a2)
loc_C546:
	move.w	$4(a2),d0
	add.w	(a2),d0
	move.w	d0,(a2)
	move.w	$6(a2),d0
	beq.s	loc_C560
	st	($FFFFB4BC).w
	add.w	$2(a2),d0
	move.w	d0,$2(a2)
loc_C560:
	adda.w	#$12,a2
	dbf	d7,loc_C444
	bsr.w	sub_C67A
	lea	($FFFFB0B4).w,a2
	move.w	($FFFFB0B2).w,d7
	subq.w	#$1,d7
loc_C576:
	move.b	$A(a2),d0
	cmp.b	#$FF,d0
	beq.w	loc_C5FA
	lea	($FFFFB018).w,a3
	move.b	$B(a2),d0
	ext.w	d0
	beq.s	loc_C594
	mulu.w	#$12,d0
	adda.w	d0,a3
loc_C594:
	bsr.w	sub_C63E
	move.w	(a2),d0
	add.w	d2,d0
	cmp.w	#$68,d0
	ble.s	loc_C5FE
	cmp.w	-$4(a6),d0
	bge.s	loc_C5FE
	move.w	$2(a2),d1
	add.w	d3,d1
	cmp.w	#$68,d1
	ble.s	loc_C5FE
	cmp.w	-$6(a6),d1
	bge.s	loc_C5FE
	move.w	d1,(a5)
	move.w	#$A00,d4
	or.b	$F(a2),d4
	move.w	d4,(a5)
	move.b	$A(a2),d1
	andi.w	#$3F,d1
	add.b	$1(a3),d1
	mulu.w	#$9,d1
	add.w	($FFFFB1C6).w,d1
	tst.b	$A(a2)
	bpl.s	loc_C5E4
	bset	#$B,d1
loc_C5E4:
	btst	#$6,$A(a2)
	beq.s	loc_C5F0
	bset	#$C,d1
loc_C5F0:
	or.w	$10(a2),d1
	move.w	d1,(a5)
	move.w	d0,(a5)
	bra.s	loc_C60E
loc_C5FA:
	bsr.w	sub_C63E
loc_C5FE:
	moveq	#$1,d0
	move.w	d0,(a5)
	moveq	#$0,d4
	move.b	$F(a2),d4
	move.w	d4,(a5)
	move.w	d0,(a5)
	move.w	d0,(a5)
loc_C60E:
	adda.w	#$12,a2
	dbf	d7,loc_C576
	tst.w	d5
	bmi.s	loc_C636
loc_C61A:
	movea.l	($FFFFB0A8).w,a0
	move.w	$2(a0),d0
	add.w	($FFFFB1C4).w,d0
	asl.w	#$3,d0
	addi.w	#$EC02,d0
	bsr.w	sub_8288
	add.w	$2(a0),d5
	move.w	d5,(a5)
loc_C636:
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_C63E:
	movea.l	($FFFFB0A8).w,a0
	move.w	$2(a0),d0
	add.b	$C(a2),d0
	asl.w	#$3,d0
	addi.w	#$EC00,d0
	bsr.w	sub_8288
	rts
loc_C656:
	lea	(dat_C662).l,a0
	jsr	(sub_132A6).l
dat_C662:
	binclude	"data/00C662.bin"

; ---------------------------------------------------------------------------
sub_C67A:
	moveq	#-$1,d5
	tst.b	($FFFFB4BC).w
	beq.w	loc_C77C
	clr.b	($FFFFB4BC).w
	link	a6,#-$4
	movem.l	d2-d4/d6-d7/a2-a3,-(a7)
	move.l	a4,-(a7)
	movea.l	($FFFFB0A8).w,a0
	move.w	$2(a0),d7
	add.w	($FFFFB1C4).w,d7
	lea	($FFFFB0B4).w,a2
	move.b	d7,$E(a2)
	move.b	d7,$F(a2)
	addq.b	#$1,$F(a2)
	moveq	#$0,d5
	clr.w	-$4(a6)
	move.w	$2(a2),d0
	move.w	d0,-$2(a6)
	move.w	($FFFFB0B2).w,d6
	subq.w	#$2,d6
	bmi.w	loc_C774
	adda.w	#$12,a2
	moveq	#$1,d7
loc_C6CC:
	move.w	$2(a2),d2
	lea	($FFFFB0B4).w,a3
	move.w	d5,d1
	mulu.w	#$12,d1
	adda.w	d1,a3
	move.w	d5,d3
	cmp.w	-$2(a6),d2
	bcs.s	loc_C706
	move.w	d5,d0
	add.w	$2(a0),d0
	move.b	d0,$F(a2)
	move.b	$E(a3),$E(a2)
	move.w	d7,d0
	add.w	$2(a0),d0
	move.b	d0,$E(a3)
	move.w	d2,-$2(a6)
	move.w	d7,d5
	bra.s	loc_C76A
loc_C706:
	cmp.w	-$4(a6),d3
	bne.s	loc_C72C
	move.b	d3,d0
	add.w	$2(a0),d0
	move.b	d0,$E(a2)
	move.b	$F(a3),$F(a2)
	move.b	d7,d0
	add.w	$2(a0),d0
	move.b	d0,$F(a3)
	move.w	d7,-$4(a6)
	bra.s	loc_C76A
loc_C72C:
	lea	($FFFFB0B4).w,a4
	moveq	#$0,d0
	move.b	$F(a3),d0
	sub.w	$2(a0),d0
	move.w	d0,d1
	mulu.w	#$12,d0
	adda.w	d0,a4
	cmp.w	$2(a4),d2
	bcs.s	loc_C764
	move.b	$E(a4),$E(a2)
	move.b	$F(a3),$F(a2)
	move.w	d7,d0
	add.w	$2(a0),d0
	move.b	d0,$F(a3)
	move.b	d0,$E(a4)
	bra.s	loc_C76A
loc_C764:
	movea.l	a4,a3
	move.l	d1,d3
	bra.s	loc_C706
loc_C76A:
	adda.w	#$12,a2
	addq.w	#$1,d7
	dbf	d6,loc_C6CC
loc_C774:
	movea.l	(a7)+,a4
	movem.l	(a7)+,d2-d4/d6-d7/a2-a3
	unlk	a6
loc_C77C:
	rts

; ---------------------------------------------------------------------------
sub_C77E:
	move.l	d2,-(a7)
	bsr.w	sub_C7A0
	move.b	($FFFF9BBC).w,d2
	cmp.b	#$1,d2
	beq.s	loc_C79C
	cmp.b	#$6,d2
	beq.s	loc_C79C
	addi.w	#$30,d0
	addi.w	#$18,d1
loc_C79C:
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_C7A0:
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$1,d0
	bne.s	loc_C7B4
	move.b	($FFFF97B9).w,d0
	move.b	($FFFF97BA).w,d1
	bra.s	loc_C7CA
loc_C7B4:
	cmp.b	#$6,d0
	bne.s	loc_C7C2
	movem.w	($FFFF9BC6).w,d0-d1
	bra.s	sub_C7CE
loc_C7C2:
	move.b	($FFFF9AF7).w,d0
	move.b	($FFFF9AF6).w,d1
loc_C7CA:
	ext.w	d0
	ext.w	d1

; ---------------------------------------------------------------------------
sub_C7CE:
	move.l	d2,-(a7)
	move.b	($FFFF9BBC).w,d2
	cmp.b	#$1,d2
	bne.s	loc_C7E0
	asl.w	#$3,d0
	asl.w	#$3,d1
	bra.s	loc_C7F2
loc_C7E0:
	cmp.b	#$6,d2
	bne.s	loc_C7E8
	bra.s	loc_C7F2
loc_C7E8:
	mulu.w	#$48,d0
	mulu.w	#$30,d1
	add.w	d1,d0
loc_C7F2:
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_C7F6:
	moveq	#$0,d0

; ---------------------------------------------------------------------------
sub_C7F8:
	movem.l	d2-d5,-(a7)
	move.l	($FFFFB53E).w,d1
	beq.s	loc_C822
	movea.l	d1,a0
	moveq	#$4,d1
	moveq	#$17,d2
	moveq	#$10,d3
	moveq	#$F,d4
	moveq	#$4,d5
	clr.w	($FFFFB50E).w
	move.w	#$8000,($FFFFB512).w
	move.w	#$FFFF,($FFFFB510).w
	bsr.w	sub_95BE
loc_C822:
	movem.l	(a7)+,d2-d5
	rts

; ---------------------------------------------------------------------------
sub_C828:
	link	a6,#-$E
	movem.l	d6,-(a7)
	move.b	($FFFF9BBC).w,d6
	move.l	($FFFFB53E).w,d0
	beq.w	loc_C872
	subq.b	#$1,($FFFFD859).w
	bpl.w	loc_C872
	move.b	#$7,($FFFFD859).w
	move.l	#$393C0003,(a4)
	moveq	#$6,d0
	lea	-$E(a6),a0
loc_C856:
	move.w	(a5),(a0)+
	dbf	d0,loc_C856
	move.l	#$793C0003,(a4)
	move.w	-$2(a6),(a5)
	moveq	#$5,d0
	lea	-$E(a6),a0
loc_C86C:
	move.w	(a0)+,(a5)
	dbf	d0,loc_C86C
loc_C872:
	movem.l	(a7)+,d6
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_C87A:
	movem.l	d2-d5/d7/a2,-(a7)
	move.w	($FFFFB1C2).w,d7
	lea	($FFFFB1C8).w,a2
	bra.s	loc_C898
loc_C888:
	move.b	(a2)+,d0
	move.b	(a2)+,d1
	cmp.b	d0,d2
	bne.s	loc_C894
	cmp.b	d1,d3
	beq.s	loc_C8F6
loc_C894:
	adda.w	#$12,a2
loc_C898:
	dbf	d7,loc_C888
	move.w	($FFFFB1C2).w,d0
	cmp.w	#$1B,d0
	bne.s	loc_C8CC
	lea	(dat_C8B2).l,a0
	jsr	(sub_132A6).l
dat_C8B2:
	binclude	"data/00C8B2.bin"
loc_C8CC:
	addq.w	#$1,d0
	move.w	d0,($FFFFB1C2).w
	move.b	d2,(a2)+
	move.b	d3,(a2)+
	move.w	d3,d4
	asl.w	#$6,d4
	add.w	d2,d4
	asl.w	#$1,d4
	addi.w	#$C000,d4
	moveq	#$2,d5
loc_C8E4:
	move.w	d4,d0
	bsr.w	sub_829C
	move.l	(a5),(a2)+
	move.w	(a5),(a2)+
	addi.w	#$80,d4
	dbf	d5,loc_C8E4
loc_C8F6:
	movem.l	(a7)+,d2-d5/d7/a2
	rts

; ---------------------------------------------------------------------------
sub_C8FC:
	movem.l	d2-d5/d7/a2,-(a7)
	move.w	($FFFFB1C2).w,d7
	lea	($FFFFB1C8).w,a2
	moveq	#$0,d2
	moveq	#$0,d3
	bra.s	loc_C932
loc_C90E:
	move.b	(a2)+,d2
	move.b	(a2)+,d3
	move.w	d3,d4
	asl.w	#$6,d4
	add.w	d2,d4
	asl.w	#$1,d4
	addi.w	#$C000,d4
	moveq	#$2,d5
loc_C920:
	move.w	d4,d0
	bsr.w	sub_8288
	move.l	(a2)+,(a5)
	move.w	(a2)+,(a5)
	addi.w	#$80,d4
	dbf	d5,loc_C920
loc_C932:
	dbf	d7,loc_C90E
	clr.w	($FFFFB1C2).w
	movem.l	(a7)+,d2-d5/d7/a2
	rts

; ---------------------------------------------------------------------------
sub_C940:
	movem.l	d5,-(a7)
	bsr.w	sub_862A
	moveq	#$0,d5
	bsr.w	sub_A71E
	bsr.w	sub_8A6E
	bsr.w	sub_8A76
	move.w	#$F000,($FFFFB436).w
	moveq	#$3,d0
	bsr.w	sub_8A90
	move.l	#$10016,($FFFFD5DA).w
	move.l	#$250019,($FFFFD5DE).w
	clr.w	($FFFFD582).w
	bsr.w	sub_8562
	clr.b	($FFFFB4D0).w
	tst.b	($FFFFBA60).w
	bne.s	loc_C988
	moveq	#$69,d0
	bra.s	loc_C98A
loc_C988:
	moveq	#$21,d0
loc_C98A:
	move.b	d0,($FFFFB524).w
	move.b	d0,($FFFFB525).w
	bsr.w	sub_B7B4
	clr.l	($FFFFD5DA).w
	move.l	#$150014,($FFFFD5DE).w
	bsr.w	sub_C7F6
	bsr.w	sub_860E
	movem.l	(a7)+,d5
	rts

; ---------------------------------------------------------------------------
sub_C9B0:
	link	a6,#-$3A
	movem.l	d2-d7/a2,-(a7)
	add.w	($FFFFB404).w,d0
	add.w	($FFFFB406).w,d1
	movea.l	($FFFFB50A).w,a2
	movem.w	d0-d1,-$34(a6)
	move.w	#$FFFF,-$36(a6)
loc_C9D0:
	move.w	-$36(a6),d2
	bmi.s	loc_C9E0
	move.w	-$38(a6),d3
	move.w	-$3A(a6),d4
	bra.s	loc_C9FC
loc_C9E0:
	movem.w	-$34(a6),d2-d3
	moveq	#$0,d4
	move.b	(a0)+,d0
	bmi.w	loc_CA76
	add.b	d0,d2
	add.b	(a0)+,d3
	move.b	(a0)+,d4
	andi.w	#$3F,d2
	andi.w	#$3F,d3
loc_C9FC:
	move.b	d2,d0
	add.b	d4,d0
	subi.b	#$40,d0
	ble.s	loc_CA18
	clr.w	-$36(a6)
	move.w	d3,-$38(a6)
	ext.w	d0
	sub.w	d0,d4
	move.w	d0,-$3A(a6)
	bra.s	loc_CA1E
loc_CA18:
	move.w	#$FFFF,-$36(a6)
loc_CA1E:
	asl.w	#$7,d3
	asl.w	#$1,d2
	add.w	d2,d3
	add.w	d6,d3
	move.w	d3,d0
	bsr.w	sub_829C
	lea	-$30(a6),a1
	move.w	d4,d5
	bra.s	loc_CA36
loc_CA34:
	move.w	(a5),(a1)+
loc_CA36:
	dbf	d5,loc_CA34
	move.w	d3,d0
	bsr.w	sub_8288
	lea	-$30(a6),a1
	move.w	($FFFFB50E).w,d1
	move.w	d4,d5
	bra.s	loc_CA6E
loc_CA4C:
	move.w	(a1)+,d0
	move.l	a2,d7
	beq.s	loc_CA62
	move.w	d0,d7
	lsr.w	#$8,d7
	lsr.w	#$4,d7
	andi.w	#$6,d7
	move.w	(a2,d7.w),($FFFFB512).w
loc_CA62:
	eor.w	d1,d0
	and.w	($FFFFB510).w,d0
	or.w	($FFFFB512).w,d0
	move.w	d0,(a5)
loc_CA6E:
	dbf	d5,loc_CA4C
	bra.w	loc_C9D0
loc_CA76:
	movem.l	(a7)+,d2-d7/a2
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_CA7E:
	movem.l	a2-a3,-(a7)
	move.b	($FFFFD513).w,d0
	tst.l	($FFFFB58A).w
	beq.s	loc_CA94
	cmp.b	($FFFFB526).w,d0
	beq.w	loc_CAB6
loc_CA94:
	move.b	d0,($FFFFB526).w
	bsr.w	sub_6EF0
	lea	($FFFFB58A).w,a0
	bsr.w	sub_9784
	move.b	$42(a2),d0
	lea	(dat_CABC).l,a3
	bsr.w	sub_99BC
	move.l	a0,($FFFFB58A).w
loc_CAB6:
	movem.l	(a7)+,a2-a3
	rts
dat_CABC:
	dc.b	$0B,$0F,$11,$FF

; ---------------------------------------------------------------------------
sub_CAC0:
	st	($FFFFB526).w
	lea	($FFFFB58A).w,a0
	bsr.w	sub_9784
	lea	($FFFFB586).w,a0
	bsr.w	sub_9784
	rts

; ---------------------------------------------------------------------------
sub_CAD6:
	movem.l	a2-a3,-(a7)
	movea.l	($FFFFB582).w,a0
	move.b	$11(a3),d1
	asl.w	#$2,d1
	movem.l	(a7)+,a2-a3
	rts

; ---------------------------------------------------------------------------
sub_CAEA:
	movem.l	d2-d7/a2-a3,-(a7)
	move.w	d0,d7
	bpl.s	loc_CB02
	move.b	($FFFFD513).w,d0
	bsr.w	sub_6EF0
	bsr.w	sub_AD5A
	bra.w	loc_CC30
loc_CB02:
	cmp.w	#$5,d7
	bcs.s	loc_CB10
	bsr.w	sub_6EEC
	moveq	#$0,d0
	bra.s	loc_CB5C
loc_CB10:
	move.b	($FFFFD513).w,d0
	bsr.w	sub_6EF0
	tst.b	d7
	bne.s	loc_CB3E
	move.b	$23(a2),d0
	cmp.b	#$3,d0
	bne.s	loc_CB3E
	move.b	$10(a3),d0
	cmp.b	#$3,d0
	bhi.s	loc_CB38
	move.b	#$2,$10(a3)
	bra.s	loc_CB3E
loc_CB38:
	move.b	#$6,$10(a3)
loc_CB3E:
	move.b	$42(a2),d0
	bpl.s	loc_CB48
	moveq	#$0,d0
	bra.s	loc_CB5C
loc_CB48:
	lea	(dat_9A14).l,a0
loc_CB4E:
	cmp.b	$4(a0),d0
	beq.s	loc_CB58
	addq.l	#$8,a0
	bra.s	loc_CB4E
loc_CB58:
	move.b	$6(a0),d0
loc_CB5C:
	ext.w	d0
	mulu.w	#$6,d0
	lea	(dat_CC36).l,a0
	adda.w	d0,a0
	move.b	(a0,d7.w),d6
	btst	#$2,$1(a3)
	bne.w	loc_CC1A
	cmp.b	#$0,d6
	beq.s	loc_CB8A
	cmp.b	#$1,d6
	beq.w	loc_CC1A
	bra.w	loc_CC30
loc_CB8A:
	lea	(dat_CC48).l,a0
	move.w	d7,d0
	asl.w	#$2,d0
	movea.l	(a0,d0.w),a0
	movea.l	(a0),a0
	lea	(dat_CC60).l,a1
	move.b	(a1,d7.w),d0
	cmp.w	#$2,d7
	bne.s	loc_CBC4
	move.b	$23(a2),d1
	cmp.b	#$1,d1
	bls.s	loc_CBBC
	move.b	$11(a3),d1
	asl.w	#$1,d1
	bra.s	loc_CBC2
loc_CBBC:
	move.b	$11(a3),d1
	asl.w	#$2,d1
loc_CBC2:
	add.b	d1,d0
loc_CBC4:
	cmp.w	#$5,d7
	bne.s	loc_CBE2
	lea	(dat_FDBF).l,a1
	move.b	$10(a3),d1
	move.b	(a1,d1.w),d1
	cmp.b	#$3,d1
	bne.s	loc_CBE0
	moveq	#$1,d1
loc_CBE0:
	add.b	d1,d0
loc_CBE2:
	ext.w	d0
	move.b	$10(a3),d6
	cmp.b	#$5,d6
	sge	($FFFFB523).w
	bsr.w	sub_CC66
	beq.s	loc_CC30
	tst.b	($FFFFB523).w
	beq.s	loc_CC06
	move.l	#$969C,($FFFFB516).w
	bra.s	loc_CC0E
loc_CC06:
	move.l	#$967E,($FFFFB516).w
loc_CC0E:
	move.w	#$A000,d1
	bsr.w	sub_961C
	bra.w	loc_CC30
loc_CC1A:
	bset	#$2,$1(a3)
	moveq	#$8,d1
	clr.w	($FFFFB514).w
	bsr.w	sub_CC66
	beq.s	loc_CC30
	bsr.w	sub_95BE
loc_CC30:
	movem.l	(a7)+,d2-d7/a2-a3
	rts
dat_CC36:
	binclude	"data/00CC36.bin"
dat_CC48:
	binclude	"data/00CC48.bin"
dat_CC60:
	dc.b	$02,$01,$03,$00,$00,$02

; ---------------------------------------------------------------------------
sub_CC66:
	moveq	#$0,d2
	move.b	$12(a3),d2
	mulu.w	#$18,d2
	sub.w	($FFFFB408).w,d2
	bmi.s	loc_CCB2
	asr.w	#$3,d2
	cmp.w	#$3F,d2
	bcc.s	loc_CCB2
	moveq	#$0,d3
	move.b	$13(a3),d3
	mulu.w	#$18,d3
	sub.w	($FFFFB40A).w,d3
	bmi.s	loc_CCB2
	asr.w	#$3,d3
	cmp.w	#$3F,d3
	bcc.s	loc_CCB2
	moveq	#$3,d4
	moveq	#$3,d5
	move.b	$23(a2),d6
	cmp.b	#$2,d6
	bne.s	loc_CCA6
	moveq	#$6,d5
loc_CCA6:
	cmp.b	#$3,d6
	bne.s	loc_CCAE
	moveq	#$6,d4
loc_CCAE:
	moveq	#$1,d7
	rts
loc_CCB2:
	moveq	#$0,d7
	rts

; ---------------------------------------------------------------------------
sub_CCB6:
	movem.l	d2-d3/d5-d7,-(a7)
	move.l	($FFFFB55A).w,d0
	beq.s	loc_CCEE
	movea.l	d0,a0
	move.w	(a0),d5
	move.b	($FFFF97B9).w,d2
	move.b	($FFFF97BA).w,d3
	ext.w	d2
	ext.w	d3
	moveq	#-$1,d6
	moveq	#$0,d7
	bsr.w	sub_CCF4
	addq.w	#$1,d2
	bsr.w	sub_CCF4
	addq.w	#$1,d3
	bsr.w	sub_CCF4
	subq.w	#$1,d2
	bsr.w	sub_CCF4
	move.b	d7,($FFFF97AD).w
loc_CCEE:
	movem.l	(a7)+,d2-d3/d5-d7
	rts

; ---------------------------------------------------------------------------
sub_CCF4:
	movem.l	d2-d3,-(a7)
	asl.w	#$7,d3
	asl.w	#$1,d2
	move.w	#$A000,d0
	add.w	d2,d0
	add.w	d3,d0
	bsr.w	sub_829C
	move.w	(a5),d0
	andi.w	#$7FF,d0
	sub.w	d5,d0
	movea.l	($FFFFB556).w,a0
	moveq	#$0,d1
loc_CD16:
	cmp.w	(a0)+,d0
	bls.s	loc_CD20
	addq.l	#$2,a0
	addq.w	#$1,d1
	bra.s	loc_CD16
loc_CD20:
	cmp.w	(a0),d6
	bgt.s	loc_CD28
	move.w	(a0),d6
	move.w	d1,d7
loc_CD28:
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_CD2E:
	link	a6,#-$52
	clr.l	($FFFFB404).w
	clr.l	-$4C(a6)
	move.l	#$3F003F,-$48(a6)
	bsr.w	sub_CFC0
	bsr.w	sub_CFF0
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_CD4E:
	link	a6,#-$52
	movem.l	d2-d3,-(a7)
	bsr.w	sub_CFC0
	movem.w	($FFFFB410).w,d0-d1
	movem.w	($FFFFB3FC).w,d2-d3
	asr.w	#$3,d2
	asr.w	#$3,d3
	add.w	d0,d2
	add.w	d1,d3
	st	($FFFFB418).w
	bsr.w	loc_CF42
	clr.b	($FFFFB418).w
	movem.l	(a7)+,d2-d3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_CD82:
	link	a6,#-$52
	movem.l	d2-d7,-(a7)
	clr.b	-$52(a6)
	move.w	#$200,d3
	movem.w	($FFFFB414).w,d6-d7
	movem.w	($FFFFB400).w,d0-d1
	add.w	($FFFFB3F4).w,d6
	bpl.s	loc_CDA6
	moveq	#$0,d6
loc_CDA6:
	sub.w	($FFFFB3FC).w,d0
	cmp.w	d0,d6
	ble.s	loc_CDB0
	move.w	d0,d6
loc_CDB0:
	add.w	($FFFFB3F6).w,d7
	bpl.s	loc_CDB8
	moveq	#$0,d7
loc_CDB8:
	sub.w	($FFFFB3FE).w,d1
	cmp.w	d1,d7
	ble.s	loc_CDC2
	move.w	d1,d7
loc_CDC2:
	move.w	($FFFFB408).w,d0
	move.w	($FFFFB40A).w,d1
	cmp.w	d0,d6
	blt.s	loc_CDEA
	add.w	d3,d0
	sub.w	($FFFFB3FC).w,d0
	cmp.w	d0,d6
	bgt.s	loc_CDEA
	cmp.w	d1,d7
	blt.s	loc_CDEA
	add.w	d3,d1
	sub.w	($FFFFB3FE).w,d1
	cmp.w	d1,d7
	bgt.s	loc_CDEA
	bra.w	loc_CECC
loc_CDEA:
	bsr.w	sub_CFC0
	movem.w	($FFFFB400).w,d0-d1
	sub.w	d3,d0
	sub.w	d3,d1
	move.w	($FFFFB3FC).w,d4
	move.w	($FFFFB3FE).w,d5
	sub.w	d3,d4
	sub.w	d3,d5
	asr.w	#$1,d4
	asr.w	#$1,d5
	add.w	($FFFFB414).w,d4
	bpl.s	loc_CE10
	moveq	#$0,d4
loc_CE10:
	cmp.w	d0,d4
	blt.s	loc_CE16
	move.w	d0,d4
loc_CE16:
	add.w	($FFFFB416).w,d5
	bpl.s	loc_CE1E
	moveq	#$0,d5
loc_CE1E:
	cmp.w	d1,d5
	blt.s	loc_CE24
	move.w	d1,d5
loc_CE24:
	andi.w	#$FFF8,d4
	andi.w	#$FFF8,d5
	move.w	d4,d0
	move.w	d5,d1
	sub.w	($FFFFB408).w,d0
	sub.w	($FFFFB40A).w,d1
	asr.w	#$3,d0
	asr.w	#$3,d1
	movem.w	d0-d1,-$50(a6)
	movem.w	d4-d5,($FFFFB408).w
	move.w	($FFFFB404).w,d4
	move.w	($FFFFB406).w,d5
	add.w	d4,d0
	add.w	d5,d1
	movem.w	d0-d1,-$4C(a6)
	andi.w	#$3F,d0
	andi.w	#$3F,d1
	movem.w	d0-d1,($FFFFB404).w
	move.w	-$4C(a6),d0
	move.w	-$4A(a6),d1
	tst.w	-$50(a6)
	bmi.s	loc_CE78
	exg	d0,d4
loc_CE78:
	tst.w	-$4E(a6)
	bmi.s	loc_CE80
	exg	d1,d5
loc_CE80:
	movem.w	d0-d1,-$2A(a6)
	tst.w	-$4E(a6)
	beq.s	loc_CEAC
	tst.w	-$50(a6)
	bmi.s	loc_CE96
	move.w	d4,d0
	bra.s	loc_CE9A
loc_CE96:
	move.w	-$2A(a6),d0
loc_CE9A:
	move.w	-$28(a6),d1
	move.w	d0,d2
	move.w	d5,d3
	addi.w	#$3F,d2
	subq.w	#$1,d3
	bsr.w	sub_CF14
loc_CEAC:
	tst.w	-$50(a6)
	beq.s	loc_CEC8
	move.w	-$2A(a6),d0
	move.w	d5,d1
	move.w	d4,d2
	move.w	-$28(a6),d3
	subq.w	#$1,d2
	addi.w	#$3F,d3
	bsr.w	sub_CF14
loc_CEC8:
	st	-$52(a6)
loc_CECC:
	movem.w	d6-d7,($FFFFB414).w
	move.w	($FFFFB404).w,d0
	move.w	($FFFFB406).w,d1
	sub.w	($FFFFB408).w,d6
	sub.w	($FFFFB40A).w,d7
	asr.w	#$3,d6
	asr.w	#$3,d7
	add.w	d0,d6
	add.w	d1,d7
	andi.w	#$3F,d6
	andi.w	#$3F,d7
	movem.w	d6-d7,($FFFFB410).w
	bsr.w	sub_100AC
	tst.b	($FFFFB522).w
	beq.s	loc_CF0C
	tst.b	-$52(a6)
	beq.s	loc_CF0C
	jsr	($5AC2).w
loc_CF0C:
	movem.l	(a7)+,d2-d7
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_CF14:
	move.l	d7,-(a7)
	moveq	#$40,d7
	tst.w	d0
	bpl.s	loc_CF22
	andi.w	#$3F,d0
	add.w	d7,d2
loc_CF22:
	cmp.w	d7,d0
	bcs.s	loc_CF2A
	sub.w	d7,d0
	sub.w	d7,d2
loc_CF2A:
	tst.w	d1
	bpl.s	loc_CF34
	andi.w	#$3F,d1
	add.w	d7,d3
loc_CF34:
	cmp.w	d7,d1
	bcs.s	loc_CF3C
	sub.w	d7,d1
	sub.w	d7,d3
loc_CF3C:
	move.l	(a7)+,d7
	bra.w	loc_CF42
loc_CF42:
	move.l	d4,-(a7)
	movem.w	d0-d3,-(a7)
	moveq	#$3F,d4
	cmp.w	d4,d2
	bhi.s	loc_CF6C
	cmp.w	d4,d3
	bhi.s	loc_CF58
	bsr.w	sub_CFEA
	bra.s	loc_CFB8
loc_CF58:
	move.w	d4,d3
	bsr.w	sub_CFEA
	movem.w	(a7),d0-d3
	moveq	#$0,d1
	and.w	d4,d3
	bsr.w	sub_CFEA
	bra.s	loc_CFB8
loc_CF6C:
	cmp.w	d4,d3
	bhi.s	loc_CF84
	move.w	d4,d2
	bsr.w	sub_CFEA
	movem.w	(a7),d0-d3
	moveq	#$0,d0
	and.w	d4,d2
	bsr.w	sub_CFEA
	bra.s	loc_CFB8
loc_CF84:
	move.w	d4,d2
	move.w	d4,d3
	bsr.w	sub_CFEA
	movem.w	(a7),d0-d3
	moveq	#$0,d0
	moveq	#$0,d1
	and.w	d4,d2
	and.w	d4,d3
	bsr.w	sub_CFEA
	movem.w	(a7),d0-d3
	moveq	#$0,d0
	and.w	d4,d2
	move.w	d4,d3
	bsr.w	sub_CFEA
	movem.w	(a7),d0-d3
	moveq	#$0,d1
	move.w	d4,d2
	and.w	d4,d3
	bsr.w	sub_CFEA
loc_CFB8:
	movem.w	(a7)+,d0-d3
	move.l	(a7)+,d4
	rts

; ---------------------------------------------------------------------------
sub_CFC0:
	movea.l	($FFFFB57E).w,a0
	move.l	$2(a0),-$4(a6)
	movea.l	($FFFFB576).w,a0
	move.l	$2(a0),-$C(a6)
	movea.l	($FFFFB57A).w,a0
	movea.l	$2(a0),a0
	move.l	a0,-$8(a6)
	adda.w	#$1D0,a0
	move.l	a0,-$3E(a6)
	rts

; ---------------------------------------------------------------------------
sub_CFEA:
	movem.w	d0-d3,-$4C(a6)

; ---------------------------------------------------------------------------
sub_CFF0:
	movem.l	d2-d7/a2-a3,-(a7)
	move.w	-$4C(a6),d0
	move.w	-$4A(a6),d1
	sub.w	($FFFFB404).w,d0
	sub.w	($FFFFB406).w,d1
	moveq	#$3F,d2
	and.w	d2,d0
	and.w	d2,d1
	move.w	($FFFFB408).w,d2
	move.w	($FFFFB40A).w,d3
	asr.w	#$3,d2
	asr.w	#$3,d3
	add.w	d2,d0
	add.w	d3,d1
	move.w	d1,d4
	move.w	d1,d2
	ext.l	d4
	divu.w	#$6,d4
	move.w	d4,d3
	move.w	d3,-$2C(a6)
	swap	d4
	neg.w	d4
	move.w	-$4A(a6),d7
	add.w	d4,d7
	add.w	d2,d4
	move.w	d0,d5
	sub.w	d4,d5
	move.w	d5,d6
	ext.l	d6
	divs.w	#$9,d6
	tst.l	d6
	bpl.s	loc_D054
	subq.w	#$1,d6
	move.w	d6,-$34(a6)
	swap	d6
	addi.w	#$9,d6
	bra.s	loc_D05A
loc_D054:
	move.w	d6,-$34(a6)
	swap	d6
loc_D05A:
	move.w	-$4C(a6),d5
	sub.w	d6,d5
	move.w	d7,d4
loc_D062:
	move.l	d5,d3
	move.w	-$34(a6),-$2E(a6)
	subq.w	#$1,-$2E(a6)
	bsr.w	sub_B396
	addq.w	#$1,-$2E(a6)
loc_D076:
	lea	-$22(a6),a0
	move.w	(a0)+,(a0)+
	move.w	(a0)+,(a0)+
	bsr.w	sub_B396
	bsr.w	sub_B3FA
	moveq	#$8,d6
	cmp.w	-$4C(a6),d3
	bge.s	loc_D09E
	move.w	-$4C(a6),d0
	move.w	d0,d1
	sub.w	d3,d1
	move.w	d1,-$38(a6)
	sub.w	d1,d6
	bra.s	loc_D0A4
loc_D09E:
	move.w	d3,d0
	clr.w	-$38(a6)
loc_D0A4:
	move.w	d0,d1
	add.w	d6,d1
	sub.w	-$48(a6),d1
	ble.s	loc_D0B0
	sub.w	d1,d6
loc_D0B0:
	moveq	#$5,d7
	cmp.w	-$4A(a6),d4
	bge.s	loc_D0C8
	move.w	-$4A(a6),d2
	move.w	d2,d1
	sub.w	d4,d1
	move.w	d1,-$3A(a6)
	sub.w	d1,d7
	bra.s	loc_D0CE
loc_D0C8:
	move.w	d4,d2
	clr.w	-$3A(a6)
loc_D0CE:
	move.w	d2,d1
	add.w	d7,d1
	sub.w	-$46(a6),d1
	ble.s	loc_D0DA
	sub.w	d1,d7
loc_D0DA:
	asl.w	#$1,d0
	asl.w	#$7,d2
	add.w	d0,d2
	move.w	-$38(a6),d0
	move.w	-$3A(a6),d1
	beq.s	loc_D0F0
	mulu.w	#$9,d1
	add.w	d1,d0
loc_D0F0:
	mulu.w	#$6,d0
	moveq	#$8,d1
	sub.w	d6,d1
	mulu.w	#$6,d1
	move.w	d1,-$40(a6)
	btst	#$1,($FFFFB4C0).w
	bne.s	loc_D10C
	bsr.w	sub_D156
loc_D10C:
	btst	#$0,($FFFFB4C0).w
	bne.s	loc_D118
	bsr.w	sub_D252
loc_D118:
	addq.w	#$1,-$2E(a6)
	addi.w	#$9,d3
	cmp.w	-$48(a6),d3
	ble.w	loc_D076
	subq.w	#$1,-$34(a6)
	subq.w	#$3,d5
	move.w	-$4C(a6),d0
	subi.w	#$9,d0
	cmp.w	d0,d5
	bgt.s	loc_D142
	addi.w	#$9,d5
	addq.w	#$1,-$34(a6)
loc_D142:
	addq.w	#$1,-$2C(a6)
	addq.w	#$6,d4
	cmp.w	-$46(a6),d4
	ble.w	loc_D062
	movem.l	(a7)+,d2-d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_D156:
	movem.l	d0/d2-d5/d7/a2-a3,-(a7)
	addi.w	#$A000,d2
	movea.l	-$8(a6),a0
	movea.l	-$4(a6),a2
	movea.l	-$3E(a6),a3
	lea	(dat_D2A2).l,a1
	adda.w	d0,a1
loc_D172:
	move.w	d6,d5
	move.w	d2,d0
	bsr.w	sub_8288
loc_D17A:
	movem.w	(a1)+,d0-d1/d3
	btst	#$8,d3
	bne.s	loc_D1E0
	btst	#$9,d3
	bne.w	loc_D20C
	btst	#$A,d3
	beq.w	loc_D238
	move.w	-$1A(a6),d4
	bmi.s	loc_D1BC
	btst	#$3,d3
	bne.s	loc_D1A6
	move.w	-$12(a6),d1
	bra.s	loc_D1AA
loc_D1A6:
	move.w	-$18(a6),d1
loc_D1AA:
	bmi.s	loc_D1D6
	lsr.w	#$3,d3
	andi.w	#$E,d3
	add.w	d1,d3
	add.w	d4,d3
	move.w	(a3,d3.w),d0
	bra.s	loc_D23A
loc_D1BC:
	btst	#$3,d3
	bne.s	loc_D1C8
	move.w	-$10(a6),d0
	bra.s	loc_D1CC
loc_D1C8:
	move.w	-$16(a6),d0
loc_D1CC:
	bmi.s	loc_D238
	add.w	d0,d1
	move.w	(a0,d1.w),d0
	bra.s	loc_D23A
loc_D1D6:
	add.w	-$E(a6),d0
	move.w	(a2,d0.w),d0
	bra.s	loc_D23A
loc_D1E0:
	move.w	-$E(a6),d4
	bmi.s	loc_D1EE
	add.w	d4,d0
	move.w	(a2,d0.w),d0
	bra.s	loc_D23A
loc_D1EE:
	tst.w	d1
	bmi.s	loc_D238
	btst	#$3,d3
	bne.s	loc_D1FE
	move.w	-$10(a6),d0
	bra.s	loc_D202
loc_D1FE:
	move.w	-$16(a6),d0
loc_D202:
	bmi.s	loc_D238
	add.w	d0,d1
	move.w	(a0,d1.w),d0
	bra.s	loc_D23A
loc_D20C:
	btst	#$3,d3
	bne.s	loc_D218
	move.w	-$10(a6),d4
	bra.s	loc_D21C
loc_D218:
	move.w	-$16(a6),d4
loc_D21C:
	bmi.s	loc_D226
	add.w	d4,d1
	move.w	(a0,d1.w),d0
	bra.s	loc_D23A
loc_D226:
	tst.w	d0
	bmi.s	loc_D238
	move.w	-$E(a6),d4
	bmi.s	loc_D238
	add.w	d4,d0
	move.w	(a2,d0.w),d0
	bra.s	loc_D23A
loc_D238:
	moveq	#$0,d0
loc_D23A:
	move.w	d0,(a5)
	dbf	d5,loc_D17A
	adda.w	-$40(a6),a1
	addi.w	#$80,d2
	dbf	d7,loc_D172
	movem.l	(a7)+,d0/d2-d5/d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_D252:
	movem.l	d2/d5/d7/a2,-(a7)
	addi.w	#$C000,d2
	lea	(dat_D3E6).l,a2
	adda.w	d0,a2
	movea.l	-$C(a6),a0
loc_D266:
	move.w	d6,d5
	move.w	d2,d0
	bsr.w	sub_8288
loc_D26E:
	move.w	$4(a2),d0
	move.w	(a2),d1
	addq.l	#$6,a2
	andi.w	#$6,d0
	move.w	-$22(a6,d0.w),d0
	add.w	d1,d0
	move.w	(a0,d0.w),d0
	move.w	d0,(a5)
	dbf	d5,loc_D26E
	adda.w	-$40(a6),a2
	moveq	#$3F,d0
	sub.w	d6,d0
	asl.w	#$1,d0
	addi.w	#$80,d2
	dbf	d7,loc_D266
	movem.l	(a7)+,d2/d5/d7/a2
	rts
dat_D2A2:
	binclude	"data/00D2A2.bin"
dat_D3E6:
	binclude	"data/00D3E6.bin"

; ---------------------------------------------------------------------------
sub_D52A:
	link	a6,#-$18
	movem.l	d2-d4/a2,-(a7)
	tst.b	($FFFF9BB8).w
	bne.s	loc_D540
	bsr.w	sub_1343E
	bra.w	loc_D674
loc_D540:
	moveq	#$0,d0
	move.b	($FFFF9BB8).w,d0
	subq.b	#$1,d0
	cmp.b	#$4,d0
	bcs.s	loc_D55A
	cmp.b	#$B,d0
	bhi.s	loc_D558
	moveq	#$4,d0
	bra.s	loc_D55A
loc_D558:
	moveq	#$5,d0
loc_D55A:
	mulu.w	#$1B,d0
	addi.w	#$75,d0
	add.w	($FFFFB1C6).w,d0
	move.b	($FFFF9BB8).w,d1
	cmp.b	#$3,d1
	beq.s	loc_D574
	addi.w	#$4000,d0
loc_D574:
	lea	-$6(a6),a0
	lea	-$18(a6),a1
	move.l	a1,$2(a0)
	moveq	#$2,d1
loc_D582:
	moveq	#$2,d2
loc_D584:
	move.w	d0,(a1)+
	addq.w	#$3,d0
	dbf	d2,loc_D584
	subq.w	#$8,d0
	dbf	d1,loc_D582
	lea	(dat_D680).l,a0
	bsr.w	sub_1344E
	lea	-$6(a6),a0
	st	($FFFFB523).w
	moveq	#$0,d0
	moveq	#$4,d2
	moveq	#$17,d3
	bsr.w	sub_94DC
	move.w	#$8000,($FFFFD5AC).w
	move.l	#$10015,($FFFFD5D6).w
	move.b	#$D,($FFFFD5E3).w
	move.w	#$152,d0
	bsr.w	sub_11C8E
	lea	(dat_D688).l,a2
	move.b	#$19,($FFFFD5E3).w
	bsr.w	sub_11C28
	move.l	#$D0019,($FFFFD5D6).w
	move.b	($FFFF9BB8).w,d0
	cmp.b	#$4,d0
	bls.s	loc_D5F2
	move.w	#$158,d0
	bra.s	loc_D5F6
loc_D5F2:
	move.w	#$157,d0
loc_D5F6:
	bsr.w	sub_11C8E
	move.w	#$C000,($FFFFD5AC).w
	lea	(dat_D69A).l,a2
	moveq	#$0,d0
	move.b	($FFFF9BB8).w,d0
	subq.w	#$1,d0
	mulu.w	#$C,d0
	adda.w	d0,a2
	move.b	#$D,($FFFFD5E3).w
	move.l	#$10016,($FFFFD5D6).w
	move.w	(a2)+,d0
	bsr.w	sub_11C8E
	move.b	#$26,($FFFFD5E3).w
	move.l	#$190015,($FFFFD5D6).w
	move.w	(a2)+,d0
	bsr.w	sub_11C8E
	move.l	#$190016,($FFFFD5D6).w
	move.w	(a2)+,d0
	bsr.w	sub_11C8E
	move.l	#$190017,($FFFFD5D6).w
	move.w	(a2)+,d0
	bsr.w	sub_11C8E
	move.l	#$190018,($FFFFD5D6).w
	move.w	(a2)+,d0
	bsr.w	sub_11C8E
	move.l	#$190019,($FFFFD5D6).w
	move.w	(a2)+,d0
	bsr.w	sub_11C8E
loc_D674:
	clr.b	($FFFFD5E3).w
	movem.l	(a7)+,d2-d4/a2
	unlk	a6
	rts
dat_D680:
	dc.b	$00,$02,$00,$17,$00,$0C,$00,$19
dat_D688:
	binclude	"data/00D688.bin"
dat_D69A:
	binclude	"data/00D69A.bin"

; ---------------------------------------------------------------------------
sub_D736:
	movem.l	d2-d6,-(a7)
	movem.w	($FFFFB3F0).w,d2-d3
	lea	($FFFFB0B4).w,a0
	moveq	#$C,d4
	moveq	#$0,d7
	moveq	#$1,d6
	move.w	d2,d0
	move.w	d3,d1
	sub.w	d5,d0
	sub.w	d5,d1
	add.w	d5,d2
	add.w	d5,d3
loc_D756:
	cmp.w	(a0),d0
	bge.s	loc_D76C
	cmp.w	$2(a0),d1
	bge.s	loc_D76C
	cmp.w	(a0),d2
	ble.s	loc_D76C
	cmp.w	$2(a0),d3
	ble.s	loc_D76C
	move.w	d6,d7
loc_D76C:
	addq.w	#$1,d6
	adda.w	#$12,a0
	dbf	d4,loc_D756
	movem.l	(a7)+,d2-d6
	rts

; ---------------------------------------------------------------------------
sub_D77C:
	link	a6,#-$8E
	movem.l	d2/a2,-(a7)
	clr.w	-$2(a6)
	clr.w	-$4(a6)
	clr.w	-$E(a6)
	bsr.w	sub_1343E
	move.b	#$0,($FFFF9BBC).w
	bsr.w	sub_B7B4
	bsr.w	sub_D97E
	bsr.w	sub_D93A
	move.b	#$8,($FFFF9BBC).w
loc_D7AC:
	lea	-$8E(a6),a2
	move.w	-$2(a6),d0
	mulu.w	#$20,d0
	adda.w	d0,a2
	bsr.w	sub_DAA2
loc_D7BE:
	jsr	(sub_DF08).l
	jsr	(sub_F1B66).l
	btst	#$0,d0
	bne.w	loc_D814
	btst	#$1,d0
	bne.w	loc_D834
	btst	#$2,d0
	bne.w	loc_D858
	btst	#$3,d0
	bne.w	loc_D878
	btst	#$6,d0
	bne.w	loc_D89C
	btst	#$4,d0
	bne.w	loc_D8AE
	btst	#$5,d0
	bne.w	loc_D8C6
	bra.s	loc_D7BE
loc_D804:
	bsr.w	sub_82EC
	bsr.w	sub_B7B4
	movem.l	(a7)+,d2/a2
	unlk	a6
	rts
loc_D814:
	clr.w	-$4(a6)
	subq.w	#$1,-$2(a6)
	bpl.w	loc_D894
	clr.w	-$2(a6)
	moveq	#$0,d0
	move.b	($FFFFB4CE).w,d0
	beq.s	loc_D7BE
	subq.w	#$1,d0
	move.w	d0,-$2(a6)
	bra.s	loc_D894
loc_D834:
	clr.w	-$4(a6)
	addq.w	#$1,-$2(a6)
	moveq	#$0,d0
	move.b	($FFFFB4CE).w,d0
	bne.s	loc_D84C
	clr.w	-$2(a6)
	bra.w	loc_D7BE
loc_D84C:
	cmp.w	-$2(a6),d0
	bhi.s	loc_D894
	clr.w	-$2(a6)
	bra.s	loc_D894
loc_D858:
	tst.b	$1F(a2)
	beq.w	loc_D894
	subq.w	#$1,-$4(a6)
	bpl.w	loc_D894
	moveq	#$0,d0
	move.b	$1F(a2),d0
	subq.w	#$1,d0
	move.w	d0,-$4(a6)
	bra.w	loc_D894
loc_D878:
	tst.b	$1F(a2)
	beq.w	loc_D7BE
	addq.w	#$1,-$4(a6)
	move.w	-$4(a6),d0
	cmp.b	$1F(a2),d0
	bcs.w	loc_D894
	clr.w	-$4(a6)
loc_D894:
	bsr.w	sub_6C3A
	bra.w	loc_D7AC
loc_D89C:
	tst.b	$1F(a2)
	beq.w	loc_D7AC
	move.w	-$4(a6),d0
	addq.b	#$1,(a2,d0.w)
	bra.s	loc_D894
loc_D8AE:
	tst.b	$1F(a2)
	beq.w	loc_D7AC
	move.w	-$4(a6),d0
	subq.b	#$1,(a2,d0.w)
	bpl.s	loc_D894
	clr.b	(a2,d0.w)
	bra.s	loc_D894
loc_D8C6:
	bsr.w	sub_6C54
	moveq	#$9,d0
	move.b	-$E(a6),($FFFFD593).w
	bsr.w	sub_136DA
	move.w	d0,d2
	bsr.w	sub_1344A
	cmp.w	#$7,d2
	bhi.w	loc_D7AC
	move.b	d2,-$E(a6)
	asl.w	#$1,d2
	lea	(jt_D8F6).l,a0
	adda.w	(a0,d2.w),a0
	jmp	(a0)
jt_D8F6:
	dc.w	loc_D9FA-jt_D8F6
	dc.w	loc_D906-jt_D8F6
	dc.w	loc_D9B8-jt_D8F6
	dc.w	loc_DA34-jt_D8F6
	dc.w	loc_DA6A-jt_D8F6
	dc.w	loc_DE46-jt_D8F6
	dc.w	loc_DC2C-jt_D8F6
	dc.w	loc_D804-jt_D8F6
loc_D906:
	clr.w	-$4(a6)
	moveq	#$0,d0
	move.b	($FFFFB4CE).w,d0
	cmp.b	#$4,d0
	bcc.w	loc_D7BE
	move.w	d0,-$2(a6)
	addq.b	#$1,($FFFFB4CE).w
	mulu.w	#$20,d0
	lea	-$8E(a6),a0
	adda.w	d0,a0
	clr.b	$1F(a0)
	bsr.w	sub_DA24
	bsr.w	sub_D93A
	bra.w	loc_D7AC

; ---------------------------------------------------------------------------
sub_D93A:
	tst.b	($FFFFB4CE).w
	bne.s	loc_D946
	move.b	#$1,($FFFFB4CE).w
loc_D946:
	clr.w	-$4(a6)
	clr.l	($FFFFB4D0).w
	lea	-$8E(a6),a0
	lea	($FFFFB4D4).w,a1
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)+
	clr.l	(a1)+
	lea	($FFFFB4D4).w,a1
	moveq	#$0,d0
loc_D964:
	move.l	a0,(a1)+
	adda.l	#$20,a0
	addq.w	#$1,d0
	cmp.b	($FFFFB4CE).w,d0
	bcs.s	loc_D964
	clr.l	($FFFFB4E4).w
	clr.l	($FFFFB4E8).w
	rts

; ---------------------------------------------------------------------------
sub_D97E:
	move.l	a2,-(a7)
	lea	($FFFFB4D4).w,a2
	moveq	#$3,d2
	lea	-$8E(a6),a0
loc_D98A:
	move.l	(a2)+,d0
	beq.s	loc_D9B2
	movea.l	d0,a1
	moveq	#$0,d0
loc_D992:
	move.b	(a1,d0.w),(a0,d0.w)
	bmi.s	loc_D9A2
	addq.w	#$1,d0
	cmp.w	#$13,d0
	bcs.s	loc_D992
loc_D9A2:
	move.b	d0,$1F(a0)
	bsr.w	sub_DA24
	adda.w	#$20,a0
	dbf	d2,loc_D98A
loc_D9B2:
	bsr.s	sub_D93A
	movea.l	(a7)+,a2
	rts
loc_D9B8:
	moveq	#$0,d0
	move.b	($FFFFB4CE).w,d0
	cmp.w	#$1,d0
	ble.w	loc_D7BE
	subq.w	#$1,d0
	move.b	d0,($FFFFB4CE).w
	move.w	-$2(a6),d1
	sub.w	d1,d0
	bne.s	loc_D9DA
	subq.w	#$1,-$2(a6)
	bra.s	loc_D9F2
loc_D9DA:
	mulu.w	#$20,d1
	lea	-$8E(a6),a0
	adda.w	d1,a0
	lea	$20(a0),a1
	mulu.w	#$F,d0
loc_D9EC:
	move.w	(a1)+,(a0)+
	dbf	d0,loc_D9EC
loc_D9F2:
	bsr.w	sub_D93A
	bra.w	loc_D7AC
loc_D9FA:
	moveq	#$3,d2
	bsr.w	sub_134F8
	move.b	d2,($FFFFB524).w
	move.b	#$0,($FFFF9BBC).w
	bsr.w	sub_B7B4
	bsr.w	sub_D97E
	bsr.w	sub_D93A
	move.b	#$8,($FFFF9BBC).w
	bsr.w	sub_1343E
	bra.w	loc_D7AC

; ---------------------------------------------------------------------------
sub_DA24:
	moveq	#$0,d0
	move.b	$1F(a0),d0
	moveq	#-$1,d1
	sub.b	d0,d1
	move.b	d1,(a0,d0.w)
	rts
loc_DA34:
	bclr	#$0,-$3(a6)
	moveq	#$0,d0
	move.b	$1F(a2),d0
	sub.w	-$4(a6),d0
	asr.w	#$1,d0
	moveq	#$0,d1
	move.b	$1F(a2),d1
	bra.s	loc_DA56
loc_DA4E:
	move.w	-$2(a2,d1.w),(a2,d1.w)
	subq.w	#$2,d1
loc_DA56:
	dbf	d0,loc_DA4E
	clr.w	(a2,d1.w)
	addq.b	#$2,$1F(a2)
	movea.l	a2,a0
	bsr.s	sub_DA24
	bra.w	loc_D7AC
loc_DA6A:
	tst.b	$1F(a2)
	beq.w	loc_D7BE
	bclr	#$0,-$3(a6)
	moveq	#$0,d0
	move.b	$1F(a2),d0
	sub.w	-$4(a6),d0
	asr.w	#$1,d0
	move.w	-$4(a6),d1
	bra.s	loc_DA92
loc_DA8A:
	move.w	$2(a2,d1.w),(a2,d1.w)
	addq.w	#$2,d1
loc_DA92:
	dbf	d0,loc_DA8A
	subq.b	#$2,$1F(a2)
	movea.l	a2,a0
	bsr.s	sub_DA24
	bra.w	loc_D7AC

; ---------------------------------------------------------------------------
sub_DAA2:
	movem.l	d2/a2,-(a7)
	bsr.w	sub_1344A
	clr.w	($FFFFD5D6).w
	move.w	($FFFFD5DC).w,($FFFFD5D8).w
	addq.w	#$4,($FFFFD5D8).w
	move.w	#$C000,($FFFFD5AC).w
	move.w	#$12E,d0
	bsr.w	sub_11C8E
	move.l	($FFFFD5DA).w,($FFFFD5D6).w
	moveq	#$0,d2
	lea	-$8E(a6),a2
loc_DAD2:
	bsr.w	sub_DB12
	adda.w	#$20,a2
	addq.w	#$1,d2
	cmp.b	($FFFFB4CE).w,d2
	bcs.s	loc_DAD2
	move.w	($FFFFD5D8).w,d0
	cmp.w	($FFFFD5E0).w,d0
	bcc.s	loc_DB0C
	move.w	($FFFFD5DA).w,-$C(a6)
	move.w	($FFFFD5DE).w,-$8(a6)
	move.w	($FFFFD5D8).w,-$A(a6)
	move.w	($FFFFD5E0).w,-$6(a6)
	lea	-$C(a6),a0
	bsr.w	sub_1344E
loc_DB0C:
	movem.l	(a7)+,d2/a2
	rts

; ---------------------------------------------------------------------------
sub_DB12:
	movem.l	d2-d3/a3,-(a7)
	movea.l	a2,a3
	move.w	#$1,($FFFFD5AA).w
	move.w	#$C000,($FFFFD5AC).w
	move.b	d2,d0
	bsr.w	sub_13322
	bsr.w	sub_11CA0
	addq.w	#$1,($FFFFD5D6).w
	move.w	#$3A00,($FFFFD5AE).w
	bsr.w	sub_11CA0
	addq.w	#$1,($FFFFD5D6).w
	moveq	#$0,d3
loc_DB42:
	cmp.b	$1F(a2),d3
	bcc.w	loc_DBC0
	cmp.w	-$4(a6),d3
	bne.s	loc_DB5E
	cmp.w	-$2(a6),d2
	bne.s	loc_DB5E
	move.w	#$E000,($FFFFD5AC).w
	bra.s	loc_DB72
loc_DB5E:
	btst	#$0,d3
	beq.s	loc_DB6C
	move.w	#$C000,($FFFFD5AC).w
	bra.s	loc_DB72
loc_DB6C:
	move.w	#$8000,($FFFFD5AC).w
loc_DB72:
	btst	#$0,d3
	beq.s	loc_DB9A
	move.w	#$3,($FFFFD5AA).w
	move.b	(a3)+,d0
	bsr.w	sub_13322
	bsr.w	sub_1368C
	bsr.w	sub_11CA0
	move.l	#$2C200000,($FFFFD5AE).w
	bsr.w	sub_11CA0
	bra.s	loc_DBBC
loc_DB9A:
	bsr.w	sub_DC0E
	move.w	#$3,($FFFFD5AA).w
	move.b	(a3)+,d0
	bsr.w	sub_13322
	bsr.w	sub_1368C
	bsr.w	sub_11CA0
	move.w	#$2C00,($FFFFD5AE).w
	bsr.w	sub_11CA0
loc_DBBC:
	addq.w	#$1,d3
	bra.s	loc_DB42
loc_DBC0:
	bsr.w	sub_DC0E
	move.w	#$A000,($FFFFD5AC).w
	move.b	$1F(a2),d0
	neg.b	d0
	subq.b	#$1,d0
	move.w	#$3,($FFFFD5AA).w
	bsr.w	sub_1330E
	bsr.w	sub_11CA0
	move.w	($FFFFD5D6).w,-$C(a6)
	move.w	($FFFFD5DE).w,-$8(a6)
	move.w	($FFFFD5D8).w,-$A(a6)
	move.w	($FFFFD5D8).w,-$6(a6)
	lea	-$C(a6),a0
	bsr.w	sub_1344E
	addq.w	#$1,($FFFFD5D8).w
	clr.w	($FFFFD5D6).w
	movem.l	(a7)+,d2-d3/a3
	rts

; ---------------------------------------------------------------------------
sub_DC0E:
	move.w	($FFFFD5D6).w,d0
	cmp.w	#$1E,d0
	bls.s	loc_DC2A
	lea	($FFFFD5AE).w,a0
	move.l	#$20202020,(a0)+
	move.w	#$2000,(a0)
	bsr.w	sub_11CA0
loc_DC2A:
	rts
loc_DC2C:
	movem.l	d2-d3/d7,-(a7)
	move.w	($FFFF9BCA).w,-(a7)
	clr.w	($FFFF9BCA).w
	clr.b	($FFFFD85A).w
	bsr.w	sub_1343E
	move.w	#$12C,d0
	bsr.w	sub_11C8E
	moveq	#$2,d2
	bsr.w	sub_134F8
	move.w	d2,d0
	ext.l	d2
	divu.w	#$3,d2
	move.b	d2,($FFFF9AFB).w
	bsr.w	sub_158BA
	move.b	#$8,($FFFFBA5E).w
	bsr.w	sub_AF00
	clr.w	($FFFFD5D6).w
	move.w	($FFFFD5DC).w,($FFFFD5D8).w
	addq.w	#$4,($FFFFD5D8).w
	move.w	#$C000,($FFFFD5AC).w
	move.w	#$12E,d0
	bsr.w	sub_11C8E
loc_DC84:
	bsr.w	sub_DD96
loc_DC88:
	bsr.w	sub_DF08
	jsr	(sub_F1B66).l
	tst.b	d0
	beq.s	loc_DC88
	btst	#$2,d0
	beq.s	loc_DCAE
	bsr.w	sub_6C3A
	subq.b	#$1,($FFFFD85A).w
	bpl.s	loc_DC84
	move.b	#$2C,($FFFFD85A).w
	bra.s	loc_DC84
loc_DCAE:
	btst	#$3,d0
	beq.s	loc_DCCC
	bsr.w	sub_6C3A
	move.b	($FFFFD85A).w,d0
	addq.b	#$1,d0
	cmp.b	#$2D,d0
	bne.s	loc_DCC6
	moveq	#$0,d0
loc_DCC6:
	move.b	d0,($FFFFD85A).w
	bra.s	loc_DC84
loc_DCCC:
	btst	#$0,d0
	beq.s	loc_DCE6
	bsr.w	sub_6C3A
	subi.b	#$F,($FFFFD85A).w
	bpl.s	loc_DC84
	addi.b	#$2D,($FFFFD85A).w
	bra.s	loc_DC84
loc_DCE6:
	btst	#$1,d0
	beq.s	loc_DD0A
	bsr.w	sub_6C3A
	move.b	($FFFFD85A).w,d0
	addi.b	#$F,d0
	cmp.b	#$2D,d0
	bcs.s	loc_DD02
	subi.b	#$2D,d0
loc_DD02:
	move.b	d0,($FFFFD85A).w
	bra.w	loc_DC84
loc_DD0A:
	btst	#$7,d0
	beq.s	loc_DD12
	bra.s	loc_DD3E
loc_DD12:
	btst	#$6,d0
	beq.s	loc_DD26
	bsr.w	sub_6C3A
	moveq	#$2,d7
	bsr.w	sub_DD50
	bra.w	loc_DC84
loc_DD26:
	btst	#$4,d0
	beq.s	loc_DD3A
	bsr.w	sub_6C3A
	moveq	#-$2,d7
	bsr.w	sub_DD50
	bra.w	loc_DC84
loc_DD3A:
	bra.w	loc_DC88
loc_DD3E:
	bsr.w	sub_1343E
	move.w	(a7)+,($FFFF9BCA).w
	movem.l	(a7)+,d2-d3/d7
	jmp	(loc_D8C6).l

; ---------------------------------------------------------------------------
sub_DD50:
	moveq	#$0,d2
	move.b	($FFFFD85A).w,d2
	divu.w	#$3,d2
	asl.w	#$1,d2
	lea	($FFFFB4EC).w,a0
	adda.w	d2,a0
	move.w	(a0),d3
	move.w	d3,d0
	swap	d2
	asl.w	#$2,d2
	moveq	#$E,d1
	asr.w	d2,d0
	and.w	d1,d0
	add.w	d7,d0
	and.w	d1,d0
	asl.w	d2,d0
	asl.w	d2,d1
	eori.w	#$FFFF,d1
	and.w	d1,d3
	or.w	d0,d3
	move.w	d3,(a0)
	move.l	#$C0420000,(a4)
	lea	($FFFFB4EC).w,a0
	moveq	#$E,d0
loc_DD8E:
	move.w	(a0)+,(a5)
	dbf	d0,loc_DD8E
	rts

; ---------------------------------------------------------------------------
sub_DD96:
	movem.l	d3-d7/a2,-(a7)
	move.l	($FFFFD5DA).w,($FFFFD5D6).w
	lea	($FFFFB4EC).w,a2
	moveq	#$0,d3
	moveq	#$1,d5
	moveq	#$2,d7
loc_DDAA:
	moveq	#$4,d6
loc_DDAC:
	move.w	#$8000,($FFFFD5AC).w
	move.w	#$2,($FFFFD5AA).w
	move.b	d5,d0
	bsr.w	sub_DE3C
	move.w	#$1,($FFFFD5AA).w
	move.w	#$C000,($FFFFD5AC).w
	move.w	#$3A00,($FFFFD5AE).w
	bsr.w	sub_11CA0
	move.w	(a2)+,d4
	bsr.w	sub_DE24
	move.w	d4,d0
	asr.w	#$1,d0
	andi.w	#$7,d0
	bsr.w	sub_DE3C
	bsr.w	sub_DE24
	move.w	d4,d0
	asr.w	#$5,d0
	andi.w	#$7,d0
	bsr.w	sub_DE3C
	bsr.w	sub_DE24
	move.w	d4,d0
	asr.w	#$8,d0
	asr.w	#$1,d0
	andi.w	#$7,d0
	bsr.w	sub_DE3C
	addq.w	#$1,($FFFFD5D6).w
	addq.w	#$1,d5
	dbf	d6,loc_DDAC
	clr.w	($FFFFD5D6).w
	addq.w	#$1,($FFFFD5D8).w
	dbf	d7,loc_DDAA
	movem.l	(a7)+,d3-d7/a2
	rts

; ---------------------------------------------------------------------------
sub_DE24:
	cmp.b	($FFFFD85A).w,d3
	beq.s	loc_DE32
	move.w	#$C000,($FFFFD5AC).w
	bra.s	loc_DE38
loc_DE32:
	move.w	#$E000,($FFFFD5AC).w
loc_DE38:
	addq.w	#$1,d3
	rts

; ---------------------------------------------------------------------------
sub_DE3C:
	bsr.w	sub_13322
	bsr.w	sub_11CA0
	rts
loc_DE46:
	movem.l	d2-d7/a2,-(a7)
	bsr.w	sub_1343E
	bsr.w	sub_C134
	move.w	#$12D,d0
	bsr.w	sub_11C8E
	moveq	#$3,d2
	jsr	(sub_134F8).l
	move.w	d2,d4
	moveq	#$3,d7
	lea	(dat_DE88).l,a2
loc_DE6C:
	move.w	d7,d2
	moveq	#$0,d3
	move.b	(a2)+,d5
	bsr.w	sub_C1DE
	dbf	d7,loc_DE6C
	bsr.w	sub_1343E
	movem.l	(a7)+,d2-d7/a2
	jmp	(loc_D8C6).l
dat_DE88:
	dc.b	$06,$00,$86,$0C

; ---------------------------------------------------------------------------
sub_DE8C:
	move.w	#$2700,sr
	movem.l	d0-d7/a0-a6,-(a7)
	tst.b	($FFFFBA52).w
	bne.s	loc_DEA0
	jsr	($23D6).w
	bra.s	loc_DEBE
loc_DEA0:
	jsr	(sub_1B542).l
	st	($FFFFB4C2).w
	move.b	($FFFFCA21).w,d0
	add.b	d0,($FFFFD604).w
	jsr	(sub_F1B6C).l
	move.b	d0,($FFFFD8FC).l
loc_DEBE:
	movem.l	(a7)+,d0-d7/a0-a6
	rte

; ---------------------------------------------------------------------------
sub_DEC4:
	move.l	d0,-(a7)
	moveq	#$6,d0
	add.b	($FFFF97F2).w,d0
	add.b	($FFFF9BB7).w,d0
	sub.b	d0,($FFFFD85B).w
	bpl.s	loc_DEE2
loc_DED6:
	bsr.w	sub_DEE6
	addi.b	#$10,($FFFFD85B).w
	bmi.s	loc_DED6
loc_DEE2:
	move.l	(a7)+,d0
	rts

; ---------------------------------------------------------------------------
sub_DEE6:
	clr.b	($FFFFB4C2).w
loc_DEEA:
	tst.b	($FFFFB4C2).w
	beq.s	loc_DEEA
	tst.b	($FFFFBA5A).w
	beq.s	loc_DF02
	tst.b	($FFFFD8FC).l
	beq.s	loc_DF02
	jmp	($352).w
loc_DF02:
	bsr.w	sub_DF18
	rts

; ---------------------------------------------------------------------------
sub_DF08:
	tst.b	($FFFFB4C2).w
	beq.s	loc_DF16
	bsr.w	sub_DF18
	clr.b	($FFFFB4C2).w
loc_DF16:
	rts

; ---------------------------------------------------------------------------
sub_DF18:
	movem.l	d0-d7/a0-a3/a6,-(a7)
	move.b	($FFFFD806).w,d0
	cmp.b	#$33,d0
	bne.s	loc_DF3A
	jsr	(sub_1B752).l
	tst.w	d0
	bne.s	loc_DF3A
	move.w	#$36,d0
	jsr	(sub_1B900).l
loc_DF3A:
	lea	(jt_DF4E).l,a0
	moveq	#$0,d0
	move.b	($FFFF9BBC).w,d0
	asl.w	#$1,d0
	adda.w	(a0,d0.w),a0
	jmp	(a0)
jt_DF4E:
	dc.w	loc_DFEC-jt_DF4E
	dc.w	loc_DFB4-jt_DF4E
	dc.w	loc_DFDA-jt_DF4E
	dc.w	loc_DFEC-jt_DF4E
	dc.w	loc_DFEC-jt_DF4E
	dc.w	loc_DFD0-jt_DF4E
	dc.w	loc_DFA0-jt_DF4E
	dc.w	loc_DFEC-jt_DF4E
	dc.w	loc_DFAA-jt_DF4E
	dc.w	loc_DFEC-jt_DF4E
	dc.w	loc_DFEC-jt_DF4E
	dc.w	loc_DFEC-jt_DF4E
	dc.w	loc_DFAE-jt_DF4E
	dc.w	loc_DFE6-jt_DF4E
	dc.w	loc_DF94-jt_DF4E
	dc.w	loc_DF70-jt_DF4E
	dc.w	loc_DFCA-jt_DF4E
loc_DF70:
	subq.b	#$1,($FFFFD85C).w
	bpl.s	loc_DF94
	move.b	#$C,($FFFFD85C).w
	move.l	#$580020,(a4)
	move.w	(a5),d2
	move.w	(a5),d3
	move.w	(a5),d4
	move.l	#$C0580000,(a4)
	move.w	d3,(a5)
	move.w	d4,(a5)
	move.w	d2,(a5)
loc_DF94:
	tst.b	($FFFFD8FC).l
	beq.s	loc_DFEC
	jmp	($352).w
loc_DFA0:
	bsr.w	sub_E208
	bsr.w	sub_E0AE
	bra.s	loc_DFCA
loc_DFAA:
	bsr.w	sub_E048
loc_DFAE:
	bsr.w	sub_C828
	bra.s	loc_DFCA
loc_DFB4:
	move.b	($FFFFD85C).w,d0
	subq.b	#$1,d0
	bpl.s	loc_DFBE
	moveq	#$27,d0
loc_DFBE:
	move.b	d0,($FFFFD85C).w
	asr.b	#$3,d0
	ext.l	d0
	bsr.w	sub_C7F8
loc_DFCA:
	bsr.w	sub_DFF2
	bra.s	loc_DFEC
loc_DFD0:
	bsr.w	sub_E14C
	bsr.w	sub_E2D2
	bra.s	loc_DFEC
loc_DFDA:
	tst.b	($FFFFB4C4).w
	beq.s	loc_DFEC
	bsr.w	sub_11898
	bra.s	loc_DFEC
loc_DFE6:
	jsr	($A5A).w
	nop
loc_DFEC:
	movem.l	(a7)+,d0-d7/a0-a3/a6
	rts

; ---------------------------------------------------------------------------
sub_DFF2:
	tst.b	($FFFFB524).w
	ble.s	loc_E046
	lea	($FFFFB4D4).w,a3
	lea	($FFFFB4E4).w,a6
	moveq	#$0,d6
	moveq	#$0,d7
	move.b	($FFFFB4CE).w,d7
	bne.s	loc_E03A
loc_E00A:
	movea.l	(a3),a2
	move.w	(a6),d3
	subq.w	#$1,d3
	bpl.s	loc_E036
loc_E012:
	move.b	(a2)+,d2
	bpl.s	loc_E022
	ext.w	d2
	adda.w	d2,a2
	cmp.b	#$FF,d2
	beq.s	loc_E036
	bra.s	loc_E012
loc_E022:
	move.b	(a2)+,d0
	ext.w	d0
	mulu.w	#$6,d0
	add.w	d0,d3
	lea	($FFFFB4D0).w,a0
	move.b	d2,(a0,d7.w)
	st	d6
loc_E036:
	move.l	a2,(a3)+
	move.w	d3,(a6)+
loc_E03A:
	dbf	d7,loc_E00A
	tst.b	d6
	beq.s	loc_E046
	bsr.w	sub_950E
loc_E046:
	rts

; ---------------------------------------------------------------------------
sub_E048:
	tst.b	($FFFFBA5D).w
	beq.w	loc_E0AC
	moveq	#$0,d0
	move.b	($FFFF9BCB).w,d0
	add.w	($FFFFD85E).w,d0
	cmp.w	#$780,d0
	bcc.s	loc_E066
	move.w	d0,($FFFFD85E).w
	bra.s	loc_E0AC
loc_E066:
	subi.w	#$780,d0
	move.w	d0,($FFFFD85E).w
	moveq	#$10,d0
	move.b	($FFFF9BCA).w,d2
	cmp.b	#$1,d2
	bls.s	loc_E0AC
	ext.w	d2
	sub.w	d2,d0
	asl.w	#$1,d0
	lea	($FFFFB4EA).w,a0
	adda.w	d0,a0
	movea.l	a0,a1
	move.w	d2,d3
	addi.w	#$40,d0
	bsr.w	sub_8278
	move.w	(a0),d0
	subq.w	#$2,d2
	bmi.s	loc_E0A0
loc_E098:
	move.w	$2(a0),(a0)+
	dbf	d2,loc_E098
loc_E0A0:
	move.w	d0,(a0)
	bra.w	loc_E0A8
loc_E0A6:
	move.w	(a1)+,(a5)
loc_E0A8:
	dbf	d3,loc_E0A6
loc_E0AC:
	rts

; ---------------------------------------------------------------------------
sub_E0AE:
	movem.l	d2-d7,-(a7)
	moveq	#$9,d7
	movea.l	($FFFFB55A).w,a0
	move.w	(a0),d6
loc_E0BA:
	bsr.w	sub_E112
	subq.w	#$1,d2
	cmp.w	#$8,d2
	bcc.s	loc_E0D2
	bchg	#$0,d2
	addq.w	#$1,d2
	add.w	d6,d2
	bsr.w	sub_E140
loc_E0D2:
	dbf	d7,loc_E0BA
	subq.b	#$1,($FFFFD860).w
	bpl.s	loc_E10C
	move.b	#$1E,($FFFFD860).w
	moveq	#$4,d0
	bsr.w	sub_6C94
	moveq	#$11,d1
	moveq	#$1D,d2
	moveq	#$1D,d3
	moveq	#$6,d4
	moveq	#$6,d5
	movea.l	($FFFFB55E).w,a0
	move.w	#$7FFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	clr.w	($FFFFB50E).w
	clr.w	($FFFFB514).w
	bsr.w	sub_95BE
loc_E10C:
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_E112:
	moveq	#$40,d0
	bsr.w	sub_6C94
	move.w	d0,d3
	moveq	#$40,d0
	bsr.w	sub_6C94
	asl.w	#$1,d0
	asl.w	#$7,d3
	add.w	d3,d0
	addi.w	#$A000,d0
	move.w	d0,d3
	bsr.w	sub_829C
	move.w	(a5),d2
	move.w	d2,d5
	andi.w	#$F800,d5
	andi.w	#$7FF,d2
	sub.w	d6,d2
	rts

; ---------------------------------------------------------------------------
sub_E140:
	move.w	d3,d0
	bsr.w	sub_8288
	or.w	d5,d2
	move.w	d2,(a5)
	rts

; ---------------------------------------------------------------------------
sub_E14C:
	move.b	($FFFFD861).w,d0
	beq.s	loc_E19A
	addq.b	#$1,d0
	move.b	d0,($FFFFD861).w
	cmp.b	#$7,d0
	bcs.s	loc_E19A
	move.b	#$1,($FFFFD861).w
	moveq	#$0,d0
	move.b	($FFFFD862).w,d0
	addq.b	#$1,d0
	cmp.b	#$3,d0
	bcs.s	loc_E176
	move.b	#$0,d0
loc_E176:
	move.b	d0,($FFFFD862).w
	moveq	#$C,d2
	moveq	#$11,d3
	moveq	#$3,d4
	moveq	#$3,d5
	movea.l	($FFFFD864).w,a0
	moveq	#$4,d1
	clr.w	($FFFFB50E).w
	clr.w	($FFFFB512).w
	move.w	#$7FFF,($FFFFB510).w
	bsr.w	sub_95BE
loc_E19A:
	rts

; ---------------------------------------------------------------------------
sub_E19C:
	move.l	a2,-(a7)
	lea	($FFFFBA3A).w,a2
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	lea	($FFFF9902).w,a0
	moveq	#$3,d2
	moveq	#$0,d0
	moveq	#$0,d1
loc_E1B4:
	add.b	$1(a0),d0
	add.b	$2(a0),d1
	addq.l	#$5,a0
	dbf	d2,loc_E1B4
	bsr.w	loc_E1F4
	move.w	d0,(a2)+
	lea	($FFFF98F8).w,a0
	bsr.w	sub_E1EA
	move.w	d0,(a2)+
	lea	($FFFF98FC).w,a0
	bsr.w	sub_E1EA
	move.w	d0,(a2)+
	lea	($FFFF98F6).w,a0
	bsr.w	sub_E1EA
	move.w	d0,(a2)+
	movea.l	(a7)+,a2
	rts

; ---------------------------------------------------------------------------
sub_E1EA:
	move.w	(a0),d0
	move.w	$24(a0),d1
	bra.w	loc_E1F4
loc_E1F4:
	ext.l	d1
	mulu.w	#$25,d1
	tst.w	d0
	beq.s	loc_E204
	divu.w	d0,d1
	move.w	d1,d0
	rts
loc_E204:
	moveq	#$0,d0
	rts

; ---------------------------------------------------------------------------
sub_E208:
	movem.l	d3-d7/a6,-(a7)
	movea.l	($FFFFB53E).w,a0
	move.w	(a0),d5
	lea	($FFFFBA3A).w,a6
	move.w	#$F836,d4
	moveq	#$3,d7
loc_E21C:
	move.w	d4,d0
	bsr.w	sub_8288
	moveq	#$F,d3
	cmp.b	($FFFFBA38).w,d7
	bne.s	loc_E230
	move.b	($FFFFBA39).w,d3
	lsr.b	#$2,d3
loc_E230:
	bsr.w	sub_E254
	addq.l	#$2,a6
	addi.w	#$80,d4
	dbf	d7,loc_E21C
	addq.b	#$1,($FFFFBA39).w
	bne.s	loc_E24E
	moveq	#$4,d0
	bsr.w	sub_6C94
	move.b	d0,($FFFFBA38).w
loc_E24E:
	movem.l	(a7)+,d3-d7/a6
	rts

; ---------------------------------------------------------------------------
sub_E254:
	subq.b	#$1,($FFFFD874).w
	bpl.s	loc_E286
	move.b	#$4,($FFFFD874).w
	move.w	$8(a6),d0
	add.w	d0,(a6)
	move.w	(a6),d0
	sub.w	$10(a6),d0
	cmp.w	#$2,d0
	blt.s	loc_E27A
	move.w	#$FFFF,$8(a6)
	bra.s	loc_E286
loc_E27A:
	cmp.w	#$FFFE,d0
	bgt.s	loc_E286
	move.w	#$1,$8(a6)
loc_E286:
	move.w	(a6),d0
	neg.w	d0
	addi.w	#$19,d0
	moveq	#$9,d6
loc_E290:
	move.w	d0,d1
	bsr.w	sub_E2C2
	cmp.w	#$5,d3
	bcc.s	loc_E2AC
	cmp.w	#$2,d3
	bhi.s	loc_E2A8
	add.w	d3,d1
	addq.w	#$1,d1
	bra.s	loc_E2AC
loc_E2A8:
	addq.w	#$5,d1
	sub.w	d3,d1
loc_E2AC:
	bsr.w	sub_E2C2
	add.w	d5,d1
	ori.w	#$2000,d1
	move.w	d1,(a5)
	addq.w	#$1,d0
	subq.w	#$1,d3
	dbf	d6,loc_E290
	rts

; ---------------------------------------------------------------------------
sub_E2C2:
	tst.w	d1
	bpl.s	loc_E2C8
	moveq	#$0,d1
loc_E2C8:
	cmp.w	#$18,d1
	bls.s	loc_E2D0
	moveq	#$18,d1
loc_E2D0:
	rts

; ---------------------------------------------------------------------------
sub_E2D2:
	move.b	($FFFFD875).w,d0
	beq.w	loc_E372
	bpl.s	loc_E2E2
	clr.b	($FFFFD875).w
	bra.s	loc_E304
loc_E2E2:
	addq.b	#$1,d0
	move.b	d0,($FFFFD875).w
	cmp.b	#$7,d0
	bcs.w	loc_E372
	move.b	#$1,($FFFFD875).w
	moveq	#$0,d0
	move.b	($FFFFD876).w,d0
	addq.b	#$1,d0
	cmp.b	#$4,d0
	bcs.s	loc_E308
loc_E304:
	move.b	#$0,d0
loc_E308:
	move.b	d0,($FFFFD876).w
	moveq	#$3,d6
loc_E30E:
	move.l	d6,-(a7)
	moveq	#$0,d0
	tst.b	($FFFFD876).w
	beq.s	loc_E340
	lea	($FFFF992C).w,a0
	move.b	(a0,d6.w),d0
	beq.s	loc_E340
	cmp.b	#$3,d0
	bcs.s	loc_E32C
	move.b	#$2,d0
loc_E32C:
	btst	d6,($FFFFD87C).w
	bne.s	loc_E336
	move.b	#$3,d0
loc_E336:
	subq.w	#$1,d0
	mulu.w	#$3,d0
	add.b	($FFFFD876).w,d0
loc_E340:
	lsl.l	#$2,d6
	lea	(dat_E374).l,a0
	move.l	(a0,d6.w),d2
	move.l	$10(a0,d6.w),d3
	moveq	#$4,d4
	moveq	#$4,d5
	movea.l	($FFFFD878).w,a0
	moveq	#$2,d1
	clr.w	($FFFFB50E).w
	clr.w	($FFFFB512).w
	move.w	#$7FFF,($FFFFB510).w
	bsr.w	sub_95BE
	move.l	(a7)+,d6
	dbf	d6,loc_E30E
loc_E372:
	rts
dat_E374:
	binclude	"data/00E374.bin"

; ---------------------------------------------------------------------------
sub_E394:
	movem.l	d5-d7/a2-a3,-(a7)
	bsr.w	sub_1503C
	lea	($FFFFD51D).w,a0
	moveq	#$3F,d0
loc_E3A2:
	st	(a0)+
	dbf	d0,loc_E3A2
	tst.b	($FFFFD50E).w
	beq.w	loc_E42C
loc_E3B0:
	clr.b	($FFFFD4FD).w
	bsr.w	sub_158F2
	lea	($FFFFC470).w,a3
	move.w	($FFFFBA64).w,d7
	subq.w	#$1,d7
	bmi.w	loc_E42C
loc_E3C6:
	bsr.w	sub_100D6
	adda.w	#$1A,a3
	dbf	d7,loc_E3C6
loc_E3D2:
	bsr.w	sub_754C
	tst.b	($FFFFD8CB).l
	beq.s	loc_E42C
	tst.b	($FFFFD8CA).l
	beq.s	loc_E42C
	moveq	#-$1,d6
	moveq	#-$1,d5
	lea	($FFFFC470).w,a3
	moveq	#$0,d7
loc_E3F0:
	move.b	(a3),d0
	beq.s	loc_E40C
	andi.b	#$C0,d0
	bne.s	loc_E40C
	move.b	$14(a3),d0
	beq.s	loc_E40C
	move.w	$14(a3),d0
	cmp.w	d5,d0
	ble.s	loc_E40C
	move.w	d0,d5
	move.w	d7,d6
loc_E40C:
	adda.w	#$1A,a3
	addq.w	#$1,d7
	cmp.w	($FFFFBA64).w,d7
	bne.s	loc_E3F0
	tst.w	d5
	bmi.s	loc_E426
	move.b	d6,($FFFFCA20).w
	bsr.w	sub_E4F0
	bra.s	loc_E3D2
loc_E426:
	bsr.w	sub_E434
	bra.s	loc_E3B0
loc_E42C:
	movem.l	(a7)+,d5-d7/a2-a3
	bra.w	sub_15FDA

; ---------------------------------------------------------------------------
sub_E434:
	movem.l	d2-d4/a2-a3,-(a7)
	bsr.w	sub_1343E
	addq.b	#$1,($FFFFD50C).w
	clr.b	($FFFF9DC1).w
	bsr.w	sub_1158A
	bsr.w	sub_6AA4
	subq.b	#$1,($FFFFD50D).w
	bne.s	loc_E456
	bsr.w	sub_F1C0
loc_E456:
	move.w	#$8000,($FFFFD5AC).w
	moveq	#$0,d2
	moveq	#$0,d3
	lea	($FFFFC470).w,a2
	lea	($FFFFBA68).w,a3
	moveq	#$7,d4
loc_E46A:
	btst	#$0,$1(a2)
	beq.s	loc_E4A4
	move.b	(a2),d0
	cmp.b	#$83,d0
	bne.s	loc_E4A4
	moveq	#$1,d2
	addq.b	#$1,$E(a2)
	move.b	$E(a2),d0
	cmp.b	#$F,d0
	ble.s	loc_E4A4
	move.b	#$87,(a2)
	moveq	#$1,d3
	bsr.w	sub_E4D2
	lea	(a3),a0
	bsr.w	sub_11CA4
	moveq	#$7A,d0
	bsr.w	sub_11C8E
	addq.w	#$1,($FFFFD5D8).w
loc_E4A4:
	adda.w	#$1A,a2
	adda.w	#$D6,a3
	dbf	d4,loc_E46A
	tst.b	d3
	bne.s	loc_E4C4
	tst.b	d2
	beq.s	loc_E4CC
	bsr.w	sub_E4D2
	move.w	#$135,d0
	bsr.w	sub_11C8E
loc_E4C4:
	bsr.w	sub_75F8
	bsr.w	sub_75F8
loc_E4CC:
	movem.l	(a7)+,d2-d4/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_E4D2:
	move.w	($FFFFD5D8).w,d0
	cmp.w	#$1A,d0
	bcs.s	loc_E4E8
	bsr.w	sub_75F8
	bsr.w	sub_75F8
	bsr.w	sub_1343E
loc_E4E8:
	move.w	#$2,($FFFFD5D6).w
	rts

; ---------------------------------------------------------------------------
sub_E4F0:
	movem.l	a2-a3,-(a7)
	jsr	(sub_1343E).l
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_6F02
	movea.l	a0,a3
	move.b	$2(a3),d0
	bsr.w	sub_6F14
	movea.l	a1,a2
	bclr	#$4,$1(a3)
	moveq	#$7,d0
	bsr.w	sub_664E
	tst.b	$14(a3)
	beq.s	loc_E540
	bsr.w	sub_98E4
	moveq	#$F,d0
	bsr.w	sub_664E
	tst.b	$14(a3)
	beq.s	loc_E540
	tst.b	$1(a3)
	bpl.s	loc_E53C
	bsr.w	sub_EF64
	bra.s	loc_E540
loc_E53C:
	bsr.w	sub_F2AE
loc_E540:
	bsr.w	sub_E54A
	movem.l	(a7)+,a2-a3
	rts

; ---------------------------------------------------------------------------
sub_E54A:
	movem.l	a2-a3,-(a7)
	bsr.w	sub_6EEC
	moveq	#$E,d0
	bsr.w	sub_69DA
	tst.b	d0
	bne.s	loc_E582
	tst.b	$14(a3)
	bne.s	loc_E582
	lea	$54(a1),a0
	moveq	#$C,d1
loc_E568:
	move.b	$5(a0),d0
	andi.b	#$30,d0
	beq.s	loc_E57A
	move.b	#$10,d0
	sub.b	d0,$5(a0)
loc_E57A:
	adda.w	#$A,a0
	dbf	d1,loc_E568
loc_E582:
	movem.l	(a7)+,a2-a3
	rts

; ---------------------------------------------------------------------------
sub_E588:
	movea.l	a3,a0

; ---------------------------------------------------------------------------
sub_E58A:
	moveq	#$0,d0
	move.b	$12(a0),d0
	mulu.w	#$18,d0
	addi.w	#$C,d0
	moveq	#$0,d1
	move.b	$13(a0),d1
	mulu.w	#$18,d1
	addi.w	#$C,d1
	rts

; ---------------------------------------------------------------------------
sub_E5A8:
	move.l	d2,-(a7)
	moveq	#$C,d2
	clr.l	($FFFFB3F4).w
	bsr.s	sub_E588
	sub.w	d2,d0
	sub.w	d2,d1
	cmp.w	($FFFFB414).w,d0
	blt.s	loc_E5DE
	cmp.w	($FFFFB416).w,d1
	blt.s	loc_E5DE
	sub.w	($FFFFB3FC).w,d0
	sub.w	($FFFFB3FE).w,d1
	addi.w	#$18,d0
	addi.w	#$18,d1
	cmp.w	($FFFFB414).w,d0
	bgt.s	loc_E5DE
	cmp.w	($FFFFB416).w,d1
	ble.s	loc_E5E2
loc_E5DE:
	bsr.w	sub_E5E6
loc_E5E2:
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_E5E6:
	move.l	d7,-(a7)
	clr.l	($FFFFB3F4).w
	bsr.s	sub_E588
	move.w	d0,($FFFFB3EC).w
	move.w	d1,($FFFFB3EE).w
	move.l	($FFFFB3EC).w,($FFFFB3F0).w
	moveq	#$0,d7
	bsr.w	sub_FF7C
	move.l	(a7)+,d7
	rts

; ---------------------------------------------------------------------------
sub_E606:
	link	a6,#-$8
	movem.l	d2-d3/d6-d7/a2-a3,-(a7)
	move.w	d0,d7
	move.b	d1,d6
	tst.b	($FFFFCA20).w
	bmi.s	loc_E61C
	bsr.w	sub_6EEC
loc_E61C:
	move.w	d7,-$8(a6)
	move.w	#$17,-$6(a6)
	move.w	d7,-$4(a6)
	addi.w	#$12,-$4(a6)
	move.w	#$1A,-$2(a6)
	lea	-$8(a6),a0
	bsr.w	sub_1344E
	tst.b	($FFFFCA20).w
	bmi.s	loc_E666
	move.w	d7,d2
	moveq	#$17,d3
	bsr.w	sub_751C
	move.l	#$30017,($FFFFD5D6).w
	add.w	d7,($FFFFD5D6).w
	bsr.w	sub_11C5A
	moveq	#$3,d0
	add.w	d7,d0
	moveq	#$18,d1
	bsr.w	sub_AC2A
loc_E666:
	move.w	#$3,($FFFFD5D6).w
	add.w	d7,($FFFFD5D6).w
	move.w	#$19,($FFFFD5D8).w
	cmp.w	#$A,d7
	bhi.w	loc_E6E2
	cmp.b	#$0,d6
	beq.s	loc_E6D2
	cmp.b	#$2,d6
	beq.s	loc_E6A0
	move.w	#$B9,d0
	bsr.w	sub_11C8E
	move.b	$6(a3),d0
	add.b	$7(a3),d0
	asr.b	#$1,d0
	bra.w	loc_E71C
loc_E6A0:
	tst.b	$32(a2)
	bne.s	loc_E6B2
	move.w	#$13A,d0
	bsr.w	sub_11C8E
	moveq	#$A,d0
	bra.s	loc_E6BC
loc_E6B2:
	move.w	#$13B,d0
	bsr.w	sub_11C8E
	moveq	#$1,d0
loc_E6BC:
	movea.l	a3,a0
	jsr	($4FB0).w
	bsr.w	sub_E7C4
	move.w	#$2500,($FFFFD5AE).w
	bsr.w	sub_11CA0
	bra.s	loc_E720
loc_E6D2:
	move.w	#$A7,d0
	bsr.w	sub_11C8E
	move.b	$16(a3),d0
	asr.w	#$1,d0
	bra.s	loc_E71C
loc_E6E2:
	cmp.b	#$2,d6
	beq.s	loc_E720
	tst.b	($FFFFD511).w
	bne.s	loc_E6FA
	move.w	($FFFFD518).w,d0
	beq.s	loc_E6FA
	bsr.w	sub_11C8E
	bra.s	loc_E720
loc_E6FA:
	move.w	#$A8,d0
	bsr.w	sub_11C8E
	move.b	($FFFFD511).w,d0
	ext.w	d0
	mulu.w	#$5,d0
	bsr.w	sub_E7C4
	move.w	#$2500,($FFFFD5AE).w
	bsr.w	sub_11CA0
	bra.s	loc_E720
loc_E71C:
	bsr.w	sub_E7C4
loc_E720:
	tst.b	($FFFFCA20).w
	bmi.w	loc_E7BC
	move.l	#$3001A,($FFFFD5D6).w
	add.w	d7,($FFFFD5D6).w
	move.b	(a3),d0
	andi.w	#$F,d0
	subq.w	#$2,d0
	bmi.s	loc_E756
	addi.w	#$A9,d0
	move.b	$17(a2),d1
	cmp.b	#$4,d1
	bne.s	loc_E7B8
	move.w	#$46,d0
	move.w	#$134,d0
	bra.s	loc_E7B8
loc_E756:
	move.b	($FFFFCA20).w,d0
	moveq	#$E,d1
	bsr.w	sub_69C8
	tst.b	d0
	beq.s	loc_E76A
	move.w	#$B0,d0
	bra.s	loc_E7B8
loc_E76A:
	move.b	($FFFFCA20).w,d0
	moveq	#$D,d1
	bsr.w	sub_69C8
	tst.b	d0
	beq.s	loc_E77E
	move.w	#$AF,d0
	bra.s	loc_E7B8
loc_E77E:
	move.b	($FFFFCA20).w,d0
	moveq	#$1D,d1
	bsr.w	sub_69C8
	tst.b	d0
	beq.s	loc_E792
	move.w	#$12F,d0
	bra.s	loc_E7B8
loc_E792:
	btst	#$5,$1(a3)
	beq.s	loc_E7A0
	move.w	#$B8,d0
	bra.s	loc_E7B8
loc_E7A0:
	cmp.b	#$A,d7
	bcs.s	loc_E7BC
	tst.b	($FFFFCA20).w
	bmi.s	loc_E7BC
	tst.b	($FFFFD511).w
	beq.s	loc_E7BC
	move.w	($FFFFD518).w,d0
	beq.s	loc_E7BC
loc_E7B8:
	bsr.w	sub_11C8E
loc_E7BC:
	movem.l	(a7)+,d2-d3/d6-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_E7C4:
	move.w	#$5,($FFFFD5AA).w
	addq.w	#$1,($FFFFD5D6).w
	bsr.w	sub_13322
	bsr.w	sub_1368C
	bsr.w	sub_11CA0
	rts

; ---------------------------------------------------------------------------
sub_E7DC:
	move.l	d2,-(a7)
	bclr	#$5,$1(a3)
	btst	#$4,($FFFF97DC).w
	beq.s	loc_E80E
	moveq	#$4,d0
	moveq	#$2,d1
	moveq	#$0,d2
	movea.l	a2,a0
	jsr	($4F20).w
	cmp.b	#$2,d0
	bcc.s	loc_E80E
	bset	#$5,$1(a3)
	move.b	$16(a3),d0
	asr.b	#$2,d0
	move.b	d0,$16(a3)
loc_E80E:
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_E812:
	movem.l	d2-d3,-(a7)
	move.b	$1(a3),d3
	eori.b	#$1,d3
	andi.w	#$1,d3
	move.b	$17(a3),d0
	bmi.s	loc_E84C
	bsr.w	sub_6F02
	move.b	(a0),d0
	beq.s	loc_E84C
	andi.b	#$C0,d0
	bne.s	loc_E84C
	move.b	$1(a0),d0
	eor.b	d3,d0
	btst	#$0,d0
	bne.s	loc_E84C
	moveq	#$64,d4
	bsr.w	sub_15B34
	tst.b	d0
	bne.s	loc_E890
loc_E84C:
	move.b	($FFFFCA20).w,d0
	moveq	#$64,d2
	move.b	d3,($FFFFD500).w
	bsr.w	sub_15C2C
	move.b	($FFFFD506).w,d0
	bne.s	loc_E87A
	move.b	($FFFFCA20).w,d0
	move.b	d3,($FFFFD500).w
	st	($FFFFD4FF).w
	bsr.w	sub_15C2C
	clr.b	($FFFFD4FF).w
	move.b	($FFFFD506).w,d0
	beq.s	loc_E892
loc_E87A:
	lsr.b	#$1,d0
	addq.b	#$1,d0
	bsr.w	sub_6C94
	lea	($FFFFCA22).w,a0
	mulu.w	#$3,d0
	move.b	(a0,d0.w),$17(a3)
loc_E890:
	bra.s	loc_E896
loc_E892:
	st	$17(a3)
loc_E896:
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_E89C:
	link	a6,#-$E
	movem.l	d3-d4/d7/a4-a5,-(a7)
	move.b	d0,-$E(a6)
	move.b	$17(a3),($FFFFD513).w
	move.l	a0,-(a7)
	lea	($FFFFCACA).w,a0
	moveq	#$0,d0
	move.b	$12(a3),d0
	moveq	#$0,d1
	move.b	$13(a3),d1
	mulu.w	#$15,d0
	add.w	d1,d0
	move.b	(a0,d0.w),d1
	andi.w	#$7F,d1
	cmp.b	#$0,d1
	bne.s	loc_E8D8
	clr.b	-$E(a6)
loc_E8D8:
	movea.l	(a7)+,a0
	clr.l	-$4(a6)
	clr.l	-$A(a6)
	moveq	#$0,d0
	move.b	$A(a3),d0
	moveq	#$0,d1
	move.b	$8(a3),d1
	mulu.w	d1,d0
	move.b	$C(a3),d1
	add.w	d1,d0
	move.w	d0,-$6(a6)
	clr.b	-$B(a6)
	clr.b	-$C(a6)
	move.b	$17(a3),d0
	bmi.s	loc_E960
	bsr.w	sub_6F02
	moveq	#$64,d4
	bsr.w	sub_15B34
	tst.b	($FFFFD502).w
	bne.s	loc_E926
	move.b	$17(a3),d0
	moveq	#$18,d1
	bsr.w	sub_69C8
	tst.b	d0
	beq.s	loc_E92C
loc_E926:
	move.b	#$3,-$B(a6)
loc_E92C:
	tst.b	($FFFFD501).w
	beq.s	loc_E93A
	move.b	#$3,-$C(a6)
	bra.s	loc_E960
loc_E93A:
	move.b	$17(a3),d0
	bsr.w	sub_6F14
	move.b	$2F(a2),d0
	andi.b	#$6,d0
	bne.s	loc_E95A
	move.b	$17(a3),d0
	moveq	#$14,d1
	bsr.w	sub_69C8
	tst.b	d0
	beq.s	loc_E960
loc_E95A:
	move.b	#$2,-$C(a6)
loc_E960:
	tst.b	($FFFF97AE).w
	beq.s	loc_E972
	move.b	$2(a3),d0
	cmp.b	#$8,d0
	bcs.w	loc_EA70
loc_E972:
	lea	$54(a2),a4
	moveq	#$C,d7
loc_E978:
	move.b	(a4),d0
	beq.w	loc_EA24
	ext.w	d0
	asl.w	#$3,d0
	lea	($779E).w,a5
	adda.w	d0,a5
	move.b	(a5),d0
	bne.s	loc_E9C8
	move.b	-$E(a6),d0
	bsr.w	sub_EAA6
	move.w	d0,d2
	move.b	$1(a5),d1
	cmp.b	#$2,d1
	bne.s	loc_E9A8
	move.b	-$C(a6),d1
	asr.w	d1,d2
	bra.s	loc_E9B4
loc_E9A8:
	cmp.b	#$3,d1
	bne.s	loc_E9B4
	move.b	-$B(a6),d1
	asr.w	d1,d2
loc_E9B4:
	cmp.w	-$6(a6),d2
	bls.w	loc_EA30
	move.w	d2,-$6(a6)
	move.l	a4,-$4(a6)
	bra.w	loc_EA30
loc_E9C8:
	cmp.b	#$1,d0
	bne.s	loc_EA00
	lea	$C2(a2),a0
	tst.b	(a0)
	beq.s	loc_E9FA
	cmpa.l	a0,a4
	beq.s	loc_EA30
	move.b	$4(a0),d3
	move.b	(a0),d0
	ext.w	d0
	asl.w	#$3,d0
	lea	($779E).w,a1
	adda.w	d0,a1
	add.b	$1(a1),d3
	move.b	$4(a4),d4
	add.b	$1(a5),d4
	cmp.b	d3,d4
	bls.s	loc_EA30
loc_E9FA:
	bsr.w	sub_EA90
	bra.s	loc_EA30
loc_EA00:
	cmp.b	#$3,d0
	bne.s	loc_EA0C
	lea	$B8(a2),a0
	bra.s	loc_EA16
loc_EA0C:
	cmp.b	#$7,d0
	bne.s	loc_EA30
	lea	$CC(a2),a0
loc_EA16:
	cmpa.l	a0,a4
	beq.s	loc_EA30
	tst.b	(a0)
	bne.s	loc_EA30
	bsr.w	sub_EA90
	bra.s	loc_EA30
loc_EA24:
	lea	$AE(a2),a0
	cmpa.l	a0,a4
	bcc.s	loc_EA30
	move.l	a4,-$A(a6)
loc_EA30:
	adda.w	#$A,a4
	dbf	d7,loc_E978
	lea	$AE(a2),a0
	move.l	-$4(a6),d0
	beq.s	loc_EA70
	movea.l	d0,a4
	move.b	$5(a4),d0
	andi.b	#$30,d0
	beq.s	loc_EA52
	clr.w	$14(a3)
loc_EA52:
	cmpa.l	a0,a4
	beq.s	loc_EA80
	move.b	$9(a4),d0
	cmp.b	#$A,d0
	beq.s	loc_EA66
	cmp.b	#$B,d0
	bne.s	loc_EA6A
loc_EA66:
	clr.w	$14(a3)
loc_EA6A:
	bsr.w	sub_EA90
	bra.s	loc_EA80
loc_EA70:
	tst.b	(a0)
	beq.s	loc_EA80
	move.l	-$A(a6),d1
	beq.s	loc_EA80
	movea.l	d1,a4
	bsr.w	sub_EA90
loc_EA80:
	movea.l	a2,a1
	movea.l	a3,a0
	bsr.w	sub_6D1E
	movem.l	(a7)+,d3-d4/d7/a4-a5
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_EA90:
	movem.l	a0/a4,-(a7)
	moveq	#$4,d0
loc_EA96:
	move.w	(a0),d1
	move.w	(a4),(a0)+
	move.w	d1,(a4)+
	dbf	d0,loc_EA96
	movem.l	(a7)+,a0/a4
	rts

; ---------------------------------------------------------------------------
sub_EAA6:
	movem.l	d2/d7,-(a7)
	move.b	d0,d7
	moveq	#$0,d0
	move.b	$3(a5),d0
	moveq	#$0,d1
	move.b	$4(a5),d1
	mulu.w	d1,d0
	add.b	$5(a5),d0
	add.b	$5(a5),d0
	move.w	d0,d2
	move.b	$9(a4),d0
	cmp.b	#$5,d0
	bcs.s	loc_EB16
	cmp.b	#$C,d0
	bhi.s	loc_EB16
	moveq	#$0,d0
	tst.b	d7
	beq.w	loc_EB4A
	move.b	(a4),d0
	cmp.b	#$25,d0
	beq.s	loc_EAEE
	cmp.b	#$26,d0
	beq.s	loc_EAEE
	moveq	#$0,d1
	bra.s	loc_EAF0
loc_EAEE:
	moveq	#$1,d1
loc_EAF0:
	btst	#$0,$1(a3)
	beq.s	loc_EAFC
	tst.b	d1
	bne.s	loc_EB14
loc_EAFC:
	btst	#$4,($FFFF97DC).w
	beq.s	loc_EB08
	tst.b	d1
	bne.s	loc_EB14
loc_EB08:
	moveq	#$1,d0
	movea.l	a4,a0
	bsr.w	sub_EB50
	asl.w	#$1,d0
	bra.s	loc_EB4A
loc_EB14:
	moveq	#$0,d2
loc_EB16:
	movea.l	a2,a1
	move.b	(a4),d0
	bsr.w	sub_6E80
	add.b	$4(a4),d0
	mulu.w	#$3,d0
	add.w	d0,d2
	movea.l	a3,a0
	movea.l	a2,a1
	tst.b	$1(a5)
	bne.s	loc_EB3A
	bsr.w	sub_6E9E
	add.w	d1,d0
	bra.s	loc_EB3E
loc_EB3A:
	bsr.w	sub_6EBC
loc_EB3E:
	add.w	d0,d2
	moveq	#$0,d0
	move.b	$2(a5),d0
	mulu.w	d0,d2
	move.w	d2,d0
loc_EB4A:
	movem.l	(a7)+,d2/d7
	rts

; ---------------------------------------------------------------------------
sub_EB50:
	link	a6,#-$1AA
	movem.l	d2-d7/a2-a3,-(a7)
	move.b	d0,-$1(a6)
	clr.w	-$3E(a6)
	tst.b	-$1(a6)
	bne.s	loc_EB6A
	lea	$AE(a2),a0
loc_EB6A:
	move.l	a0,-$C(a6)
	move.b	(a0),d0
	beq.w	loc_EF46
	ext.w	d0
	asl.w	#$3,d0
	lea	($779E).w,a1
	adda.w	d0,a1
	move.l	a1,-$10(a6)
	move.b	$1(a1),d0
	cmp.b	#$7,d0
	bne.s	loc_EB90
	moveq	#$2,d0
	bra.s	loc_EB9C
loc_EB90:
	cmp.b	#$9,d0
	bne.s	loc_EB9A
	moveq	#$3,d0
	bra.s	loc_EB9C
loc_EB9A:
	moveq	#$1,d0
loc_EB9C:
	move.w	d0,-$4(a6)
	move.b	($FFFFCA20).w,-$2(a6)
	movea.l	-$C(a6),a0
	bsr.w	sub_11630
	move.w	d0,-$40(a6)
	add.w	-$4(a6),d0
	move.w	d0,-$6(a6)
	cmp.w	#$9,d0
	bls.s	loc_EBE4
	move.w	#$9,-$6(a6)
	movea.l	-$C(a6),a0
	move.b	(a0),d0
	cmp.b	#$25,d0
	beq.s	loc_EBE4
	cmp.b	#$26,d0
	beq.s	loc_EBE4
	tst.b	$17(a3)
	bmi.s	loc_EBE4
	move.b	$17(a3),-$2(a6)
loc_EBE4:
	move.w	-$6(a6),d0
	sub.w	-$4(a6),d0
	move.w	d0,-$8(a6)
	movea.l	-$C(a6),a0
	move.b	(a0),d0
	cmp.b	#$25,d0
	beq.s	loc_EC02
	cmp.b	#$26,d0
	bne.s	loc_EC28
loc_EC02:
	move.b	$1(a3),d0
	andi.w	#$1,d0
	beq.s	loc_EC1A
	move.b	#$4,-$3B(a6)
	move.b	#$1,-$3C(a6)
	bra.s	loc_EC4C
loc_EC1A:
	move.b	#$1,-$3B(a6)
	move.b	#$4,-$3C(a6)
	bra.s	loc_EC4C
loc_EC28:
	move.b	$1(a3),d0
	andi.w	#$1,d0
	beq.s	loc_EC40
	move.b	#$F4,-$3B(a6)
	move.b	#$1,-$3C(a6)
	bra.s	loc_EC4C
loc_EC40:
	move.b	#$1,-$3B(a6)
	move.b	#$FE,-$3C(a6)
loc_EC4C:
	move.b	-$2(a6),d0
	bsr.w	sub_6EF0
	moveq	#$0,d0
	move.b	$12(a3),d0
	move.w	d0,-$14(a6)
	moveq	#$0,d1
	move.b	$13(a3),d1
	move.w	d1,-$12(a6)
	move.l	-$14(a6),-$32(a6)
	move.l	-$14(a6),-$2E(a6)
	move.w	-$6(a6),d0
	sub.w	d0,-$32(a6)
	sub.w	d0,-$30(a6)
	add.w	d0,-$2E(a6)
	add.w	d0,-$2C(a6)
	move.l	-$14(a6),-$3A(a6)
	move.l	-$14(a6),-$36(a6)
	move.w	-$8(a6),d0
	sub.w	d0,-$3A(a6)
	sub.w	d0,-$38(a6)
	add.w	d0,-$36(a6)
	add.w	d0,-$34(a6)
	lea	-$1A9(a6),a0
	move.w	#$168,d0
loc_ECB0:
	clr.b	(a0)+
	dbf	d0,loc_ECB0
	lea	($FFFFC470).w,a3
	move.w	($FFFFBA64).w,d7
	bra.w	loc_EDF6
loc_ECC2:
	move.b	(a3),d0
	beq.w	loc_EDF2
	andi.b	#$C0,d0
	bne.w	loc_EDF2
	moveq	#$0,d5
	move.b	$12(a3),d5
	moveq	#$0,d6
	move.b	$13(a3),d6
	cmp.w	-$32(a6),d5
	blt.w	loc_EDF2
	cmp.w	-$2E(a6),d5
	bgt.w	loc_EDF2
	cmp.w	-$30(a6),d6
	blt.w	loc_EDF2
	cmp.w	-$2C(a6),d6
	bgt.w	loc_EDF2
	move.b	$1(a3),d0
	andi.w	#$1,d0
	lea	-$3C(a6),a0
	move.b	(a0,d0.w),d4
	movea.l	-$C(a6),a0
	move.b	(a0),d0
	cmp.b	#$25,d0
	beq.s	loc_ED1E
	cmp.b	#$26,d0
	bne.s	loc_ED36
loc_ED1E:
	move.w	d5,d0
	move.w	d6,d1
	bsr.w	sub_143FE
	cmp.b	#$0,d1
	beq.s	loc_ED32
	cmp.b	#$1,d1
	bne.s	loc_ED48
loc_ED32:
	moveq	#$0,d4
	bra.s	loc_ED48
loc_ED36:
	cmp.b	#$23,d0
	bne.s	loc_ED48
	moveq	#$E,d0
	jsr	($69DA).w
	tst.b	d0
	beq.s	loc_ED48
	moveq	#$0,d4
loc_ED48:
	move.w	-$4(a6),d0
	move.w	d0,-$28(a6)
	neg.w	d0
	move.w	d0,-$26(a6)
	add.w	d6,d0
	cmp.w	-$38(a6),d0
	bge.s	loc_ED68
	move.w	-$38(a6),d0
	sub.w	d6,d0
	move.w	d0,-$26(a6)
loc_ED68:
	move.w	-$28(a6),d0
	add.w	d6,d0
	cmp.w	-$34(a6),d0
	ble.s	loc_ED7E
	move.w	-$34(a6),d0
	sub.w	d6,d0
	move.w	d0,-$28(a6)
loc_ED7E:
	lea	(dat_EF56).l,a1
	adda.w	-$4(a6),a1
	move.w	-$26(a6),d3
loc_ED8C:
	move.w	d3,d1
	muls.w	#$3,d1
	move.b	(a1,d1.w),d1
	ext.w	d1
	move.w	d5,d0
	sub.w	d1,d0
	move.w	d0,-$22(a6)
	add.w	d5,d1
	move.w	d1,-$24(a6)
	cmp.w	-$3A(a6),d0
	bge.s	loc_EDB2
	move.w	-$3A(a6),-$22(a6)
loc_EDB2:
	cmp.w	-$36(a6),d1
	ble.s	loc_EDBE
	move.w	-$36(a6),-$24(a6)
loc_EDBE:
	move.w	-$22(a6),d2
	move.w	d3,d0
	add.w	d6,d0
	sub.w	-$12(a6),d0
	muls.w	#$13,d0
	add.w	d2,d0
	sub.w	-$14(a6),d0
	lea	-$F5(a6),a0
	adda.w	d0,a0
loc_EDDA:
	add.b	d4,(a0)+
	bvc.s	loc_EDE2
	sub.b	d4,-$1(a0)
loc_EDE2:
	addq.w	#$1,d2
	cmp.w	-$24(a6),d2
	ble.s	loc_EDDA
	addq.w	#$1,d3
	cmp.w	-$28(a6),d3
	ble.s	loc_ED8C
loc_EDF2:
	adda.w	#$1A,a3
loc_EDF6:
	dbf	d7,loc_ECC2
	bsr.w	sub_6EEC
	moveq	#$0,d0
	move.b	$12(a3),d0
	move.w	d0,-$20(a6)
	move.b	$13(a3),d0
	move.w	d0,-$1E(a6)
	moveq	#$0,d7
	move.w	-$8(a6),d5
	neg.w	d5
loc_EE18:
	move.w	-$8(a6),d6
	neg.w	d6
loc_EE1E:
	lea	-$F5(a6),a0
	move.w	d6,d0
	muls.w	#$13,d0
	add.w	d5,d0
	move.b	(a0,d0.w),d2
	bmi.w	loc_EE8E
	move.b	d2,-$2A(a6)
	cmp.b	d7,d2
	blt.s	loc_EE8E
	bne.s	loc_EE46
	jsr	($6D06).w
	cmp.b	#$19,d0
	bhi.s	loc_EE8E
loc_EE46:
	move.w	-$14(a6),d0
	add.w	d5,d0
	cmp.w	#$15,d0
	bcc.s	loc_EE8E
	move.w	-$12(a6),d1
	add.w	d6,d1
	cmp.w	#$15,d1
	bcc.s	loc_EE8E
	move.w	d0,-$18(a6)
	move.w	d1,-$16(a6)
	move.w	-$20(a6),d2
	move.w	-$1E(a6),d3
	move.w	-$40(a6),d4
	st	($FFFFD504).w
	bsr.w	sub_15B5A
	tst.b	d0
	beq.s	loc_EE8E
	tst.b	($FFFFD501).w
	bne.s	loc_EE8E
	move.l	-$18(a6),-$1C(a6)
	move.b	-$2A(a6),d7
loc_EE8E:
	addq.w	#$1,d6
	cmp.w	-$8(a6),d6
	ble.s	loc_EE1E
	addq.w	#$1,d5
	cmp.w	-$8(a6),d5
	ble.w	loc_EE18
	tst.b	-$1(a6)
	bne.s	loc_EEDA
	tst.b	d7
	beq.s	loc_EED0
	move.b	#$3,($FFFFD50D).w
	bsr.w	sub_6EEC
	movem.w	-$1C(a6),d0-d1
	mulu.w	#$18,d0
	mulu.w	#$18,d1
	movem.w	d0-d1,($FFFFB3F0).w
	bsr.w	sub_10FAA
	bra.w	loc_EF46
loc_EED0:
	moveq	#$0,d0
	bsr.w	sub_E89C
	bra.w	loc_EF46
loc_EEDA:
	moveq	#$0,d0
	ext.w	d7
	bmi.w	loc_EF46
	movea.l	-$C(a6),a0
	move.b	(a0),d0
	cmp.b	#$25,d0
	bne.s	loc_EEF8
	moveq	#$6,d0
	jsr	($6C8C).w
	addq.w	#$1,d0
	bra.s	loc_EF44
loc_EEF8:
	cmp.b	#$26,d0
	bne.s	loc_EF06
	moveq	#$6,d0
	jsr	($6C8C).w
	bra.s	loc_EF44
loc_EF06:
	cmp.b	#$21,d0
	bne.s	loc_EF10
	moveq	#$28,d0
	bra.s	loc_EF44
loc_EF10:
	cmp.b	#$24,d0
	bne.s	loc_EF22
	moveq	#$A,d0
	jsr	($6C8C).w
	addi.w	#$A,d0
	bra.s	loc_EF44
loc_EF22:
	cmp.b	#$23,d0
	bne.s	loc_EF32
	moveq	#$A,d0
	jsr	($6C8C).w
	addq.w	#$5,d0
	bra.s	loc_EF44
loc_EF32:
	cmp.b	#$11,d0
	bne.s	loc_EF3C
	moveq	#$19,d0
	bra.s	loc_EF44
loc_EF3C:
	cmp.b	#$12,d0
	bne.s	loc_EF44
	moveq	#$1E,d0
loc_EF44:
	mulu.w	d7,d0
loc_EF46:
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts
	dc.b	$FD,$FD,$01,$FD,$01,$02,$01,$02
dat_EF56:
	binclude	"data/00EF56.bin"

; ---------------------------------------------------------------------------
sub_EF64:
	movem.l	d3-d7/a6,-(a7)
	moveq	#$0,d7
	moveq	#$0,d3
	bsr.w	sub_F156
	bsr.w	sub_10200
	move.b	$14(a3),d0
	beq.w	loc_F0CC
	cmp.b	#$1,d0
	seq	d6
	bne.s	loc_EF88
	st	$17(a3)
loc_EF88:
	bsr.w	sub_E812
	tst.b	$17(a3)
	bmi.w	loc_F07A
	moveq	#$E,d0
	jsr	($664E).w
	moveq	#$1,d0
	bsr.w	sub_E89C
	tst.w	$14(a3)
	beq.w	loc_F0CC
	bsr.w	sub_11638
	move.w	d0,d5
	moveq	#$0,d0
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_15D8A
	lea	($FFFF6CB0).l,a6
	tst.b	(a6)
	bmi.w	loc_F07A
loc_EFC4:
	bsr.w	sub_F156
	tst.b	d0
	bne.w	loc_F0CC
	tst.b	$14(a3)
	beq.w	loc_F0CC
	move.w	d5,d4
	cmp.w	#$1,d4
	bls.s	loc_EFF2
	asr.w	#$1,d4
	move.b	$17(a3),d0
	jsr	($6F02).w
	bsr.w	sub_15B34
	tst.b	d0
	beq.s	loc_F030
	bra.s	loc_F024
loc_EFF2:
	moveq	#$1,d2
	move.b	$1(a3),d0
	eori.b	#$1,d0
	andi.w	#$1,d0
	move.b	d0,($FFFFD500).w
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_15C2C
	move.b	($FFFFD506).w,d0
	beq.s	loc_F030
	jsr	($6C94).w
	lea	($FFFFCA22).w,a0
	mulu.w	#$3,d0
	move.b	(a0,d0.w),$17(a3)
loc_F024:
	bsr.w	sub_F0E2
	tst.b	$14(a3)
	beq.w	loc_F0CC
loc_F030:
	moveq	#$0,d0
	move.b	(a6)+,d0
	bmi.s	loc_F07A
	tst.w	d7
	bne.s	loc_F048
	move.w	d0,-(a7)
	bsr.w	sub_F132
	bsr.w	sub_F9A6
	move.w	(a7)+,d0
	moveq	#$1,d7
loc_F048:
	move.w	d0,-(a7)
	moveq	#$1,d0
	moveq	#$0,d1
	bsr.w	sub_E606
	move.w	(a7)+,d0
	lea	(dat_146E0).l,a0
	move.b	(a0,d0.w),d1
	ext.w	d1
	move.w	d1,($FFFFB3F4).w
	move.b	$B(a0,d0.w),d1
	ext.w	d1
	move.w	d1,($FFFFB3F6).w
	bsr.w	sub_F898
	bmi.s	loc_F0D0
	tst.b	d0
	bne.w	loc_EFC4
loc_F07A:
	tst.b	d6
	bne.s	loc_F08A
	move.b	#$1,$14(a3)
	bsr.w	sub_F0D6
	bra.s	loc_F0CC
loc_F08A:
	move.w	d5,d2
	beq.s	loc_F0C8
	move.b	$1(a3),d0
	eori.b	#$1,d0
	andi.w	#$1,d0
	move.b	d0,($FFFFD500).w
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_15C2C
	move.b	($FFFFD506).w,d0
	beq.s	loc_F0C8
	jsr	($6C94).w
	lea	($FFFFCA22).w,a0
	mulu.w	#$3,d0
	move.b	(a0,d0.w),$17(a3)
	bsr.w	sub_F0E2
	tst.b	$14(a3)
	beq.s	loc_F0CC
loc_F0C8:
	bsr.w	sub_F1A2
loc_F0CC:
	bsr.w	sub_F0D6
loc_F0D0:
	movem.l	(a7)+,d3-d7/a6
	rts

; ---------------------------------------------------------------------------
sub_F0D6:
	tst.w	d7
	beq.s	loc_F0E0
	bsr.w	sub_FA22
	clr.w	d7
loc_F0E0:
	rts

; ---------------------------------------------------------------------------
sub_F0E2:
	tst.b	$14(a3)
	beq.s	loc_F130
	bsr.s	sub_F0D6
	bsr.w	sub_105FC
	tst.b	d0
	beq.s	loc_F102
	bsr.w	sub_F132
	jsr	($6EEC).w
	moveq	#$0,d0
	bsr.w	sub_EB50
	bra.s	loc_F130
loc_F102:
	tst.b	$17(a3)
	bmi.s	loc_F130
	move.b	$17(a3),d0
	jsr	($6F02).w
	bsr.w	sub_E588
	movem.w	d0-d1,($FFFFB3F0).w
	move.b	$17(a3),d0
	bsr.w	sub_10400
	tst.b	($FFFFD511).w
	beq.s	loc_F130
	bsr.w	sub_F132
	bsr.w	sub_1074A
loc_F130:
	rts

; ---------------------------------------------------------------------------
sub_F132:
	tst.b	d3
	bne.s	loc_F154
	moveq	#$1,d3
	jsr	($6EEC).w
	bsr.w	sub_E5A8
	movea.l	a3,a0
	movea.l	a2,a1
	jsr	($6D1E).w
	st	($FFFFD508).w
	moveq	#$1,d0
	moveq	#$0,d1
	bsr.w	sub_E606
loc_F154:
	rts

; ---------------------------------------------------------------------------
sub_F156:
	move.l	d2,-(a7)
	moveq	#$0,d2
	jsr	(sub_F1B66).l
	btst	#$7,d0
	beq.s	loc_F19C
	lea	($FFFFC470).w,a0
	moveq	#$0,d1
loc_F16C:
	move.b	$1(a0),d0
	btst	#$0,d0
	beq.s	loc_F190
	btst	#$6,d0
	bne.s	loc_F190
	tst.b	$1(a0)
	bpl.s	loc_F190
	bclr	#$7,$1(a0)
	cmp.b	($FFFFCA20).w,d1
	bne.s	loc_F190
	moveq	#$1,d2
loc_F190:
	adda.w	#$1A,a0
	addq.w	#$1,d1
	cmp.w	#$8,d1
	bne.s	loc_F16C
loc_F19C:
	move.l	d2,d0
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_F1A2:
	clr.b	$14(a3)
	movem.l	d0/a0-a3,-(a7)
	jsr	($6EEC).w
	bsr.w	sub_105FC
	bne.s	loc_F1BA
	bset	#$4,$1(a3)
loc_F1BA:
	movem.l	(a7)+,d0/a0-a3
	rts

; ---------------------------------------------------------------------------
sub_F1C0:
	lea	($FFFFC470).w,a0
	move.w	($FFFFBA64).w,d0
	subq.w	#$1,d0
loc_F1CA:
	move.b	(a0),d1
	beq.s	loc_F1E0
	andi.b	#$C0,d1
	bne.s	loc_F1E0
	btst	#$0,$1(a0)
	bne.s	loc_F1E0
	move.b	#$82,(a0)
loc_F1E0:
	adda.w	#$1A,a0
	dbf	d0,loc_F1CA
	rts

; ---------------------------------------------------------------------------
sub_F1EA:
	movem.l	d2-d3,-(a7)
	lea	($FFFFC470).w,a0
	lea	($FFFFCA22).w,a1
	moveq	#$0,d2
	moveq	#$0,d3
	move.w	($FFFFBA64).w,d1
	bra.s	loc_F21E
loc_F200:
	move.b	(a0),d0
	beq.s	loc_F218
	andi.b	#$C0,d0
	bne.s	loc_F218
	btst	#$0,$1(a0)
	bne.s	loc_F218
	move.b	d3,(a1)
	addq.l	#$3,a1
	addq.w	#$1,d2
loc_F218:
	addq.w	#$1,d3
	adda.w	#$1A,a0
loc_F21E:
	dbf	d1,loc_F200
	move.b	d2,($FFFFD506).w
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_F22C:
	movem.l	d2-d4,-(a7)
	moveq	#$0,d4
	move.b	($FFFFCA20).w,d0
	jsr	($6F14).w
	move.b	$32(a1),d4
	lea	($FFFFC470).w,a0
	lea	($FFFFCA22).w,a1
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$7,d1
loc_F24C:
	move.b	(a0),d0
	cmp.b	#$83,d0
	beq.s	loc_F268
	tst.b	d4
	beq.s	loc_F276
	cmp.b	#$84,d0
	bne.s	loc_F276
	move.b	$2(a0),d0
	btst	d0,($FFFFD50A).w
	bne.s	loc_F276
loc_F268:
	btst	#$0,$1(a0)
	beq.s	loc_F276
	move.b	d3,(a1)
	addq.l	#$3,a1
	addq.w	#$1,d2
loc_F276:
	addq.w	#$1,d3
	adda.w	#$1A,a0
	dbf	d1,loc_F24C
	move.b	d2,($FFFFD506).w
	movem.l	(a7)+,d2-d4
	rts

; ---------------------------------------------------------------------------
sub_F28A:
	btst	#$0,$1(a3)
	beq.s	loc_F2AA
	tst.b	$32(a2)
	bne.s	loc_F29E
	tst.b	$3B(a2)
	beq.s	loc_F2AA
loc_F29E:
	bsr.s	sub_F22C
	tst.b	($FFFFD506).w
	beq.s	loc_F2AA
	moveq	#$1,d0
	rts
loc_F2AA:
	moveq	#$0,d0
	rts

; ---------------------------------------------------------------------------
sub_F2AE:
	link	a6,#-$56
	movem.l	d2-d7,-(a7)
	clr.l	-$8(a6)
	lea	(dat_F4D6).l,a0
	lea	-$56(a6),a1
	moveq	#$E,d0
loc_F2C6:
	move.w	(a0)+,(a1)+
	dbf	d0,loc_F2C6
	bsr.s	sub_F28A
	move.b	d0,-$38(a6)
	beq.s	loc_F2E0
	move.w	#$5E,-$3C(a6)
	move.b	#$2A,-$4B(a6)
loc_F2E0:
	st	-$A(a6)
	moveq	#-$1,d7
	bsr.w	sub_F81C
loc_F2EA:
	bsr.w	sub_E5E6
	move.b	($FFFFCA20).w,-$A(a6)
loc_F2F4:
	bsr.w	sub_F780
	tst.b	($FFFFD51C).w
	beq.s	loc_F306
	bsr.w	sub_F6DC
	clr.b	($FFFFD51C).w
loc_F306:
	moveq	#$1,d0
	move.b	d7,d1
	bsr.w	sub_E606
	cmp.b	#$1,d7
	blt.s	loc_F346
	move.b	-$A(a6),d0
	bsr.w	sub_10400
	move.b	-$A(a6),d0
	bpl.s	loc_F328
	tst.b	-$14(a6)
	beq.s	loc_F346
loc_F328:
	move.b	($FFFFCA20).w,d2
	move.b	d0,($FFFFCA20).w
	moveq	#$14,d0
	move.b	d7,d1
	bsr.w	sub_E606
	move.b	d2,($FFFFCA20).w
	bra.s	loc_F350

; ---------------------------------------------------------------------------
sub_F33E:
	ori.b	#$17,(a4)
	ori.b	#$1A,-(a6)
loc_F346:
	lea	(sub_F33E).l,a0
	bsr.w	sub_1344E
loc_F350:
	tst.b	$14(a3)
	beq.w	loc_F6D0
	cmp.b	#$FF,d7
	bne.w	loc_F4F4
	move.w	#$30,($FFFFD888).l
	st	($FFFFB4C4).w
	move.l	#$20020,(a4)
	moveq	#$E,d0
	lea	($FFFFB4EC).w,a0
	lea	-$36(a6),a1
loc_F37C:
	move.w	(a0),(a1)+
	move.w	(a5),(a0)+
	dbf	d0,loc_F37C
	jsr	($6EEC).w
	bsr.w	sub_AD46
	movem.l	a2-a3,-(a7)
	move.b	#$40,($FFFFD595).w
	st	($FFFFD592).w
	lea	-$46(a6),a3
	lea	-$56(a6),a2
	bsr.w	sub_1391A
	move.w	d0,d5
	movem.l	(a7)+,a2-a3
	move.l	#$40017,($FFFFD582).w
	move.l	#$260019,($FFFFD586).w
	lea	(sub_F33E).l,a0
	bsr.w	sub_1344E
	clr.b	($FFFFB4C4).w
	moveq	#$E,d0
	lea	($FFFFB4EC).w,a0
	lea	-$36(a6),a1
loc_F3D4:
	move.b	(a1)+,(a0)+
	dbf	d0,loc_F3D4
	bsr.w	sub_AD5A
	jsr	(sub_96D8).l
	tst.w	d5
	bmi.s	loc_F400
	asl.w	#$1,d5
	lea	(jt_F3F6).l,a0
	adda.w	(a0,d5.w),a0
	jmp	(a0)
jt_F3F6:
	dc.w	loc_F424-jt_F3F6
	dc.w	loc_F47E-jt_F3F6
	dc.w	loc_F494-jt_F3F6
	dc.w	loc_F49E-jt_F3F6
	dc.w	loc_F4CE-jt_F3F6
loc_F400:
	move.b	($FFFFCA20).w,d0
	cmp.b	#$8,d0
	bcc.w	loc_F350
	jsr	($6C54).w
	bsr.w	sub_F838
	bsr.w	sub_FDC8
	tst.b	$14(a3)
	beq.w	loc_F6D0
	bra.w	loc_F2E0
loc_F424:
	moveq	#$1,d7
	bsr.w	sub_105FC
	tst.b	d0
	sne	-$14(a6)
	bsr.w	sub_11746
	bsr.w	sub_F1EA
	clr.b	-$16(a6)
	movem.l	d0-d2/a0,-(a7)
	lea	($FFFFD51D).w,a0
	moveq	#$0,d0
	move.b	($FFFFCA20).w,d0
	move.b	(a0,d0.w),d2
	bmi.s	loc_F476
	moveq	#$0,d1
	move.b	($FFFFD506).w,d1
	lea	($FFFFCA22).w,a0
	bra.s	loc_F468
loc_F45C:
	move.l	d1,d0
	mulu.w	#$3,d0
	cmp.b	(a0,d0.w),d2
	beq.s	loc_F46E
loc_F468:
	dbf	d1,loc_F45C
	bra.s	loc_F476
loc_F46E:
	move.b	d1,-$16(a6)
	st	($FFFFD51C).w
loc_F476:
	movem.l	(a7)+,d0-d2/a0
	bra.w	loc_F2EA
loc_F47E:
	moveq	#$0,d7
	move.w	$12(a3),-$10(a6)
	move.b	$16(a3),-$12(a6)
	bsr.w	sub_F9A6
	bra.w	loc_F2EA
loc_F494:
	bset	#$7,$1(a3)
	bra.w	loc_F6D0
loc_F49E:
	tst.b	-$38(a6)
	bne.s	loc_F4BC
	moveq	#$1,d0
	cmp.b	$14(a3),d0
	beq.s	loc_F4B4
	move.b	d0,$14(a3)
	bra.w	loc_F6D0
loc_F4B4:
	clr.b	$14(a3)
	bra.w	loc_F6D0
loc_F4BC:
	bsr.w	sub_116F8
	moveq	#$2,d7
	bsr.w	sub_F22C
	clr.b	-$16(a6)
	bra.w	loc_F2EA
loc_F4CE:
	bsr.w	sub_F1A2
	bra.w	loc_F6D0
dat_F4D6:
	binclude	"data/00F4D6.bin"
loc_F4F4:
	cmp.b	#$1,d7
	bne.s	loc_F50E
	move.b	$10(a3),d2
	moveq	#$0,d0
	bsr.w	sub_116AC
	cmp.b	$10(a3),d2
	beq.s	loc_F50E
	bsr.w	sub_AD5A
loc_F50E:
	moveq	#$14,d4
	clr.l	-$E(a6)
loc_F514:
	jsr	(sub_F1B66).l
	btst	#$7,d0
	beq.s	loc_F552
	cmp.b	#$0,d7
	bne.s	loc_F544
	bsr.w	sub_FA22
	bsr.w	sub_F996
	bsr.w	sub_F9F4
	move.w	-$10(a6),$12(a3)
	move.b	-$12(a6),$16(a3)
	bsr.w	sub_F986
	bra.s	loc_F54C
loc_F544:
	clr.b	-$14(a6)
	bsr.w	sub_116F8
loc_F54C:
	moveq	#-$1,d7
	bra.w	loc_F2EA
loc_F552:
	btst	#$6,d0
	beq.s	loc_F570
	cmp.b	#$0,d7
	beq.s	loc_F566
	bsr.w	sub_116F8
	bra.w	loc_F400
loc_F566:
	bsr.w	sub_FA22
	moveq	#-$1,d7
	bra.w	loc_F400
loc_F570:
	btst	#$4,d0
	beq.s	loc_F594
	cmp.b	#$0,d7
	beq.s	loc_F584
	bsr.w	sub_F6DC
	bra.w	loc_F2F4
loc_F584:
	tst.b	($FFFFCA21).w
	bne.w	loc_F350
	bsr.w	sub_F1C0
	bra.w	loc_F6D0
loc_F594:
	btst	#$5,d0
	beq.s	loc_F5CE
	cmp.b	#$0,d7
	bne.s	loc_F5AE
	bsr.w	sub_FA22
	moveq	#-$1,d7
	jsr	($6C54).w
	bra.w	loc_F2EA
loc_F5AE:
	cmp.b	#$1,d7
	bne.s	loc_F5BC
	bsr.w	sub_103CE
	bra.w	loc_F350
loc_F5BC:
	moveq	#-$1,d7
	bsr.w	sub_F780
	bsr.w	sub_101A4
	move.b	#$FF,d7
	bra.w	loc_F2EA
loc_F5CE:
	btst	#$0,d0
	beq.s	loc_F5D8
	moveq	#-$1,d2
	bra.s	loc_F5E4
loc_F5D8:
	btst	#$1,d0
	beq.s	loc_F5E2
	moveq	#$1,d2
	bra.s	loc_F5E4
loc_F5E2:
	moveq	#$0,d2
loc_F5E4:
	btst	#$2,d0
	beq.s	loc_F5EE
	moveq	#-$1,d1
	bra.s	loc_F5FA
loc_F5EE:
	btst	#$3,d0
	beq.s	loc_F5F8
	moveq	#$1,d1
	bra.s	loc_F5FA
loc_F5F8:
	moveq	#$0,d1
loc_F5FA:
	movem.w	d1-d2,($FFFFB3F4).w
	cmp.b	#$0,d7
	beq.w	loc_F6AA
	tst.l	($FFFFB3F4).w
	beq.s	loc_F63A
	bsr.w	sub_116F8
	moveq	#$17,d2
loc_F614:
	move.w	#$BB8,d0
loc_F618:
	dbf	d0,loc_F618
	bsr.w	sub_10006
	bsr.w	sub_F7BA
	dbf	d2,loc_F614
	cmp.b	#$1,d7
	bne.s	loc_F648
	bsr.w	sub_11746
	bsr.w	sub_1172A
	bra.w	loc_F648
loc_F63A:
	tst.l	($FFFFD87E).l
	beq.w	loc_F648
	bsr.w	sub_11898
loc_F648:
	clr.l	($FFFFB3F4).w
	movem.w	($FFFFB3F0).w,d2-d3
	divu.w	#$18,d2
	divu.w	#$18,d3
	bsr.w	sub_1432E
	tst.b	d0
	bmi.s	loc_F668
	cmp.b	#$2,d7
	bne.s	loc_F66E
loc_F668:
	tst.b	d1
	bmi.s	loc_F66E
	move.b	d1,d0
loc_F66E:
	cmp.b	-$A(a6),d0
	beq.w	loc_F67E
	move.b	d0,-$A(a6)
	bra.w	loc_F2F4
loc_F67E:
	tst.b	-$14(a6)
	beq.w	loc_F350
	move.b	($FFFFD511).w,d2
	move.w	($FFFFD518).w,d3
	move.b	-$A(a6),d0
	bsr.w	sub_10400
	cmp.b	($FFFFD511).w,d2
	bne.w	loc_F2F4
	cmp.w	($FFFFD518).w,d3
	bne.w	loc_F2F4
	bra.w	loc_F350
loc_F6AA:
	or.w	d1,-$E(a6)
	or.w	d2,-$C(a6)
	movem.w	-$E(a6),d1-d2
	and.w	d1,d2
	bne.s	loc_F6C0
	dbf	d4,loc_F514
loc_F6C0:
	move.l	-$E(a6),($FFFFB3F4).w
	bsr.w	sub_F898
	bmi.s	loc_F6D0
	bra.w	loc_F2EA
loc_F6D0:
	bsr.w	sub_F838
	movem.l	(a7)+,d2-d7
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_F6DC:
	tst.b	($FFFFD506).w
	beq.w	loc_F77E
	bsr.w	sub_116F8
	movem.l	d5/a2-a3,-(a7)
	jsr	($6C54).w
	movem.w	($FFFFB3F0).w,d2-d3
	moveq	#$0,d0
	move.b	-$16(a6),d0
	mulu.w	#$3,d0
	lea	($FFFFCA22).w,a0
	move.b	(a0,d0.w),d0
	jsr	($6EF0).w
	moveq	#$0,d4
	moveq	#$0,d5
	moveq	#$18,d6
	move.b	$12(a3),d4
	move.b	$13(a3),d5
	mulu.w	d6,d4
	mulu.w	d6,d5
	moveq	#$C,d6
	add.w	d6,d4
	add.w	d6,d5
	moveq	#$1F,d6
loc_F726:
	moveq	#$20,d1
	sub.w	d6,d1
	move.w	d4,d0
	sub.w	d2,d0
	muls.w	d1,d0
	asr.l	#$5,d0
	add.w	d2,d0
	sub.w	($FFFFB3F0).w,d0
	move.w	d0,($FFFFB3F4).w
	move.w	d5,d0
	sub.w	d3,d0
	muls.w	d1,d0
	asr.l	#$5,d0
	add.w	d3,d0
	sub.w	($FFFFB3F2).w,d0
	move.w	d0,($FFFFB3F6).w
	bsr.w	sub_DEE6
	bsr.w	sub_10006
	bsr.w	sub_F7BA
	dbf	d6,loc_F726
	move.b	-$16(a6),d0
	addq.b	#$1,d0
	cmp.b	($FFFFD506).w,d0
	bcs.s	loc_F76C
	moveq	#$0,d0
loc_F76C:
	move.b	d0,-$16(a6)
	movem.l	(a7)+,d5/a2-a3
	cmp.b	#$1,d7
	bne.s	loc_F77E
	bsr.w	sub_11746
loc_F77E:
	rts

; ---------------------------------------------------------------------------
sub_F780:
	move.l	a3,-(a7)
	cmp.b	#$0,d7
	ble.s	loc_F7AE
	bsr.w	sub_F81C
	movea.l	($FFFFB532).w,a0
	lea	-$4(a6),a3
	move.b	d7,d0
	subq.b	#$1,d0
	move.b	d0,(a3)
	st	$1(a3)
	moveq	#$1,d0
	movea.l	-$8(a6),a1
	move.w	(a1),d1
	bsr.w	sub_B58A
	bra.w	loc_F7B2
loc_F7AE:
	bsr.w	sub_F838
loc_F7B2:
	bsr.w	sub_F7BA
	movea.l	(a7)+,a3
	rts

; ---------------------------------------------------------------------------
sub_F7BA:
	movem.l	d2-d3,-(a7)
	move.l	#$2C020003,(a4)
	move.w	(a5),d3
	andi.b	#$FF,d3
	ori.w	#$A00,d3
	move.w	#$EC00,d0
	bsr.w	sub_8288
	cmp.b	#$0,d7
	ble.s	loc_F808
	move.w	($FFFFB3F2).w,d0
	sub.w	($FFFFB416).w,d0
	addi.w	#$74,d0
	move.w	d0,(a5)
	move.w	d3,(a5)
	movea.l	-$8(a6),a1
	move.w	(a1),d0
	ori.w	#$8000,d0
	move.w	d0,(a5)
	move.w	($FFFFB3F0).w,d0
	sub.w	($FFFFB414).w,d0
	addi.w	#$74,d0
	move.w	d0,(a5)
	bra.s	loc_F816
loc_F808:
	moveq	#$0,d2
	move.w	d2,(a5)
	move.w	#$EC06,d0
	bsr.w	sub_8288
	move.w	d2,(a5)
loc_F816:
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_F81C:
	move.l	a2,-(a7)
	tst.l	-$8(a6)
	bne.s	loc_F834
	bsr.w	sub_97CC
	addi.w	#$9,d0
	move.w	d0,$6(a2)
	move.l	a2,-$8(a6)
loc_F834:
	movea.l	(a7)+,a2
	rts

; ---------------------------------------------------------------------------
sub_F838:
	lea	-$8(a6),a0
	bsr.w	sub_9784
	rts

; ---------------------------------------------------------------------------
sub_F842:
	movem.l	d4-d7/a0-a1,-(a7)
	move.b	$F(a3),d7
	move.b	$1(a3),d6
	andi.b	#$1,d6
	moveq	#$0,d5
	move.w	($FFFFBA64).w,d5
	subq.w	#$1,d5
loc_F85A:
	move.l	d5,d0
	jsr	($6F02).w
	move.b	(a0),d0
	beq.s	loc_F888
	andi.b	#$C0,d0
	bne.s	loc_F888
	move.b	$1(a0),d0
	andi.b	#$1,d0
	eor.b	d6,d0
	beq.s	loc_F888
	cmp.b	$F(a0),d7
	bcc.s	loc_F888
	moveq	#$28,d4
	jsr	(sub_15B34).l
	tst.b	d0
	bne.s	loc_F890
loc_F888:
	dbf	d5,loc_F85A
	st	d0
	bra.s	loc_F892
loc_F890:
	clr.b	d0
loc_F892:
	movem.l	(a7)+,d4-d7/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_F898:
	move.b	$12(a3),d0
	add.b	($FFFFB3F5).w,d0
	cmp.b	#$15,d0
	bcc.s	loc_F8B4
	move.b	$13(a3),d0
	add.b	($FFFFB3F7).w,d0
	cmp.b	#$15,d0
	bcs.s	loc_F912
loc_F8B4:
	tst.b	$1(a3)
	bmi.s	loc_F8D0
	bsr.w	sub_1343E
	moveq	#$7,d0
	bsr.w	sub_136DA
	tst.w	d0
	beq.s	loc_F8D0
	bsr.w	sub_1344A
	bra.w	loc_F958
loc_F8D0:
	bsr.w	sub_F842
	tst.b	d0
	bne.s	loc_F8F4
	bsr.w	sub_1343E
	move.l	#$40017,($FFFFD5D6).w
	move.w	#$B6,d0
	bsr.w	sub_11C8E
	jsr	($75F8).w
	bra.w	loc_F958
loc_F8F4:
	move.b	#$85,(a3)
	move.b	#$6,$16(a3)
	clr.b	$14(a3)
	bsr.w	sub_1343E
	bsr.w	sub_11C5A
	move.w	#$B7,d0
	bsr.w	sub_11C8E
loc_F912:
	move.b	($FFFFCA20).w,d0
	move.w	($FFFFB3F6).w,d1
	asl.w	#$2,d1
	add.w	($FFFFB3F4).w,d1
	lea	(dat_F97F).l,a0
	move.b	(a0,d1.w),d1
	cmp.b	#$8,d1
	beq.s	loc_F958
	move.b	d1,$10(a3)
	bsr.w	sub_1443C
	tst.b	d0
	bpl.s	loc_F958
	move.b	d1,d0
	bsr.w	sub_144EA
	btst	#$5,d0
	bne.s	loc_F958
	andi.w	#$1F,d0
	cmp.b	$16(a3),d0
	bhi.s	loc_F958
	sub.b	d0,$16(a3)
	bra.s	loc_F95C
loc_F958:
	clr.l	($FFFFB3F4).w
loc_F95C:
	bsr.w	sub_FA52
	move.w	($FFFFB3F4).w,d0
	move.w	($FFFFB3F6).w,d1
	add.b	d0,$12(a3)
	add.b	d1,$13(a3)
	or.b	d1,d0
	beq.s	loc_F978
	bsr.w	sub_11A44
loc_F978:
	rts
	dc.b	$07,$00,$01,$08,$06
dat_F97F:
	dc.b	$08,$02,$08,$05,$04,$03,$08

; ---------------------------------------------------------------------------
sub_F986:
	move.l	a2,-(a7)
	movea.l	a3,a2
	bsr.w	sub_14298
	bsr.w	sub_AD5A
	movea.l	(a7)+,a2
	rts

; ---------------------------------------------------------------------------
sub_F996:
	move.l	a2,-(a7)
	movea.l	a3,a2
	bsr.w	sub_AD3E
	bsr.w	sub_142A8
	movea.l	(a7)+,a2
	rts

; ---------------------------------------------------------------------------
sub_F9A6:
	bsr.s	sub_F996
	bset	#$2,$1(a3)
	bsr.w	sub_F9F4
	st	($FFFFD510).w
	moveq	#$1,d0
	move.w	#$1,($FFFFB016).w
	move.w	#$2,($FFFFB0B2).w
	lea	($FFFFB018).w,a0
	clr.b	$1(a0)
	clr.b	$3(a0)
	move.b	#$C,$2(a0)
	lea	($FFFFB0B4).w,a0
	moveq	#$11,d0
loc_F9DC:
	clr.w	(a0)+
	dbf	d0,loc_F9DC
	lea	($FFFFB0C6).w,a0
	move.b	#$1,$C(a0)
	move.b	#$2,$9(a0)
	rts

; ---------------------------------------------------------------------------
sub_F9F4:
	move.l	a3,-(a7)
	lea	($FFFFC470).w,a0
	move.w	($FFFFBA64).w,d0
	move.w	$12(a3),d1
	bra.s	loc_FA1A
loc_FA04:
	cmp.w	$12(a0),d1
	bne.s	loc_FA16
	cmpa.l	a0,a3
	beq.s	loc_FA16
	movea.l	a0,a3
	bsr.w	sub_AD5A
	bra.s	loc_FA1E
loc_FA16:
	adda.w	#$1A,a0
loc_FA1A:
	dbf	d0,loc_FA04
loc_FA1E:
	movea.l	(a7)+,a3
	rts

; ---------------------------------------------------------------------------
sub_FA22:
	movem.l	a2-a3,-(a7)
	bclr	#$2,$1(a3)
	bsr.w	sub_F986
	lea	($FFFFB0B4).w,a2
	lea	($FFFFB018).w,a3
	clr.l	$4(a3)
	clr.b	$D(a2)
	clr.b	$1F(a2)
	clr.w	($FFFFB0B2).w
	bsr.w	sub_C3F0
	movem.l	(a7)+,a2-a3
	rts

; ---------------------------------------------------------------------------
sub_FA52:
	link	a6,#-$C
	movem.l	d2-d7/a2-a3,-(a7)
	move.b	$23(a2),d7
	move.b	d7,-$1(a6)
	move.b	$42(a2),-$2(a6)
	move.b	$10(a3),-$3(a6)
	move.b	$11(a3),-$4(a6)
	bsr.w	sub_FBA4
	moveq	#$0,d4
	move.b	-$3(a6),d4
	lea	(dat_FDBF).l,a1
	move.b	(a1,d4.w),d4
	asl.w	#$1,d4
	lea	(dat_FBF8).l,a1
	adda.w	(a0,d4.w),a1
	move.l	a1,-$C(a6)
	cmp.b	($FFFFD510).w,d4
	beq.w	loc_FB3C
	move.b	d4,($FFFFD510).w
	lea	($FFFFB018).w,a3
	move.b	-$2(a6),(a3)
	movea.l	-$C(a6),a0
	lea	$2(a0),a0
	lea	$8(a3),a1
loc_FAB8:
	move.b	(a0)+,(a1)+
	bpl.s	loc_FAB8
	lea	$8(a3),a0
	bsr.w	sub_FB94
	addq.l	#$1,a0
	bsr.w	sub_FB94
	movea.l	-$C(a6),a0
	dc.w	$3028,$0000	; move.w $0(a0),d0
	lea	(dat_FBF8).l,a1
	adda.w	d0,a1
	move.l	a1,$4(a3)
	move.b	d7,d0
	move.w	($FFFFB1C6).w,d1
	movea.l	($FFFFB586).w,a0
	lea	$8(a3),a3
	bsr.w	sub_B58A
	lea	($FFFFB018).w,a3
	lea	($FFFFB0B4).w,a2
	move.b	($FFFFCA20).w,d0
	jsr	($6F02).w
	bsr.w	sub_E58A
	moveq	#$C,d4
	sub.w	d4,d0
	sub.w	d4,d1
	movem.w	d0-d1,(a2)
	cmp.b	#$2,d7
	bne.s	loc_FB20
	addi.w	#$18,d1
	movem.w	d0-d1,$12(a2)
	bra.s	loc_FB36
loc_FB20:
	cmp.b	#$3,d7
	bne.s	loc_FB32
	addi.w	#$18,d0
	movem.w	d0-d1,$12(a2)
	bra.s	loc_FB36
loc_FB32:
	st	$1C(a2)
loc_FB36:
	bsr.w	sub_C0DC
	nop
loc_FB3C:
	moveq	#$0,d5
	move.w	($FFFFB3F4).w,d2
	move.w	($FFFFB3F6).w,d3
	tst.l	($FFFFB3F4).w
	beq.s	loc_FB50
	moveq	#$17,d5
	bra.s	loc_FB5A
loc_FB50:
	move.b	#$2,($FFFF9BB7).w
	bsr.w	sub_DEC4
loc_FB5A:
	move.b	#$2,($FFFF9BB7).w
	bsr.w	sub_DEC4
	add.w	d2,($FFFFB3EC).w
	add.w	d3,($FFFFB3EE).w
	lea	($FFFFB0B4).w,a2
	add.w	d2,(a2)
	add.w	d3,$2(a2)
	add.w	d2,$12(a2)
	add.w	d3,$14(a2)
	bsr.w	sub_C3F8
	moveq	#$0,d7
	bsr.w	sub_FF7C
	dbf	d5,loc_FB5A
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_FB94:
	btst	#$6,(a0)
	beq.s	loc_FBA2
	move.b	-$4(a6),d0
	asl.b	#$2,d0
	add.b	d0,(a0)
loc_FBA2:
	rts

; ---------------------------------------------------------------------------
sub_FBA4:
	move.b	-$2(a6),d0
	bpl.s	loc_FBAE
	moveq	#$0,d0
	bra.s	loc_FBCE
loc_FBAE:
	lea	(dat_9A14).l,a0
loc_FBB4:
	move.b	$4(a0),d1
	bmi.s	loc_FBD8
	cmp.b	d0,d1
	beq.s	loc_FBC2
	addq.l	#$8,a0
	bra.s	loc_FBB4
loc_FBC2:
	move.b	$7(a0),d0
	andi.w	#$F,d0
	mulu.w	#$8,d0
loc_FBCE:
	lea	(dat_FBF8).l,a0
	adda.w	d0,a0
	rts
loc_FBD8:
	lea	(dat_FBE4).l,a0
	jsr	(sub_132A6).l
dat_FBE4:
	binclude	"data/00FBE4.bin"
dat_FBF8:
	binclude	"data/00FBF8.bin"
dat_FDBF:
	binclude	"data/00FDBF.bin"

; ---------------------------------------------------------------------------
sub_FDC8:
	movem.l	d5-d7,-(a7)
	bsr.w	sub_85D6
	move.b	($FFFF9BBC).w,d6
	move.b	#$9,($FFFF9BBC).w
	bsr.w	sub_862A
	bsr.w	sub_8A60
	bsr.w	sub_8A76
	moveq	#$0,d5
	bsr.w	sub_A71E
	bsr.w	sub_B0DA
	bsr.w	sub_CAC0
	lea	($FFFFB532).w,a0
	bsr.w	sub_9784
	clr.l	($FFFFD57E).w
	moveq	#$0,d7
	tst.l	($FFFFB53A).w
	beq.s	loc_FE14
	move.w	($FFFFB530).w,d7
	clr.w	($FFFFB52A).w
	bsr.w	sub_8360
loc_FE14:
	lea	(dat_FE6C).l,a0
	bsr.w	sub_A768
	jsr	($7000).w
	bsr.w	sub_860E
	jsr	($748C).w
	lea	($FFFFB532).w,a0
	bsr.w	sub_9784
	clr.l	($FFFFD57E).w
	move.b	d6,($FFFF9BBC).w
	jsr	(sub_85D6).l
	bsr.w	sub_14D60
	lea	(dat_1524E).l,a0
	bsr.w	sub_A768
	moveq	#$1,d7
	bsr.w	sub_FF7C
	bsr.w	sub_860E
	bsr.w	sub_14FEA
	bsr.w	sub_B834
	bsr.w	sub_98E4
	move.w	d5,d0
	movem.l	(a7)+,d5-d7
	rts
dat_FE6C:
	binclude	"data/00FE6C.bin"

; ---------------------------------------------------------------------------
sub_FEA8:
	move.b	($FFFF9BBC).w,d0
	cmp.b	#$6,d0
	beq.w	loc_FEF6
	cmp.b	#$1,d0
	bne.w	loc_FEC4
	bsr.w	sub_100AC
	bra.w	loc_FEF6
loc_FEC4:
	tst.b	($FFFFBA5D).w
	bne.s	loc_FED8
	bsr.w	sub_AC9C
	bsr.w	sub_FEF8
	bsr.w	sub_100AC
	bra.s	loc_FEF6
loc_FED8:
	tst.b	d7
	bmi.s	loc_FEE2
	bsr.w	sub_CD2E
	bra.s	loc_FEE6
loc_FEE2:
	bsr.w	sub_CD4E
loc_FEE6:
	bsr.w	sub_100AC
	tst.b	($FFFFB522).w
	beq.w	loc_FEF6
	jsr	($5AC2).w
loc_FEF6:
	rts

; ---------------------------------------------------------------------------
sub_FEF8:
	movem.l	d2-d7/a2,-(a7)
	moveq	#$0,d0
	moveq	#$0,d1
	moveq	#$14,d2
	moveq	#$14,d3
	movea.l	($FFFFB536).w,a2
	movea.l	$2(a2),a2
	lea	($FFFFCACA).w,a0
	adda.w	d0,a0
	move.w	d1,d4
	mulu.w	#$15,d4
	adda.w	d4,a0
	move.w	#$15,d4
	sub.w	d2,d4
	subq.l	#$1,d4
	move.w	#$C000,d5
	mulu.w	#$6,d0
	mulu.w	#$180,d1
	add.w	d0,d5
	add.w	d1,d5
loc_FF32:
	move.w	d2,d6
loc_FF34:
	move.b	(a0)+,d1
	andi.w	#$7F,d1
	mulu.w	#$12,d1
	movea.l	a2,a1
	adda.w	d1,a1
	moveq	#$2,d7
loc_FF44:
	move.w	d5,d0
	bsr.w	sub_8288
	moveq	#$2,d0
loc_FF4C:
	move.w	(a1)+,(a5)
	dbf	d0,loc_FF4C
	addi.w	#$80,d5
	dbf	d7,loc_FF44
	addi.w	#$FE86,d5
	dbf	d6,loc_FF34
	move.w	d2,d1
	addq.l	#$1,d1
	mulu.w	#$6,d1
	sub.w	d1,d5
	addi.w	#$180,d5
	adda.w	d4,a0
	dbf	d3,loc_FF32
	movem.l	(a7)+,d2-d7/a2
	rts

; ---------------------------------------------------------------------------
sub_FF7C:
	movem.l	d2-d5,-(a7)
	movem.w	($FFFFB3EC).w,d0-d1
	movem.w	($FFFFB3FC).w,d2-d3
	movem.w	($FFFFB400).w,d4-d5
	sub.w	d2,d4
	sub.w	d3,d5
	asr.w	#$1,d2
	asr.w	#$1,d3
	sub.w	d2,d0
	bpl.s	loc_FFA0
	moveq	#$0,d0
loc_FFA0:
	cmp.w	d4,d0
	blt.s	loc_FFA6
	move.w	d4,d0
loc_FFA6:
	sub.w	d3,d1
	bpl.s	loc_FFAC
	moveq	#$0,d1
loc_FFAC:
	cmp.w	d5,d1
	blt.s	loc_FFB2
	move.w	d5,d1
loc_FFB2:
	tst.b	($FFFFBA5D).w
	bne.s	loc_FFD4
	movem.w	d0-d1,($FFFFB414).l
	clr.b	($FFFFB4BF).w
	bsr.w	sub_100AC
	tst.w	d7
	beq.s	loc_10000
	bsr.w	sub_FEA8
	bra.w	loc_10000
loc_FFD4:
	sub.w	($FFFFB414).w,d0
	sub.w	($FFFFB416).w,d1
	movem.w	d0-d1,($FFFFB3F4).w
	tst.l	($FFFFB3F4).w
	beq.s	loc_FFEC
	bsr.w	sub_CD82
loc_FFEC:
	tst.b	d7
	bpl.s	loc_10000
	bsr.w	sub_CD4E
	tst.b	($FFFFB522).w
	beq.w	loc_10000
	jsr	($5AC2).w
loc_10000:
	movem.l	(a7)+,d2-d5
	rts

; ---------------------------------------------------------------------------
sub_10006:
	movem.l	d2-d3/d7,-(a7)
	move.w	($FFFFB3F4).w,d0
	add.w	d0,($FFFFB3F0).w
	move.w	($FFFFB3F6).w,d2
	add.w	d2,($FFFFB3F2).w
	move.l	($FFFFB3F0).w,($FFFFB3EC).w
	move.w	($FFFFB3FC).w,d2
	asr.w	#$1,d2
	move.w	($FFFFB3EC).w,d0
	cmp.w	d2,d0
	bge.s	loc_10030
	move.l	d2,d0
loc_10030:
	move.w	($FFFFB400).w,d1
	sub.l	d2,d1
	cmp.w	d1,d0
	blt.s	loc_1003C
	move.w	d1,d0
loc_1003C:
	move.w	d0,($FFFFB3EC).w
	move.w	($FFFFB3FE).w,d2
	asr.w	#$1,d2
	move.w	($FFFFB3EE).w,d0
	cmp.w	d2,d0
	bge.s	loc_10050
	move.l	d2,d0
loc_10050:
	move.w	($FFFFB402).w,d1
	sub.l	d2,d1
	cmp.w	d1,d0
	blt.s	loc_1005C
	move.w	d1,d0
loc_1005C:
	move.w	d0,($FFFFB3EE).w
	move.w	($FFFFB3F0).w,d0
	cmp.w	#$C,d0
	bge.s	loc_1006C
	moveq	#$C,d0
loc_1006C:
	move.w	($FFFFB400).w,d1
	subi.l	#$C,d1
	cmp.w	d1,d0
	ble.s	loc_1007C
	move.w	d1,d0
loc_1007C:
	move.w	d0,($FFFFB3F0).w
	move.w	($FFFFB3F2).w,d0
	cmp.w	#$C,d0
	bge.s	loc_1008C
	moveq	#$C,d0
loc_1008C:
	move.w	($FFFFB402).w,d1
	subi.l	#$C,d1
	cmp.w	d1,d0
	ble.s	loc_1009C
	move.w	d1,d0
loc_1009C:
	move.w	d0,($FFFFB3F2).w
	moveq	#$0,d7
	bsr.w	sub_FF7C
	movem.l	(a7)+,d2-d3/d7
	rts

; ---------------------------------------------------------------------------
sub_100AC:
	move.w	($FFFFB404).w,d0
	asl.w	#$3,d0
	add.w	($FFFFB414).w,d0
	sub.w	($FFFFB408).w,d0
	sub.w	($FFFFB3F8).w,d0
	neg.w	d0
	move.w	($FFFFB406).w,d1
	asl.w	#$3,d1
	add.w	($FFFFB416).w,d1
	sub.w	($FFFFB40A).w,d1
	sub.w	($FFFFB3FA).w,d1
	bra.w	loc_96A6

; ---------------------------------------------------------------------------
sub_100D6:
	movem.l	d2/a2,-(a7)
	move.b	(a3),d0
	beq.w	loc_1019E
	andi.b	#$C0,d0
	bne.w	loc_1019E
	move.b	$2(a3),d0
	cmp.b	#$8,d0
	bcc.s	loc_10110
	jsr	($6F14).w
	movea.l	a1,a0
	moveq	#$7,d0
	moveq	#$2,d1
	moveq	#$0,d2
	jsr	($4F20).w
	cmp.b	#$2,d0
	bcs.s	loc_10110
	move.b	$2(a3),d0
	bset	d0,($FFFFD4FD).w
loc_10110:
	bclr	#$1,$1(a3)
	move.b	$2(a3),d0
	jsr	($6F14).w
	movea.l	a1,a2
	move.b	$F(a3),d0
	asl.b	#$1,d0
	move.b	d0,$16(a3)
	bsr.w	sub_E7DC
	move.w	$6(a3),$18(a3)
	moveq	#$12,d0
	jsr	($664E).w
	move.b	($FFFFD50C).w,d0
	andi.b	#$1,d0
	move.b	$18(a3),d1
	add.b	d0,d1
	asr.b	#$1,d1
	move.b	d1,$18(a3)
	move.b	$19(a3),d1
	add.b	d0,d1
	asr.b	#$1,d1
	move.b	d1,$19(a3)
	movea.l	a3,a0
	movea.l	a2,a1
	jsr	($6EBC).w
	move.w	d0,d2
	moveq	#$A,d0
	jsr	($6C8C).w
	add.b	d0,d2
	move.b	($FFFF9DC1).w,d0
	btst	#$0,$1(a3)
	beq.s	loc_10182
	cmp.b	#$1,d0
	bne.s	loc_1018A
	subq.b	#$8,d2
	bra.s	loc_1018A
loc_10182:
	cmp.b	#$2,d0
	bne.s	loc_1018A
	subq.b	#$8,d2
loc_1018A:
	cmp.b	#$1,d2
	bgt.s	loc_10192
	moveq	#$2,d2
loc_10192:
	move.b	d2,$14(a3)
	jsr	($6D06).w
	move.b	d0,$15(a3)
loc_1019E:
	movem.l	(a7)+,d2/a2
	rts

; ---------------------------------------------------------------------------
sub_101A4:
	movem.l	d2-d3,-(a7)
	moveq	#$18,d0
	movem.w	($FFFFB3F0).w,d2-d3
	divu.w	d0,d2
	divu.w	d0,d3
	bsr.w	sub_1432E
	tst.b	d1
	bmi.s	loc_101FA
	cmp.b	#$8,d1
	bcc.s	loc_101FA
	move.b	d1,$17(a3)
	move.b	d1,d0
	jsr	($6F02).w
	move.b	(a0),d0
	cmp.b	#$83,d0
	beq.s	loc_101EA
	cmp.b	#$84,d0
	bne.s	loc_101FA
	tst.b	$32(a2)
	beq.s	loc_101FA
	move.b	$2(a0),d0
	btst	d0,($FFFFD50A).w
	bne.s	loc_101FA
loc_101EA:
	move.b	#$1,($FFFFD505).w
	bsr.w	sub_1021E
	clr.b	($FFFFD505).w
	nop
loc_101FA:
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_10200:
	bsr.w	sub_F28A
	tst.b	d0
	beq.s	loc_1021C
	move.b	($FFFFCA22).w,$17(a3)
	move.b	#$2,($FFFFD505).w
	bsr.w	sub_1021E
	clr.b	($FFFFD505).w
loc_1021C:
	rts

; ---------------------------------------------------------------------------
sub_1021E:
	movem.l	d2-d7/a2-a3/a6,-(a7)
	moveq	#$0,d7
	moveq	#$0,d3
	moveq	#$0,d0
	move.b	($FFFFCA20).w,d0
	bsr.w	sub_15D8A
	lea	($FFFF6CB0).l,a6
	tst.b	(a6)
	bmi.w	loc_10280
loc_1023C:
	bsr.w	sub_1039E
	bne.s	loc_10280
	moveq	#$0,d0
	move.b	(a6)+,d0
	bmi.s	loc_10280
	tst.w	d7
	bne.s	loc_1025A
	move.w	d0,-(a7)
	bsr.w	sub_F132
	bsr.w	sub_F9A6
	move.w	(a7)+,d0
	moveq	#$1,d7
loc_1025A:
	lea	(dat_146E0).l,a0
	move.b	(a0,d0.w),d1
	ext.w	d1
	move.w	d1,($FFFFB3F4).w
	move.b	$B(a0,d0.w),d1
	ext.w	d1
	move.w	d1,($FFFFB3F6).w
	bsr.w	sub_F898
	bmi.w	loc_10398
	tst.b	d0
	bne.s	loc_1023C
loc_10280:
	bsr.w	sub_FA22
	tst.b	(a3)
	bmi.w	loc_10398
	bsr.w	sub_1039E
	beq.w	loc_10398
	clr.b	$14(a3)
	move.l	a0,d6
	bsr.w	sub_1343E
	tst.b	$32(a2)
	bne.s	loc_102D0
	moveq	#$A,d0
	moveq	#$2,d1
	moveq	#$0,d2
	movea.l	a2,a0
	jsr	($4F20).w
	cmp.b	#$2,d0
	bcc.s	loc_102D0
	move.w	#$8000,($FFFFD5AC).w
	lea	(a2),a0
	bsr.w	sub_11CA4
	moveq	#$70,d0
	bsr.w	sub_11C8E
	moveq	#$5E,d0
	bsr.w	sub_11C8E
	bra.w	loc_10390
loc_102D0:
	move.w	#$C000,($FFFFD5AC).w
	lea	(a2),a0
	bsr.w	sub_11CA4
	moveq	#$6E,d0
	bsr.w	sub_11C8E
	moveq	#$5E,d0
	bsr.w	sub_11C8E
	movea.l	d6,a0
	clr.b	$E(a0)
	move.b	#$84,(a0)
	move.b	$2(a0),d0
	btst	d0,($FFFFD50A).w
	bne.w	loc_10390
	moveq	#$1,d0
	moveq	#$2,d1
	moveq	#$0,d2
	movea.l	a2,a0
	jsr	($4F20).w
	subq.b	#$2,d0
	bmi.w	loc_10390
	asl.b	#$2,d0
	add.b	$32(a2),d0
	movea.l	d6,a0
	move.b	d0,$E(a0)
	move.b	$2(a0),d0
	jsr	($6F14).w
	move.b	$2E(a1),d0
	cmp.b	$E(a0),d0
	bcc.s	loc_10332
	move.b	d0,$E(a0)
loc_10332:
	moveq	#$8,d4
	movea.l	a0,a3
	lea	(dat_146E0).l,a2
loc_1033C:
	move.b	(a2,d4.w),d2
	move.b	$B(a2,d4.w),d3
	add.b	$12(a3),d2
	add.b	$13(a3),d3
	move.w	d2,d0
	move.w	d3,d1
	bsr.w	sub_143FE
	tst.b	d0
	bpl.s	loc_1038C
	move.b	d1,d0
	bsr.w	sub_144EA
	btst	#$5,d0
	bne.s	loc_1038C
	move.b	#$1,(a3)
	move.b	d2,$12(a3)
	move.b	d3,$13(a3)
	bsr.w	sub_AC9C
	bsr.w	sub_14254
	move.w	#$29,d0
	jsr	(sub_1B900).l
	move.b	$2(a3),d0
	bset	d0,($FFFFD50A).w
	bra.s	loc_10390
loc_1038C:
	dbf	d4,loc_1033C
loc_10390:
	jsr	($75F8).w
	jsr	($75F8).w
loc_10398:
	movem.l	(a7)+,d2-d7/a2-a3/a6
	rts

; ---------------------------------------------------------------------------
sub_1039E:
	move.b	$17(a3),d0
	jsr	($6F02).w
	move.b	$12(a0),d0
	move.b	$13(a0),d1
	sub.b	$12(a3),d0
	sub.b	$13(a3),d1
	addq.b	#$1,d0
	addq.b	#$1,d1
	cmp.b	#$2,d0
	bhi.s	loc_103CA
	cmp.b	#$2,d1
	bhi.s	loc_103CA
	moveq	#$1,d0
	rts
loc_103CA:
	moveq	#$0,d0
	rts

; ---------------------------------------------------------------------------
sub_103CE:
	jsr	($6C54).w
	tst.b	($FFFFD511).w
	beq.s	loc_103FE
	bsr.w	sub_116F8
	bsr.w	sub_105FC
	tst.b	d0
	beq.s	loc_103EA
	bsr.w	sub_10FAA
	bra.s	loc_103FE
loc_103EA:
	bsr.w	sub_1074A
	lea	($FFFFD51D).w,a0
	moveq	#$0,d0
	move.b	($FFFFCA20).w,d0
	move.b	($FFFFD513).w,(a0,d0.w)
loc_103FE:
	rts

; ---------------------------------------------------------------------------
sub_10400:
	link	a6,#-$4
	movem.l	d2-d7/a2-a3,-(a7)
	move.b	d0,($FFFFD513).w
	clr.b	($FFFFD511).w
	clr.w	($FFFFD518).w
	bsr.w	sub_105FC
	beq.s	loc_10454
	jsr	($6EEC).w
	lea	$AE(a2),a0
	move.b	$5(a0),d0
	andi.b	#$30,d0
	beq.s	loc_10436
	move.w	#$12B,($FFFFD518).w
	bra.w	loc_105F4
loc_10436:
	move.b	#$32,-$1(a6)
	st	($FFFFD513).w
	clr.b	-$3(a6)
	movem.w	($FFFFB3F0).w,d2-d3
	divu.w	#$18,d2
	divu.w	#$18,d3
	bra.s	loc_10484
loc_10454:
	move.b	($FFFFD513).w,d0
	bmi.w	loc_105F4
	jsr	($6EF0).w
	moveq	#$0,d2
	moveq	#$0,d3
	move.b	$12(a3),d2
	move.b	$13(a3),d3
	jsr	($6D1E).w
	moveq	#$B,d0
	jsr	($664E).w
	bsr.w	sub_10666
	move.b	d0,-$1(a6)
	move.b	$1(a3),-$3(a6)
loc_10484:
	jsr	($6EEC).w
	jsr	($6D1E).w
	moveq	#$A,d0
	jsr	($664E).w
	move.b	$3(a3),-$2(a6)
	move.b	-$3(a6),d0
	move.b	$1(a3),d1
	eor.b	d0,d1
	btst	#$0,d1
	bne.s	loc_104B2
	move.w	#$BC,($FFFFD518).w
	bra.w	loc_105F4
loc_104B2:
	bsr.w	sub_11638
	move.w	d0,d4
	moveq	#$0,d5
	tst.b	($FFFF97AE).w
	beq.s	loc_104CA
	move.b	($FFFFCA20).w,d0
	cmp.b	#$8,d0
	bcs.s	loc_104E6
loc_104CA:
	lea	$AE(a2),a0
	moveq	#$0,d7
	move.b	(a0),d0
	beq.s	loc_104E6
	move.b	$9(a0),d7
	ext.w	d0
	asl.w	#$3,d0
	lea	($779E).w,a1
	adda.w	d0,a1
	move.b	$1(a1),d5
loc_104E6:
	move.w	d4,d6
	moveq	#$0,d0
	moveq	#$0,d1
	move.b	$12(a3),d0
	move.b	$13(a3),d1
	bsr.w	sub_15B5A
	tst.b	d0
	bne.s	loc_1056A
	movem.l	d0-d1/a1-a3,-(a7)
	st	d2
	move.b	($FFFFD513).w,d0
	bmi.s	loc_1052E
	jsr	($6EF0).w
	move.b	$23(a2),d0
	cmp.b	#$2,d0
	bcs.s	loc_1052E
	moveq	#$0,d2
	moveq	#$0,d3
	move.b	$12(a3),d2
	move.b	$13(a3),d3
	cmp.b	#$2,d0
	beq.s	loc_1052C
	addq.w	#$1,d2
	bra.s	loc_1052E
loc_1052C:
	addq.w	#$1,d3
loc_1052E:
	movem.l	(a7)+,d0-d1/a1-a3
	tst.b	d2
	bmi.s	loc_1054C
	move.w	d6,d4
	moveq	#$0,d0
	moveq	#$0,d1
	move.b	$12(a3),d0
	move.b	$13(a3),d1
	bsr.w	sub_15B5A
	tst.b	d0
	bne.s	loc_1056A
loc_1054C:
	cmp.b	#$1,d6
	beq.s	loc_10560
	cmp.b	d6,d1
	bcc.s	loc_10560
	move.w	#$BA,($FFFFD518).w
	bra.w	loc_105F4
loc_10560:
	move.w	#$BB,($FFFFD518).w
	bra.w	loc_105F4
loc_1056A:
	move.b	d1,($FFFFD512).w
	tst.b	($FFFFD503).w
	beq.s	loc_1057E
	move.w	#$C,($FFFFD518).w
	subq.b	#$2,-$2(a6)
loc_1057E:
	move.w	d6,d0
	cmp.w	#$1,d0
	bls.s	loc_105D4
	asr.w	#$1,d0
	cmp.w	d0,d1
	bls.s	loc_105A0
	mulu.w	#$3,d6
	asr.w	#$2,d6
	cmp.w	d6,d1
	bhi.s	loc_1059C
	subq.b	#$2,-$2(a6)
	bra.s	loc_105A0
loc_1059C:
	subq.b	#$5,-$2(a6)
loc_105A0:
	cmp.b	#$3,d5
	bne.s	loc_105B4
	tst.b	($FFFFD502).w
	beq.s	loc_105D4
	move.w	#$BD,($FFFFD518).w
	bra.s	loc_105F4
loc_105B4:
	cmp.b	#$2,d5
	beq.s	loc_105C6
	cmp.b	#$5,d7
	bcs.s	loc_105D4
	cmp.b	#$C,d7
	bhi.s	loc_105D4
loc_105C6:
	tst.b	($FFFFD501).w
	beq.s	loc_105D4
	move.w	#$BE,($FFFFD518).w
	bra.s	loc_105F4
loc_105D4:
	move.b	-$2(a6),d0
	sub.b	-$1(a6),d0
	addi.b	#$14,d0
	beq.s	loc_105E4
	bpl.s	loc_105E6
loc_105E4:
	moveq	#$1,d0
loc_105E6:
	cmp.b	#$13,d0
	bls.s	loc_105EE
	moveq	#$13,d0
loc_105EE:
	ext.w	d0
	move.b	d0,($FFFFD511).w
loc_105F4:
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_105FC:
	tst.b	($FFFF97AE).w
	beq.s	loc_1060C
	move.b	$2(a3),d0
	cmp.b	#$8,d0
	bcs.s	loc_10624
loc_1060C:
	lea	$AE(a2),a0
	move.b	(a0),d0
	beq.s	loc_10624
	move.b	$9(a0),d0
	cmp.b	#$5,d0
	bcs.s	loc_10624
	cmp.b	#$C,d0
	bls.s	loc_10628
loc_10624:
	moveq	#$0,d0
	rts
loc_10628:
	moveq	#$1,d0
	rts

; ---------------------------------------------------------------------------
sub_1062C:
	movem.l	a2-a3,-(a7)
	tst.b	($FFFF97AE).w
	beq.s	loc_10640
	move.b	($FFFFCA20).w,d0
	cmp.b	#$8,d0
	bcs.s	loc_1065A
loc_10640:
	jsr	($6EEC).w
	lea	$AE(a2),a2
	move.b	(a2),d0
	beq.s	loc_1065A
	jsr	($6E70).w
	move.b	$1(a3),d0
	cmp.b	#$2,d0
	beq.s	loc_1065E
loc_1065A:
	moveq	#$0,d0
	bra.s	loc_10660
loc_1065E:
	moveq	#$1,d0
loc_10660:
	movem.l	(a7)+,a2-a3
	rts

; ---------------------------------------------------------------------------
sub_10666:
	movem.l	d2-d7/a2-a3,-(a7)
	jsr	($6EEC).w
	moveq	#$0,d2
	move.b	$12(a3),d2
	moveq	#$0,d3
	move.b	$13(a3),d3
	move.b	$1(a3),d7
	move.b	($FFFFD513).w,d0
	jsr	($6EF0).w
	moveq	#$0,d0
	move.b	$12(a3),d0
	moveq	#$0,d1
	move.b	$13(a3),d1
	move.b	$1(a3),d4
	eor.b	d4,d7
	bsr.w	sub_15D36
	move.b	d0,d4
	move.b	$1(a3),d0
	andi.b	#$6,d0
	bne.s	loc_106B6
	btst	#$0,d7
	beq.s	loc_106B6
	move.b	d4,$10(a3)
	bsr.w	sub_AD5A
loc_106B6:
	move.b	#$1,($FFFFD496).w
	sub.b	$10(a3),d4
	andi.w	#$7,d4
	cmp.w	#$2,d4
	bcs.w	loc_10740
	beq.w	loc_10732
	cmp.w	#$6,d4
	bhi.w	loc_10740
	beq.s	loc_10732
	move.w	#$129,($FFFFD518).w
	move.b	$5(a3),d5
	moveq	#$2,d6
	jsr	($6EEC).w
	cmpi.b	#$4,$18(a2)
	bne.s	loc_106FC
	subq.b	#$2,d5
	moveq	#$7,d6
	add.b	$19(a2),d6
	asr.b	#$2,d6
loc_106FC:
	move.b	($FFFFCA20).w,d0
	cmp.b	#$8,d0
	bcc.s	loc_1072E
	btst	d0,($FFFFD4FD).w
	beq.s	loc_1072E
	lea	$AE(a2),a0
	move.b	(a0),d0
	beq.s	loc_10724
	ext.w	d0
	asl.w	#$3,d0
	lea	($779E).w,a0
	adda.w	d0,a0
	tst.b	$1(a0)
	bne.s	loc_1072E
loc_10724:
	move.b	d6,($FFFFD496).w
	move.w	#$12A,($FFFFD518).w
loc_1072E:
	move.b	d5,d0
	bra.s	loc_10744
loc_10732:
	move.w	#$128,($FFFFD518).w
	move.b	$4(a3),d0
	subq.b	#$2,d0
	bra.s	loc_10744
loc_10740:
	move.b	$4(a3),d0
loc_10744:
	movem.l	(a7)+,d2-d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_1074A:
	movem.l	d2-d6/a3,-(a7)
	movem.w	($FFFFB3F0).w,d2-d3
	move.b	($FFFFD513).w,d0
	bmi.s	loc_10776
	jsr	($6F02).w
	movea.l	a0,a3
	move.b	(a3),d0
	beq.w	loc_107DA
	andi.b	#$C0,d0
	bne.w	loc_107DA
	bset	#$1,$1(a3)
	bra.s	loc_1077A
loc_10776:
	movea.w	#$0,a3
loc_1077A:
	move.b	#$3,($FFFFD50D).w
	moveq	#$0,d4
	moveq	#$0,d6
	bsr.w	sub_107E8
	moveq	#$1,d4
	bsr.w	sub_107E8
	moveq	#$1,d0
	bsr.w	sub_116AC
	moveq	#$5,d0
	bsr.w	sub_CAEA
	moveq	#$1,d0
	moveq	#$1,d1
	bsr.w	sub_E606
	move.b	($FFFFCA20).w,d2
	move.b	($FFFFD513).w,($FFFFCA20).w
	moveq	#$14,d0
	moveq	#$1,d1
	bsr.w	sub_E606
	move.b	d2,($FFFFCA20).w
	bsr.w	sub_CA7E
	bsr.w	sub_11638
	cmp.b	#$1,d0
	sls	d4
	move.w	d6,d0
	moveq	#$0,d1
	bsr.w	sub_108AA
	jsr	($6EEC).w
	clr.b	$14(a3)
	bsr.w	sub_AD5A
loc_107DA:
	lea	($FFFFB58A).w,a0
	bsr.w	sub_9784
	movem.l	(a7)+,d2-d6/a3
	rts

; ---------------------------------------------------------------------------
sub_107E8:
	movem.l	d7/a2-a3,-(a7)
	jsr	($6EEC).w
	move.b	($FFFFD50C).w,d7
	andi.w	#$1,d7
	eor.b	d4,d7
	add.b	$6(a3,d4.w),d7
	asr.w	#$1,d7
	bra.w	loc_108A0
loc_10804:
	clr.b	($FFFFD4FC).w
	jsr	($6EEC).w
	moveq	#$14,d0
	jsr	($6C8C).w
	cmp.b	($FFFFD511).w,d0
	bhi.w	loc_108A0
	moveq	#$2,d0
	add.w	d4,d0
	jsr	($664E).w
	move.b	$8(a3,d4.w),d0
	move.b	$A(a3,d4.w),d1
	jsr	($6CE4).w
	add.b	$C(a3,d4.w),d0
	bpl.s	loc_10836
	moveq	#$0,d0
loc_10836:
	ext.w	d0
	moveq	#$0,d1
	move.b	($FFFFD496).w,d1
	mulu.w	d1,d0
	move.b	d0,($FFFFD497).w
	moveq	#$4,d0
	jsr	($664E).w
	move.b	($FFFFD513).w,d0
	jsr	($6EF0).w
	moveq	#$5,d0
	jsr	($664E).w
	bsr.w	sub_1062C
	tst.b	d0
	beq.s	loc_1088A
	move.b	$2F(a2),d0
	btst	#$2,d0
	beq.s	loc_10876
	jsr	($6D06).w
	cmp.b	#$4B,d0
	bls.s	loc_10886
	bra.s	loc_1088A
loc_10876:
	btst	#$1,d0
	beq.s	loc_1088A
	jsr	($6D06).w
	cmp.b	#$32,d0
	bhi.s	loc_1088A
loc_10886:
	st	($FFFFD4FC).w
loc_1088A:
	lea	($FFFFD48E).w,a0
	tst.b	($FFFFD4FC).w
	beq.s	loc_10898
	st	($FFFFD497).w
loc_10898:
	move.b	($FFFFD497).w,(a0,d6.w)
	addq.w	#$1,d6
loc_108A0:
	dbf	d7,loc_10804
	movem.l	(a7)+,d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_108AA:
	link	a6,#-$108
	movem.l	d2-d7/a2-a3,-(a7)
	clr.b	-$40(a6)
	move.b	d1,-$46(a6)
	move.b	d4,-$48(a6)
	move.w	d0,d6
	move.w	d6,-$1C(a6)
	bne.s	loc_108C8
	moveq	#$1,d6
loc_108C8:
	cmp.w	#$C,d6
	bls.s	loc_108F0
	lea	(dat_108DA).l,a0
	jsr	(sub_132A6).l
dat_108DA:
	binclude	"data/0108DA.bin"
loc_108F0:
	move.w	#$80,d0
	add.w	($FFFFB3FC).w,d0
	move.w	d0,-$2A(a6)
	move.w	#$80,d0
	add.w	($FFFFB3FE).w,d0
	move.w	d0,-$2C(a6)
	clr.b	-$D(a6)
	move.b	-$46(a6),-$E(a6)
	move.l	a3,-$C(a6)
	beq.s	loc_1092A
	move.b	$2(a3),d0
	jsr	($6F14).w
	lea	-$4(a6),a0
	bsr.w	sub_10DFC
	bra.s	loc_10938
loc_1092A:
	mulu.w	#$18,d2
	mulu.w	#$18,d3
	movem.w	d2-d3,-$4(a6)
loc_10938:
	bsr.w	sub_10EB4
	jsr	($6EEC).w
	lea	-$8(a6),a0
	bsr.w	sub_10DFC
	movem.w	($FFFFB414).w,d2-d3
loc_1094E:
	moveq	#-$18,d4
	add.w	($FFFFB3FC).w,d4
	moveq	#-$18,d5
	add.w	($FFFFB3FE).w,d5
	add.w	d2,d4
	add.w	d3,d5
	cmp.w	d2,d0
	blt.s	loc_10988
	cmp.w	d4,d0
	bge.s	loc_10988
	cmp.w	d3,d1
	blt.s	loc_10988
	cmp.w	d5,d1
	bge.s	loc_10988
	movem.w	-$4(a6),d0-d1
	cmp.w	d2,d0
	blt.s	loc_10988
	cmp.w	d4,d0
	bge.s	loc_10988
	cmp.w	d3,d1
	blt.s	loc_10988
	cmp.w	d5,d1
	bge.s	loc_10988
	bra.w	loc_109F0
loc_10988:
	tst.b	-$D(a6)
	bne.s	loc_109E6
	st	-$D(a6)
	movem.w	-$4(a6),d0-d1
	add.w	-$8(a6),d0
	add.w	-$6(a6),d1
	sub.w	($FFFFB3FC).w,d0
	sub.w	($FFFFB3FE).w,d1
	moveq	#$18,d7
	add.w	d7,d0
	add.w	d7,d1
	asr.w	#$1,d0
	asr.w	#$1,d1
	divu.w	d7,d0
	divu.w	d7,d1
	muls.w	d7,d0
	muls.w	d7,d1
	move.w	d0,d2
	move.w	d1,d3
	asl.w	#$1,d0
	add.w	($FFFFB3FC).w,d0
	asr.w	#$1,d0
	bpl.s	loc_109CA
	moveq	#$0,d0
loc_109CA:
	asl.w	#$1,d1
	add.w	($FFFFB3FE).w,d1
	asr.w	#$1,d1
	bpl.s	loc_109D6
	moveq	#$0,d1
loc_109D6:
	movem.w	d0-d1,-$12(a6)
	movem.w	-$8(a6),d0-d1
	bra.w	loc_1094E
loc_109E6:
	move.l	-$8(a6),-$12(a6)
	st	-$E(a6)
loc_109F0:
	tst.b	-$D(a6)
	beq.s	loc_10A0E
	move.l	-$12(a6),($FFFFB3EC).w
	addi.w	#$C,($FFFFB3EC).w
	addi.w	#$C,($FFFFB3EE).w
	moveq	#$0,d7
	bsr.w	sub_FF7C
loc_10A0E:
	movem.w	-$8(a6),d0-d4
	bsr.w	sub_15D36
	move.b	d0,-$18(a6)
	tst.b	($FFFFD87D).w
	beq.s	loc_10A5A
	move.b	#$3,-$1A(a6)
	move.b	#$4,-$19(a6)
	clr.b	-$47(a6)
	move.b	-$18(a6),d0
	beq.s	loc_10A44
	cmp.b	#$4,d0
	bne.s	loc_10A42
	moveq	#$C,d0
	bra.s	loc_10A44
loc_10A42:
	moveq	#$6,d0
loc_10A44:
	move.b	d0,($FFFFD51A).w
	st	($FFFFD51B).w
	moveq	#$3E,d0
	lea	($FFFFD51A).w,a3
	bsr.w	sub_99BC
	bra.w	loc_10AD0
loc_10A5A:
	move.b	($FFFFCA20).w,d0
	jsr	($6F02).w
	move.b	$2(a0),d0
	jsr	($6F14).w
	lea	$AE(a1),a0
	tst.b	($FFFF97AE).w
	beq.s	loc_10A7A
	cmp.b	#$8,d0
	bcs.s	loc_10A8C
loc_10A7A:
	move.b	(a0),d0
	beq.s	loc_10A8C
	ext.w	d0
	lea	(dat_10F5A).l,a0
	move.b	(a0,d0.w),d0
	bne.s	loc_10A8E
loc_10A8C:
	moveq	#$60,d0
loc_10A8E:
	lea	(dat_10F3A).l,a0
loc_10A94:
	cmp.b	(a0)+,d0
	beq.s	loc_10A9C
	addq.l	#$3,a0
	bra.s	loc_10A94
loc_10A9C:
	move.b	(a0)+,-$1A(a6)
	move.b	(a0)+,-$19(a6)
	move.b	(a0)+,-$47(a6)
	cmp.w	#$67,d0
	bcc.s	loc_10AC0
	lea	(dat_10F20).l,a0
	moveq	#$0,d1
	move.b	-$18(a6),d1
	move.b	(a0,d1.w),d1
	add.b	d1,d0
loc_10AC0:
	asl.w	#$2,d0
	lea	(dat_F14F2).l,a0
	movea.l	(a0,d0.w),a0
	bsr.w	sub_9DD4
loc_10AD0:
	btst	#$4,($FFFF97DC).w
	beq.s	loc_10ADC
	clr.b	-$1A(a6)
loc_10ADC:
	move.l	a0,-$16(a6)
	move.l	d6,d0
	moveq	#$9,d1
	bsr.w	sub_92AA
	movea.l	a0,a2
	moveq	#$1,d0
	move.w	(a2),d1
	lea	(dat_10F28).l,a3
	movea.l	-$16(a6),a0
	bsr.w	sub_B58A
	lea	-$16(a6),a0
	bsr.w	sub_9784
	move.w	$2(a2),d5
	move.w	d5,d0
	asl.w	#$3,d5
	addi.w	#$EC00,d5
	move.w	d5,-$44(a6)
	addi.w	#$A00,d0
	move.w	d0,-$30(a6)
	movem.w	-$4(a6),d0-d1
	sub.w	-$8(a6),d0
	smi	-$21(a6)
	bpl.s	loc_10B2E
	neg.w	d0
loc_10B2E:
	sub.w	-$6(a6),d1
	smi	-$22(a6)
	bpl.s	loc_10B3A
	neg.w	d1
loc_10B3A:
	cmp.w	d1,d0
	scc	-$17(a6)
	bcc.s	loc_10B44
	exg	d0,d1
loc_10B44:
	ext.l	d0
	moveq	#$0,d2
	move.b	-$19(a6),d2
	divu.w	d2,d0
	ext.l	d1
	asl.l	#$8,d1
	tst.w	d0
	bne.s	loc_10B5A
	moveq	#$0,d1
	bra.s	loc_10B60
loc_10B5A:
	divu.w	d0,d1
	ext.l	d1
	asl.l	#$8,d1
loc_10B60:
	move.w	d0,-$24(a6)
	moveq	#$0,d0
	move.b	-$19(a6),d0
	swap	d0
	tst.b	-$17(a6)
	bne.s	loc_10B74
	exg	d0,d1
loc_10B74:
	tst.b	-$21(a6)
	bpl.s	loc_10B7C
	neg.l	d0
loc_10B7C:
	tst.b	-$22(a6)
	bpl.s	loc_10B84
	neg.l	d1
loc_10B84:
	movem.l	d0-d1,-$3A(a6)
	clr.l	-$3E(a6)
	tst.b	-$1A(a6)
	beq.s	loc_10BE0
	movem.w	-$8(a6),d0-d1
	sub.w	-$4(a6),d0
	sub.w	-$2(a6),d1
	muls.w	d0,d0
	muls.w	d1,d1
	add.w	d1,d0
	jsr	($6BD6).w
	ext.l	d0
	moveq	#$0,d1
	move.b	-$1A(a6),d1
	divu.w	d1,d0
	cmp.w	#$30,d0
	bls.s	loc_10BBE
	moveq	#$30,d0
loc_10BBE:
	asl.w	#$8,d0
	ext.l	d0
	move.w	-$24(a6),d1
	beq.s	loc_10BE0
	divu.w	d1,d0
	ext.l	d0
	asl.l	#$8,d0
	asl.l	#$2,d0
	sub.l	d0,-$36(a6)
	asr.l	#$4,d0
	divu.w	d1,d0
	ext.l	d0
	asl.l	#$5,d0
	move.l	d0,-$3E(a6)
loc_10BE0:
	lea	-$108(a6),a0
	move.w	d6,d3
	movem.w	-$8(a6),d0-d1
	addi.w	#$80,d0
	addi.w	#$80,d1
	bra.s	loc_10C06
loc_10BF6:
	move.w	d0,(a0)+
	clr.w	(a0)+
	move.w	d1,(a0)+
	clr.w	(a0)+
	move.l	-$3A(a6),(a0)+
	move.l	-$36(a6),(a0)+
loc_10C06:
	dbf	d3,loc_10BF6
	move.w	d6,d3
	subq.w	#$1,d3
	mulu.w	#$9,d3
	add.w	-$24(a6),d3
	move.w	d3,d0
	asr.w	#$1,d0
	move.w	d0,-$32(a6)
	moveq	#$0,d1
	move.b	-$18(a6),d1
	asl.w	#$1,d1
	lea	(dat_10F2A).l,a0
	move.w	(a0,d1.w),d0
	add.w	(a2),d0
	move.b	-$47(a6),d1
	asl.w	#$8,d1
	or.w	d1,d0
	move.w	d0,-$28(a6)
loc_10C3E:
	bsr.w	sub_DEE6
	move.w	-$44(a6),d5
	move.w	-$30(a6),-$2E(a6)
	move.w	d6,d4
	move.w	d3,d2
	clr.w	-$42(a6)
	lea	-$108(a6),a0
	bra.w	loc_10D7C
loc_10C5C:
	move.w	d4,d0
	bne.s	loc_10C6E
	move.w	$4(a2),d0
	ori.w	#$A00,d0
	move.w	d0,-$2E(a6)
	bra.s	loc_10C72
loc_10C6E:
	addq.w	#$1,-$2E(a6)
loc_10C72:
	tst.w	d2
	bne.s	loc_10C7A
	bsr.w	sub_10E3E
loc_10C7A:
	move.w	d5,d0
	jsr	(sub_8288).l
	tst.b	-$48(a6)
	bne.w	loc_10D5C
	tst.w	d2
	ble.w	loc_10D5C
	cmp.w	-$24(a6),d2
	bgt.w	loc_10D5C
	move.l	-$3E(a6),d0
	add.l	d0,$C(a0)
	cmp.w	#$9,d2
	bhi.w	loc_10D1A
	tst.w	-$1C(a6)
	beq.w	loc_10D1A
	lea	($FFFFD48E).w,a1
	move.w	-$42(a6),d0
	move.b	(a1,d0.w),d0
	cmp.b	#$FF,d0
	bne.s	loc_10D1A
	move.w	$C(a0),-$20(a6)
	move.w	$8(a0),-$1E(a6)
	neg.w	-$1E(a6)
	btst	#$0,-$41(a6)
	beq.s	loc_10CE2
	neg.w	-$20(a6)
	neg.w	-$1E(a6)
loc_10CE2:
	move.w	-$20(a6),d0
	moveq	#$9,d1
	sub.w	d2,d1
	muls.w	d1,d0
	move.w	$8(a0),d1
	muls.w	d2,d1
	add.w	d1,d0
	ext.l	d0
	divs.w	#$9,d0
	add.w	d0,(a0)
	move.w	-$1E(a6),d0
	moveq	#$9,d1
	sub.w	d2,d1
	muls.w	d1,d0
	move.w	$C(a0),d1
	muls.w	d2,d1
	add.w	d1,d0
	ext.l	d0
	divs.w	#$9,d0
	add.w	d0,$4(a0)
	bra.s	loc_10D28
loc_10D1A:
	move.l	$8(a0),d0
	add.l	d0,(a0)
	move.l	$C(a0),d0
	add.l	d0,$4(a0)
loc_10D28:
	move.w	(a0),d0
	sub.w	($FFFFB414).w,d0
	cmp.w	#$68,d0
	blt.s	loc_10D5C
	cmp.w	-$2A(a6),d0
	bge.s	loc_10D5C
	move.w	$4(a0),d1
	sub.w	($FFFFB416).w,d1
	cmp.w	#$68,d1
	blt.s	loc_10D5C
	cmp.w	-$2C(a6),d1
	bge.s	loc_10D5C
	move.w	d1,(a5)
	move.w	-$2E(a6),(a5)
	move.w	-$28(a6),(a5)
	move.w	d0,(a5)
	bra.s	loc_10D6A
loc_10D5C:
	moveq	#$1,d0
	move.w	d0,(a5)
	move.w	-$2E(a6),(a5)
	move.w	-$28(a6),(a5)
	move.w	d0,(a5)
loc_10D6A:
	addq.w	#$1,-$42(a6)
	addq.w	#$8,d5
	adda.l	#$10,a0
	subi.l	#$9,d2
loc_10D7C:
	dbf	d4,loc_10C5C
	move.l	#$6C000003,(a4)
	move.w	#$1,(a5)
	move.w	$2(a2),d0
	move.w	d0,(a5)
	cmp.w	-$32(a6),d3
	bne.s	loc_10DAC
	tst.b	-$E(a6)
	beq.s	loc_10DAC
	clr.b	-$E(a6)
	move.l	-$4(a6),($FFFFB3EC).w
	moveq	#$0,d7
	bsr.w	sub_FF7C
loc_10DAC:
	dbf	d3,loc_10C3E
	move.b	($FFFFD513).w,d0
	bmi.w	loc_10DEA
	jsr	($6F02).w
	tst.b	(a0)
	bpl.s	loc_10DD2
	move.l	a2,-(a7)
	movea.l	a0,a2
	bsr.w	sub_142A8
	movea.l	(a7)+,a2
	moveq	#$1,d2
	bsr.w	sub_11B30
	bra.s	loc_10DEA
loc_10DD2:
	tst.b	-$40(a6)
	beq.s	loc_10DEA
	moveq	#$F,d0
	jsr	($75FA).w
	moveq	#-$1,d0
	bsr.w	sub_CAEA
	moveq	#$F,d0
	jsr	($75FA).w
loc_10DEA:
	movea.l	a2,a0
	bsr.w	sub_9240
	clr.b	($FFFFD87D).w
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_10DFC:
	move.w	d2,-(a7)
	moveq	#$0,d0
	moveq	#$0,d1
	move.b	$12(a3),d0
	move.b	$13(a3),d1
	mulu.w	#$18,d0
	mulu.w	#$18,d1
	move.b	$23(a1),d2
	cmp.b	#$3,d2
	bne.s	loc_10E2E
	moveq	#$0,d2
	move.b	$10(a3),d2
	lea	(dat_10E36).l,a1
	move.b	(a1,d2.w),d2
	add.w	d2,d0
loc_10E2E:
	movem.w	d0-d1,(a0)
	move.w	(a7)+,d2
	rts
dat_10E36:
	dc.b	$0C,$18,$18,$18,$0C,$00,$00,$00

; ---------------------------------------------------------------------------
sub_10E3E:
	movem.l	d2/a0/a2-a3,-(a7)
	tst.w	-$1C(a6)
	beq.s	loc_10EAE
	tst.b	-$48(a6)
	bne.s	loc_10E58
	move.w	#$1,d0
	jsr	(sub_1B900).l
loc_10E58:
	lea	($FFFFD48E).w,a1
	move.w	-$42(a6),d2
	move.b	(a1,d2.w),d2
	ble.s	loc_10EAE
	move.l	-$C(a6),d1
	beq.s	loc_10EAE
	movea.l	d1,a3
	move.b	(a3),d0
	beq.s	loc_10EAE
	andi.b	#$C0,d0
	bne.s	loc_10EAE
	move.b	$2(a3),d0
	jsr	($6F14).w
	movea.l	a1,a2
	move.b	d2,d0
	jsr	($760A).w
	move.b	($FFFFCA20).w,d2
	move.b	($FFFFD513).w,($FFFFCA20).w
	moveq	#$14,d0
	moveq	#$1,d1
	bsr.w	sub_E606
	move.b	d2,($FFFFCA20).w
	tst.b	-$40(a6)
	bne.s	loc_10EAE
	st	-$40(a6)
	moveq	#$0,d0
	bsr.w	sub_CAEA
loc_10EAE:
	movem.l	(a7)+,d2/a0/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_10EB4:
	movem.l	a0-a3,-(a7)
	tst.b	-$48(a6)
	beq.s	loc_10ECA
	moveq	#$2,d0
	tst.w	-$1C(a6)
	bne.s	loc_10EFC
	moveq	#$3,d0
	bra.s	loc_10EFC
loc_10ECA:
	jsr	($6EEC).w
	moveq	#$5,d0
	moveq	#$0,d1
	move.b	$AE(a2),d1
	beq.s	loc_10EFC
	cmp.b	#$12,d1
	bhi.s	loc_10EEA
	lea	(dat_10F0C).l,a0
	move.b	(a0,d1.w),d0
	bra.s	loc_10EFC
loc_10EEA:
	bsr.w	sub_11638
	cmp.b	#$C,d0
	beq.s	loc_10EF8
	moveq	#$0,d0
	bra.s	loc_10EFC
loc_10EF8:
	move.w	#$D,d0
loc_10EFC:
	tst.b	d0
	beq.s	loc_10F06
	jsr	(sub_1B900).l
loc_10F06:
	movem.l	(a7)+,a0-a3
	rts
dat_10F0C:
	binclude	"data/010F0C.bin"
dat_10F20:
	dc.b	$00,$01,$02,$01,$00,$01,$02,$01
dat_10F28:
	dc.b	$00,$FF
dat_10F2A:
	binclude	"data/010F2A.bin"
dat_10F3A:
	binclude	"data/010F3A.bin"
dat_10F5A:
	binclude	"data/010F5A.bin"
dat_10F69:
	binclude	"data/010F69.bin"

; ---------------------------------------------------------------------------
sub_10FAA:
	link	a6,#-$2A
	movem.l	d2-d7/a2-a3,-(a7)
	clr.b	-$27(a6)
	lea	$AE(a2),a0
	move.l	a0,-$16(a6)
	move.b	$9(a0),-$1C(a6)
	move.b	(a0),d0
	ext.w	d0
	asl.w	#$3,d0
	lea	($779E).w,a1
	adda.w	d0,a1
	move.l	a1,-$1A(a6)
	move.b	$3(a1),d0
	move.b	$4(a1),d1
	move.b	$5(a1),d2
	add.b	$4(a0),d2
	jsr	($6CE4).w
	add.b	d2,d0
	move.b	d0,-$21(a6)
	st	-$1B(a6)
	lea	(dat_10F69).l,a0
	moveq	#$0,d0
	move.b	-$1C(a6),d0
	mulu.w	#$5,d0
	adda.w	d0,a0
	move.l	a0,-$20(a6)
	move.b	$4(a0),-$12(a6)
	move.b	$1(a0),d0
	ext.w	d0
	move.w	d0,-$6(a6)
	move.b	-$1C(a6),d0
	cmp.b	#$C,d0
	bne.s	loc_11028
	clr.b	-$21(a6)
	bra.s	loc_1102E
loc_11028:
	cmp.b	#$5,d0
	bne.s	loc_1103A
loc_1102E:
	moveq	#$4,d0
	jsr	($6C8C).w
	addq.b	#$1,d0
	move.b	d0,-$1B(a6)
loc_1103A:
	movea.l	-$1A(a6),a0
	move.b	$1(a0),d0
	cmp.b	#$7,d0
	beq.s	loc_1104E
	cmp.b	#$9,d0
	bne.s	loc_11058
loc_1104E:
	movea.l	-$16(a6),a0
	ori.b	#$20,$5(a0)
loc_11058:
	move.b	$12(a3),d0
	move.b	$13(a3),d1
	ext.w	d0
	ext.w	d1
	movem.w	d0-d1,-$26(a6)
	movem.w	($FFFFB3F0).w,d0-d1
	divu.w	#$18,d0
	divu.w	#$18,d1
	movem.w	d0-d1,-$4(a6)
	moveq	#$14,d0
	jsr	($6C8C).w
	cmp.b	($FFFFD511).w,d0
	bls.s	loc_1108E
	bsr.w	sub_1137E
loc_1108E:
	move.w	-$26(a6),d0
	move.w	-$24(a6),d1
	move.w	-$4(a6),d2
	move.w	-$2(a6),d3
	moveq	#$64,d4
	st	($FFFFD504).w
	bsr.w	sub_15B5A
	tst.b	d0
	bne.s	loc_110B2
	movem.w	d2-d3,-$4(a6)
loc_110B2:
	movea.w	#$0,a3
	moveq	#$0,d0
	move.w	-$4(a6),d2
	move.w	-$2(a6),d3
	move.w	-$6(a6),d1
	subq.w	#$1,d1
	moveq	#$0,d4
	bsr.w	sub_108AA
	clr.l	-$A(a6)
	moveq	#-$1,d0
	move.l	d0,-$E(a6)
	st	-$10(a6)
	st	-$11(a6)
	move.b	-$1C(a6),d0
	cmp.b	#$6,d0
	beq.s	loc_110F6
	cmp.b	#$A,d0
	beq.s	loc_110F6
	cmp.b	#$B,d0
	bne.w	loc_1113E
loc_110F6:
	move.w	#$7,d7
loc_110FA:
	move.w	d7,d0
	jsr	($6EF0).w
	move.b	(a3),d0
	beq.s	loc_11132
	andi.b	#$C0,d0
	bne.s	loc_11132
	moveq	#$3,d0
	jsr	($69DA).w
	tst.b	d0
	beq.s	loc_11132
	move.l	a3,-$A(a6)
	move.b	d7,-$22(a6)
	move.b	$12(a3),d0
	ext.w	d0
	move.w	d0,-$E(a6)
	move.b	$13(a3),d0
	ext.w	d0
	move.w	d0,-$C(a6)
	bra.s	loc_11136
loc_11132:
	dbf	d7,loc_110FA
loc_11136:
	bsr.w	sub_113EC
	st	-$27(a6)
loc_1113E:
	move.w	-$4(a6),d0
	move.w	-$2(a6),d1
	move.w	-$6(a6),d2
	bsr.w	sub_15C54
	tst.l	-$A(a6)
	beq.s	loc_111C0
	moveq	#$0,d7
	move.b	($FFFFD506).w,d7
	lea	($FFFFCA22).w,a0
	bra.s	loc_111BC
loc_11160:
	move.b	(a0),d0
	cmp.b	-$22(a6),d0
	bne.s	loc_111BA
	st	(a0)
	tst.b	-$10(a6)
	bmi.s	loc_111C0
	jsr	($6EF0).w
	bsr.w	sub_F9A6
	move.b	($FFFFCA20).w,d5
	move.b	-$22(a6),($FFFFCA20).w
	movea.w	#$0,a3
	moveq	#$0,d0
	moveq	#$0,d2
	moveq	#$0,d3
	move.b	-$10(a6),d2
	move.b	-$11(a6),d3
	st	($FFFFD87D).w
	moveq	#$0,d1
	moveq	#$0,d4
	bsr.w	sub_108AA
	move.b	d5,($FFFFCA20).w
	movea.l	-$A(a6),a3
	move.b	-$10(a6),$12(a3)
	move.b	-$11(a6),$13(a3)
	bsr.w	sub_FA22
	bra.s	loc_111C0
loc_111BA:
	addq.l	#$3,a0
loc_111BC:
	dbf	d7,loc_11160
loc_111C0:
	bsr.w	sub_114D6
	tst.b	-$27(a6)
	beq.s	loc_111D0
	moveq	#$0,d7
	bsr.w	sub_FEA8
loc_111D0:
	movea.l	-$20(a6),a0
	tst.b	$2(a0)
	beq.w	loc_11292
	moveq	#$E,d7
	lea	($FFFF78DE).l,a1
	lea	($FFFF78CE).l,a2
loc_111EA:
	move.b	$E(a1),d0
	cmp.b	$E(a2),d0
	bcc.s	loc_111F6
	movea.l	a1,a2
loc_111F6:
	adda.w	#$10,a1
	dbf	d7,loc_111EA
	tst.b	$E(a2)
	beq.s	loc_11208
	bsr.w	sub_1150E
loc_11208:
	move.l	-$4(a6),(a2)
	subq.w	#$1,(a2)
	subq.w	#$1,$2(a2)
	move.b	-$1C(a6),d0
	addi.b	#$F8,d0
	move.b	d0,$F(a2)
	lea	$4(a2),a3
	moveq	#$2,d7
loc_11224:
	moveq	#$2,d6
loc_11226:
	move.w	(a2),d2
	move.w	$2(a2),d3
	add.w	d6,d2
	add.w	d7,d3
	cmp.w	#$15,d2
	bcc.s	loc_11264
	cmp.w	#$15,d3
	bcc.s	loc_11264
	move.w	d2,d0
	move.w	d3,d1
	bsr.w	sub_145DE
	move.b	d0,d4
	bsr.w	sub_144EA
	andi.b	#$20,d0
	bne.s	loc_11264
	move.b	d4,(a3)+
	mulu.w	#$15,d3
	add.w	d2,d3
	lea	($FFFFCACA).w,a0
	move.b	$F(a2),(a0,d3.w)
	bra.s	loc_11266
loc_11264:
	st	(a3)+
loc_11266:
	dbf	d6,loc_11226
	dbf	d7,loc_11224
	btst	#$4,($FFFF97DC).w
	bne.s	loc_1127E
	move.b	#$5,$E(a2)
	bra.s	loc_11284
loc_1127E:
	move.b	#$2,$E(a2)
loc_11284:
	bsr.w	sub_14254
	moveq	#-$1,d7
	bsr.w	sub_FEA8
	jsr	($75F8).w
loc_11292:
	moveq	#$0,d7
	move.b	($FFFFD506).w,d7
	lea	($FFFFCA22).w,a2
	bra.w	loc_11338
loc_112A0:
	move.l	a2,-(a7)
	move.b	(a2),d0
	bmi.w	loc_11334
	move.b	d0,($FFFFD513).w
	clr.b	-$2A(a6)
	jsr	($6EF0).w
	move.b	-$1C(a6),d0
	cmp.b	#$5,d0
	bne.s	loc_112CC
	btst	#$0,$2F(a2)
	beq.s	loc_112CC
	st	-$28(a6)
	bra.s	loc_112D6
loc_112CC:
	moveq	#$0,d0
	jsr	($6990).w
	move.b	d0,-$28(a6)
loc_112D6:
	movea.l	-$20(a6),a0
	move.b	-$21(a6),d0
	beq.s	loc_112F0
	move.b	-$28(a6),d1
	move.b	$3(a0),d2
	bsr.w	sub_115CE
	st	-$2A(a6)
loc_112F0:
	move.b	(a3),d0
	beq.s	loc_11334
	andi.b	#$C0,d0
	bne.s	loc_11334
	movea.l	-$20(a6),a0
	move.b	(a0),d0
	beq.s	loc_11334
	move.b	-$1B(a6),d1
	move.b	-$28(a6),d2
	move.b	$3(a0),d3
	jsr	($6A34).w
	tst.b	-$28(a6)
	bne.s	loc_11334
	tst.b	-$2A(a6)
	bne.s	loc_11334
	bsr.w	sub_CA7E
	moveq	#$0,d0
	bsr.w	sub_CAEA
	moveq	#$F,d0
	jsr	($75FA).w
	moveq	#-$1,d0
	bsr.w	sub_CAEA
loc_11334:
	movea.l	(a7)+,a2
	addq.l	#$3,a2
loc_11338:
	dbf	d7,loc_112A0
	lea	($FFFFB58A).w,a0
	bsr.w	sub_9784
	jsr	($6EEC).w
	clr.b	$14(a3)
	movea.l	-$16(a6),a0
	move.b	$8(a0),d2
	beq.s	loc_11376
	move.b	($FFFFCA20).w,d1
	cmp.b	#$8,d1
	bcs.s	loc_1136C
	move.b	$3F(a2),d0
	jsr	($6C94).w
	tst.b	d0
	bne.s	loc_11376
loc_1136C:
	subq.b	#$1,d2
	bne.s	loc_11372
	clr.b	(a0)
loc_11372:
	move.b	d2,$8(a0)
loc_11376:
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_1137E:
	movem.l	d2-d4/d7,-(a7)
	moveq	#$3,d7
loc_11384:
	move.w	-$4(a6),d0
	sub.w	-$26(a6),d0
	bsr.w	sub_113D8
	add.w	-$26(a6),d0
	move.w	d0,d2
	move.w	-$2(a6),d0
	sub.w	-$24(a6),d0
	bsr.w	sub_113D8
	add.w	-$24(a6),d0
	move.w	d0,d3
	cmp.w	#$15,d2
	bcc.s	loc_113CE
	cmp.w	#$15,d3
	bcc.s	loc_113CE
	move.w	-$26(a6),d0
	move.w	-$24(a6),d1
	moveq	#$4,d4
	bsr.w	sub_15B5A
	tst.b	d0
	beq.s	loc_113CE
	movem.w	d2-d3,-$4(a6)
	bra.s	loc_113D2
loc_113CE:
	dbf	d7,loc_11384
loc_113D2:
	movem.l	(a7)+,d2-d4/d7
	rts

; ---------------------------------------------------------------------------
sub_113D8:
	move.l	d7,-(a7)
	move.w	d0,d7
	moveq	#$4,d0
	jsr	($6C8C).w
	asr.w	#$1,d0
	subq.w	#$1,d0
	add.w	d7,d0
	move.l	(a7)+,d7
	rts

; ---------------------------------------------------------------------------
sub_113EC:
	link	a3,#-$6
	movem.l	d2-d7,-(a7)
	st	-$F(a6)
	moveq	#$6,d6
loc_113FA:
	moveq	#$6,d7
loc_113FC:
	move.w	-$4(a6),d4
	move.w	-$2(a6),d5
	add.w	d6,d4
	add.w	d7,d5
	subq.w	#$3,d4
	subq.w	#$3,d5
	cmp.w	#$15,d4
	bcc.w	loc_114C2
	cmp.w	#$15,d5
	bcc.w	loc_114C2
	movem.w	d4-d5,-$6(a3)
	move.w	-$4(a6),d0
	move.w	-$2(a6),d1
	move.w	d4,d2
	move.w	d5,d3
	move.w	-$6(a6),d4
	bsr.w	sub_15B5A
	tst.b	d0
	beq.s	loc_11474
	move.w	-$6(a3),d0
	move.w	-$4(a3),d1
	bsr.w	sub_145DE
	move.b	d0,-$1(a3)
	bsr.w	sub_144FE
	cmp.b	-$1(a3),d2
	beq.s	loc_11460
	move.w	-$6(a3),d0
	move.w	-$4(a3),d1
	bsr.w	sub_14670
loc_11460:
	move.w	d3,d2
	bmi.s	loc_11472
	move.w	-$6(a3),d0
	move.w	-$4(a3),d1
	addq.w	#$1,d1
	bsr.w	sub_14670
loc_11472:
	bra.s	loc_114C2
loc_11474:
	tst.l	-$A(a6)
	beq.s	loc_114C2
	move.w	-$6(a3),d0
	move.w	-$4(a3),d1
	bsr.w	sub_143FE
	tst.b	d0
	bpl.s	loc_114C2
	move.b	d1,d0
	bsr.w	sub_144EA
	andi.b	#$20,d0
	bne.s	loc_114C2
	move.w	-$E(a6),d0
	move.w	-$C(a6),d1
	move.w	-$6(a3),d2
	move.w	-$4(a3),d3
	moveq	#$5,d4
	bsr.w	sub_15B5A
	tst.b	d0
	beq.s	loc_114C2
	cmp.b	-$F(a6),d1
	bcc.s	loc_114C2
	move.b	d1,-$F(a6)
	move.b	d2,-$10(a6)
	move.b	d3,-$11(a6)
loc_114C2:
	dbf	d7,loc_113FC
	dbf	d6,loc_113FA
	bsr.w	sub_14254
	movem.l	(a7)+,d2-d7
	unlk	a3
	rts

; ---------------------------------------------------------------------------
sub_114D6:
	move.l	d2,-(a7)
	move.w	-$4(a6),d0
	move.w	-$2(a6),d1
	mulu.w	#$18,d0
	mulu.w	#$18,d1
	sub.w	($FFFFB414).w,d0
	sub.w	($FFFFB416).w,d1
	add.w	($FFFFB3F8).w,d0
	add.w	($FFFFB3FA).w,d1
	addi.w	#$C,d0
	addi.w	#$C,d1
	move.b	-$12(a6),d2
	ext.w	d2
	bsr.w	sub_A102
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_1150E:
	movem.l	d2-d3/d5-d7/a2-a3,-(a7)
	movea.l	a0,a2
	clr.b	$E(a2)
	lea	($FFFFCACA).w,a0
	lea	$4(a2),a3
	moveq	#$2,d7
loc_11522:
	moveq	#$2,d6
loc_11524:
	move.w	(a2),d2
	move.w	$2(a2),d3
	add.w	d6,d2
	add.w	d7,d3
	move.b	(a3)+,d0
	bmi.s	loc_1153C
	mulu.w	#$15,d3
	add.w	d2,d3
	move.b	d0,(a0,d3.w)
loc_1153C:
	dbf	d6,loc_11524
	dbf	d7,loc_11522
	lea	($FFFF78CE).l,a2
	moveq	#$F,d5
loc_1154C:
	tst.b	$E(a2)
	beq.s	loc_1157C
	lea	$4(a2),a3
	moveq	#$2,d7
loc_11558:
	moveq	#$2,d6
loc_1155A:
	move.w	(a2),d2
	move.w	$2(a2),d3
	add.w	d6,d2
	add.w	d7,d3
	move.b	(a3)+,d0
	bmi.s	loc_11574
	mulu.w	#$15,d3
	add.w	d2,d3
	move.b	$F(a2),(a0,d3.w)
loc_11574:
	dbf	d6,loc_1155A
	dbf	d7,loc_11558
loc_1157C:
	adda.w	#$10,a2
	dbf	d5,loc_1154C
	movem.l	(a7)+,d2-d3/d5-d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_1158A:
	movem.l	d6-d7/a2,-(a7)
	lea	($FFFF78CE).l,a2
	moveq	#$F,d7
	moveq	#$0,d6
loc_11598:
	move.b	$E(a2),d0
	beq.s	loc_115B2
	cmp.b	#$1,d0
	bne.s	loc_115AE
	movea.l	a2,a0
	bsr.w	sub_1150E
	moveq	#$1,d6
	bra.s	loc_115B2
loc_115AE:
	subq.b	#$1,$E(a2)
loc_115B2:
	adda.w	#$10,a2
	dbf	d7,loc_11598
	tst.b	d6
	beq.s	loc_115C8
	moveq	#$0,d7
	bsr.w	sub_FEA8
	bsr.w	sub_14254
loc_115C8:
	movem.l	(a7)+,d6-d7/a2
	rts

; ---------------------------------------------------------------------------
sub_115CE:
	movem.l	d2/a2-a3,-(a7)
	tst.b	d1
	beq.s	loc_115E6
	cmp.b	#$0,d2
	beq.s	loc_115E6
	cmp.b	#$2,d2
	beq.w	loc_1162A
	asr.b	#$1,d0
loc_115E6:
	jsr	($760A).w
	move.b	($FFFFCA20).w,d2
	move.b	($FFFFD513).w,($FFFFCA20).w
	moveq	#$14,d0
	moveq	#$1,d1
	bsr.w	sub_E606
	move.b	d2,($FFFFCA20).w
	bsr.w	sub_CA7E
	move.b	($FFFFD513).w,d0
	jsr	($6F02).w
	tst.b	(a0)
	bpl.s	loc_11618
	moveq	#$0,d2
	bsr.w	sub_11B30
	bra.s	loc_1162A
loc_11618:
	moveq	#$0,d0
	bsr.w	sub_CAEA
	moveq	#$F,d0
	jsr	($75FA).w
	moveq	#-$1,d0
	bsr.w	sub_CAEA
loc_1162A:
	movem.l	(a7)+,d2/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_11630:
	movem.l	d2-d3/a2-a3,-(a7)
	move.l	a0,d3
	bra.s	loc_1163E

; ---------------------------------------------------------------------------
sub_11638:
	movem.l	d2-d3/a2-a3,-(a7)
	moveq	#$0,d3
loc_1163E:
	tst.b	($FFFF97AE).w
	beq.s	loc_1164E
	move.b	($FFFFCA20).w,d0
	cmp.b	#$8,d0
	bcs.s	loc_116A4
loc_1164E:
	jsr	($6EEC).w
	tst.l	d3
	bne.s	loc_1165C
	lea	$AE(a2),a0
	bra.s	loc_1165E
loc_1165C:
	movea.l	d3,a0
loc_1165E:
	move.b	(a0),d0
	beq.s	loc_116A4
	ext.w	d0
	asl.w	#$3,d0
	lea	($779E).w,a1
	adda.w	d0,a1
	move.b	$7(a1),d2
	beq.s	loc_116A4
	cmp.b	#$FF,d2
	beq.s	loc_116A4
	move.b	$9(a0),d0
	cmp.b	#$5,d0
	bcs.s	loc_116A0
	cmp.b	#$C,d0
	bhi.s	loc_116A0
	cmp.b	#$A,d0
	beq.s	loc_116A0
	cmp.b	#$B,d0
	beq.s	loc_116A0
	moveq	#$10,d0
	jsr	($76FA).w
	tst.b	d0
	beq.s	loc_116A0
	moveq	#$C,d2
loc_116A0:
	move.w	d2,d0
	bra.s	loc_116A6
loc_116A4:
	moveq	#$1,d0
loc_116A6:
	movem.l	(a7)+,d2-d3/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_116AC:
	movem.l	d2-d3/a2-a3,-(a7)
	tst.b	d0
	bne.s	loc_116C4
	movem.w	($FFFFB3F0).w,d2-d3
	divu.w	#$18,d2
	divu.w	#$18,d3
	bra.s	loc_116DA
loc_116C4:
	move.b	($FFFFD513).w,d0
	bmi.s	loc_116F2
	jsr	($6EF0).w
	moveq	#$0,d2
	moveq	#$0,d3
	move.b	$12(a3),d2
	move.b	$13(a3),d3
loc_116DA:
	jsr	($6EEC).w
	moveq	#$0,d0
	moveq	#$0,d1
	move.b	$12(a3),d0
	move.b	$13(a3),d1
	bsr.w	sub_15D36
	move.b	d0,$10(a3)
loc_116F2:
	movem.l	(a7)+,d2-d3/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_116F8:
	tst.l	($FFFFD87E).w
	beq.s	loc_11720
	move.w	#$9FFF,($FFFFB510).w
	clr.w	($FFFFB50E).w
	move.l	#$11722,($FFFFB50A).l
	movem.w	($FFFFD882).w,d0-d1
	bsr.w	sub_11882
	clr.l	($FFFFD87E).w
loc_11720:
	rts
	dc.b	$00,$00,$20,$00,$40,$00,$40,$00

; ---------------------------------------------------------------------------
sub_1172A:
	jsr	($6ACC).w
	move.b	$5(a0),d0
	andi.b	#$30,d0
	beq.s	loc_1173E
	move.w	#$70,d0
	bra.s	loc_11740
loc_1173E:
	moveq	#-$1,d0
loc_11740:
	move.w	d0,($FFFFD888).w
	rts

; ---------------------------------------------------------------------------
sub_11746:
	movem.l	d2-d3/a2-a3,-(a7)
	bsr.w	sub_105FC
	tst.b	d0
	beq.w	loc_117E0
	bsr.s	sub_1172A
	move.l	#$C0620000,(a4)
	moveq	#$E,d2
	lea	($FFFFB4EC).w,a0
loc_11762:
	move.w	(a0)+,(a5)
	dbf	d2,loc_11762
	jsr	($6EEC).w
	lea	$AE(a2),a0
	move.b	$9(a0),d0
	cmp.b	#$A,d0
	bne.s	loc_11780
	moveq	#$4,d0
	moveq	#$54,d1
	bra.s	loc_11790
loc_11780:
	cmp.b	#$B,d0
	bne.s	loc_1178C
	moveq	#$2,d0
	moveq	#$3C,d1
	bra.s	loc_11790
loc_1178C:
	moveq	#$0,d0
	moveq	#$24,d1
loc_11790:
	lea	(dat_117F2).l,a0
	adda.w	(a0,d0.w),a0
	move.l	a0,($FFFFD87E).w
	move.w	d1,($FFFFD886).w
	movem.w	($FFFFB3F0).w,d2-d3
	sub.w	($FFFFD886).w,d2
	sub.w	($FFFFD886).w,d3
	sub.w	($FFFFB408).w,d2
	sub.w	($FFFFB40A).w,d3
	asr.w	#$3,d2
	asr.w	#$3,d3
	movem.w	d2-d3,($FFFFD882).w
	move.w	d2,d0
	move.w	d3,d1
	move.w	#$9FFF,($FFFFB510).w
	clr.w	($FFFFB50E).w
	move.l	#$117EA,($FFFFB50A).l
	bsr.w	sub_11882
	bra.s	loc_117E4
loc_117E0:
	clr.l	($FFFFD87E).w
loc_117E4:
	movem.l	(a7)+,d2-d3/a2-a3
	rts
	dc.b	$00,$00,$20,$00,$60,$00,$60,$00
dat_117F2:
	binclude	"data/0117F2.bin"

; ---------------------------------------------------------------------------
sub_11882:
	move.l	d6,-(a7)
	move.l	($FFFFD87E).w,d6
	beq.s	loc_11894
	movea.l	d6,a0
	move.w	#$C000,d6
	bsr.w	sub_C9B0
loc_11894:
	move.l	(a7)+,d6
	rts

; ---------------------------------------------------------------------------
sub_11898:
	link	a6,#-$1E
	movem.l	d2-d7/a2-a3,-(a7)
	lea	-$1E(a6),a3
	move.w	($FFFFD888).w,d7
	addq.w	#$1,d7
	cmp.w	#$30,d7
	bne.s	loc_118B2
	moveq	#$10,d7
loc_118B2:
	cmp.w	#$60,d7
	bne.s	loc_118BC
	move.w	#$40,d7
loc_118BC:
	cmp.w	#$90,d7
	bne.s	loc_118C6
	move.w	#$70,d7
loc_118C6:
	move.w	d7,($FFFFD888).w
	moveq	#$E,d6
	lea	($FFFFB4EC).w,a2
loc_118D0:
	move.w	($FFFFD888).w,d7
	cmp.w	#$10,d7
	bcc.s	loc_118E6
	move.w	(a2),d2
	bsr.w	sub_11A20
	move.w	d0,d3
	bra.w	loc_11978
loc_118E6:
	cmp.w	#$20,d7
	bcc.s	loc_118FC
	bsr.w	sub_11A20
	move.w	d0,d2
	bsr.w	sub_11A36
	move.w	d0,d3
	bra.w	loc_11978
loc_118FC:
	cmp.w	#$30,d7
	bcc.s	loc_11910
	bsr.w	sub_11A36
	move.w	d0,d2
	bsr.w	sub_11A20
	move.w	d0,d3
	bra.s	loc_11978
loc_11910:
	cmp.w	#$40,d7
	bcc.s	loc_11920
	move.w	(a2),d2
	bsr.w	sub_11A26
	move.w	d0,d3
	bra.s	loc_11978
loc_11920:
	cmp.w	#$50,d7
	bcc.s	loc_11934
	bsr.w	sub_11A26
	move.w	d0,d2
	bsr.w	sub_11A36
	move.w	d0,d3
	bra.s	loc_11978
loc_11934:
	cmp.w	#$60,d7
	bcc.s	loc_11948
	bsr.w	sub_11A36
	move.w	d0,d2
	bsr.w	sub_11A26
	move.w	d0,d3
	bra.s	loc_11978
loc_11948:
	cmp.w	#$70,d7
	bcc.s	loc_11958
	move.w	(a2),d2
	bsr.w	sub_11A26
	move.w	d0,d3
	bra.s	loc_11978
loc_11958:
	cmp.w	#$80,d7
	bcc.s	loc_1196C
	bsr.w	sub_11A2E
	move.w	d0,d2
	bsr.w	sub_11A36
	move.w	d0,d3
	bra.s	loc_11978
loc_1196C:
	bsr.w	sub_11A36
	move.w	d0,d2
	bsr.w	sub_11A2E
	move.w	d0,d3
loc_11978:
	andi.w	#$F,d7
	moveq	#$10,d4
	sub.w	d7,d4
	bsr.w	sub_119CC
	move.w	d0,d1
	asr.w	#$4,d2
	asr.w	#$4,d3
	bsr.w	sub_119CC
	asl.w	#$4,d0
	or.w	d0,d1
	asr.w	#$4,d2
	asr.w	#$4,d3
	bsr.w	sub_119CC
	asl.w	#$8,d0
	or.w	d0,d1
	move.w	d1,(a3)+
	addq.l	#$2,a2
	dbf	d6,loc_118D0
	tst.b	($FFFFB4C4).w
	bne.s	loc_119B0
	bsr.w	sub_DEE6
loc_119B0:
	moveq	#$62,d0
	jsr	(sub_8278).l
	moveq	#$E,d7
	lea	-$1E(a6),a3
loc_119BE:
	move.w	(a3)+,(a5)
	dbf	d7,loc_119BE
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_119CC:
	movem.w	d2-d3,-(a7)
	andi.w	#$E,d2
	andi.w	#$E,d3
	cmp.w	d3,d2
	blt.s	loc_119E6
	sub.w	d7,d2
	cmp.w	d3,d2
	bge.s	loc_119F0
	move.w	d3,d2
	bra.s	loc_119F0
loc_119E6:
	beq.s	loc_119F0
	add.w	d7,d2
	cmp.w	d3,d2
	ble.s	loc_119F0
	move.w	d3,d2
loc_119F0:
	move.w	d2,d0
	movem.w	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_119F8:
	move.w	(a2),d0
	move.w	d0,d4
	andi.w	#$E,d4
	lsr.w	#$4,d0
	move.w	d0,d1
	andi.w	#$E,d1
	add.w	d1,d4
	lsr.w	#$4,d0
	andi.w	#$E,d0
	add.w	d0,d4
	rts

; ---------------------------------------------------------------------------
sub_11A14:
	cmp.w	#$E,d4
	bcs.s	loc_11A1C
	moveq	#$E,d4
loc_11A1C:
	move.w	d4,d0
	rts

; ---------------------------------------------------------------------------
sub_11A20:
	bsr.s	sub_119F8
	asr.w	#$1,d4
	bra.s	sub_11A14

; ---------------------------------------------------------------------------
sub_11A26:
	bsr.s	sub_119F8
	bsr.s	sub_11A14
	asl.w	#$8,d0
	rts

; ---------------------------------------------------------------------------
sub_11A2E:
	bsr.s	sub_119F8
	asr.w	#$1,d4
	bsr.s	sub_11A14
	bra.s	loc_11A3A

; ---------------------------------------------------------------------------
sub_11A36:
	bsr.s	sub_119F8
	bsr.s	sub_11A14
loc_11A3A:
	asl.w	#$4,d0
	or.w	d4,d0
	asl.w	#$4,d0
	or.w	d4,d0
	rts

; ---------------------------------------------------------------------------
sub_11A44:
	link	a6,#-$2
	movem.l	d1-d7/a0-a3,-(a7)
	move.b	($FFFFCA20).w,d0
	move.b	d0,-$2(a6)
	move.b	d0,($FFFFD513).w
	jsr	($6F02).w
	move.b	$1(a0),d7
	andi.b	#$1,d7
	clr.b	d6
	move.b	#$0,($FFFFCA20).w
loc_11A6C:
	jsr	($6EEC).w
	move.b	(a3),d0
	beq.w	loc_11AEA
	andi.b	#$C0,d0
	bne.w	loc_11AEA
	move.b	$1(a3),d0
	btst	#$4,d0
	beq.w	loc_11AEA
	andi.b	#$1,d0
	eor.b	d7,d0
	beq.s	loc_11AEA
	moveq	#$0,d0
	move.b	-$2(a6),d0
	bsr.w	sub_10400
	tst.b	($FFFFD511).w
	beq.s	loc_11AEA
	bclr	#$4,$1(a3)
	jsr	(sub_98E4).l
	tst.b	d6
	bne.s	loc_11AC4
	move.b	-$2(a6),d0
	jsr	($6EF0).w
	bsr.w	sub_FA22
	st	d6
	jsr	($6EEC).w
loc_11AC4:
	move.b	-$2(a6),d0
	move.b	d0,($FFFFD513).w
	jsr	($6F02).w
	bsr.w	sub_E588
	movem.w	d0-d1,($FFFFB3F0).w
	bsr.w	sub_1074A
	move.b	-$2(a6),d0
	jsr	($6F02).w
	move.b	(a0),d0
	ble.s	loc_11B1E
loc_11AEA:
	moveq	#$0,d0
	move.b	($FFFFCA20).w,d0
	addq.b	#$1,d0
	move.b	d0,($FFFFCA20).w
	cmp.w	($FFFFBA64).w,d0
	bcs.w	loc_11A6C
	move.b	-$2(a6),($FFFFCA20).w
	tst.b	d6
	beq.s	loc_11B1A
	jsr	(sub_98E4).l
	move.b	-$2(a6),d0
	jsr	($6EF0).w
	bsr.w	sub_F9A6
loc_11B1A:
	moveq	#$1,d0
	bra.s	loc_11B26
loc_11B1E:
	move.b	-$2(a6),($FFFFCA20).w
	moveq	#-$1,d0
loc_11B26:
	movem.l	(a7)+,d1-d7/a0-a3
	unlk	a6
	tst.b	d0
	rts

; ---------------------------------------------------------------------------
sub_11B30:
	movem.l	d2-d3/a2-a3,-(a7)
	move.b	($FFFFD513).w,d0
	jsr	($6EF0).w
	move.w	#$46,d0
	cmpi.b	#$4,$17(a2)
	beq.s	loc_11B68
	move.w	#$44,d0
	cmpi.b	#$32,$25(a2)
	bne.s	loc_11B68
	cmpi.b	#$1F,$42(a2)
	beq.s	loc_11B68
	cmpi.b	#$13,$42(a2)
	beq.s	loc_11B68
	move.w	#$45,d0
loc_11B68:
	jsr	(sub_1B900).l
	move.b	$23(a2),d0
	cmp.b	#$2,d0
	bcs.s	loc_11B7C
	moveq	#$23,d3
	bra.s	loc_11B7E
loc_11B7C:
	moveq	#$14,d3
loc_11B7E:
	moveq	#$1,d2
loc_11B80:
	move.w	d2,d0
	bsr.w	sub_CAEA
	move.w	d3,d0
	jsr	($75FA).w
	addq.w	#$1,d2
	cmp.w	#$5,d2
	bne.s	loc_11B80
	movem.l	(a7)+,d2-d3/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_11B9A:
	movem.l	d2,-(a7)
	asl.w	#$1,d0
	if DEUTSCH	; DEUTSCH-HOOK 5: Systemtexte aus DE_Systemtexte (6 Byte wie Original)
	lea	(DE_Systemtexte).l,a1
	else
	lea	(dat_11DC4).l,a1
	endif
	move.w	(a1,d0.w),d0
	adda.w	d0,a1
	movea.l	a1,a0
	bsr.w	sub_11C18
	move.l	d0,d1
	lea	($FFFFD5AE).w,a0
	bsr.w	sub_11C18
loc_11BBC:
	moveq	#$1,d2
	add.l	d0,d2
	add.l	d1,d2
	move.b	(a0,d0.w),(a0,d2.w)
	dbf	d0,loc_11BBC
loc_11BCC:
	move.b	(a1)+,(a0)+
	dbf	d1,loc_11BCC
	move.b	#$20,-(a0)
	movem.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_11BDC:
	moveq	#$1,d1
	bra.s	loc_11BE2

; ---------------------------------------------------------------------------
sub_11BE0:
	moveq	#$0,d1
loc_11BE2:
	asl.w	#$1,d0
	if DEUTSCH	; DEUTSCH-HOOK 5: Systemtexte aus DE_Systemtexte (6 Byte wie Original)
	lea	(DE_Systemtexte).l,a1
	else
	lea	(dat_11DC4).l,a1
	endif
	move.w	(a1,d0.w),d0
	adda.w	d0,a1
	bra.s	loc_11BF8

; ---------------------------------------------------------------------------
sub_11BF2:
	moveq	#$1,d1
	bra.s	loc_11BF8
	dc.b	$72,$00
loc_11BF8:
	lea	($FFFFD5AE).w,a0
	bsr.w	sub_11C18
	tst.l	d1
	beq.s	loc_11C10
	tst.l	d0
	beq.s	loc_11C10
	move.b	#$20,(a0,d0.w)
	addq.l	#$1,d0
loc_11C10:
	adda.w	d0,a0
loc_11C12:
	move.b	(a1)+,(a0)+
	bne.s	loc_11C12
	rts

; ---------------------------------------------------------------------------
sub_11C18:
	moveq	#$0,d0
	move.l	a0,-(a7)
loc_11C1C:
	tst.b	(a0)+
	beq.s	loc_11C24
	addq.l	#$1,d0
	bra.s	loc_11C1C
loc_11C24:
	movea.l	(a7)+,a0
	rts

; ---------------------------------------------------------------------------
sub_11C28:
	movem.l	d2-d3,-(a7)
loc_11C2C:
	move.b	(a2)+,d2
	bmi.s	loc_11C46
	ext.w	d2
	move.b	(a2)+,d3
	ext.w	d3
	move.w	d2,($FFFFD5D6).w
	move.w	d3,($FFFFD5D8).w
	move.w	(a2)+,d0
	bsr.w	sub_11C8E
	bra.s	loc_11C2C
loc_11C46:
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_11C4C:
	lea	($FFFFD5AE).w,a0
	bsr.s	sub_11C18
	lsr.w	#$1,d0
	sub.w	d0,($FFFFD5D6).w
	bra.s	sub_11CA0

; ---------------------------------------------------------------------------
sub_11C5A:
	move.b	($FFFFCA20).w,d0

; ---------------------------------------------------------------------------
sub_11C5E:
	jsr	($6F02).w
	move.b	$2(a0),d0
	jsr	($6F14).w
	tst.b	(a0)
	bpl.s	loc_11C74
	move.w	#$A000,d0
	bra.s	loc_11C86
loc_11C74:
	btst	#$0,$52(a1)
	beq.s	loc_11C82
	move.w	#$C000,d0
	bra.s	loc_11C86
loc_11C82:
	move.w	#$8000,d0
loc_11C86:
	move.w	d0,($FFFFD5AC).w
	lea	(a1),a0
	bra.s	sub_11CA4

; ---------------------------------------------------------------------------
sub_11C8E:
	if DEUTSCH	; DEUTSCH-HOOK 5: Systemtexte aus DE_Systemtexte (6 Byte wie Original)
	lea	(DE_Systemtexte).l,a0
	else
	lea	(dat_11DC4).l,a0
	endif
	asl.w	#$1,d0
	move.w	(a0,d0.w),d0
	adda.w	d0,a0
	bra.w	sub_11CA4

; ---------------------------------------------------------------------------
sub_11CA0:
	lea	($FFFFD5AE).w,a0

; ---------------------------------------------------------------------------
sub_11CA4:
	movem.l	d2-d6,-(a7)
	move.w	($FFFFD5DA).w,d3
	cmp.w	($FFFFD5D6).w,d3
	ble.s	loc_11CB6
	move.w	d3,($FFFFD5D6).w
loc_11CB6:
	cmp.w	($FFFFD5D6).w,d3
	sne	d6
	move.w	($FFFFD5DC).w,d3
	cmp.w	($FFFFD5D8).w,d3
	ble.s	loc_11CCA
	move.w	d3,($FFFFD5D8).w
loc_11CCA:
	move.w	($FFFFD5AC).w,d3
loc_11CCE:
	move.w	#$20,d5
	bsr.w	sub_11C18
	subq.w	#$1,d0
	add.w	($FFFFD5D6).w,d0
	cmp.w	($FFFFD5DE).w,d0
	ble.s	loc_11CFC
	move.w	($FFFFD5DE).w,d4
	sub.w	($FFFFD5D6).w,d4
	addq.w	#$1,d4
loc_11CEC:
	cmp.b	(a0,d4.w),d5
	beq.s	loc_11D06
	dbf	d4,loc_11CEC
	tst.b	d6
	bne.w	loc_11D5C
loc_11CFC:
	move.w	#$FFFF,d4
	bsr.w	sub_11C18
	bra.s	loc_11D08
loc_11D06:
	move.l	d4,d0
loc_11D08:
	tst.b	($FFFFD5E2).w
	beq.s	loc_11D24
	add.w	($FFFFD5DA).w,d0
	sub.w	($FFFFD5DE).w,d0
	asr.w	#$1,d0
	neg.w	d0
	bmi.s	loc_11D24
	add.w	($FFFFD5DA).w,d0
	move.w	d0,($FFFFD5D6).w
loc_11D24:
	clr.b	d3
loc_11D26:
	move.b	(a0)+,d3
	beq.w	loc_11D84
	dbf	d4,loc_11D32
	bra.s	loc_11D5C
loc_11D32:
	cmp.b	#$D,d3
	beq.s	loc_11D5C
	subi.b	#$20,d3
	cmp.b	#$40,d3
	blt.s	loc_11D46
	subi.b	#$20,d3
loc_11D46:
	addq.b	#$6,d3
	bsr.w	sub_11DAC
	move.w	d3,(a5)
	addq.w	#$1,($FFFFD5D6).w
	move.w	($FFFFD5D6).w,d0
	cmp.w	($FFFFD5DE).w,d0
	bls.s	loc_11D26
loc_11D5C:
	moveq	#$0,d6
	move.w	($FFFFD5DA).w,($FFFFD5D6).w
	addq.w	#$1,($FFFFD5D8).w
	move.w	($FFFFD5D8).w,d0
	cmp.w	($FFFFD5E0).w,d0
	bls.s	loc_11D78
	move.l	($FFFFD5DA).w,($FFFFD5D6).w
loc_11D78:
	moveq	#$20,d5
loc_11D7A:
	cmp.b	(a0),d5
	bne.w	loc_11CCE
	addq.l	#$1,a0
	bra.s	loc_11D7A
loc_11D84:
	moveq	#$0,d4
	move.b	($FFFFD5E3).w,d4
	beq.s	loc_11DA2
	sub.w	($FFFFD5D6).w,d4
	ble.s	loc_11DA2
	move.w	#$8774,d3
	bsr.w	sub_11DAC
	bra.s	loc_11D9E
loc_11D9C:
	move.w	d3,(a5)
loc_11D9E:
	dbf	d4,loc_11D9C
loc_11DA2:
	clr.b	($FFFFD5E2).w
	movem.l	(a7)+,d2-d6
	rts

; ---------------------------------------------------------------------------
sub_11DAC:
	move.w	($FFFFD5D6).w,d0
	move.w	($FFFFD5D8).w,d2
	asl.w	#$1,d0
	asl.w	#$7,d2
	add.w	d2,d0
	add.w	($FFFFD5A8).w,d0
	jmp	(sub_8288).l
dat_11DC4:
	binclude	"data/011DC4.bin"

; ---------------------------------------------------------------------------
sub_13268:
	clr.b	($FFFFD5AE).w
	move.w	#$8,($FFFFD5AA).w
	bsr.w	sub_13376
	bsr.w	sub_1368C
	move.w	#$9F,d0
	bsr.w	sub_11BDC
	rts
loc_13284:
	lea	($FFFFD5AE).w,a0
	move.w	($FFFFD5AA).w,d0
	move.b	#$20,d1
	bra.s	loc_132A0
loc_13292:
	cmp.b	(a0,d0.w),d1
	bne.s	loc_132A0
	move.b	#$2D,(a0,d0.w)
	rts
loc_132A0:
	dbf	d0,loc_13292
	rts

; ---------------------------------------------------------------------------
sub_132A6:
	move.w	#$8164,(a4)
	jsr	(sub_9222).l
	move.l	#$0,($FFFFD5D6).w
	move.w	#$E000,($FFFFD5AC).w
	bsr.w	sub_11CA4
	illegal
	dc.b	$4E,$75

; ---------------------------------------------------------------------------
sub_132C6:
	bsr.w	sub_133AA
	bra.w	sub_11CA0
	dc.b	$61,$00,$00,$E4,$60,$00,$E9,$CC

; ---------------------------------------------------------------------------
sub_132D6:
	bsr.w	sub_133BE
	bra.w	sub_11CA0

; ---------------------------------------------------------------------------
sub_132DE:
	bsr.w	sub_1330E
	bra.w	sub_11CA0
	binclude	"data/0132E6.bin"

; ---------------------------------------------------------------------------
sub_132F6:
	bsr.w	sub_13322
	bra.w	sub_11CA0
	dc.b	$61,$00,$00,$28,$60,$00,$E9,$9C

; ---------------------------------------------------------------------------
sub_13306:
	bsr.w	sub_13376
	bra.w	sub_11CA0

; ---------------------------------------------------------------------------
sub_1330E:
	ext.w	d0
	lea	($FFFFD5AE).w,a0
	tst.w	d0
	bpl.s	sub_1332C
	neg.w	d0
	bsr.w	sub_1332C
	bra.w	loc_13284

; ---------------------------------------------------------------------------
sub_13322:
	move.b	d0,d1
	moveq	#$0,d0
	move.b	d1,d0

; ---------------------------------------------------------------------------
sub_13328:
	lea	($FFFFD5AE).w,a0

; ---------------------------------------------------------------------------
sub_1332C:
	move.w	d2,-(a7)
	move.w	($FFFFD5AA).w,d2
	clr.b	(a0,d2.w)
	subq.w	#$1,d2
	swap	d0
	clr.w	d0
	swap	d0
loc_1333E:
	divu.w	#$A,d0
	swap	d0
	addi.b	#$30,d0
	move.b	d0,(a0,d2.w)
	clr.w	d0
	swap	d0
	subq.w	#$1,d2
	bmi.s	loc_13362
	tst.w	d0
	bne.s	loc_1333E
loc_13358:
	move.b	#$20,(a0,d2.w)
	dbf	d2,loc_13358
loc_13362:
	move.w	(a7)+,d2
	rts
	binclude	"data/013366.bin"

; ---------------------------------------------------------------------------
sub_13376:
	lea	($FFFFD5AE).w,a0
	move.w	d2,-(a7)
	move.w	($FFFFD5AA).w,d2
	clr.b	(a0,d2.w)
	subq.w	#$1,d2
loc_13386:
	moveq	#$A,d1
	bsr.w	sub_13406
	addi.b	#$30,d1
	move.b	d1,(a0,d2.w)
	subq.w	#$1,d2
	bmi.s	loc_133A6
	tst.l	d0
	bne.s	loc_13386
loc_1339C:
	move.b	#$20,(a0,d2.w)
	dbf	d2,loc_1339C
loc_133A6:
	move.w	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_133AA:
	move.b	d0,d1
	moveq	#$0,d0
	move.b	d1,d0
	moveq	#$1,d1
	bra.s	loc_133C0

; ---------------------------------------------------------------------------
sub_133B4:
	move.w	d0,d1
	moveq	#$0,d0
	move.w	d1,d0
	moveq	#$3,d1
	bra.s	loc_133C0

; ---------------------------------------------------------------------------
sub_133BE:
	moveq	#$7,d1
loc_133C0:
	move.w	d2,-(a7)
	lea	($FFFFD5AE).w,a0
	clr.b	$1(a0,d1.w)
loc_133CA:
	move.b	d0,d2
	lsr.l	#$4,d0
	andi.b	#$F,d2
	cmp.b	#$A,d2
	bcs.s	loc_133DE
	addi.b	#$37,d2
	bra.s	loc_133E2
loc_133DE:
	addi.b	#$30,d2
loc_133E2:
	move.b	d2,(a0,d1.w)
	dbf	d1,loc_133CA
	move.w	(a7)+,d2
	rts
	binclude	"data/0133EE.bin"

; ---------------------------------------------------------------------------
sub_13406:
	movem.l	d2-d4,-(a7)
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$0,d4
	move.w	d1,d4
	beq.s	loc_13430
loc_13414:
	cmp.l	d4,d0
	bcs.s	loc_13420
	asl.l	#$1,d4
	bcs.s	loc_13430
	addq.w	#$1,d2
	bra.s	loc_13414
loc_13420:
	subq.l	#$1,d2
	bmi.s	loc_13430
	lsr.l	#$1,d4
	cmp.l	d4,d0
	bcs.s	loc_13420
	bset	d2,d3
	sub.l	d4,d0
	bra.s	loc_13420
loc_13430:
	move.l	d0,d1
	move.l	d3,d0
	movem.l	(a7)+,d2-d4
	rts

; ---------------------------------------------------------------------------
sub_1343A:
	moveq	#$10,d1
	bra.s	loc_13450

; ---------------------------------------------------------------------------
sub_1343E:
	lea	($FFFFD5DA).w,a0
	move.l	($FFFFD5DA).w,($FFFFD5D6).w
	bra.s	sub_1344E

; ---------------------------------------------------------------------------
sub_1344A:
	lea	($FFFFD582).w,a0

; ---------------------------------------------------------------------------
sub_1344E:
	moveq	#$20,d1
loc_13450:
	movem.l	d2-d5,-(a7)
	move.w	(a0),d2
	move.w	$2(a0),d3
	move.w	$4(a0),d4
	move.w	$6(a0),d5
	sub.w	d2,d4
	addq.w	#$1,d4
	sub.w	d3,d5
	addq.w	#$1,d5
	moveq	#$0,d0
	movea.l	d0,a0
	tst.b	($FFFFD5E4).w
	bne.s	loc_1347A
	clr.w	($FFFFB514).w
	bra.s	loc_13480
loc_1347A:
	move.w	#$8774,($FFFFB514).w
loc_13480:
	jsr	(sub_95BE).l
	movem.l	(a7)+,d2-d5
	rts
loc_1348C:
	move.b	(a0)+,d0
	move.b	(a1)+,d1
	cmp.b	d1,d0
	bne.s	loc_1349C
	tst.b	d0
	bne.s	loc_1348C
	moveq	#$0,d0
	rts
loc_1349C:
	tst.b	d0
	beq.s	loc_134AC
	tst.b	d1
	beq.s	loc_134A8
	cmp.b	d1,d0
	bcs.s	loc_134AC
loc_134A8:
	moveq	#$1,d0
	rts
loc_134AC:
	moveq	#-$1,d0
	rts

; ---------------------------------------------------------------------------
sub_134B0:
	move.l	d2,($FFFFD5A4).w
	moveq	#$A,d0
	tst.b	($FFFFD5A4).w
	bne.s	loc_134CE
	moveq	#$8,d0
	tst.b	($FFFFD5A5).w
	bne.s	loc_134CE
	moveq	#$5,d0
	tst.b	($FFFFD5A6).w
	bne.s	loc_134CE
	moveq	#$3,d0
loc_134CE:
	move.l	d0,d2
	asr.l	#$1,d0
	addq.l	#$1,d0
	move.w	($FFFFD5D8).w,($FFFFD584).w
	move.w	($FFFFD5D8).w,($FFFFD588).w
	move.w	($FFFFD5D6).w,d1
	add.w	d0,d1
	move.w	d1,($FFFFD586).w
	move.w	($FFFFD5D6).w,d1
	sub.w	d0,d1
	move.w	d1,($FFFFD582).w
	move.w	d1,($FFFFD5D6).w

; ---------------------------------------------------------------------------
sub_134F8:
	link	a6,#-$E
	movem.l	d2-d4/a2,-(a7)
	ext.l	d2
	move.w	d2,d4
	subq.l	#$1,d4
	bsr.w	sub_1388E
	bsr.w	sub_1344A
	move.l	#$0,-$A(a6)
	move.l	#$0,-$6(a6)
	clr.w	-$2(a6)
	tst.l	($FFFFD5A4).w
	beq.s	loc_13552
	lea	-$A(a6),a0
	move.l	d2,d1
	subq.l	#$1,d1
	move.l	($FFFFD5A4).w,d0
	tst.b	($FFFFBA61).w
	beq.s	loc_1353C
	moveq	#$1,d0
loc_1353C:
	divu.w	#$A,d0
	swap	d0
	move.b	d0,(a0,d1.w)
	move.w	#$0,d0
	swap	d0
	dbf	d1,loc_1353C
	bra.s	loc_13558
loc_13552:
	moveq	#$3C,d0
	bsr.w	sub_11C8E
loc_13558:
	move.l	($FFFFD5D6).w,-$E(a6)
loc_1355E:
	bsr.w	sub_1362C
	clr.w	($FFFFD5AE).w
	move.l	-$E(a6),($FFFFD5D6).w
	moveq	#$0,d3
	lea	-$A(a6),a2
loc_13572:
	move.b	(a2)+,d0
	addi.b	#$30,d0
	move.b	d0,($FFFFD5AE).w
	cmp.w	d4,d3
	bne.s	loc_13588
	move.w	#$E000,($FFFFD5AC).w
	bra.s	loc_1358E
loc_13588:
	move.w	#$C000,($FFFFD5AC).w
loc_1358E:
	bsr.w	sub_11CA0
	addq.l	#$1,d3
	cmp.w	d2,d3
	bne.s	loc_13572
	jsr	($6C64).w
	btst	#$7,d0
	beq.s	loc_135B4
	tst.b	($FFFFD592).w
	bne.s	loc_135B4
	lea	-$A(a6),a0
	clr.l	(a0)+
	clr.l	(a0)+
	clr.w	(a0)
	bra.s	loc_13612
loc_135B4:
	btst	#$5,d0
	bne.s	loc_13612
	btst	#$6,d0
	bne.s	loc_135C6
	btst	#$2,d0
	beq.s	loc_135CE
loc_135C6:
	subq.l	#$1,d4
	bpl.s	loc_135CE
	move.l	d2,d4
	subq.l	#$1,d4
loc_135CE:
	btst	#$4,d0
	bne.s	loc_135DA
	btst	#$3,d0
	beq.s	loc_135E2
loc_135DA:
	addq.l	#$1,d4
	cmp.w	d2,d4
	bne.s	loc_135E2
	moveq	#$0,d4
loc_135E2:
	lea	-$A(a6),a0
	adda.w	d4,a0
	btst	#$0,d0
	beq.s	loc_135FC
	move.b	(a0),d1
	addq.l	#$1,d1
	cmp.b	#$A,d1
	bne.s	loc_135FA
	moveq	#$0,d1
loc_135FA:
	move.b	d1,(a0)
loc_135FC:
	btst	#$1,d0
	beq.s	loc_1360A
	subq.b	#$1,(a0)
	bpl.s	loc_1360A
	move.b	#$9,(a0)
loc_1360A:
	jsr	($6C3A).w
	bra.w	loc_1355E
loc_13612:
	bsr.w	sub_138FC
	bsr.w	sub_1362C
	clr.l	($FFFFD5A4).w
	clr.b	($FFFFD592).w
	movem.l	(a7)+,d2-d4/a2
	move.l	d0,d2
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_1362C:
	move.l	d2,-(a7)
	move.w	d2,($FFFFD5AA).w
	lea	-$A(a6),a0
	subq.l	#$1,d2
	moveq	#$0,d0
	moveq	#$0,d1
loc_1363C:
	mulu.w	#$A,d0
	move.b	(a0)+,d1
	add.l	d1,d0
	dbf	d2,loc_1363C
	tst.l	($FFFFD5A4).w
	beq.s	loc_13688
	cmp.l	($FFFFD5A4).w,d0
	ble.s	loc_13688
	move.l	($FFFFD5A4).w,d0
	bsr.w	sub_13376
	lea	-$A(a6),a0
	lea	($FFFFD5AE).w,a1
	moveq	#$0,d0
loc_13666:
	move.b	(a1,d0.w),d1
	cmp.b	#$20,d1
	bne.s	loc_13674
	move.b	#$30,d1
loc_13674:
	subi.b	#$30,d1
	move.b	d1,(a0,d0.w)
	addq.l	#$1,d0
	cmp.w	($FFFFD5AA).w,d0
	bne.s	loc_13666
	move.l	($FFFFD5A4).w,d0
loc_13688:
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_1368C:
	lea	($FFFFD5AE).w,a0
	movea.l	a0,a1
	moveq	#$20,d0
loc_13694:
	cmp.b	(a0)+,d0
	beq.s	loc_13694
	subq.l	#$1,a0
loc_1369A:
	move.b	(a0)+,(a1)+
	bne.s	loc_1369A
	rts

; ---------------------------------------------------------------------------
sub_136A0:
	clr.w	($FFFFD5D6).w
	addq.w	#$1,($FFFFD5D8).w
	move.w	($FFFFD5D8).w,d0
	cmp.w	($FFFFD5E0).w,d0
	bls.s	loc_136BA
	bsr.w	sub_14246
	bsr.w	sub_1343E
loc_136BA:
	rts

; ---------------------------------------------------------------------------
sub_136BC:
	move.l	($FFFFD58A).w,d0
	beq.s	loc_136CA
	movea.l	d0,a0
	movea.l	($FFFFD58E).w,a1
	jsr	(a0)
loc_136CA:
	bsr.w	sub_DF08
	jsr	(sub_F1B66).l
	tst.b	d0
	beq.s	sub_136BC
	rts

; ---------------------------------------------------------------------------
sub_136DA:
	link	a6,#-$170
	movem.l	d2-d6/a2,-(a7)
	bsr.w	sub_1388E
	move.w	d0,d5
	bsr.w	sub_1344A
	tst.w	d5
	bpl.s	loc_136F6
	lea	($FFFFD5AE).w,a0
	bra.s	loc_13720
loc_136F6:
	lea	(dat_13866).l,a0
	asl.w	#$2,d5
	move.w	(a0,d5.w),d1
	move.w	$2(a0,d5.w),d2
	tst.w	d1
	beq.s	loc_13714
	move.w	d1,d0
	bsr.w	sub_11C8E
	addq.w	#$1,($FFFFD5D6).w
loc_13714:
	if DEUTSCH	; DEUTSCH-HOOK 5: Systemtexte aus DE_Systemtexte (6 Byte wie Original)
	lea	(DE_Systemtexte).l,a0
	else
	lea	(dat_11DC4).l,a0
	endif
	asl.w	#$1,d2
	adda.w	(a0,d2.w),a0
loc_13720:
	lea	-$2A(a6),a1
loc_13724:
	move.b	(a0)+,(a1)+
	bne.s	loc_13724
	lea	-$2A(a6),a0
	lea	-$16A(a6),a2
	moveq	#$0,d3
loc_13732:
	move.l	($FFFFD5D6).w,(a2)
	lea	$4(a2),a1
loc_1373A:
	addq.w	#$1,($FFFFD5D6).w
	move.b	(a0)+,d0
	beq.s	loc_1374C
	cmp.b	#$7E,d0
	beq.s	loc_1374C
	move.b	d0,(a1)+
	bra.s	loc_1373A
loc_1374C:
	move.b	#$0,(a1)+
	addq.l	#$1,d3
	adda.l	#$28,a2
	cmp.b	#$7E,d0
	beq.s	loc_13732
	moveq	#$0,d4
	move.b	($FFFFD593).w,d4
loc_13764:
	bsr.w	sub_1382C
loc_13768:
	bsr.w	sub_136BC
	tst.b	($FFFFBA5A).w
	bne.w	loc_1380E
	btst	#$6,($FFFFD595).w
	beq.s	loc_137BA
	btst	#$6,d0
	beq.s	loc_137BA
	jsr	($6C54).w
	move.b	($FFFFD595).w,-$16C(a6)
	move.l	($FFFFD58A).w,-$170(a6)
	clr.b	($FFFFD595).w
	clr.l	($FFFFD58A).w
	moveq	#$6D,d0
	st	($FFFFD596).w
	jsr	($5308).w
	bsr.w	sub_13892
	move.b	-$16C(a6),($FFFFD595).w
	move.l	-$170(a6),($FFFFD58A).w
	jsr	($6C54).w
	bra.s	loc_13764
loc_137BA:
	cmp.w	#$1,d3
	bhi.s	loc_137CA
	andi.w	#$F0,d0
	beq.s	loc_13768
	moveq	#$0,d4
	bra.s	loc_1380E
loc_137CA:
	btst	#$7,d0
	beq.s	loc_137DA
	tst.b	($FFFFD592).w
	bne.s	loc_137DA
	moveq	#-$1,d4
	bra.s	loc_1380E
loc_137DA:
	btst	#$5,d0
	bne.s	loc_1380E
	btst	#$4,d0
	bne.s	loc_137EC
	btst	#$3,d0
	beq.s	loc_137F6
loc_137EC:
	addq.l	#$1,d4
	cmp.b	d3,d4
	bcs.s	loc_13802
	subq.l	#$1,d4
	bra.s	loc_13802
loc_137F6:
	btst	#$2,d0
	beq.s	loc_1380A
	subq.l	#$1,d4
	bpl.s	loc_13802
	moveq	#$0,d4
loc_13802:
	bsr.w	sub_1382C
	jsr	($6C3A).w
loc_1380A:
	bra.w	loc_13768
loc_1380E:
	jsr	($6C54).w
	bsr.w	sub_138FC
	clr.b	($FFFFD592).w
	clr.b	($FFFFD593).w
	clr.b	($FFFFD595).w
	move.l	d4,d0
	movem.l	(a7)+,d2-d6/a2
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_1382C:
	movem.l	d2/a2,-(a7)
	moveq	#$0,d2
	lea	-$16A(a6),a2
loc_13836:
	cmp.w	d2,d3
	beq.s	loc_13860
	cmp.w	d2,d4
	bne.s	loc_13844
	move.w	#$E000,d0
	bra.s	loc_13848
loc_13844:
	move.w	#$C000,d0
loc_13848:
	move.w	d0,($FFFFD5AC).w
	move.l	(a2),($FFFFD5D6).w
	lea	$4(a2),a0
	bsr.w	sub_11CA4
	addq.l	#$1,d2
	adda.w	#$28,a2
	bra.s	loc_13836
loc_13860:
	movem.l	(a7)+,d2/a2
	rts
dat_13866:
	binclude	"data/013866.bin"

; ---------------------------------------------------------------------------
sub_1388E:
	bsr.w	sub_138AC

; ---------------------------------------------------------------------------
sub_13892:
	move.l	($FFFFD582).w,($FFFFD5D6).w
	move.l	($FFFFD582).w,($FFFFD5DA).w
	move.l	($FFFFD586).w,($FFFFD5DE).w
	move.w	#$C000,($FFFFD5AC).w
	rts

; ---------------------------------------------------------------------------
sub_138AC:
	movem.l	d0/a0,-(a7)
	move.l	($FFFFD88A).w,d0
	bne.s	loc_138BC
	move.l	#$FFFFD8CA,d0
loc_138BC:
	cmp.w	#$D88E,d0
	bne.s	loc_138E4
	lea	(dat_138CE).l,a0
	jsr	(sub_132A6).l
dat_138CE:
	binclude	"data/0138CE.bin"
loc_138E4:
	movea.l	d0,a0
	move.l	($FFFFD5DE).w,-(a0)
	move.l	($FFFFD5DA).w,-(a0)
	move.l	($FFFFD5D6).w,-(a0)
	move.l	a0,($FFFFD88A).w
	movem.l	(a7)+,d0/a0
	rts

; ---------------------------------------------------------------------------
sub_138FC:
	movem.l	d0/a0,-(a7)
	movea.l	($FFFFD88A).w,a0
	move.l	(a0)+,($FFFFD5D6).w
	move.l	(a0)+,($FFFFD5DA).w
	move.l	(a0)+,($FFFFD5DE).w
	move.l	a0,($FFFFD88A).w
	movem.l	(a7)+,d0/a0
	rts

; ---------------------------------------------------------------------------
sub_1391A:
	link	a6,#-$12
	movem.l	d2-d3/d5-d7/a2-a3,-(a7)
	move.w	#$FFFF,-$12(a6)
	moveq	#$0,d0
	move.b	($FFFFD59B).w,d0
	asl.w	#$2,d0
	lea	(dat_13A92).l,a0
	movea.l	(a0,d0.w),a0
	jsr	(sub_9DD4).l
	move.l	a0,-$6(a6)
	move.l	#$2C020003,(a4)
	move.w	(a5),-$2(a6)
	jsr	(sub_A9B8).l
	moveq	#$0,d2
	move.b	($FFFFD593).w,d2
	moveq	#$0,d5
	moveq	#$0,d6
	move.w	d2,d0
	mulu.w	#$3,d0
	movea.l	a2,a0
	adda.w	d0,a0
	move.b	(a0)+,d5
	move.b	(a0),d6
	move.l	a3,d0
	beq.s	loc_13984
	move.b	(a3)+,($FFFFD583).w
	move.b	(a3)+,($FFFFD585).w
	move.b	(a3)+,($FFFFD587).w
	move.b	(a3)+,($FFFFD589).w
	bsr.w	sub_1388E
loc_13984:
	bsr.w	sub_13ADE
loc_13988:
	move.b	d2,($FFFFD594).w
	bsr.w	sub_136BC
	moveq	#$0,d7
	btst	#$6,d0
	beq.s	loc_139AE
	tst.b	($FFFFD597).w
	bne.s	loc_139D0
	btst	#$6,($FFFFD595).w
	beq.s	loc_139AE
loc_139A6:
	ori.w	#$FF00,d2
	bra.w	loc_13A4C
loc_139AE:
	btst	#$4,d0
	beq.s	loc_139C4
	btst	#$4,($FFFFD595).w
	beq.s	loc_139C4
	ori.w	#$FE00,d2
	bra.w	loc_13A4C
loc_139C4:
	btst	#$5,d0
	beq.s	loc_139E2
	tst.b	($FFFFD596).w
	bne.s	loc_139A6
loc_139D0:
	lea	($FFFFD564).w,a0
loc_139D4:
	move.b	(a0)+,d0
	bmi.s	loc_139DE
	cmp.b	d0,d2
	bne.s	loc_139D4
	bra.s	loc_13988
loc_139DE:
	bra.w	loc_13A4C
loc_139E2:
	btst	#$7,d0
	beq.s	loc_139F4
	tst.b	($FFFFD592).w
	bne.s	loc_139F4
	moveq	#-$1,d2
	bra.w	loc_13A4C
loc_139F4:
	btst	#$2,d0
	beq.s	loc_13A00
	bset	#$2,d7
	bra.s	loc_13A22
loc_13A00:
	btst	#$3,d0
	beq.s	loc_13A0C
	bset	#$3,d7
	bra.s	loc_13A22
loc_13A0C:
	btst	#$0,d0
	beq.s	loc_13A18
	bset	#$0,d7
	bra.s	loc_13A22
loc_13A18:
	btst	#$1,d0
	beq.s	loc_13A22
	bset	#$1,d7
loc_13A22:
	and.b	($FFFFD595).w,d0
	beq.s	loc_13A30
	ori.w	#$FD00,d0
	move.w	d0,d2
	bra.s	loc_13A4C
loc_13A30:
	tst.b	d7
	beq.w	loc_13988
	bsr.w	sub_13BD2
	cmp.b	($FFFFD594).w,d2
	beq.s	loc_13A44
	bsr.w	sub_13A9E
loc_13A44:
	bsr.w	sub_13ADE
	bra.w	loc_13988
loc_13A4C:
	move.l	a3,d0
	beq.s	loc_13A54
	bsr.w	sub_138FC
loc_13A54:
	jsr	($6C54).w
	move.l	#$6C000003,(a4)
	moveq	#$0,d0
	move.b	-$1(a6),d0
	move.l	d0,(a5)
	moveq	#$1,d0
	move.l	d0,(a5)
	movea.l	-$6(a6),a0
	jsr	(sub_978C).l
	move.w	d2,d0
	clr.b	($FFFFD593).w
	clr.b	($FFFFD595).w
	clr.b	($FFFFD592).w
	clr.b	($FFFFD597).w
	clr.b	($FFFFD596).w
	movem.l	(a7)+,d2-d3/d5-d7/a2-a3
	unlk	a6
	rts
dat_13A92:
	binclude	"data/013A92.bin"

; ---------------------------------------------------------------------------
sub_13A9E:
	movem.l	d2-d3/a2,-(a7)
	moveq	#$0,d0
	move.b	($FFFFD59A).w,d0
	beq.s	loc_13AD8
	mulu.w	#$3,d2
	move.b	$1(a2,d2.w),d3
	move.b	(a2,d2.w),d2
	jsr	(sub_A85A).l
	moveq	#$0,d2
	move.b	($FFFFD594).w,d2
	mulu.w	#$3,d2
	move.b	$2(a2,d2.w),d0
	move.b	$1(a2,d2.w),d3
	move.b	(a2,d2.w),d2
	jsr	(sub_A85A).l
loc_13AD8:
	movem.l	(a7)+,d2-d3/a2
	rts

; ---------------------------------------------------------------------------
sub_13ADE:
	move.l	a3,d0
	beq.s	loc_13B02
	bsr.w	sub_1344A
	move.l	($FFFFD582).w,($FFFFD5D6).w
	moveq	#$0,d0
	move.w	d2,d0
	asl.w	#$1,d0
	move.w	(a3,d0.w),d0
	beq.s	loc_13B14
	st	($FFFFD5E2).w
	bsr.w	sub_11C8E
	bra.s	loc_13B14
loc_13B02:
	move.l	($FFFFD5A0).w,d0
	beq.s	loc_13B14
	movea.l	d0,a0
	move.l	a6,-(a7)
	movea.l	($FFFFD59C).w,a6
	jsr	(a0)
	movea.l	(a7)+,a6
loc_13B14:
	move.w	d2,d3
	mulu.w	#$3,d3
	bsr.w	sub_13B2A
	tst.b	($FFFFD59A).w
	beq.s	loc_13B28
	jsr	($6C3A).w
loc_13B28:
	rts

; ---------------------------------------------------------------------------
sub_13B2A:
	movem.l	d2-d7,-(a7)
	moveq	#$0,d5
	move.b	$1(a2,d3.w),d5
	asl.w	#$3,d5
	addi.w	#$7C,d5
	moveq	#$0,d4
	move.b	(a2,d3.w),d4
	asl.w	#$3,d4
	addi.w	#$7C,d4
	tst.w	-$12(a6)
	bmi.s	loc_13B98
	tst.b	($FFFFD59A).w
	bne.s	loc_13B98
	moveq	#$F,d7
	moveq	#$0,d6
loc_13B56:
	addq.l	#$8,d6
	move.w	-$12(a6),d0
	move.w	d4,d2
	mulu.w	d6,d2
	move.l	#$80,d1
	sub.w	d6,d1
	mulu.w	d1,d0
	add.l	d0,d2
	asr.l	#$7,d2
	move.w	-$10(a6),d0
	move.w	d5,d3
	mulu.w	d6,d3
	move.l	#$80,d1
	sub.w	d6,d1
	mulu.w	d1,d0
	add.l	d0,d3
	asr.l	#$7,d3
	bsr.w	sub_13BAE
	move.b	#$1,($FFFF9BB7).w
	jsr	(sub_DEC4).l
	dbf	d7,loc_13B56
loc_13B98:
	move.w	d4,d2
	move.w	d5,d3
	bsr.w	sub_13BAE
	move.w	d4,-$12(a6)
	move.w	d5,-$10(a6)
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_13BAE:
	move.l	#$6C000003,(a4)
	move.w	d3,(a5)
	move.w	#$F00,d0
	move.b	-$1(a6),d0
	move.w	d0,(a5)
	movea.l	-$6(a6),a0
	move.w	#$8000,d0
	add.w	(a0),d0
	moveq	#$0,d1
	move.w	d0,(a5)
	move.w	d2,(a5)
	rts

; ---------------------------------------------------------------------------
sub_13BD2:
	moveq	#-$1,d0
	move.l	d0,-$A(a6)
	move.w	d5,-$C(a6)
	move.w	d6,-$E(a6)
	bsr.w	sub_13C02
	move.w	-$A(a6),d0
	bmi.s	loc_13BEC
	move.w	d0,d2
loc_13BEC:
	movea.l	a2,a0
	move.w	d2,d1
	mulu.w	#$3,d1
	adda.w	d1,a0
	moveq	#$0,d5
	move.b	(a0),d5
	moveq	#$0,d6
	move.b	$1(a0),d6
	rts

; ---------------------------------------------------------------------------
sub_13C02:
	move.l	d3,-(a7)
	moveq	#$0,d3
	movea.l	a2,a0
loc_13C08:
	cmp.w	d2,d3
	beq.w	loc_13C8E
	moveq	#$0,d0
	move.b	(a0),d0
	moveq	#$0,d1
	move.b	$1(a0),d1
	btst	#$0,d7
	beq.s	loc_13C2E
	cmp.w	d6,d1
	bge.w	loc_13C8E
	cmp.w	-$E(a6),d1
	beq.w	loc_13C8E
	bra.s	loc_13C64
loc_13C2E:
	btst	#$1,d7
	beq.s	loc_13C42
	cmp.w	d6,d1
	ble.w	loc_13C8E
	cmp.w	-$E(a6),d1
	beq.s	loc_13C8E
	bra.s	loc_13C64
loc_13C42:
	btst	#$2,d7
	beq.s	loc_13C54
	cmp.w	d5,d0
	bge.s	loc_13C8E
	cmp.w	-$C(a6),d0
	beq.s	loc_13C8E
	bra.s	loc_13C64
loc_13C54:
	btst	#$3,d7
	beq.s	loc_13C64
	cmp.w	d5,d0
	ble.s	loc_13C8E
	cmp.w	-$C(a6),d0
	beq.s	loc_13C8E
loc_13C64:
	sub.w	d5,d0
	muls.w	d0,d0
	sub.w	d6,d1
	muls.w	d1,d1
	btst	#$0,d7
	bne.s	loc_13C78
	btst	#$1,d7
	beq.s	loc_13C7C
loc_13C78:
	asl.w	#$2,d0
	bra.s	loc_13C7E
loc_13C7C:
	asl.w	#$2,d1
loc_13C7E:
	add.w	d1,d0
	cmp.w	-$8(a6),d0
	bhi.s	loc_13C8E
	move.w	d0,-$8(a6)
	move.w	d3,-$A(a6)
loc_13C8E:
	addq.l	#$1,d3
	addq.l	#$3,a0
	tst.b	(a0)
	bpl.w	loc_13C08
	move.l	(a7)+,d3
	rts

; ---------------------------------------------------------------------------
sub_13C9C:
	movem.l	a2-a3,-(a7)
	asl.w	#$2,d0
	lea	(dat_13CC6).l,a2
	move.w	$2(a2,d0.w),d1
	beq.s	loc_13CB4
	movea.l	a2,a3
	adda.w	d1,a3
	bra.s	loc_13CB8
loc_13CB4:
	movea.w	#$0,a3
loc_13CB8:
	adda.w	(a2,d0.w),a2
	bsr.w	sub_1391A
	movem.l	(a7)+,a2-a3
	rts
dat_13CC6:
	binclude	"data/013CC6.bin"
dat_13D70:
	binclude	"data/013D70.bin"
dat_13D92:
	binclude	"data/013D92.bin"

; ---------------------------------------------------------------------------
sub_13DA2:
	bsr.w	sub_13DD6
	moveq	#$1A,d0
	moveq	#$C,d1
	jsr	(sub_92AA).l
	move.l	a0,($FFFFD560).w
	move.w	(a0),d0
	asl.w	#$5,d0
	jsr	(sub_8288).l
	moveq	#$2F,d0
loc_13DC0:
	move.l	#$2020202,(a5)
	move.l	#$20202020,(a5)
	dbf	d0,loc_13DC0
	bsr.w	sub_13DF0
	rts

; ---------------------------------------------------------------------------
sub_13DD6:
	move.b	#$FF,($FFFFD564).w
	move.l	($FFFFD560).w,d0
	beq.s	loc_13DEE
	movea.l	d0,a0
	jsr	(sub_9240).l
	clr.l	($FFFFD560).w
loc_13DEE:
	rts

; ---------------------------------------------------------------------------
sub_13DF0:
	movem.l	d2-d4,-(a7)
	move.b	#$FF,($FFFFD564).w
	movea.l	($FFFFD560).w,a0
	move.w	$2(a0),d0
	move.w	d0,d4
	addq.l	#$1,d4
	asl.w	#$3,d0
	addi.w	#$EC00,d0
	jsr	(sub_8288).l
	moveq	#$1,d3
	moveq	#$19,d2
loc_13E16:
	move.w	d3,(a5)
	tst.w	d2
	beq.s	loc_13E22
	move.l	d4,d0
	addq.l	#$1,d4
	bra.s	loc_13E24
loc_13E22:
	moveq	#$0,d0
loc_13E24:
	addi.w	#$A00,d0
	move.w	d0,(a5)
	move.w	#$8000,d0
	add.w	(a0),d0
	move.w	d0,(a5)
	move.w	d3,(a5)
	dbf	d2,loc_13E16
	move.l	#$2C020003,(a4)
	move.w	(a5),d2
	move.l	#$6C020003,(a4)
	andi.w	#$F300,d2
	add.w	$2(a0),d2
	move.w	d2,(a5)
	movem.l	(a7)+,d2-d4
	rts

; ---------------------------------------------------------------------------
sub_13E56:
	movem.l	d2/a0,-(a7)
	move.w	d0,d1
	mulu.w	#$3,d1
	adda.l	d1,a0
	movea.l	($FFFFD560).w,a1
	move.w	$2(a1),d2
	subq.l	#$1,d2
	lea	($FFFFD564).w,a1
loc_13E70:
	addq.l	#$1,d2
	tst.b	(a1)+
	bpl.s	loc_13E70
	move.b	d0,-(a1)
	move.b	#$FF,$1(a1)
	asl.w	#$3,d2
	addi.w	#$EC00,d2
	move.w	d2,d0
	jsr	(sub_8288).l
	moveq	#$0,d0
	move.b	$1(a0),d0
	asl.w	#$3,d0
	addi.w	#$80,d0
	move.w	d0,(a5)
	move.w	d2,d0
	addq.l	#$6,d0
	jsr	(sub_8288).l
	moveq	#$0,d0
	move.b	(a0),d0
	asl.w	#$3,d0
	addi.w	#$80,d0
	move.w	d0,(a5)
	movem.l	(a7)+,d2/a0
	rts

; ---------------------------------------------------------------------------
sub_13EB6:
	link	a6,#-$10
	movem.l	d2-d7/a2,-(a7)
	move.l	d0,d7
	move.w	d3,d6
	move.w	d1,d3
	move.w	d2,d4
	lea	($FFFF0000).l,a2
	asl.w	#$1,d1
	asl.w	#$7,d2
	add.w	d1,d2
	move.w	d2,d5
	addi.w	#$C000,d2
	bsr.w	sub_14064
	move.w	d5,d2
	addi.w	#$F000,d2
	bsr.w	sub_14064
	move.l	($FFFFD5DA).w,-(a7)
	move.l	($FFFFD5DE).w,-(a7)
	move.l	($FFFFD582).w,-(a7)
	move.l	($FFFFD586).w,-(a7)
	move.l	d6,d0
	jsr	(sub_8A90).l
	move.w	d3,d0
	addq.w	#$1,d0
	move.w	d0,($FFFFD5DA).w
	addi.w	#$C,d0
	move.w	d0,($FFFFD5DE).w
	move.w	d4,d0
	addq.w	#$1,d0
	move.w	d0,($FFFFD5DC).w
	addi.w	#$E,d0
	move.w	d0,($FFFFD5E0).w
	bsr.w	sub_1343E
	clr.w	($FFFFD5D6).w
	move.w	d4,d0
	addq.w	#$2,d0
	move.w	d0,($FFFFD5D8).w
	st	($FFFFD5E2).w
	move.w	#$C000,($FFFFD5AC).w
	move.l	d7,d0
	bpl.s	loc_13F42
	bsr.w	sub_11CA0
	bra.s	loc_13F46
loc_13F42:
	bsr.w	sub_11C8E
loc_13F46:
	moveq	#$0,d5
	moveq	#$2,d6
	bsr.w	sub_1413E
loc_13F4E:
	bsr.w	sub_136BC
	btst	#$7,d0
	beq.s	loc_13F60
loc_13F58:
	clr.w	($FFFFD5AE).w
	bra.w	loc_14024
loc_13F60:
	btst	#$5,d0
	beq.s	loc_13FBA
	tst.w	d6
	beq.s	loc_13F58
	cmp.b	#$1,d6
	bne.s	loc_13F78
	bsr.w	sub_14124
	bra.w	loc_14024
loc_13F78:
	cmp.b	#$1C,d6
	bcs.s	loc_13FA4
	cmp.b	#$1C,d6
	bne.s	loc_13F98
	cmp.b	#$A,d5
	beq.w	loc_14018
	cmp.b	#$0,d5
	beq.w	loc_14018
	moveq	#$20,d0
	bra.s	loc_13FB0
loc_13F98:
	tst.w	d5
	beq.w	loc_14018
	subq.l	#$1,d5
	bra.w	loc_14018
loc_13FA4:
	cmp.b	#$A,d5
	beq.w	loc_14018
	moveq	#$3F,d0
	add.b	d6,d0
loc_13FB0:
	move.b	d0,-$10(a6,d5.w)
	addq.l	#$1,d5
	bra.w	loc_14018
loc_13FBA:
	btst	#$6,d0
	bne.s	loc_13FC6
	btst	#$2,d0
	beq.s	loc_13FD2
loc_13FC6:
	lea	(dat_140E8).l,a0
	move.b	(a0,d6.w),d6
	bra.s	loc_1400C
loc_13FD2:
	btst	#$4,d0
	bne.s	loc_13FDE
	btst	#$3,d0
	beq.s	loc_13FEA
loc_13FDE:
	lea	(dat_14106).l,a0
	move.b	(a0,d6.w),d6
	bra.s	loc_1400C
loc_13FEA:
	btst	#$0,d0
	beq.s	loc_13FFC
	lea	(dat_140AC).l,a0
	move.b	(a0,d6.w),d6
	bra.s	loc_1400C
loc_13FFC:
	btst	#$1,d0
	beq.s	loc_1400C
	lea	(dat_140CA).l,a0
	move.b	(a0,d6.w),d6
loc_1400C:
	jsr	($6C3A).w
	bsr.w	sub_1413E
	bra.w	loc_13F4E
loc_14018:
	bsr.w	sub_1413E
	jsr	($6C54).w
	bra.w	loc_13F4E
loc_14024:
	jsr	($6C54).w
	lea	($FFFF0000).l,a2
	move.w	d3,d5
	asl.w	#$1,d5
	move.w	d4,d1
	asl.w	#$7,d1
	add.w	d1,d5
	move.w	d5,d2
	addi.w	#$C000,d2
	bsr.w	sub_14088
	move.w	d5,d2
	addi.w	#$F000,d2
	bsr.w	sub_14088
	move.l	(a7)+,($FFFFD586).w
	move.l	(a7)+,($FFFFD582).w
	move.l	(a7)+,($FFFFD5DE).w
	move.l	(a7)+,($FFFFD5DA).w
	movem.l	(a7)+,d2-d7/a2
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_14064:
	movem.l	d2-d4,-(a7)
	moveq	#$10,d3
loc_1406A:
	move.w	d2,d0
	jsr	(sub_829C).l
	moveq	#$E,d4
loc_14074:
	move.w	(a5),(a2)+
	dbf	d4,loc_14074
	addi.w	#$80,d2
	dbf	d3,loc_1406A
	movem.l	(a7)+,d2-d4
	rts

; ---------------------------------------------------------------------------
sub_14088:
	movem.l	d2-d4,-(a7)
	moveq	#$10,d3
loc_1408E:
	move.w	d2,d0
	jsr	(sub_8288).l
	moveq	#$E,d4
loc_14098:
	move.w	(a2)+,(a5)
	dbf	d4,loc_14098
	addi.w	#$80,d2
	dbf	d3,loc_1408E
	movem.l	(a7)+,d2-d4
	rts
dat_140AC:
	binclude	"data/0140AC.bin"
dat_140CA:
	binclude	"data/0140CA.bin"
dat_140E8:
	binclude	"data/0140E8.bin"
dat_14106:
	binclude	"data/014106.bin"

; ---------------------------------------------------------------------------
sub_14124:
	move.l	d5,-(a7)
	lea	-$10(a6),a0
	lea	($FFFFD5AE).w,a1
	subq.l	#$1,d5
	bmi.s	loc_14138
loc_14132:
	move.b	(a0)+,(a1)+
	dbf	d5,loc_14132
loc_14138:
	clr.b	(a1)
	move.l	(a7)+,d5
	rts

; ---------------------------------------------------------------------------
sub_1413E:
	move.l	d7,-(a7)
	moveq	#$0,d7
	move.w	d3,d0
	addq.w	#$2,d0
	move.w	d0,($FFFFD582).w
	move.w	d4,d1
	addq.w	#$6,d1
	move.w	d1,($FFFFD584).w
	addi.w	#$A,d0
	move.w	d0,($FFFFD586).w
	addq.w	#$1,d1
	move.w	d1,($FFFFD588).w
	bsr.w	sub_1344A
	move.w	#$E000,($FFFFD5AC).w
	move.l	($FFFFD582).w,($FFFFD5D6).w
	bsr.s	sub_14124
	bsr.w	sub_11CA0
loc_14176:
	cmp.b	d6,d7
	bne.s	loc_14182
	move.w	#$E000,($FFFFD5AC).w
	bra.s	loc_14188
loc_14182:
	move.w	#$C000,($FFFFD5AC).w
loc_14188:
	tst.w	d7
	bne.s	loc_141A8
	move.w	d3,d0
	addq.w	#$2,d0
	move.w	d0,($FFFFD5D6).w
	move.w	d4,d1
	addi.w	#$E,d1
	move.w	d1,($FFFFD5D8).w
	moveq	#$68,d0
	bsr.w	sub_11C8E
	bra.w	loc_14238
loc_141A8:
	cmp.w	#$1,d7
	bne.s	loc_141CC
	move.w	d3,d0
	addi.w	#$9,d0
	move.w	d0,($FFFFD5D6).w
	move.w	d4,d1
	addi.w	#$E,d1
	move.w	d1,($FFFFD5D8).w
	moveq	#$4D,d0
	bsr.w	sub_11C8E
	bra.w	loc_14238
loc_141CC:
	cmp.w	#$1C,d7
	bcc.s	loc_141FE
	moveq	#$3F,d0
	add.w	d7,d0
	asl.w	#$8,d0
	move.w	d0,($FFFFD5AE).w
	move.l	d7,d0
	subq.l	#$2,d0
	divu.w	#$6,d0
	addq.w	#$8,d0
	add.w	d4,d0
	move.w	d0,($FFFFD5D8).w
	swap	d0
	asl.w	#$1,d0
	addq.w	#$2,d0
	add.w	d3,d0
	move.w	d0,($FFFFD5D6).w
	bsr.w	sub_11CA0
	bra.s	loc_14238
loc_141FE:
	cmp.w	#$1D,d7
	beq.s	loc_1421E
	move.w	d3,d0
	addq.w	#$6,d0
	move.w	d0,($FFFFD5D6).w
	move.w	d4,d1
	addi.w	#$C,d1
	move.w	d1,($FFFFD5D8).w
	moveq	#$51,d0
	bsr.w	sub_11C8E
	bra.s	loc_14238
loc_1421E:
	move.w	d3,d0
	addi.w	#$A,d0
	move.w	d0,($FFFFD5D6).w
	move.w	d4,d1
	addi.w	#$C,d1
	move.w	d1,($FFFFD5D8).w
	moveq	#$50,d0
	bsr.w	sub_11C8E
loc_14238:
	addq.l	#$1,d7
	cmp.w	#$1E,d7
	bne.w	loc_14176
	move.l	(a7)+,d7
	rts

; ---------------------------------------------------------------------------
sub_14246:
	moveq	#$2,d0
	clr.b	($FFFFD593).w
	bsr.w	sub_136DA
	bra.w	sub_1344A

; ---------------------------------------------------------------------------
sub_14254:
	movem.l	d2/a2,-(a7)
	lea	($FFFFCACA).w,a0
	move.w	#$1B8,d2
loc_14260:
	bclr	#$7,(a0)+
	dbf	d2,loc_14260
	lea	($FFFFC470).w,a2
	move.w	($FFFFBA64).w,d2
	bra.s	loc_1428E
loc_14272:
	move.b	(a2),d1
	beq.s	loc_1428A
	andi.b	#$C0,d1
	bne.s	loc_1428A
	move.b	$1(a2),d1
	btst	#$2,d1
	bne.s	loc_1428A
	bsr.w	sub_14298
loc_1428A:
	adda.w	#$1A,a2
loc_1428E:
	dbf	d2,loc_14272
	movem.l	(a7)+,d2/a2
	rts

; ---------------------------------------------------------------------------
sub_14298:
	move.l	a3,-(a7)
	lea	(sub_142F2).l,a3
	bsr.w	sub_142B8
	movea.l	(a7)+,a3
	rts

; ---------------------------------------------------------------------------
sub_142A8:
	move.l	a3,-(a7)
	lea	(sub_14306).l,a3
	bsr.w	sub_142B8
	movea.l	(a7)+,a3
	rts

; ---------------------------------------------------------------------------
sub_142B8:
	movem.l	d2-d4,-(a7)
	move.b	$2(a2),d0
	jsr	($6F14).w
	move.b	$23(a1),d4
	moveq	#$0,d2
	move.b	$12(a2),d2
	moveq	#$0,d3
	move.b	$13(a2),d3
	jsr	(a3)
	cmp.b	#$3,d4
	bne.s	loc_142E2
	addq.w	#$1,d2
	jsr	(a3)
	bra.s	loc_142EC
loc_142E2:
	cmp.b	#$2,d4
	bne.s	loc_142EC
	addq.w	#$1,d3
	jsr	(a3)
loc_142EC:
	movem.l	(a7)+,d2-d4
	rts

; ---------------------------------------------------------------------------
sub_142F2:
	lea	($FFFFCACA).w,a0
	move.w	d3,d0
	mulu.w	#$15,d0
	add.w	d2,d0
	bset	#$7,(a0,d0.w)
	rts

; ---------------------------------------------------------------------------
sub_14306:
	lea	($FFFFCACA).w,a0
	move.w	d3,d0
	mulu.w	#$15,d0
	add.w	d2,d0
	bclr	#$7,(a0,d0.w)
	rts

; ---------------------------------------------------------------------------
sub_1431A:
	lea	($FFFFCACA).w,a0
	move.w	d3,d0
	mulu.w	#$15,d0
	add.w	d2,d0
	tst.b	(a0,d0.w)
	smi	d0
	rts

; ---------------------------------------------------------------------------
sub_1432E:
	link	a6,#-$8
	movem.l	d2-d6/a2-a3,-(a7)
	move.l	#$FFFFD5F8,-$6(a6)
	move.b	d2,-$1(a6)
	move.b	d3,-$2(a6)
	clr.b	-$8(a6)
	bsr.s	sub_1431A
	tst.b	d0
	beq.s	loc_14382
	lea	(sub_143E4).l,a3
	move.w	($FFFFBA64).w,d2
	lea	($FFFFC470).w,a2
	bra.s	loc_1437E
loc_14360:
	move.b	(a2),d0
	beq.s	loc_14376
	andi.b	#$C0,d0
	bne.s	loc_14376
	btst	#$2,$1(a2)
	bne.s	loc_14376
	bsr.w	sub_142B8
loc_14376:
	adda.w	#$1A,a2
	addq.b	#$1,-$8(a6)
loc_1437E:
	dbf	d2,loc_14360
loc_14382:
	movea.l	-$6(a6),a1
	st	(a1)
	move.b	-$1(a6),d5
	move.b	-$2(a6),d6
	st	d3
	moveq	#$0,d4
	lea	($FFFFC470).w,a0
	move.w	($FFFFBA64).w,d1
	bra.s	loc_143D0
loc_1439E:
	btst	#$2,$1(a0)
	bne.s	loc_143CA
	move.b	(a0),d0
	bpl.s	loc_143CA
	cmp.b	$12(a0),d5
	bne.s	loc_143CA
	cmp.b	$13(a0),d6
	bne.s	loc_143CA
	btst	#$0,$1(a0)
	beq.s	loc_143C4
	cmp.b	#$83,d0
	beq.s	loc_143C8
loc_143C4:
	tst.b	d3
	bpl.s	loc_143CA
loc_143C8:
	move.b	d4,d3
loc_143CA:
	adda.w	#$1A,a0
	addq.w	#$1,d4
loc_143D0:
	dbf	d1,loc_1439E
	move.b	d3,d1
	lea	($FFFFD5F8).w,a1
	move.b	(a1),d0
	movem.l	(a7)+,d2-d6/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_143E4:
	cmp.b	-$1(a6),d2
	bne.s	loc_143FC
	cmp.b	-$2(a6),d3
	bne.s	loc_143FC
	movea.l	-$6(a6),a0
	move.b	-$8(a6),(a0)+
	move.l	a0,-$6(a6)
loc_143FC:
	rts

; ---------------------------------------------------------------------------
sub_143FE:
	movem.l	d2-d3,-(a7)
	cmp.b	#$15,d0
	bcc.s	loc_1442E
	cmp.b	#$15,d1
	bcc.s	loc_1442E
	moveq	#$0,d2
	moveq	#$0,d3
	move.b	d0,d2
	move.b	d1,d3
	bsr.w	sub_1432E
	mulu.w	#$15,d3
	add.w	d2,d3
	lea	($FFFFCACA).w,a0
	move.b	(a0,d3.w),d1
	andi.w	#$7F,d1
	bra.s	loc_14436
loc_1442E:
	moveq	#-$1,d0
	moveq	#$0,d1
	st	($FFFFD5F8).w
loc_14436:
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_1443C:
	link	a6,#-$6
	movem.l	a2-a3,-(a7)
	move.b	d0,-$5(a6)
	jsr	($6F02).w
	movea.l	a0,a2
	lea	(sub_144A6).l,a3
	move.b	$12(a2),-$1(a6)
	move.b	$13(a2),-$2(a6)
	lea	(dat_146E0).l,a0
	ext.w	d1
	move.b	(a0,d1.w),d0
	add.b	d0,$12(a2)
	move.b	$B(a0,d1.w),d0
	add.b	d0,$13(a2)
	st	-$3(a6)
	clr.b	-$4(a6)
	move.b	#$1,-$6(a6)
	bsr.w	sub_142B8
	move.b	-$1(a6),$12(a2)
	move.b	-$2(a6),$13(a2)
	move.b	-$3(a6),d0
	move.b	-$4(a6),d1
	movem.l	(a7)+,a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_144A6:
	move.w	d2,d0
	move.w	d3,d1
	bsr.w	sub_143FE
	lea	($FFFFD5F8).w,a0
loc_144B2:
	move.b	(a0)+,d0
	bmi.s	loc_144C0
	cmp.b	-$5(a6),d0
	beq.s	loc_144B2
	move.b	d0,-$3(a6)
loc_144C0:
	move.b	d1,d0
	bsr.w	sub_144EA
	andi.w	#$3F,d0
	cmp.b	-$6(a6),d0
	bcs.s	loc_144D8
	move.b	d0,-$6(a6)
	move.b	d1,-$4(a6)
loc_144D8:
	rts
	binclude	"data/0144DA.bin"

; ---------------------------------------------------------------------------
sub_144EA:
	andi.w	#$7F,d0
	subq.b	#$2,d0
	bpl.s	loc_144F4
	moveq	#-$1,d0
loc_144F4:
	movea.l	($FFFFD810).w,a0
	move.b	(a0,d0.w),d0
	rts

; ---------------------------------------------------------------------------
sub_144FE:
	moveq	#-$1,d3
	move.l	($FFFFD814).w,d1
	beq.s	loc_14540
	movea.l	d1,a0
	andi.w	#$7F,d0
	move.w	d0,d2
loc_1450E:
	move.b	(a0,d2.w),d0
	bpl.s	loc_14540
	cmp.b	#$80,d0
	bne.s	loc_14522
	move.b	$1(a0,d2.w),d3
	addq.w	#$2,d2
	bra.s	loc_1450E
loc_14522:
	cmp.b	#$81,d0
	bne.s	loc_1453C
	jsr	($6D06).w
	btst	#$0,d0
	beq.s	loc_14538
	move.b	$1(a0,d2.w),d2
	bra.s	loc_1450E
loc_14538:
	addq.b	#$2,d2
	bra.s	loc_1450E
loc_1453C:
	move.b	d0,d2
	bra.s	loc_1450E
loc_14540:
	move.w	d0,d2
	rts

; ---------------------------------------------------------------------------
sub_14544:
	movem.l	d2-d7/a2,-(a7)
	move.b	$2(a3),d0
	jsr	($6F14).w
	movea.l	a1,a2
	move.b	$23(a2),d0
	moveq	#$C,d2
	moveq	#$C,d3
	cmp.b	#$3,d0
	bne.s	loc_14564
	moveq	#$18,d2
	bra.s	loc_1456C
loc_14564:
	cmp.b	#$2,d0
	bne.s	loc_1456C
	moveq	#$18,d3
loc_1456C:
	moveq	#$0,d4
	move.b	$12(a3),d4
	mulu.w	#$18,d4
	moveq	#$0,d5
	move.b	$13(a3),d5
	mulu.w	#$18,d5
	move.w	($FFFFB414).w,d6
	add.w	($FFFFB3FC).w,d6
	move.w	($FFFFB416).w,d7
	add.w	($FFFFB3FE).w,d7
	cmp.w	($FFFFB414).w,d4
	blt.s	loc_145B2
	cmp.w	($FFFFB416).w,d5
	blt.s	loc_145B2
	move.w	d6,d0
	sub.w	d2,d0
	cmp.w	d0,d4
	bge.s	loc_145B2
	move.w	d7,d0
	sub.w	d3,d0
	cmp.w	d0,d5
	bge.s	loc_145B2
	moveq	#$1,d0
	moveq	#$1,d1
	bra.s	loc_145D8
loc_145B2:
	cmp.w	d6,d4
	bge.s	loc_145D4
	cmp.w	d7,d5
	bge.s	loc_145D4
	move.w	($FFFFB414).w,d0
	sub.w	d2,d0
	cmp.w	d0,d4
	ble.s	loc_145D4
	move.w	($FFFFB416).w,d0
	sub.w	d3,d0
	cmp.w	d0,d5
	ble.s	loc_145D4
	moveq	#$0,d0
	moveq	#$1,d1
	bra.s	loc_145D8
loc_145D4:
	moveq	#$0,d0
	moveq	#$0,d1
loc_145D8:
	movem.l	(a7)+,d2-d7/a2
	rts

; ---------------------------------------------------------------------------
sub_145DE:
	movem.l	d2-d3/d7,-(a7)
	ext.w	d0
	ext.w	d1
	move.w	d0,d2
	move.w	d1,d3
	lea	($FFFFCACA).w,a0
	mulu.w	#$15,d1
	add.w	d0,d1
	move.b	(a0,d1.w),d0
	andi.w	#$7F,d0
	cmp.b	#$0,d0
	beq.s	loc_1460A
	cmp.b	#$1,d0
	bne.w	loc_14656
loc_1460A:
	moveq	#$F,d7
	lea	($FFFF78CE).l,a0
loc_14612:
	tst.b	$E(a0)
	beq.s	loc_1463E
	move.w	d2,d0
	move.w	d3,d1
	sub.w	(a0),d0
	sub.w	$2(a0),d1
	cmp.w	#$2,d0
	bhi.s	loc_1463E
	cmp.w	#$2,d1
	bhi.s	loc_1463E
	mulu.w	#$3,d1
	add.w	d0,d1
	neg.w	d1
	move.b	$C(a0,d1.w),d0
	bmi.s	loc_1463E
	bra.s	loc_14656
loc_1463E:
	adda.w	#$10,a0
	dbf	d7,loc_14612
	lea	(dat_1465C).l,a0
	move.l	($FFFFD5DA).w,($FFFFD5D6).w
	bsr.w	sub_11CA4
loc_14656:
	movem.l	(a7)+,d2-d3/d7
	rts
dat_1465C:
	binclude	"data/01465C.bin"

; ---------------------------------------------------------------------------
sub_14670:
	movem.l	d3-d4/d7,-(a7)
	ext.w	d0
	ext.w	d1
	move.w	d0,d4
	move.w	d1,d3
	lea	($FFFFCACA).w,a0
	mulu.w	#$15,d1
	add.w	d0,d1
	adda.w	d1,a0
	move.b	(a0),d0
	andi.w	#$7F,d0
	cmp.b	#$0,d0
	beq.s	loc_1469E
	cmp.b	#$1,d0
	beq.s	loc_1469E
	move.b	d2,(a0)
	bra.s	loc_146DA
loc_1469E:
	moveq	#$F,d7
	lea	($FFFF78CE).l,a1
loc_146A6:
	tst.b	$E(a1)
	beq.s	loc_146D2
	move.w	d4,d0
	move.w	d3,d1
	sub.w	(a1),d0
	sub.w	$2(a1),d1
	cmp.w	#$2,d0
	bhi.s	loc_146D2
	cmp.w	#$2,d1
	bhi.s	loc_146D2
	mulu.w	#$3,d1
	add.w	d0,d1
	tst.b	$4(a1,d1.w)
	bmi.s	loc_146D2
	move.b	d2,$4(a1,d1.w)
loc_146D2:
	adda.w	#$10,a1
	dbf	d7,loc_146A6
loc_146DA:
	movem.l	(a7)+,d3-d4/d7
	rts
dat_146E0:
	binclude	"data/0146E0.bin"
dat_146F6:
	dc.b	$0A,$FF,$00,$09
dat_146FA:
	dc.b	$05,$0D,$08,$03,$08
dat_146FF:
	dc.b	$08
dat_14700:
	binclude	"data/014700.bin"
dat_14710:
	binclude	"data/014710.bin"

; ---------------------------------------------------------------------------
sub_14738:
	movem.l	d2-d7,-(a7)
	move.w	($FFFFBA64).w,d0
	lea	($FFFFC470).w,a0
	bra.s	loc_14752
loc_14746:
	st	$12(a0)
	st	$17(a0)
	adda.w	#$1A,a0
loc_14752:
	dbf	d0,loc_14746
	moveq	#$0,d4
	move.b	($FFFF9AFA).w,d5
	moveq	#$1,d6
	moveq	#$1,d7
	bsr.w	sub_147EE
	moveq	#$0,d7
	moveq	#$3,d1
	move.b	($FFFFD8CC).w,d0
	beq.s	loc_147B2
loc_1476E:
	asr.b	#$1,d0
	bcc.s	loc_14774
	addq.w	#$1,d7
loc_14774:
	dbf	d1,loc_1476E
	move.b	($FFFFD8CC).w,d3
	moveq	#$0,d2
loc_1477E:
	asr.b	#$1,d3
	bcc.s	loc_147A8
	move.b	d2,d5
	addq.b	#$2,d5
	andi.w	#$3,d5
	moveq	#$0,d6
	move.b	($FFFFD4FE).w,d4
	bne.s	loc_147A2
	move.b	($FFFF9AFA).w,d0
	addq.b	#$2,d0
	andi.b	#$3,d0
	cmp.b	d0,d5
	beq.s	loc_147A2
	moveq	#$1,d4
loc_147A2:
	bsr.w	sub_147EE
	subq.w	#$1,d7
loc_147A8:
	addq.w	#$1,d2
	cmp.w	#$4,d2
	bne.s	loc_1477E
	bra.s	loc_147C8
loc_147B2:
	move.b	($FFFF9AFA).w,d5
	addq.b	#$2,d5
	andi.w	#$3,d5
	moveq	#$0,d6
	moveq	#$1,d7
	move.b	($FFFFD4FE).w,d4
	bsr.w	sub_147EE
loc_147C8:
	move.w	($FFFFBA64).w,d0
	lea	($FFFFC470).w,a0
	bra.s	loc_147E4
loc_147D2:
	tst.b	$12(a0)
	bpl.s	loc_147E0
	tst.b	(a0)
	beq.s	loc_147E0
	bset	#$6,(a0)
loc_147E0:
	adda.w	#$1A,a0
loc_147E4:
	dbf	d0,loc_147D2
	movem.l	(a7)+,d2-d7
	rts

; ---------------------------------------------------------------------------
sub_147EE:
	link	a6,#-$20C
	movem.l	d2-d4/a3-a5,-(a7)
	move.w	#$6,-$208(a6)
	move.w	d5,d0
	mulu.w	#$5,d0
	tst.b	($FFFFBA5D).w
	beq.s	loc_1480C
	addi.w	#$14,d0
loc_1480C:
	lea	(dat_14710).l,a0
	adda.w	d0,a0
	move.l	a0,-$206(a6)
	ext.w	d5
	lea	(dat_14700).l,a0
	adda.w	d5,a0
	move.b	$8(a0),d2
	move.b	$C(a0),d3
	move.b	($FFFFD8D0).w,d0
	move.b	($FFFFD8D1).w,d1
	add.b	(a0),d0
	add.b	$4(a0),d1
	tst.b	($FFFFBA5D).w
	beq.s	loc_14840
	add.b	d3,d2
loc_14840:
	ext.w	d2
	ext.w	d3
	muls.w	d4,d2
	muls.w	d4,d3
	sub.b	d2,d0
	sub.b	d3,d1
	lea	-$200(a6),a4
	movea.l	a4,a5
	move.b	d0,(a5)+
	move.b	d1,(a5)+
	move.w	d7,d4
	moveq	#$0,d3
	lea	($FFFFC456).w,a3
loc_1485E:
	bsr.w	loc_14874
	beq.s	loc_1486C
	bsr.w	sub_148B8
	beq.s	loc_1486C
	bra.s	loc_1485E
loc_1486C:
	movem.l	(a7)+,d2-d4/a3-a5
	unlk	a6
	rts
loc_14874:
	addq.w	#$1,d3
	cmp.w	($FFFFBA64).w,d3
	bhi.s	loc_148B4
	adda.w	#$1A,a3
	move.b	(a3),d0
	beq.s	loc_14874
	andi.b	#$40,d0
	bne.s	loc_14874
	tst.b	$12(a3)
	bpl.s	loc_14874
	move.b	$1(a3),d0
	andi.b	#$1,d0
	cmp.b	d6,d0
	bne.s	loc_14874
	subq.w	#$1,d4
	bne.s	loc_14874
	move.w	d7,d4
	move.b	$2(a3),d0
	jsr	($6F14).w
	move.b	$23(a1),-$202(a6)
	moveq	#$1,d0
	rts
loc_148B4:
	moveq	#$0,d0
	rts

; ---------------------------------------------------------------------------
sub_148B8:
	movem.l	d2-d7/a2,-(a7)
	asl.b	#$1,d5
loc_148BE:
	tst.w	-$208(a6)
	beq.s	loc_148C8
	subq.w	#$1,-$208(a6)
loc_148C8:
	cmpa.l	a5,a4
	beq.w	loc_149B2
	move.b	(a4)+,d2
	ext.w	d2
	move.b	(a4)+,d3
	ext.w	d3
	cmpa.l	a6,a4
	bne.s	loc_148DE
	lea	-$200(a6),a4
loc_148DE:
	move.w	d3,d0
	mulu.w	#$15,d0
	add.w	d2,d0
	lea	($FFFFCACA).w,a0
	adda.w	d0,a0
	move.l	a0,-$20C(a6)
	move.b	(a0),d0
	bmi.w	loc_14968
	bsr.w	sub_144EA
	btst	#$5,d0
	bne.w	loc_14968
	andi.b	#$3F,d0
	cmp.b	#$4,d0
	bcc.w	loc_14970
	move.b	-$202(a6),d0
	cmp.b	#$2,d0
	bne.s	loc_14934
	movea.l	-$20C(a6),a0
	move.b	$15(a0),d0
	bmi.w	loc_14970
	bsr.w	sub_144EA
	andi.b	#$3F,d0
	cmp.b	#$4,d0
	bcc.s	loc_14970
	bra.s	loc_14952
loc_14934:
	cmp.b	#$3,d0
	bne.s	loc_14952
	movea.l	-$20C(a6),a0
	move.b	$1(a0),d0
	bmi.s	loc_14970
	bsr.w	sub_144EA
	andi.b	#$3F,d0
	cmp.b	#$4,d0
	bcc.s	loc_14970
loc_14952:
	move.b	d5,$10(a3)
	move.b	d2,$12(a3)
	move.b	d3,$13(a3)
	movea.l	a3,a2
	bsr.w	sub_14298
	moveq	#$1,d6
	bra.s	loc_14972
loc_14968:
	tst.w	-$208(a6)
	beq.w	loc_148BE
loc_14970:
	moveq	#$0,d6
loc_14972:
	moveq	#$4,d4
	lea	(dat_146E0).l,a0
	movea.l	-$206(a6),a1
	moveq	#$0,d7
loc_14980:
	move.b	(a1)+,d7
	move.b	(a0,d7.w),d0
	move.b	$B(a0,d7.w),d1
	add.b	d2,d0
	cmp.b	#$15,d0
	bcc.s	loc_149A6
	add.b	d3,d1
	cmp.b	#$15,d1
	bcc.s	loc_149A6
	move.b	d0,(a5)+
	move.b	d1,(a5)+
	cmpa.l	a6,a5
	bne.s	loc_149A6
	lea	-$200(a6),a5
loc_149A6:
	dbf	d4,loc_14980
	move.w	d6,d0
	beq.w	loc_148BE
	bra.s	loc_149B4
loc_149B2:
	moveq	#$0,d0
loc_149B4:
	movem.l	(a7)+,d2-d7/a2
	rts

; ---------------------------------------------------------------------------
sub_149BA:
	movem.l	d3-d5/a3,-(a7)
	move.w	#$FFFF,($FFFFD8CE).w
	lea	($FFFFCACA).w,a3
	move.w	#$1B8,d3
	cmp.w	#$B,d2
	bcc.s	loc_149D8
	moveq	#$8,d4
	moveq	#$1,d5
	bra.s	loc_149DC
loc_149D8:
	moveq	#$16,d4
	moveq	#$1,d5
loc_149DC:
	moveq	#$2,d0
	jsr	($6C8C).w
	and.w	d5,d0
	add.w	d4,d0
	move.b	d0,(a3)+
	dbf	d3,loc_149DC
	lea	($2FF6).w,a0
	moveq	#$0,d1
	move.b	(a0,d2.w),d1
	lea	($300E).w,a3
	adda.w	d1,a3
loc_149FC:
	move.b	(a3)+,d0
	bmi.s	loc_14A2A
	cmp.b	#$7F,d0
	bne.s	loc_14A14
	moveq	#$4,d0
	jsr	($6C8C).w
	addq.l	#$2,d0
	move.w	d0,($FFFFD8CE).w
	bra.s	loc_149FC
loc_14A14:
	cmp.b	#$7E,d0
	bne.s	loc_14A22
	move.w	#$FFFF,($FFFFD8CE).w
	bra.s	loc_149FC
loc_14A22:
	move.b	(a3)+,d1
	bsr.w	sub_14A30
	bra.s	loc_149FC
loc_14A2A:
	movem.l	(a7)+,d3-d5/a3
	rts

; ---------------------------------------------------------------------------
sub_14A30:
	movem.l	d7/a3,-(a7)
	ext.w	d0
	subq.l	#$1,d0
	mulu.w	#$B,d0
	lea	($30D8).w,a3
	adda.w	d0,a3
	ext.w	d1
	move.w	d1,d7
	subq.l	#$1,d7
loc_14A48:
	jsr	($6D06).w
	cmp.b	(a3),d0
	bhi.s	loc_14A54
	bsr.w	sub_14A5E
loc_14A54:
	dbf	d7,loc_14A48
	movem.l	(a7)+,d7/a3
	rts

; ---------------------------------------------------------------------------
sub_14A5E:
	movem.l	d6-d7,-(a7)
	move.b	$1(a3),d0
	move.b	$2(a3),d1
	jsr	($6CE4).w
	move.w	d0,d7
	move.b	#$1,($FFFFD5F8).w
	move.b	$4(a3),d6
	move.b	$3(a3),($FFFFD5F9).w
	btst	#$4,$6(a3)
	bne.s	loc_14A9C
	moveq	#$15,d0
	jsr	($6C8C).w
	move.b	d0,($FFFFD5FA).w
	moveq	#$15,d0
	jsr	($6C8C).w
	move.b	d0,($FFFFD5FB).w
loc_14A9C:
	move.b	$5(a3),d0
	beq.s	loc_14AA8
	jsr	($6C8C).w
	add.b	d0,d6
loc_14AA8:
	tst.w	($FFFFD8CE).w
	bmi.s	loc_14AB2
	move.w	($FFFFD8CE).w,d6
loc_14AB2:
	subq.l	#$1,d7
	bmi.s	loc_14ABE
loc_14AB6:
	bsr.w	sub_14AC4
	dbf	d7,loc_14AB6
loc_14ABE:
	movem.l	(a7)+,d6-d7
	rts

; ---------------------------------------------------------------------------
sub_14AC4:
	movem.l	d4-d5/d7,-(a7)
	tst.b	($FFFFD5F8).w
	bne.s	loc_14AD8
	btst	#$1,$6(a3)
	bne.w	loc_14B28
loc_14AD8:
	move.b	$7(a3),($FFFFD5FC).w
	move.b	$9(a3),d0
	beq.s	loc_14AF6
	jsr	($6C94).w
	btst	#$3,$6(a3)
	beq.s	loc_14AF2
	asl.b	#$1,d0
loc_14AF2:
	add.b	d0,($FFFFD5FC).w
loc_14AF6:
	move.b	$8(a3),($FFFFD5FD).w
	cmpi.b	#$0,($FFFFD5FD).w
	beq.s	loc_14B24
	btst	#$2,$6(a3)
	bne.s	loc_14B20
	move.b	$A(a3),d0
	beq.s	loc_14B24
	jsr	($6C94).w
	btst	#$3,$6(a3)
	beq.s	loc_14B20
	asl.b	#$1,d0
loc_14B20:
	add.b	d0,($FFFFD5FD).w
loc_14B24:
	clr.b	($FFFFD5F8).w
loc_14B28:
	tst.b	d6
	beq.w	loc_14B8A
	move.b	d6,d7
	btst	#$5,$6(a3)
	bne.s	loc_14B42
	move.b	d7,d0
	addq.l	#$1,d0
	jsr	($6C94).w
	move.b	d0,d7
loc_14B42:
	move.l	#$81,d0
	jsr	($6C94).w
	moveq	#$0,d4
	move.b	d0,d4
	move.w	d4,d1
	mulu.w	d1,d1
	move.w	#$3FFF,d0
	sub.w	d1,d0
	jsr	($6BD6).w
	move.w	d0,d5
	ext.w	d7
	moveq	#$4,d0
	jsr	($6C94).w
	mulu.w	d7,d4
	mulu.w	d7,d5
	asr.w	#$7,d4
	asr.w	#$7,d5
	btst	#$0,d0
	beq.s	loc_14B78
	neg.w	d4
loc_14B78:
	btst	#$1,d0
	beq.s	loc_14B80
	neg.w	d5
loc_14B80:
	add.b	($FFFFD5FA).w,d4
	add.b	($FFFFD5FB).w,d5
	bra.s	loc_14B92
loc_14B8A:
	move.b	($FFFFD5FA).w,d4
	move.b	($FFFFD5FB).w,d5
loc_14B92:
	ext.w	d4
	ext.w	d5
	bsr.w	sub_14BD4
	tst.w	d0
	beq.s	loc_14BCE
	lea	($FFFFCACA).w,a0
	mulu.w	#$15,d5
	add.w	d4,d5
	move.b	($FFFFD5FC).w,(a0,d5.w)
	move.b	($FFFFD5FD).w,d0
	cmp.b	#$0,d0
	beq.s	loc_14BCE
	btst	#$0,$6(a3)
	beq.s	loc_14BC8
	addi.l	#$15,d5
	bra.s	loc_14BCA
loc_14BC8:
	addq.l	#$1,d5
loc_14BCA:
	move.b	d0,(a0,d5.w)
loc_14BCE:
	movem.l	(a7)+,d4-d5/d7
	rts

; ---------------------------------------------------------------------------
sub_14BD4:
	movem.l	d3-d7,-(a7)
	moveq	#$1,d1
	tst.b	($FFFFD5F9).w
	beq.s	loc_14C00
	subq.l	#$1,d4
	subq.l	#$1,d5
	move.w	d4,d3
	moveq	#$2,d7
loc_14BE8:
	moveq	#$2,d6
	move.w	d3,d4
loc_14BEC:
	bsr.w	sub_14C2C
	and.w	d0,d1
	addq.l	#$1,d4
	dbf	d6,loc_14BEC
	addq.l	#$1,d5
	dbf	d7,loc_14BE8
	bra.s	loc_14C24
loc_14C00:
	bsr.w	sub_14C2C
	and.w	d0,d1
	move.b	($FFFFD5FD).w,d0
	cmp.b	#$0,d0
	beq.s	loc_14C24
	btst	#$0,$6(a3)
	beq.s	loc_14C1C
	addq.l	#$1,d5
	bra.s	loc_14C1E
loc_14C1C:
	addq.l	#$1,d4
loc_14C1E:
	bsr.w	sub_14C2C
	and.w	d0,d1
loc_14C24:
	move.w	d1,d0
	movem.l	(a7)+,d3-d7
	rts

; ---------------------------------------------------------------------------
sub_14C2C:
	tst.w	d4
	bmi.s	loc_14C76
	cmp.w	#$15,d4
	bge.s	loc_14C76
	tst.w	d5
	bmi.s	loc_14C76
	cmp.w	#$15,d5
	bge.s	loc_14C76
	lea	($FFFFCACA).w,a0
	move.w	d5,d0
	mulu.w	#$15,d0
	add.w	d4,d0
	move.b	(a0,d0.w),d0
	cmp.b	#$B,d2
	bcc.s	loc_14C64
	cmp.b	#$8,d0
	beq.s	loc_14C7A
	cmp.b	#$9,d0
	beq.s	loc_14C7A
	bra.s	loc_14C76
loc_14C64:
	cmp.b	#$18,d0
	beq.s	loc_14C7A
	cmp.b	#$16,d0
	beq.s	loc_14C7A
	cmp.b	#$17,d0
	beq.s	loc_14C7A
loc_14C76:
	moveq	#$0,d0
	rts
loc_14C7A:
	moveq	#$1,d0
	rts

; ---------------------------------------------------------------------------
sub_14C7E:
	ext.w	d3
	bmi.s	loc_14C96
	cmp.w	#$10,d3
	bge.s	loc_14C96
	ext.w	d4
	bmi.s	loc_14C96
	cmp.w	#$10,d4
	bge.s	loc_14C96
	moveq	#$1,d0
	rts
loc_14C96:
	moveq	#$0,d0
	rts

; ---------------------------------------------------------------------------
sub_14C9A:
	movem.l	d3-d4,-(a7)
	bsr.s	sub_14C7E
	tst.w	d0
	bne.s	loc_14CA8
	moveq	#$0,d0
	bra.s	loc_14CC8
loc_14CA8:
	bsr.w	sub_14CCE
	tst.w	d0
	bne.s	loc_14CB4
	moveq	#$0,d0
	bra.s	loc_14CC8
loc_14CB4:
	move.w	d4,d0
	asl.w	#$4,d0
	add.w	d3,d0
	lea	($FFFFB8A4).w,a0
	move.b	(a0,d0.w),d0
	lsr.b	d5,d0
	andi.w	#$3,d0
loc_14CC8:
	movem.l	(a7)+,d3-d4
	rts

; ---------------------------------------------------------------------------
sub_14CCE:
	movem.l	d3-d5,-(a7)
	bsr.s	sub_14C7E
	tst.w	d0
	bne.s	loc_14CDC
	moveq	#$0,d0
	bra.s	loc_14D06
loc_14CDC:
	move.w	d4,d0
	mulu.w	#$10,d0
	add.w	d3,d0
	lea	($FFFFB5A4).w,a0
	btst	#$2,d5
	beq.s	loc_14CF2
	lea	($FFFFB6A4).w,a0
loc_14CF2:
	move.b	(a0,d0.w),d0
	asl.w	#$1,d5
	andi.w	#$7,d5
	bchg	#$2,d5
	lsr.b	d5,d0
	andi.w	#$F,d0
loc_14D06:
	movem.l	(a7)+,d3-d5
	rts
	binclude	"data/014D0C.bin"

; ---------------------------------------------------------------------------
sub_14D60:
	jsr	(sub_862A).l
	jsr	(sub_8A6E).l
	jsr	(sub_8A76).l
	move.l	#$7B000003,(a4)
	move.w	#$BF,d1
	move.l	#$7740774,d0
loc_14D82:
	move.l	d0,(a5)
	dbf	d1,loc_14D82
	moveq	#$8,d0
	jsr	(sub_8A90).l
	move.w	#$9100,(a4)
	move.w	#$9296,(a4)
	move.l	#$10017,($FFFFD5DA).w
	move.l	#$26001A,($FFFFD5DE).w
	move.l	#$40017,($FFFFD582).w
	move.l	#$26001A,($FFFFD586).w
	move.l	#$14000B0,($FFFFB3FC).w
	move.l	#$1F801F8,($FFFFB400).w
	clr.l	($FFFFB3F8).w
	clr.b	($FFFFB525).w
	moveq	#$1,d5
	jsr	(sub_A71E).l
	jsr	(sub_82AC).l
	jsr	(sub_8360).l
	moveq	#-$1,d0
	move.l	d0,($FFFFB40C).w
	move.b	($FFFFB4CA).w,d0
	jsr	(sub_976C).l
	rts

; ---------------------------------------------------------------------------
sub_14DF6:
	link	a6,#-$4
	movem.l	d2-d7/a2-a3,-(a7)
	moveq	#$0,d7
	lea	($FFFFC470).w,a3
	move.w	($FFFFBA64).w,d0
	subq.w	#$1,d0
	bmi.w	loc_14EFC
loc_14E0E:
	move.b	(a3),d1
	beq.s	loc_14E36
	andi.b	#$C0,d1
	bne.s	loc_14E36
	btst	#$0,$1(a3)
	beq.s	loc_14E30
	btst	#$6,$1(a3)
	bne.s	loc_14E30
	bclr	#$7,$1(a3)
	bra.s	loc_14E36
loc_14E30:
	bset	#$7,$1(a3)
loc_14E36:
	adda.w	#$1A,a3
	dbf	d0,loc_14E0E
	lea	($FFFFBA68).w,a2
	lea	($FFFFC470).w,a3
	moveq	#$0,d6
loc_14E48:
	move.b	(a3),d1
	beq.w	loc_14EEA
	andi.b	#$C0,d1
	bne.w	loc_14EEA
	btst	#$0,$1(a3)
	beq.w	loc_14EEA
	btst	#$6,$1(a3)
	bne.w	loc_14EEA
	moveq	#$0,d4
	moveq	#$0,d5
loc_14E6E:
	move.w	d5,d0
	jsr	($6F02).w
	move.b	(a0),d1
	beq.w	loc_14EE2
	andi.b	#$C0,d1
	move.b	$2(a0),d0
	jsr	($6F14).w
	move.b	$23(a1),d0
	cmp.b	#$2,d0
	bcc.w	loc_14EE2
	move.b	$1(a0),d1
	andi.b	#$C1,d1
	cmp.b	#$C1,d1
	bne.s	loc_14EE2
	move.w	d5,d0
	moveq	#$3,d1
	jsr	($69C8).w
	tst.b	d0
	bne.s	loc_14EE2
	moveq	#$2,d0
	moveq	#$2,d1
	moveq	#$0,d2
	movea.l	a2,a0
	jsr	($4F20).w
	cmp.b	#$2,d0
	bcs.s	loc_14EE2
	move.w	d5,d0
	jsr	($6F02).w
	bclr	#$7,$1(a0)
	tst.b	d7
	bne.s	loc_14ED4
	st	d7
	bsr.w	sub_14F12
loc_14ED4:
	tst.b	d4
	bne.s	loc_14EDE
	st	d4
	bsr.w	loc_14F60
loc_14EDE:
	bsr.w	sub_14FBC
loc_14EE2:
	addq.l	#$1,d5
	cmp.w	($FFFFBA64).w,d5
	bne.s	loc_14E6E
loc_14EEA:
	adda.w	#$1A,a3
	adda.w	#$D6,a2
	addq.l	#$1,d6
	cmp.w	($FFFFBA64).w,d6
	bne.w	loc_14E48
loc_14EFC:
	tst.b	d7
	beq.s	loc_14F0A
	bsr.w	sub_14246
	jsr	(sub_85D6).l
loc_14F0A:
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_14F12:
	jsr	(sub_862A).l
	move.l	d5,-(a7)
	moveq	#$0,d5
	jsr	(sub_A71E).l
	move.l	(a7)+,d5
	jsr	(sub_8A76).l
	moveq	#$0,d0
	jsr	(sub_8A90).l
	jsr	(sub_B0DA).l
	jsr	(sub_860E).l

; ---------------------------------------------------------------------------
sub_14F3E:
	move.l	#$4,($FFFFD5D6).w
	move.w	#$E000,($FFFFD5AC).w
	st	($FFFFD5E2).w
	move.w	#$85,d0
	bsr.w	sub_11C8E
	move.w	#$2,-$4(a6)
	rts
loc_14F60:
	move.w	-$4(a6),d3
	addq.w	#$4,d3
	cmp.w	#$18,d3
	bcs.s	loc_14F80
	bsr.w	sub_14246
	jsr	(sub_8A44).l
	jsr	(sub_C8FC).l
	bsr.s	sub_14F3E
	bra.s	loc_14F60
loc_14F80:
	move.w	#$5,-$2(a6)
	move.w	d3,($FFFFD5D8).w
	move.w	#$3,($FFFFD5D6).w
	lea	(a2),a0
	move.w	#$C000,($FFFFD5AC).w
	bsr.w	sub_11CA4
	addq.w	#$1,($FFFFD5D6).w
	move.w	#$86,d0
	bsr.w	sub_11C8E
	move.l	d6,d0
	moveq	#$3,d2
	addq.l	#$1,d3
	jsr	(sub_AB00).l
	addq.w	#$1,d3
	move.w	d3,-$4(a6)
	rts

; ---------------------------------------------------------------------------
sub_14FBC:
	move.w	-$2(a6),d2
	move.w	-$4(a6),d3
	addq.w	#$4,d2
	cmp.w	#$24,d2
	bcc.s	loc_14FE8
	move.w	d2,-$2(a6)
	move.w	d5,d0
	jsr	($6F02).w
	move.b	$2(a0),d0
	bset	#$7,d0
	st	($FFFFB523).w
	jsr	(sub_A85A).l
loc_14FE8:
	rts

; ---------------------------------------------------------------------------
sub_14FEA:
	moveq	#$2,d0
	moveq	#$12,d1
	jsr	(sub_92AA).l
	move.l	a0,($FFFFB422).w
	move.w	$2(a0),d0
	asl.w	#$3,d0
	addi.w	#$EC00,d0
	jsr	(sub_8288).l
	moveq	#$1,d0
	move.w	d0,(a5)
	move.w	$2(a0),d1
	addi.w	#$A01,d1
	move.w	d1,(a5)
	move.w	(a0),(a5)
	move.w	d0,(a5)
	move.w	d0,(a5)
	move.w	$4(a0),d1
	addi.w	#$A00,d1
	move.w	d1,(a5)
	move.w	(a0),d1
	addi.w	#$9,d1
	move.w	d1,(a5)
	move.w	d0,(a5)
	move.l	#$6C020003,(a4)
	move.w	$2(a0),(a5)
	rts

; ---------------------------------------------------------------------------
sub_1503C:
	move.l	d7,-(a7)
	move.b	($FFFF9BBC).w,($FFFF9BBD).w
	move.b	#$2,($FFFF9BBC).w
	clr.b	($FFFFD509).w
	clr.b	($FFFFD50E).w
	clr.b	($FFFFD50A).w
	move.b	($FFFF9DB6).w,($FFFFD4FE).w
	tst.b	($FFFFD8CC).w
	beq.s	loc_15068
	move.b	#$1,($FFFFD4FE).w
loc_15068:
	tst.b	($FFFFD4FE).w
	beq.s	loc_15074
	tst.b	($FFFFD8CC).w
	beq.s	loc_15082
loc_15074:
	move.b	(dat_146FA).l,d0
	move.b	(dat_146FF).l,d1
	bra.s	loc_15096
loc_15082:
	lea	(dat_146F6).l,a0
	moveq	#$0,d1
	move.b	($FFFF9AFA).w,d1
	move.b	(a0,d1.w),d0
	move.b	$5(a0,d1.w),d1
loc_15096:
	move.b	d0,($FFFFD8D0).w
	move.b	d1,($FFFFD8D1).w
	jsr	(sub_82AC).l
	move.w	($FFFFB52A).w,d0
	cmp.w	#$6,d0
	bne.s	loc_150BE
	jsr	(sub_B100).l
	move.b	($FFFF9AFB).w,($FFFFB4CA).w
	bra.w	loc_1510E
loc_150BE:
	moveq	#$0,d2
	cmp.w	#$4,d0
	bne.s	loc_150E8
	move.b	($FFFF97AD).w,d2
	jsr	(sub_149BA).l
	move.l	#$31F5,($FFFFD810).w
	move.l	#$325A,($FFFFD814).w
	move.b	#$E,($FFFFB4CA).w
	bra.s	loc_1510E
loc_150E8:
	move.b	($FFFF97AD).w,d2
	addi.l	#$B,d2
	jsr	(sub_149BA).l
	move.l	#$31CB,($FFFFD810).w
	move.l	#$3231,($FFFFD814).w
	move.b	#$F,($FFFFB4CA).w
loc_1510E:
	tst.b	($FFFFBA5B).w
	beq.s	loc_15130
	lea	($FFFFC470).w,a0
	moveq	#$0,d0
loc_1511A:
	cmp.b	($FFFF9DA7).w,d0
	beq.s	loc_15124
	bset	#$6,(a0)
loc_15124:
	adda.w	#$1A,a0
	addq.w	#$1,d0
	cmp.w	#$8,d0
	bne.s	loc_1511A
loc_15130:
	bsr.w	sub_14738
	jsr	($754C).w
	tst.b	($FFFFD8CB).w
	beq.w	loc_1524A
	tst.b	($FFFFD8CA).w
	beq.w	loc_1524A
	bsr.w	sub_14254
	st	($FFFFD509).w
	st	($FFFFD50E).w
	clr.b	($FFFFD50C).w
	move.b	#$3,($FFFFD50D).w
	clr.b	($FFFF9E29).w
	tst.l	($FFFFD57E).w
	beq.s	loc_1518E
	lea	(dat_15174).l,a0
	jsr	(sub_132A6).l
dat_15174:
	binclude	"data/015174.bin"
loc_1518E:
	move.b	#$37,d0
	jsr	(sub_1B900).l
	jsr	(sub_85D6).l
	clr.w	($FFFFB52A).w
	jsr	(sub_8360).l
	moveq	#$0,d0
	jsr	(sub_982A).l
	bsr.w	sub_14DF6
	bsr.w	sub_14D60
	lea	(dat_1524E).l,a0
	jsr	(sub_A768).l
	moveq	#$7,d7
	lea	($FFFFC470).w,a0
loc_151CA:
	move.b	(a0),d0
	beq.s	loc_1520E
	andi.b	#$C0,d0
	bne.s	loc_1520E
	btst	#$0,$1(a0)
	beq.s	loc_1520E
	moveq	#$0,d0
	move.b	$12(a0),d0
	mulu.w	#$18,d0
	move.w	d0,($FFFFB3EC).w
	moveq	#$0,d0
	move.b	$13(a0),d0
	mulu.w	#$18,d0
	move.w	d0,($FFFFB3EE).w
	clr.l	($FFFFB414).w
	clr.l	($FFFFB408).w
	moveq	#$1,d7
	bsr.w	sub_FF7C
	jsr	(sub_860E).l
	bra.s	loc_15216
loc_1520E:
	adda.w	#$1A,a0
	dbf	d7,loc_151CA
loc_15216:
	clr.l	($FFFFB414).w
	clr.l	($FFFFB408).w
	clr.l	($FFFFB3EC).w
	clr.l	($FFFFB3F0).w
	moveq	#$5F,d0
	lea	($FFFFD49C).w,a0
loc_1522C:
	clr.b	(a0)+
	dbf	d0,loc_1522C
	moveq	#$3F,d7
	lea	($FFFF78CE).l,a0
loc_1523A:
	clr.l	(a0)+
	dbf	d7,loc_1523A
	bsr.w	sub_14FEA
	jsr	(sub_B834).l
loc_1524A:
	move.l	(a7)+,d7
	rts
dat_1524E:
	binclude	"data/01524E.bin"

; ---------------------------------------------------------------------------
sub_15268:
	link	a6,#-$44
	movem.l	d6-d7/a2-a3,-(a7)
	lea	(dat_1530C).l,a0
	bsr.w	sub_15872
	lea	(dat_1531C).l,a0
	bsr.w	sub_15872
	lea	(dat_1532C).l,a0
	bsr.w	sub_15872
	movea.l	($FFFFB57A).w,a2
	movea.l	($FFFFB57E).w,a3
	move.w	$6(a2),d0
	move.w	d0,-$4(a6)
	move.w	d0,-$6(a6)
	move.l	$2(a2),-$A(a6)
	moveq	#$0,d0
	move.w	(a2),d0
	move.l	d0,-$12(a6)
	move.w	(a3),d0
	move.l	d0,-$16(a6)
	move.w	#$6,-$18(a6)
	move.l	$8(a2),-$1C(a6)
	move.l	#$15342,-$20(a6)
	move.l	#$1533B,-$24(a6)
	clr.w	-$2(a6)
	moveq	#$7,d7
loc_152D8:
	move.l	$2(a3),-$E(a6)
	moveq	#$7,d6
loc_152E0:
	bsr.w	sub_1534A
	moveq	#$42,d0
	add.l	d0,-$E(a6)
	dbf	d6,loc_152E0
	moveq	#$3A,d0
	add.l	d0,-$A(a6)
	dbf	d7,loc_152D8
	move.w	-$6(a6),$6(a2)
	move.l	-$1C(a6),$8(a2)
	movem.l	(a7)+,d6-d7/a2-a3
	unlk	a6
	rts
dat_1530C:
	binclude	"data/01530C.bin"
dat_1531C:
	binclude	"data/01531C.bin"
dat_1532C:
	binclude	"data/01532C.bin"

; ---------------------------------------------------------------------------
sub_1534A:
	movem.l	d2-d7/a2-a3,-(a7)
	movea.l	-$1C(a6),a1
	move.w	-$18(a6),d7
	move.w	-$2(a6),d6
	movea.l	-$20(a6),a2
	movea.l	-$24(a6),a3
loc_15362:
	move.b	(a2)+,d2
	ext.w	d2
	move.b	(a3)+,d3
	ext.w	d3
	smi	d5
	bpl.s	loc_15370
	neg.w	d3
loc_15370:
	movea.l	-$A(a6),a0
	move.w	(a0,d2.w),d2
	andi.w	#$7FF,d2
	movea.l	-$E(a6),a0
	move.w	(a0,d3.w),d3
	andi.w	#$7FF,d3
	tst.b	d5
	beq.s	loc_1538E
	exg	d2,d3
loc_1538E:
	lea	($FFFFA0F6).w,a0
	move.w	d6,d5
	bra.s	loc_153A6
loc_15396:
	movem.w	(a0)+,d0-d1/d4
	cmp.w	d0,d2
	bne.s	loc_153A6
	cmp.w	d1,d3
	bne.s	loc_153A6
	bra.w	loc_15402
loc_153A6:
	dbf	d5,loc_15396
	move.w	-$6(a6),d4
	addq.w	#$1,-$6(a6)
	addq.w	#$1,d6
	movem.w	d2-d4,(a0)
	move.w	d2,d0
	asl.w	#$5,d0
	jsr	(sub_829C).l
	lea	-$44(a6),a0
	moveq	#$7,d0
loc_153C8:
	move.l	(a5),(a0)+
	dbf	d0,loc_153C8
	move.w	d3,d0
	asl.w	#$5,d0
	jsr	(sub_829C).l
	lea	-$44(a6),a0
	moveq	#$7,d5
loc_153DE:
	move.l	(a0),d0
	move.l	(a5),d1
	bsr.w	sub_1541A
	move.l	d0,(a0)+
	dbf	d5,loc_153DE
	move.w	d4,d0
	asl.w	#$5,d0
	jsr	(sub_8288).l
	lea	-$44(a6),a0
	moveq	#$7,d0
loc_153FC:
	move.l	(a0)+,(a5)
	dbf	d0,loc_153FC
loc_15402:
	ori.w	#$4000,d4
	move.w	d4,(a1)+
	dbf	d7,loc_15362
	move.l	a1,-$1C(a6)
	move.w	d6,-$2(a6)
	movem.l	(a7)+,d2-d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_1541A:
	move.l	d4,-(a7)
	moveq	#$F,d4
	moveq	#$7,d3
loc_15420:
	move.l	d0,d2
	and.l	d4,d2
	bne.s	loc_1542C
	move.l	d1,d2
	and.l	d4,d2
	or.l	d2,d0
loc_1542C:
	asl.l	#$4,d4
	dbf	d3,loc_15420
	move.l	(a7)+,d4
	rts

; ---------------------------------------------------------------------------
sub_15436:
	link	a6,#-$632
	movem.l	d7/a2-a3,-(a7)
	lea	(dat_15570).l,a0
	bsr.w	sub_15872
	movea.l	($FFFFB576).w,a2
	move.w	$6(a2),d7
	ori.w	#$4000,d7
	addq.w	#$6,$6(a2)
	movea.l	$2(a2),a0
	lea	(dat_1553A).l,a1
	lea	(dat_1555E).l,a3
	moveq	#$11,d1
loc_1546A:
	move.w	(a1)+,d0
	tst.b	(a3)+
	beq.s	loc_1547C
	bsr.w	sub_155A0
	move.w	d7,$24(a0,d0.w)
	addq.w	#$1,d7
	bra.s	loc_15480
loc_1547C:
	move.w	(a0),$24(a0,d0.w)
loc_15480:
	addq.w	#$2,a0
	dbf	d1,loc_1546A
	addi.l	#$24,$8(a2)
	move.w	$6(a2),-$2(a6)
	move.l	$8(a2),-$6(a6)
	lea	(dat_15580).l,a0
	bsr.w	sub_15872
	move.l	d0,-$E(a6)
	moveq	#$11,d7
	movea.l	($FFFFB576).w,a2
	movea.l	$2(a2),a0
	movea.l	($FFFFD8D2).w,a3
	moveq	#-$1,d0
	move.w	(a3),d0
	movea.l	$2(a3),a3
	bsr.w	sub_15798
	movea.l	$2(a2),a0
	adda.w	#$12,a0
	bsr.w	sub_15798
	movea.l	($FFFFB576).w,a2
	move.w	-$2(a6),$6(a2)
	move.l	-$6(a6),$8(a2)
	lea	(dat_15590).l,a0
	bsr.w	sub_15872
	move.l	d0,-$E(a6)
	moveq	#$1D,d7
	movea.l	$2(a2),a0
	movea.l	($FFFFD8D6).w,a3
	moveq	#-$1,d0
	move.w	(a3),d0
	movea.l	$2(a3),a3
	bsr.w	sub_15798
	movea.l	$2(a2),a0
	adda.w	#$12,a0
	bsr.w	sub_15798
	move.w	-$2(a6),d0
	move.l	-$E(a6),d1
	movea.l	-$6(a6),a0
	movea.l	($FFFFD8D6).w,a1
	movea.l	($FFFFB576).w,a2
	bsr.w	sub_15686
	move.w	d0,$6(a2)
	move.l	a0,$8(a2)
	bsr.w	sub_15612
	movem.l	(a7)+,d7/a2-a3
	unlk	a6
	rts
dat_1553A:
	binclude	"data/01553A.bin"
dat_1555E:
	binclude	"data/01555E.bin"
dat_15570:
	binclude	"data/015570.bin"
dat_15580:
	binclude	"data/015580.bin"
dat_15590:
	binclude	"data/015590.bin"

; ---------------------------------------------------------------------------
sub_155A0:
	link	a6,#-$20
	movem.l	d0-d7/a0,-(a7)
	cmp.w	#$8,d1
	bhi.s	loc_155B4
	move.w	-$12(a0),d4
	bra.s	loc_155B8
loc_155B4:
	move.w	$12(a0),d4
loc_155B8:
	asl.w	#$5,d4
	move.w	(a0),d0
	asl.w	#$5,d0
	jsr	(sub_829C).l
	moveq	#-$1,d5
	moveq	#$7,d6
	lea	-$20(a6),a0
loc_155CC:
	move.l	(a5),d0
	and.l	d5,d0
	move.l	d0,(a0)+
	lsr.l	#$4,d5
	dbf	d6,loc_155CC
	move.w	d4,d0
	jsr	(sub_829C).l
	moveq	#$7,d6
	lea	-$20(a6),a0
loc_155E6:
	move.l	(a0),d0
	move.l	(a5),d1
	bsr.w	sub_1541A
	move.l	d0,(a0)+
	dbf	d6,loc_155E6
	asl.w	#$5,d7
	move.w	d7,d0
	jsr	(sub_8288).l
	lea	-$20(a6),a0
	moveq	#$7,d6
loc_15604:
	move.l	(a0)+,(a5)
	dbf	d6,loc_15604
	movem.l	(a7)+,d0-d7/a0
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_15612:
	movem.l	d7/a3,-(a7)
	lea	(dat_1563E).l,a0
	movea.l	$8(a2),a1
	movea.l	$2(a2),a3
	moveq	#$23,d7
loc_15626:
	move.w	(a0)+,d0
	move.w	(a3,d0.w),d0
	move.w	d0,(a1)+
	dbf	d7,loc_15626
	moveq	#$48,d0
	add.l	d0,$8(a2)
	movem.l	(a7)+,d7/a3
	rts
dat_1563E:
	binclude	"data/01563E.bin"

; ---------------------------------------------------------------------------
sub_15686:
	link	a6,#-$32
	movem.l	d2-d3/d7/a3,-(a7)
	move.l	a1,-$28(a6)
	move.l	a0,-$24(a6)
	move.l	d1,-$2C(a6)
	move.w	d0,d2
	move.w	#$48,-$2E(a6)
loc_156A2:
	move.w	#$2D0,-$30(a6)
	clr.w	-$32(a6)
loc_156AC:
	lea	(dat_1578E).l,a3
	moveq	#$0,d3
loc_156B4:
	move.b	(a3)+,d0
	beq.s	loc_156D4
	bmi.s	loc_156C4
	movea.l	$2(a2),a0
	adda.w	-$2E(a6),a0
	bra.s	loc_156CC
loc_156C4:
	movea.l	$2(a2),a0
	adda.w	-$30(a6),a0
loc_156CC:
	move.w	(a0,d3.w),d0
	bra.w	loc_1573A
loc_156D4:
	movea.l	$2(a2),a0
	adda.w	-$2E(a6),a0
	move.w	(a0,d3.w),d0
	asl.w	#$5,d0
	jsr	(sub_829C).l
	moveq	#$7,d0
	lea	-$20(a6),a0
loc_156EE:
	move.l	(a5),(a0)+
	dbf	d0,loc_156EE
	movea.l	-$28(a6),a0
	movea.l	$2(a0),a0
	adda.w	-$32(a6),a0
	move.w	(a0,d3.w),d0
	asl.w	#$5,d0
	movea.l	-$2C(a6),a0
	adda.w	d0,a0
	move.w	d2,d0
	asl.w	#$5,d0
	jsr	(sub_8288).l
	lea	-$20(a6),a1
	moveq	#$7,d7
loc_1571C:
	move.l	(a0)+,d0
	move.l	(a1)+,d1
	movem.l	d2-d3,-(a7)
	bsr.w	sub_1541A
	movem.l	(a7)+,d2-d3
	move.l	d0,(a5)
	dbf	d7,loc_1571C
	move.w	d2,d0
	ori.w	#$4000,d0
	addq.w	#$1,d2
loc_1573A:
	movea.l	-$24(a6),a0
	move.w	d0,(a0)+
	move.l	a0,-$24(a6)
	addq.w	#$2,d3
	cmp.w	#$12,d3
	bne.w	loc_156B4
	move.w	#$B4,-$32(a6)
	move.w	-$30(a6),d0
	addi.w	#$B4,d0
	cmp.w	#$384,d0
	bhi.s	loc_1576A
	move.w	d0,-$30(a6)
	bra.w	loc_156AC
loc_1576A:
	move.w	-$2E(a6),d0
	addi.w	#$6C,d0
	cmp.w	#$B4,d0
	bhi.s	loc_15780
	move.w	d0,-$2E(a6)
	bra.w	loc_156A2
loc_15780:
	move.w	d2,d0
	movea.l	-$24(a6),a0
	movem.l	(a7)+,d2-d3/d7/a3
	unlk	a6
	rts
dat_1578E:
	binclude	"data/01578E.bin"

; ---------------------------------------------------------------------------
sub_15798:
	movem.l	d2-d7/a2-a3,-(a7)
	move.l	a0,-$A(a6)
	clr.w	-$32(a6)
loc_157A4:
	moveq	#$8,d6
	movea.l	-$A(a6),a2
loc_157AA:
	move.w	(a2)+,d2
	move.w	(a3)+,d3
	move.w	d3,-$30(a6)
	andi.w	#$7FF,d2
	andi.w	#$7FF,d3
	lea	-$632(a6),a0
	move.w	-$32(a6),d5
	subq.w	#$1,d5
	bmi.s	loc_157DE
loc_157C6:
	movem.w	(a0)+,d0-d1/d4
	cmp.w	d1,d3
	bne.s	loc_157DA
	tst.w	d0
	bmi.w	loc_1584C
	cmp.w	d0,d2
	beq.w	loc_1584C
loc_157DA:
	dbf	d5,loc_157C6
loc_157DE:
	movea.l	-$E(a6),a1
	move.w	d3,d0
	asl.w	#$5,d0
	adda.w	d0,a1
	moveq	#$1F,d5
loc_157EA:
	move.b	(a1)+,d0
	move.b	d0,d1
	andi.b	#$F,d0
	beq.s	loc_15800
	andi.b	#$F0,d1
	beq.s	loc_15800
	dbf	d5,loc_157EA
	moveq	#-$1,d2
loc_15800:
	move.w	-$2(a6),d4
	addq.w	#$1,-$2(a6)
	movem.w	d2-d4,(a0)
	addq.w	#$1,-$32(a6)
	move.w	d2,d0
	asl.w	#$5,d0
	jsr	(sub_829C).l
	lea	-$2E(a6),a0
	moveq	#$7,d0
loc_15820:
	move.l	(a5),(a0)+
	dbf	d0,loc_15820
	move.w	d4,d0
	asl.w	#$5,d0
	jsr	(sub_8288).l
	movea.l	-$E(a6),a0
	asl.w	#$5,d3
	adda.w	d3,a0
	lea	-$2E(a6),a1
	moveq	#$7,d5
loc_1583E:
	move.l	(a0)+,d0
	move.l	(a1)+,d1
	bsr.w	sub_1541A
	move.l	d0,(a5)
	dbf	d5,loc_1583E
loc_1584C:
	ori.w	#$4000,d4
	move.w	-$30(a6),d0
	andi.w	#$1800,d0
	or.w	d0,d4
	movea.l	-$6(a6),a1
	move.w	d4,(a1)+
	move.l	a1,-$6(a6)
	dbf	d6,loc_157AA
	dbf	d7,loc_157A4
	movem.l	(a7)+,d2-d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_15872:
	movem.l	d3-d4/a2-a3,-(a7)
	movea.l	a0,a2
	movea.l	(a2),a0
	movea.l	$4(a2),a3
	moveq	#$0,d3
	move.b	(a3),d3
	asl.w	#$2,d3
	movea.l	(a0,d3.w),a0
	lea	(dat_158B2).l,a3
	moveq	#$0,d3
	move.b	$E(a2),d3
	moveq	#$0,d4
	move.b	$D(a2),d4
	move.b	$C(a2),($FFFFB4CB).w
	jsr	(sub_9BB6).l
	movea.l	$8(a2),a1
	move.l	a0,(a1)
	movem.l	(a7)+,d3-d4/a2-a3
	rts
dat_158B2:
	dc.b	$00,$01,$02,$03,$04,$05,$06,$07

; ---------------------------------------------------------------------------
sub_158BA:
	move.l	d2,-(a7)
	move.b	d0,($FFFF9BBE).w
	ext.w	d0
	ext.l	d0
	divu.w	#$3,d0
	move.b	d0,($FFFFB419).w
	asl.w	#$1,d0
	lea	(dat_51836).l,a0
	adda.w	(a0,d0.w),a0
	move.l	a0,($FFFFB41A).w
	adda.w	#$10,a0
	move.l	a0,($FFFFB41E).w
	moveq	#$0,d2
	move.b	($FFFF9BD4).w,d2
	jsr	($5734).w
	move.l	(a7)+,d2
	rts

; ---------------------------------------------------------------------------
sub_158F2:
	movem.l	d2-d5/a2-a3,-(a7)
	moveq	#$0,d5
	bsr.w	sub_1343E
	lea	($FFFFD499).w,a3
	clr.b	(a3)
	clr.b	$1(a3)
	moveq	#$0,d4
	lea	($FFFFC470).w,a2
loc_1590C:
	move.b	(a2),d0
	beq.w	loc_1598E
	andi.b	#$C0,d0
	bne.w	loc_1598E
	move.b	$1(a2),d3
	andi.w	#$1,d3
	tst.b	(a3,d3.w)
	bne.w	loc_1598E
	moveq	#$1F,d0
	lea	($FFFFD49C).w,a0
loc_15930:
	cmpi.b	#$E,$1(a0)
	beq.s	loc_15940
	cmpi.b	#$D,$1(a0)
	bne.s	loc_15944
loc_15940:
	cmp.b	(a0),d4
	beq.s	loc_1598E
loc_15944:
	addq.w	#$3,a0
	dbf	d0,loc_15930
	move.b	$2(a2),d0
	jsr	($6F14).w
	movea.l	a1,a0
	moveq	#$2,d0
	moveq	#$2,d1
	moveq	#$0,d2
	jsr	($4F20).w
	cmp.w	#$2,d0
	bcs.s	loc_1598E
	move.b	#$1,(a3,d3.w)
	move.w	#$2,($FFFFD5D6).w
	move.b	d4,($FFFFCA20).w
	bsr.w	sub_11C5A
	moveq	#$6E,d0
	bsr.w	sub_11C8E
	move.l	#$B1,d0
	bsr.w	sub_11C8E
	addq.w	#$1,($FFFFD5D8).w
	moveq	#$1,d5
loc_1598E:
	adda.w	#$1A,a2
	addq.w	#$1,d4
	cmp.w	($FFFFBA64).w,d4
	bne.w	loc_1590C
	tst.w	d5
	beq.s	loc_159AC
	jsr	($75F8).w
	jsr	($75F8).w
	bsr.w	sub_1343E
loc_159AC:
	movem.l	(a7)+,d2-d5/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_159B2:
	tst.w	d0
	bgt.s	loc_159BC
	bmi.s	loc_159C0
	moveq	#$0,d0
	rts
loc_159BC:
	moveq	#$1,d0
	rts
loc_159C0:
	moveq	#-$1,d0
	rts

; ---------------------------------------------------------------------------
sub_159C4:
	movem.l	d2-d3/d7/a2-a3,-(a7)
	moveq	#$0,d7
	move.b	($FFFFD506).w,d7
	subq.b	#$1,d7
	ble.s	loc_15A0A
	moveq	#$0,d2
	lea	($FFFFCA22).w,a2
loc_159D8:
	move.w	d2,d3
	addq.w	#$1,d3
	movea.l	a2,a3
	addq.l	#$3,a3
loc_159E0:
	move.b	$1(a2),d0
	cmp.b	$1(a3),d0
	bcs.s	loc_159FA
	moveq	#$2,d1
	movea.l	a2,a0
	movea.l	a3,a1
loc_159F0:
	move.b	(a0),d0
	move.b	(a1),(a0)+
	move.b	d0,(a1)+
	dbf	d1,loc_159F0
loc_159FA:
	addq.l	#$3,a3
	addq.w	#$1,d3
	cmp.w	d7,d3
	bls.s	loc_159E0
	addq.l	#$3,a2
	addq.w	#$1,d2
	cmp.w	d7,d2
	bcs.s	loc_159D8
loc_15A0A:
	movem.l	(a7)+,d2-d3/d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_15A10:
	move.l	(a0),$E(a0)
	move.w	$4(a0),d0
	sub.w	(a0),d0
	move.w	d0,d1
	bpl.s	loc_15A20
	neg.w	d1
loc_15A20:
	move.w	d1,$A(a0)
	bsr.s	sub_159B2
	move.w	d0,$12(a0)
	move.w	$6(a0),d0
	sub.w	$2(a0),d0
	move.w	d0,d1
	bpl.s	loc_15A38
	neg.w	d1
loc_15A38:
	move.w	d1,$C(a0)
	bsr.w	sub_159B2
	move.w	d0,$14(a0)
	clr.w	$8(a0)
	clr.b	$16(a0)
	rts

; ---------------------------------------------------------------------------
sub_15A4E:
	movem.l	d6-d7,-(a7)
	moveq	#$1,d6
	moveq	#$1,d7
	move.w	$A(a0),d0
	cmp.w	$C(a0),d0
	bcs.w	loc_15ABA
	move.w	$E(a0),d0
	cmp.w	$4(a0),d0
	beq.w	loc_15B10
	add.w	$12(a0),d0
	move.w	d0,$E(a0)
	move.w	$12(a0),d6
	addq.w	#$1,d6
	move.w	$8(a0),d0
	add.w	$C(a0),d0
	add.w	$C(a0),d0
	addq.b	#$2,$16(a0)
	cmp.w	$A(a0),d0
	blt.s	loc_15AB0
	sub.w	$A(a0),d0
	sub.w	$A(a0),d0
	move.w	$10(a0),d1
	add.w	$14(a0),d1
	move.w	d1,$10(a0)
	move.w	$14(a0),d7
	addq.w	#$1,d7
	addq.b	#$1,$16(a0)
loc_15AB0:
	move.w	d0,$8(a0)
	moveq	#$1,d0
	bra.w	loc_15B12
loc_15ABA:
	move.w	$10(a0),d0
	cmp.w	$6(a0),d0
	beq.w	loc_15B10
	add.w	$14(a0),d0
	move.w	d0,$10(a0)
	move.w	$14(a0),d7
	addq.w	#$1,d7
	move.w	$8(a0),d0
	add.w	$A(a0),d0
	add.w	$A(a0),d0
	addq.b	#$2,$16(a0)
	cmp.w	$C(a0),d0
	blt.s	loc_15B08
	sub.w	$C(a0),d0
	sub.w	$C(a0),d0
	move.w	$E(a0),d1
	add.w	$12(a0),d1
	move.w	d1,$E(a0)
	move.w	$12(a0),d6
	addq.w	#$1,d6
	addq.b	#$1,$16(a0)
loc_15B08:
	move.w	d0,$8(a0)
	moveq	#$1,d0
	bra.s	loc_15B12
loc_15B10:
	moveq	#$0,d0
loc_15B12:
	mulu.w	#$3,d7
	add.w	d6,d7
	lea	(dat_15B2A).l,a1
	move.b	(a1,d7.w),$17(a0)
	movem.l	(a7)+,d6-d7
	rts
dat_15B2A:
	binclude	"data/015B2A.bin"

; ---------------------------------------------------------------------------
sub_15B34:
	movem.l	d2-d3,-(a7)
	moveq	#$0,d0
	moveq	#$0,d1
	moveq	#$0,d2
	moveq	#$0,d3
	move.b	$12(a0),d0
	move.b	$13(a0),d1
	move.b	$12(a3),d2
	move.b	$13(a3),d3
	bsr.w	sub_15B5A
	movem.l	(a7)+,d2-d3
	rts

; ---------------------------------------------------------------------------
sub_15B5A:
	link	a6,#-$18
	movem.l	d4-d7/a2,-(a7)
	clr.b	($FFFFD501).w
	clr.b	($FFFFD502).w
	clr.b	($FFFFD503).w
	moveq	#$2,d7
	move.w	d4,d5
	asl.w	#$1,d5
	addq.w	#$1,d5
	lea	-$18(a6),a2
	movem.w	d0-d3,(a2)
	movea.l	a2,a0
	bsr.w	sub_15A10
loc_15B84:
	lea	($FFFFCACA).w,a0
	move.w	$10(a2),d0
	mulu.w	#$15,d0
	add.w	$E(a2),d0
	move.b	(a0,d0.w),d6
	andi.w	#$7F,d6
	cmp.b	#$0,d6
	bne.s	loc_15BB0
	st	($FFFFD501).w
	tst.b	($FFFFD504).w
	bne.w	loc_15C0E
	bra.s	loc_15BD4
loc_15BB0:
	cmp.b	#$1,d6
	bne.s	loc_15BBC
	st	($FFFFD502).w
	bra.s	loc_15BD4
loc_15BBC:
	tst.w	d7
	beq.s	loc_15BC4
	subq.w	#$1,d7
	bra.s	loc_15BD4
loc_15BC4:
	move.b	d6,d0
	bsr.w	sub_144EA
	andi.b	#$80,d0
	beq.s	loc_15BD4
	st	($FFFFD503).w
loc_15BD4:
	cmp.b	$16(a2),d5
	bcs.s	loc_15C0E
	tst.b	($FFFFD4FF).w
	bne.s	loc_15BFE
	move.b	d6,d0
	bsr.w	sub_144EA
	andi.b	#$40,d0
	beq.s	loc_15BFE
	move.w	(a2),d0
	cmp.w	$4(a2),d0
	bne.s	loc_15C0E
	move.w	$2(a2),d0
	cmp.w	$6(a2),d0
	bne.s	loc_15C0E
loc_15BFE:
	movea.l	a2,a0
	bsr.w	sub_15A4E
	tst.b	d0
	bne.w	loc_15B84
	moveq	#$1,d0
	bra.s	loc_15C10
loc_15C0E:
	moveq	#$0,d0
loc_15C10:
	move.b	$16(a2),d1
	asr.b	#$1,d1
	ext.w	d1
	move.w	$E(a2),d2
	move.w	$10(a2),d3
	clr.b	($FFFFD504).w
	movem.l	(a7)+,d4-d7/a2
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_15C2C:
	link	a6,#-$8
	movem.l	a2-a3,-(a7)
	bsr.w	sub_15C74
	jsr	($6F02).w
	movea.l	a0,a2
	lea	(sub_15C88).l,a3
	bsr.w	sub_142B8
	bsr.w	sub_15C7E
	movem.l	(a7)+,a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_15C54:
	link	a6,#-$8
	movem.l	d2-d3,-(a7)
	bsr.w	sub_15C74
	move.w	d0,d2
	move.w	d1,d3
	bsr.w	sub_15C88
	bsr.w	sub_15C7E
	movem.l	(a7)+,d2-d3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_15C74:
	move.w	d2,-$2(a6)
	clr.b	($FFFFD506).w
	rts

; ---------------------------------------------------------------------------
sub_15C7E:
	bsr.w	sub_159C4
	st	($FFFFD500).w
	rts

; ---------------------------------------------------------------------------
sub_15C88:
	movem.l	d7/a2-a3,-(a7)
	movem.w	d2-d3,-$6(a6)
	lea	(sub_15CD8).l,a3
	lea	($FFFFC470).w,a2
	move.w	($FFFFBA64).w,d7
	moveq	#$0,d6
	bra.s	loc_15CCE
loc_15CA4:
	move.b	(a2),d0
	beq.s	loc_15CC8
	andi.b	#$C0,d0
	bne.s	loc_15CC8
	move.b	($FFFFD500).w,d0
	bmi.s	loc_15CC0
	move.b	$1(a2),d1
	eor.b	d0,d1
	btst	#$0,d1
	bne.s	loc_15CC8
loc_15CC0:
	move.b	d6,-$7(a6)
	bsr.w	sub_142B8
loc_15CC8:
	addq.w	#$1,d6
	adda.w	#$1A,a2
loc_15CCE:
	dbf	d7,loc_15CA4
	movem.l	(a7)+,d7/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_15CD8:
	movem.l	d2-d4/d7/a2,-(a7)
	movem.w	-$6(a6),d0-d1
	move.w	-$2(a6),d4
	bsr.w	sub_15B5A
	tst.b	d0
	beq.w	loc_15D30
	move.b	-$7(a6),d0
	moveq	#$0,d7
	move.b	($FFFFD506).w,d7
	lea	($FFFFCA22).w,a2
	bra.s	loc_15D14
loc_15D00:
	cmp.b	(a2),d0
	bne.s	loc_15D12
	cmp.b	$1(a2),d1
	bcc.w	loc_15D30
	move.b	d1,$1(a2)
	bra.s	loc_15D30
loc_15D12:
	addq.l	#$3,a2
loc_15D14:
	dbf	d7,loc_15D00
	move.b	d0,(a2)
	move.b	d1,$1(a2)
	movem.w	-$6(a6),d0-d1
	bsr.w	sub_15D36
	move.b	d0,$2(a2)
	addq.b	#$1,($FFFFD506).w
loc_15D30:
	movem.l	(a7)+,d2-d4/d7/a2
	rts

; ---------------------------------------------------------------------------
sub_15D36:
	movem.l	d2-d4,-(a7)
	sub.w	d0,d2
	sub.w	d1,d3
	move.w	d2,d0
	bpl.s	loc_15D44
	neg.w	d0
loc_15D44:
	move.w	d3,d1
	bpl.s	loc_15D4A
	neg.w	d1
loc_15D4A:
	cmp.w	d1,d0
	bcc.s	loc_15D60
	mulu.w	#$26A,d0
	asr.l	#$8,d0
	cmp.w	d1,d0
	bhi.s	loc_15D5C
	moveq	#$0,d4
	bra.s	loc_15D70
loc_15D5C:
	moveq	#$1,d4
	bra.s	loc_15D70
loc_15D60:
	mulu.w	#$26A,d1
	asr.l	#$8,d1
	cmp.w	d0,d1
	bhi.s	loc_15D6E
	moveq	#$2,d4
	bra.s	loc_15D70
loc_15D6E:
	moveq	#$1,d4
loc_15D70:
	tst.w	d3
	bmi.s	loc_15D78
	neg.w	d4
	addq.w	#$4,d4
loc_15D78:
	tst.w	d2
	bpl.s	loc_15D7E
	neg.w	d4
loc_15D7E:
	andi.w	#$7,d4
	move.w	d4,d0
	movem.l	(a7)+,d2-d4
	rts

; ---------------------------------------------------------------------------
sub_15D8A:
	link	a6,#-$10
	movem.l	d2-d7/a2-a5,-(a7)
	move.b	d0,-$2(a6)
	jsr	($6EF0).w
	move.b	$17(a3),-$10(a6)
	move.b	$1(a3),-$8(a6)
	lea	($FFFF6AF6).l,a0
	move.w	#$6D,d0
	moveq	#-$1,d1
loc_15DB2:
	move.l	d1,(a0)+
	dbf	d0,loc_15DB2
	move.b	-$2(a6),d0
	jsr	($6EF0).w
	moveq	#$0,d0
	move.b	$12(a3),d0
	move.w	d0,-$6(a6)
	move.b	$13(a3),d0
	move.w	d0,-$4(a6)
	move.b	$23(a2),d0
	cmp.b	#$2,d0
	bne.s	loc_15DE2
	st	-$E(a6)
	bra.s	loc_15DF4
loc_15DE2:
	cmp.b	#$3,d0
	bne.s	loc_15DF0
	move.b	#$1,-$E(a6)
	bra.s	loc_15DF4
loc_15DF0:
	clr.b	-$E(a6)
loc_15DF4:
	lea	($FFFF6D14).l,a4
	movea.l	a4,a5
	movem.w	-$6(a6),d2-d3
	lea	(dat_146E0).l,a1
	lea	($FFFFCACA).w,a2
	lea	($FFFF6AF6).l,a3
	bra.s	loc_15E2C
loc_15E14:
	cmpa.l	a5,a4
	beq.w	loc_15F9C
	cmpa.l	#$FFFF78CC,a4
	bne.s	loc_15E28
	lea	($FFFF6D14).l,a4
loc_15E28:
	move.b	(a4)+,d2
	move.b	(a4)+,d3
loc_15E2C:
	addq.w	#$1,-$C(a6)
	move.w	#$7,-$A(a6)
	move.w	d2,d6
	move.w	d3,d7
loc_15E3A:
	move.w	-$A(a6),d4
	move.w	-$C(a6),d0
	asr.b	#$1,d0
	bcc.s	loc_15E4C
	neg.w	d4
	sub.w	d0,d4
	bra.s	loc_15E4E
loc_15E4C:
	add.w	d0,d4
loc_15E4E:
	andi.w	#$7,d4
	move.w	d6,d2
	move.w	d7,d3
	lea	(dat_146E0).l,a1
	add.b	(a1,d4.w),d2
	cmp.b	#$15,d2
	bcc.w	loc_15F4E
	add.b	$B(a1,d4.w),d3
	cmp.b	#$15,d3
	bcc.w	loc_15F4E
	move.w	d3,d5
	mulu.w	#$15,d5
	add.w	d2,d5
	tst.b	(a3,d5.w)
	bpl.w	loc_15F4E
	move.b	($FFFFD505).w,d0
	beq.s	loc_15EC4
	cmp.b	#$1,d0
	beq.s	loc_15E92
	bra.s	loc_15E9E
loc_15E92:
	bsr.w	sub_1432E
	cmp.b	-$10(a6),d1
	bne.s	loc_15EB8
	bra.s	loc_15EF0
loc_15E9E:
	bsr.w	sub_1432E
	lea	($FFFFCA22).w,a0
	moveq	#$0,d0
	move.b	($FFFFD506).w,d0
	bra.s	loc_15EB4
loc_15EAE:
	cmp.b	(a0),d1
	beq.s	loc_15EF0
	addq.l	#$3,a0
loc_15EB4:
	dbf	d0,loc_15EAE
loc_15EB8:
	move.b	(a2,d5.w),d0
	bmi.w	loc_15F4E
	bra.w	loc_15F00
loc_15EC4:
	move.b	(a2,d5.w),d0
	bpl.w	loc_15F00
	bsr.w	sub_1432E
	move.b	d0,d1
	bmi.s	loc_15F4E
	jsr	($6F02).w
	move.b	(a0),d0
	beq.s	loc_15F4E
	andi.b	#$C0,d0
	bne.s	loc_15F4E
	move.b	$1(a0),d0
	add.b	-$8(a6),d0
	btst	#$0,d0
	beq.s	loc_15F4E
loc_15EF0:
	move.b	-$2(a6),d0
	jsr	($6F02).w
	move.b	d1,$17(a0)
	bra.w	loc_15F5A
loc_15F00:
	bsr.w	sub_144EA
	btst	#$5,d0
	bne.w	loc_15F4E
	move.b	-$E(a6),d0
	beq.s	loc_15F2A
	bmi.s	loc_15F1A
	move.b	$1(a2,d5.w),d0
	bra.s	loc_15F1E
loc_15F1A:
	move.b	$15(a2,d5.w),d0
loc_15F1E:
	bmi.s	loc_15F4E
	bsr.w	sub_144EA
	btst	#$5,d0
	bne.s	loc_15F4E
loc_15F2A:
	cmpa.l	#$FFFF78CC,a5
	bne.s	loc_15F38
	lea	($FFFF6D14).l,a5
loc_15F38:
	move.b	d4,d0
	addq.b	#$4,d0
	andi.b	#$7,d0
	move.b	d0,(a3,d5.w)
	move.b	d2,(a5)+
	move.b	d3,(a5)+
	cmpa.l	a4,a5
	beq.w	loc_15F9C
loc_15F4E:
	subq.w	#$1,-$A(a6)
	bpl.w	loc_15E3A
	bra.w	loc_15E14
loc_15F5A:
	lea	(dat_146E0).l,a1
	lea	($FFFF6AF6).l,a2
	lea	($FFFF6CE2).l,a0
	addq.b	#$4,d4
	andi.b	#$7,d4
	move.b	d4,(a0)+
	bra.s	loc_15F86
loc_15F76:
	move.w	d2,d0
	move.w	d3,d1
	mulu.w	#$15,d1
	add.w	d0,d1
	move.b	(a2,d1.w),d4
	move.b	d4,(a0)+
loc_15F86:
	cmp.w	-$6(a6),d2
	bne.s	loc_15F92
	cmp.w	-$4(a6),d3
	beq.s	loc_15FA2
loc_15F92:
	add.b	(a1,d4.w),d2
	add.b	$B(a1,d4.w),d3
	bra.s	loc_15F76
loc_15F9C:
	lea	($FFFF6CE2).l,a0
loc_15FA2:
	st	(a0)
	lea	($FFFF6CE2).l,a0
	lea	($FFFF6CB0).l,a1
	moveq	#$0,d0
loc_15FB2:
	tst.b	(a0,d0.w)
	bmi.s	loc_15FBC
	addq.w	#$1,d0
	bra.s	loc_15FB2
loc_15FBC:
	st	(a1,d0.w)
	bra.s	loc_15FCE
loc_15FC2:
	move.b	(a0)+,d1
	addq.b	#$4,d1
	andi.b	#$7,d1
	move.b	d1,(a1,d0.w)
loc_15FCE:
	dbf	d0,loc_15FC2
	movem.l	(a7)+,d2-d7/a2-a5
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_15FDA:
	link	a6,#-$4
	movem.l	d6-d7,-(a7)
	clr.b	($FFFFD8DA).w
	clr.b	($FFFFD8CC).w
	moveq	#$0,d6
	move.b	#$3,($FFFF9BBC).w
	tst.b	($FFFF9858).w
	beq.s	loc_16002
	move.b	#$1,($FFFF9927).w
	st	($FFFF9930).w
loc_16002:
	clr.b	-$1(a6)
	clr.b	-$2(a6)
	clr.b	-$3(a6)
	st	($FFFFD50B).w
	clr.b	($FFFF9DBD).w
	bsr.w	sub_16EC0
	tst.b	($FFFFBA5A).w
	bne.w	loc_160FA
	tst.b	($FFFFBA5B).w
	beq.s	loc_1605A
	move.b	($FFFF9DA7).w,d0
	jsr	($6F02).w
	move.b	(a0),d0
	bpl.s	loc_1605A
	move.b	#$80,($FFFF9DBD).w
	andi.b	#$3F,d0
	cmp.b	#$5,d0
	beq.s	loc_1604C
	move.l	#$84,d0
	bra.s	loc_16058
loc_1604C:
	moveq	#$0,d0
	move.b	($FFFF9DA7).w,d0
	bset	d0,($FFFFD8DA).w
	moveq	#$1,d0
loc_16058:
	move.b	d0,(a0)
loc_1605A:
	lea	($FFFFC470).w,a0
	moveq	#$7,d7
loc_16060:
	bclr	#$2,$1(a0)
	bclr	#$4,$1(a0)
	move.b	(a0),d0
	beq.s	loc_160AA
	bmi.s	loc_16086
	btst	#$0,$1(a0)
	beq.s	loc_16086
	st	-$1(a6)
	st	-$3(a6)
	clr.b	($FFFFD50B).w
loc_16086:
	bclr	#$6,d0
	move.b	d0,d1
	andi.b	#$F,d1
	cmp.b	#$5,d1
	bne.s	loc_160A8
	moveq	#$7,d0
	sub.l	d7,d0
	bset	d0,($FFFFD8DA).w
	st	-$2(a6)
	moveq	#$1,d0
	st	-$1(a6)
loc_160A8:
	move.b	d0,(a0)
loc_160AA:
	adda.w	#$1A,a0
	dbf	d7,loc_16060
	movem.l	d7/a2-a3,-(a7)
	moveq	#$7,d7
loc_160B8:
	move.l	d7,d0
	jsr	($6F02).w
	tst.b	(a0)
	beq.s	loc_160CA
	jsr	($6F14).w
	jsr	($6D1E).w
loc_160CA:
	dbf	d7,loc_160B8
	movem.l	(a7)+,d7/a2-a3
	tst.b	-$1(a6)
	bne.s	loc_160DC
	jmp	($7588).w
loc_160DC:
	tst.b	-$3(a6)
	bne.s	loc_160FA
	st	($FFFF9DBD).w
	lea	($FFFFC470).w,a0
	moveq	#$7,d7
loc_160EC:
	move.b	(a0),d0
	bpl.s	loc_160F2
	clr.b	(a0)
loc_160F2:
	adda.w	#$1A,a0
	dbf	d7,loc_160EC
loc_160FA:
	tst.b	($FFFFD50E).w
	beq.s	loc_16114
	jsr	(sub_CAC0).l
	lea	($FFFFB532).w,a0
	jsr	(sub_9784).l
	clr.l	($FFFFD57E).w
loc_16114:
	jsr	(sub_85D6).l
	clr.w	($FFFFB52A).w
	jsr	(sub_8360).l
	lea	($FFFFB582).w,a0
	jsr	(sub_9784).l
	move.w	#$8,($FFFFB52A).w
	jsr	(sub_8360).l
	tst.b	($FFFFBA5A).w
	bne.w	loc_1619E
	moveq	#$1,d0
	jsr	(sub_982A).l
	lea	(dat_161E4).l,a0
	jsr	(sub_A768).l
	bsr.w	sub_1621E
	bsr.w	sub_1631E
	move.w	#$33,d0
	jsr	(sub_1B900).l
	bsr.w	sub_1640C
	tst.b	($FFFF9930).w
	bmi.s	loc_16178
	tst.b	($FFFFD50E).w
	beq.s	loc_1617C
loc_16178:
	bsr.w	sub_16B96
loc_1617C:
	tst.b	($FFFFB9F3).w
	beq.s	loc_16186
	bsr.w	sub_165A0
loc_16186:
	lea	($FFFFB532).w,a0
	jsr	(sub_9784).l
	clr.l	($FFFFD57E).w
	lea	($FFFFB582).w,a0
	jsr	(sub_9784).l
loc_1619E:
	tst.b	($FFFF9930).w
	bpl.s	loc_161AC
	bsr.w	sub_16EF0
	clr.b	($FFFF9930).w
loc_161AC:
	move.b	($FFFFB9F0).w,d0
	jsr	($40D0).w
	jsr	(sub_BEF4).l
	clr.b	($FFFFB524).w
	jsr	(sub_82EC).l
	move.b	($FFFF9BBD).w,($FFFFBA5E).w
	tst.b	($FFFF9858).w
	beq.s	loc_161D6
	clr.b	($FFFF9858).w
	bra.s	loc_161DC
loc_161D6:
	jsr	(sub_AF00).l
loc_161DC:
	movem.l	(a7)+,d6-d7
	unlk	a6
	rts
dat_161E4:
	binclude	"data/0161E4.bin"

; ---------------------------------------------------------------------------
sub_1621E:
	movem.l	d3/a2-a3,-(a7)
	tst.b	($FFFF97AE).w
	bne.s	loc_16262
	moveq	#$45,d3
	lea	($FFFF6AF6).l,a3
	moveq	#$0,d0
loc_16232:
	move.w	d0,(a3)+
	dbf	d3,loc_16232
	moveq	#$0,d3
	move.b	($FFFFB9F3).w,d3
	lea	($FFFFB9F4).w,a3
	move.b	#$0,($FFFFB9F3).w
	bra.s	loc_1625E
loc_1624A:
	moveq	#$0,d0
	move.b	(a3)+,d0
	mulu.w	#$A,d0
	lea	(dat_F17CC).l,a2
	adda.w	d0,a2
	bsr.w	sub_16268
loc_1625E:
	dbf	d3,loc_1624A
loc_16262:
	movem.l	(a7)+,d3/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_16268:
	movem.l	d2-d4/a2-a3,-(a7)
loc_1626C:
	moveq	#$0,d0
	move.b	(a2),d0
	beq.w	loc_16318
	lea	(dat_A829).l,a0
	moveq	#$0,d1
	move.b	(a0,d0.w),d1
	bmi.s	loc_16294
	beq.w	loc_16318
	mulu.w	#$A,d1
	lea	(dat_F17CC).l,a2
	adda.w	d1,a2
	bra.s	loc_1626C
loc_16294:
	moveq	#$0,d4
	move.b	$4(a2),d4
	moveq	#$0,d1
	move.b	$8(a2),d1
	tst.b	($FFFFBA60).w
	bne.s	loc_162E2
	lea	($FFFF6AF6).l,a3
	moveq	#$0,d2
	move.b	($FFFFB9F3).w,d2
	bra.s	loc_162DE
loc_162B4:
	cmp.b	(a3),d0
	bne.s	loc_162DA
	cmp.b	$4(a3),d4
	bne.s	loc_162DA
	moveq	#$0,d3
	move.b	$8(a3),d3
	bmi.s	loc_162D2
	add.w	d1,d3
	cmp.w	#$64,d3
	bcs.s	loc_162D4
	moveq	#$64,d3
	bra.s	loc_162D4
loc_162D2:
	addq.l	#$1,d3
loc_162D4:
	move.b	d3,$8(a3)
	bra.s	loc_16318
loc_162DA:
	adda.w	#$A,a3
loc_162DE:
	dbf	d2,loc_162B4
loc_162E2:
	moveq	#$0,d0
	move.b	($FFFFB9F3).w,d0
	cmp.b	#$E,d0
	bcc.s	loc_16318
	tst.b	d1
	bne.s	loc_162FE
	tst.b	($FFFFBA60).w
	bne.s	loc_162FE
	move.l	#$81,d1
loc_162FE:
	bsr.w	sub_16592
	movea.l	a0,a3
	moveq	#$8,d0
loc_16306:
	move.w	(a2,d0.w),(a3,d0.w)
	subq.w	#$2,d0
	bpl.s	loc_16306
	addq.b	#$1,($FFFFB9F3).w
	move.b	d1,$8(a3)
loc_16318:
	movem.l	(a7)+,d2-d4/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_1631E:
	movem.l	d2-d7/a2-a4,-(a7)
	moveq	#$0,d6
	clr.l	($FFFFD514).w
	tst.b	($FFFF9930).w
	bpl.s	loc_1634A
	move.b	($FFFF9927).w,d0
	cmp.b	#$1,d0
	bne.s	loc_1634A
	lea	(dat_16402).l,a4
	moveq	#$0,d0
	move.b	($FFFF9924).w,d0
	lsl.w	#$1,d0
	move.w	(a4,d0.w),d6
loc_1634A:
	lea	($FFFFC470).w,a4
	moveq	#$0,d7
loc_16350:
	move.b	(a4),d0
	beq.w	loc_163D2
	move.b	d0,d1
	andi.b	#$F,d1
	cmp.w	#$8,d7
	bcc.s	loc_16378
	btst	d7,($FFFFD8DA).w
	bne.w	loc_163D2
	tst.b	d0
	bmi.w	loc_163D2
	addq.l	#$1,($FFFFD514).w
	bra.w	loc_163D2
loc_16378:
	tst.b	d0
	bpl.w	loc_163D2
	move.b	$2(a4),d0
	jsr	($6F14).w
	btst	#$0,$52(a1)
	bne.s	loc_1639A
	moveq	#$0,d0
	move.w	$40(a1),d0
	add.l	d0,d6
	st	($FFFFD50E).w
loc_1639A:
	tst.b	($FFFFBA5B).w
	bne.s	loc_163D2
	tst.b	($FFFF97AE).w
	bne.s	loc_163D2
	move.l	$1A(a1),d0
	add.l	d0,($FFFFBA34).w
	moveq	#$C,d5
	lea	$54(a1),a2
loc_163B4:
	move.b	(a2),d0
	beq.s	loc_163CA
	btst	#$6,$5(a2)
	bne.s	loc_163CA
	bclr	#$7,$5(a2)
	bsr.w	sub_16268
loc_163CA:
	adda.w	#$A,a2
	dbf	d5,loc_163B4
loc_163D2:
	adda.w	#$1A,a4
	addq.l	#$1,d7
	cmp.w	($FFFFBA64).w,d7
	bcs.w	loc_16350
	tst.b	($FFFFBA5B).w
	beq.s	loc_163EA
	move.l	d6,d0
	bra.s	loc_163F8
loc_163EA:
	moveq	#$0,d0
	move.l	($FFFFD514).w,d1
	beq.s	loc_163F8
	divu.w	d1,d6
	moveq	#$0,d0
	move.w	d6,d0
loc_163F8:
	move.l	d0,($FFFFD514).w
	movem.l	(a7)+,d2-d7/a2-a4
	rts
dat_16402:
	binclude	"data/016402.bin"

; ---------------------------------------------------------------------------
sub_1640C:
	move.l	d5,-(a7)
	tst.b	($FFFFBA60).w
	bne.w	loc_1655C
	tst.b	($FFFFD50E).w
	bne.s	loc_16436
	tst.b	($FFFFBA5B).w
	bne.s	loc_16436
	tst.l	($FFFFD514).w
	bne.s	loc_16436
	tst.l	($FFFFBA34).w
	bne.s	loc_16436
	tst.b	($FFFFB9F4).w
	beq.w	loc_1655C
loc_16436:
	jsr	(sub_862A).l
	moveq	#$0,d5
	jsr	(sub_A71E).l
	jsr	(sub_8A76).l
	jsr	(sub_8A60).l
	jsr	(sub_B0DA).l
	moveq	#$1,d0
	jsr	(sub_8A90).l
	move.l	#$50005,($FFFFD5D6).w
	move.w	#$C000,($FFFFD5AC).w
	tst.b	($FFFFD50E).w
	bne.s	loc_1647A
	tst.b	($FFFFBA5B).w
	beq.w	loc_164BA
loc_1647A:
	move.w	#$91,d0
	bsr.w	sub_11C8E
	move.b	($FFFF9DBD).w,d0
	cmp.b	#$80,d0
	bne.s	loc_16496
	move.w	#$27,d0
	bsr.w	sub_11C8E
	bra.s	loc_164A4
loc_16496:
	tst.b	($FFFFD50B).w
	beq.s	loc_164B2
	move.w	#$92,d0
	bsr.w	sub_11C8E
loc_164A4:
	clr.l	($FFFFD514).w
	clr.b	($FFFFB9F3).w
	clr.l	($FFFFBA34).w
	bra.s	loc_164BA
loc_164B2:
	move.w	#$93,d0
	bsr.w	sub_11C8E
loc_164BA:
	move.w	#$5,($FFFFD5D6).w
	addq.w	#$2,($FFFFD5D8).w
	tst.l	($FFFFD514).w
	beq.s	loc_164FE
	move.w	#$94,d0
	bsr.w	sub_11C8E
	move.l	($FFFFD514).w,d0
	move.w	#$6,($FFFFD5AA).w
	bsr.w	sub_13376
	bsr.w	sub_1368C
	bsr.w	sub_11CA0
	move.w	#$5,($FFFFD5D6).w
	addq.w	#$1,($FFFFD5D8).w
	move.w	#$95,d0
	bsr.w	sub_11C8E
	bsr.w	sub_16560
loc_164FE:
	move.w	#$5,($FFFFD5D6).w
	addq.w	#$2,($FFFFD5D8).w
	if DEUTSCH	; DEUTSCH-HOOK 11: Kampfende, Beute-Zeile mit eigenem Anfangstext (4 Byte wie Original)
	move.w	#DE_TXT_KAMPFBEUTE,d0
	else
	move.w	#$91,d0
	endif
	bsr.w	sub_11C8E
	move.w	#$96,d0
	bsr.w	sub_11C8E
	move.l	($FFFFBA34).w,d0
	bne.s	loc_16536
	tst.b	($FFFFB9F3).w
	bne.s	loc_1652C
	move.w	#$97,d0
	bsr.w	sub_11C8E
loc_1652C:
	move.w	#$98,d0
	bsr.w	sub_11C8E
	bra.s	loc_16542
loc_16536:
	add.l	d0,($FFFF9BD0).w
	bsr.w	sub_13268
	bsr.w	sub_11CA0
loc_16542:
	jsr	(sub_860E).l
	jsr	($6C54).w
	bsr.w	sub_14246
	move.w	#$C000,($FFFFD5AC).w
	jsr	(sub_85D6).l
loc_1655C:
	move.l	(a7)+,d5
	rts

; ---------------------------------------------------------------------------
sub_16560:
	move.l	d7,-(a7)
	moveq	#$7,d7
loc_16564:
	move.l	d7,d0
	jsr	($6F14).w
	jsr	($6F02).w
	move.b	(a0),d0
	andi.b	#$C0,d0
	bne.s	loc_1658A
	btst	d7,($FFFFD8DA).w
	bne.s	loc_1658A
	move.l	$1E(a1),d0
	move.l	($FFFFD514).w,d1
	add.l	d1,d0
	move.l	d0,$1E(a1)
loc_1658A:
	dbf	d7,loc_16564
	move.l	(a7)+,d7
	rts

; ---------------------------------------------------------------------------
sub_16592:
	mulu.w	#$A,d0
	lea	($FFFF6AF6).l,a0
	adda.w	d0,a0
	rts

; ---------------------------------------------------------------------------
sub_165A0:
	link	a6,#-$56
	movem.l	d2-d7/a2-a3,-(a7)
	jsr	(sub_C940).l
	move.b	($FFFF9BBC).w,-$56(a6)
	move.b	#$C,($FFFF9BBC).w
	clr.b	-$54(a6)
	bsr.w	sub_16954
	moveq	#$45,d0
	lea	(dat_16AE2).l,a1
	lea	-$52(a6),a0
loc_165CE:
	move.b	(a1)+,(a0)+
	dbf	d0,loc_165CE
	bsr.w	sub_1692A
loc_165D8:
	st	-$C(a6)
	bsr.w	sub_168FC
loc_165E0:
	bsr.w	sub_13DA2
	moveq	#$0,d7
	move.b	-$C(a6),d7
	bpl.s	loc_165F2
	bsr.w	sub_168B2
	bra.s	loc_165F6
loc_165F2:
	bsr.w	sub_16868
loc_165F6:
	lea	-$52(a6),a2
	movea.w	#$0,a3
	clr.b	($FFFFD595).w
	move.l	a6,($FFFFD59C).w
	move.l	#$169C6,($FFFFD5A0).l
	st	($FFFFD597).w
	move.b	-$54(a6),($FFFFD593).w
	bsr.w	sub_1391A
	cmp.w	#$FFFF,d0
	beq.w	loc_16798
	move.b	d0,-$54(a6)
	cmp.b	#$8,d0
	bcc.s	loc_16650
	tst.b	($FFFFD59A).w
	bne.s	loc_16650
	move.b	d0,($FFFFCA20).w
	jsr	($6F02).w
	tst.b	(a0)
	beq.s	loc_165F6
	bsr.w	sub_13DD6
	bsr.w	sub_16B28
	bsr.w	sub_16954
	bra.s	loc_165D8
loc_16650:
	cmp.w	#$8,d0
	beq.w	loc_16798
	move.w	d0,d2
	moveq	#$0,d0
	move.b	-$C(a6),d0
	bpl.s	loc_16688
	move.b	d2,-$C(a6)
	moveq	#$0,d3
	move.b	d2,d3
	mulu.w	#$3,d3
	move.b	-$50(a6,d3.w),d0
	move.b	d0,($FFFFD59A).w
	tst.b	($FFFFBA60).w
	bne.w	loc_165E0
	move.b	#$4E,-$50(a6,d3.w)
	bra.w	loc_165E0
loc_16688:
	move.l	d0,d3
	move.l	d2,d0
	jsr	($6F14).w
	move.l	d3,d0
	bsr.w	sub_16984
	bpl.s	loc_1669C
	clr.b	$8(a3)
loc_1669C:
	move.l	a0,d6
	movea.l	a3,a0
	jsr	(sub_81E6).l
	move.l	a0,d5
	moveq	#$0,d2
	move.l	d2,d0
	move.b	$8(a3),d0
	ble.w	loc_1671A
	tst.b	($FFFFBA60).w
	beq.s	loc_166D2
	bsr.w	sub_168EA
	move.l	($FFFF9BD0).w,d1
	divu.w	d0,d1
	cmp.w	#$FA,d1
	bls.s	loc_166D8
	move.l	#$FA,d1
	bra.s	loc_166D8
loc_166D2:
	moveq	#$0,d1
	move.b	$8(a3),d1
loc_166D8:
	tst.b	(a0)
	beq.s	loc_166F0
	moveq	#$0,d0
	move.b	$8(a0),d0
	move.l	#$FA,d2
	sub.w	d0,d2
	cmp.b	d2,d1
	bls.s	loc_166F0
	move.w	d2,d1
loc_166F0:
	moveq	#$0,d2
	move.b	d1,d2
	tst.b	($FFFFBA60).w
	bne.s	loc_16700
	cmp.b	#$1,d2
	beq.s	loc_16708
loc_16700:
	bsr.w	sub_16834
	beq.w	loc_165F6
loc_16708:
	movea.l	d5,a0
	tst.b	(a0)
	beq.s	loc_1671A
	move.b	$8(a0),d0
	add.b	d2,d0
	move.b	d0,$8(a0)
	bra.s	loc_16732
loc_1671A:
	movea.l	d5,a0
	movea.l	d6,a1
	moveq	#$0,d1
loc_16720:
	move.b	(a1,d1.w),(a0,d1.w)
	addq.l	#$1,d1
	cmp.w	#$A,d1
	bcs.s	loc_16720
	move.b	d2,$8(a0)
loc_16732:
	tst.b	d2
	bne.s	loc_16738
	moveq	#$1,d2
loc_16738:
	movem.l	d0-d1/a0-a1,-(a7)
	moveq	#$0,d0
	move.b	-$54(a6),d0
	jsr	($6F02).w
	jsr	($6F14).w
	jsr	($6D1E).w
	movem.l	(a7)+,d0-d1/a0-a1
	tst.b	($FFFFBA60).w
	beq.s	loc_16776
	movea.l	a0,a3
	bsr.w	sub_168EA
	mulu.w	d2,d0
	sub.l	d0,($FFFF9BD0).w
	bsr.w	sub_16954
	bsr.w	sub_168EA
	cmp.l	($FFFF9BD0).w,d0
	bhi.s	loc_16790
	bra.w	loc_165E0
loc_16776:
	movea.l	d6,a1
	moveq	#$0,d0
	move.b	$8(a1),d0
	sub.b	d2,d0
	move.b	d0,$8(a1)
	andi.b	#$7F,d0
	bne.w	loc_165E0
	move.b	#$0,(a1)
loc_16790:
	clr.b	($FFFFD59A).w
	bra.w	loc_165D8
loc_16798:
	tst.b	-$C(a6)
	bpl.s	loc_16790
	bsr.w	sub_167C4
	beq.s	loc_16790
	bsr.w	sub_13DD6
	clr.l	($FFFFD5A0).w
	clr.b	($FFFFD59A).w
	jsr	(sub_85D6).l
	move.b	-$56(a6),($FFFF9BBC).w
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_167C4:
	tst.b	($FFFFBA60).w
	bne.w	loc_1682E
	moveq	#$D,d1
	lea	-$52(a6),a0
loc_167D2:
	move.l	d1,d0
	addi.w	#$9,d0
	mulu.w	#$3,d0
	move.b	$2(a0,d0.w),d0
	cmp.b	#$4E,d0
	bne.s	loc_167EE
	dbf	d1,loc_167D2
	bra.w	loc_1682E
loc_167EE:
	bsr.w	sub_169A4
	move.w	#$C000,($FFFFD5AC).w
	move.l	#$60016,($FFFFD5D6).w
	move.w	#$E5,d0
	bsr.w	sub_11C8E
	move.l	#$50017,($FFFFD582).w
	move.l	#$220017,($FFFFD586).w
	move.l	#$50017,($FFFFD5D6).w
	moveq	#$8,d0
	bsr.w	sub_136DA
	tst.b	d0
	bpl.s	loc_16830
	moveq	#$0,d0
	bra.s	loc_16830
loc_1682E:
	moveq	#$1,d0
loc_16830:
	tst.b	d0
	rts

; ---------------------------------------------------------------------------
sub_16834:
	bsr.w	sub_169A4
	move.l	#$C0016,($FFFFD5D6).w
	move.w	#$8B,d0
	bsr.w	sub_11C8E
	move.l	#$130017,($FFFFD5D6).w
	move.b	($FFFFBA60).w,($FFFFBA61).w
	bsr.w	sub_134B0
	clr.b	($FFFFBA61).w
	move.l	d0,d2
	bsr.w	sub_1343E
	tst.l	d2
	rts

; ---------------------------------------------------------------------------
sub_16868:
	moveq	#$9,d3
	lea	-$52(a6),a0
loc_1686E:
	move.l	d3,d0
	bsr.w	sub_13E56
	addq.w	#$1,d3
	cmp.w	#$17,d3
	bcs.s	loc_1686E
	move.w	d7,d0
	bsr.w	sub_16984
	bpl.s	loc_16888
	clr.b	$8(a3)
loc_16888:
	moveq	#$7,d3
loc_1688A:
	move.l	d3,d0
	jsr	($6F14).w
	jsr	($6F02).w
	tst.b	(a0)
	beq.s	loc_168A2
	movea.l	a3,a0
	jsr	(sub_81E6).l
	bne.s	loc_168AC
loc_168A2:
	move.l	d3,d0
	lea	-$52(a6),a0
	bsr.w	sub_13E56
loc_168AC:
	dbf	d3,loc_1688A
	rts

; ---------------------------------------------------------------------------
sub_168B2:
	movem.l	d2-d3/a3,-(a7)
	moveq	#$9,d2
loc_168B8:
	move.l	d2,d0
	bsr.w	sub_16984
	tst.b	(a3)
	beq.s	loc_168D2
	tst.b	($FFFFBA60).w
	beq.s	loc_168DC
	bsr.w	sub_168EA
	cmp.l	($FFFF9BD0).w,d0
	bls.s	loc_168DC
loc_168D2:
	lea	-$52(a6),a0
	move.l	d2,d0
	bsr.w	sub_13E56
loc_168DC:
	addq.w	#$1,d2
	cmp.w	#$17,d2
	bcs.s	loc_168B8
	movem.l	(a7)+,d2-d3/a3
	rts

; ---------------------------------------------------------------------------
sub_168EA:
	moveq	#$0,d0
	move.w	$6(a3),d0
	moveq	#$0,d1
	move.b	($FFFF9E63).w,d1
	mulu.w	d1,d0
	lsr.l	#$4,d0
	rts

; ---------------------------------------------------------------------------
sub_168FC:
	lea	($FFFF6AF6).l,a2
	lea	-$37(a6),a3
	moveq	#$0,d2
loc_16908:
	movea.l	a2,a0
	jsr	(sub_A7BC).l
	bne.s	loc_16916
	move.b	#$4E,d0
loc_16916:
	move.b	d0,$2(a3)
	addq.w	#$3,a3
	adda.w	#$A,a2
	addq.w	#$1,d2
	cmp.b	($FFFFB9F3).w,d2
	bcs.s	loc_16908
	rts

; ---------------------------------------------------------------------------
sub_1692A:
	moveq	#$0,d1
	lea	($FFFFC470).w,a0
loc_16930:
	tst.b	(a0)
	bne.s	loc_16944
	move.l	d1,d0
	mulu.w	#$3,d0
	lea	-$52(a6),a1
	move.b	#$4E,$2(a1,d0.w)
loc_16944:
	adda.l	#$1A,a0
	addq.w	#$1,d1
	cmp.w	#$8,d1
	bcs.s	loc_16930
	rts

; ---------------------------------------------------------------------------
sub_16954:
	move.l	#$F,($FFFFD5DA).w
	move.l	#$15000F,($FFFFD5DE).w
	bsr.w	sub_1343E
	move.l	($FFFF9BD0).w,d0
	bsr.w	sub_13268
	move.w	#$C000,($FFFFD5AC).w
	move.l	#$B000F,($FFFFD5D6).w
	bsr.w	sub_11C4C
	rts

; ---------------------------------------------------------------------------
sub_16984:
	subi.w	#$9,d0
	bsr.w	sub_16592
	lea	-$A(a6),a3
	moveq	#$9,d0
loc_16992:
	move.b	(a0,d0.w),(a3,d0.w)
	dbf	d0,loc_16992
	moveq	#$0,d0
	move.b	$8(a3),d0
	rts

; ---------------------------------------------------------------------------
sub_169A4:
	move.l	#$20016,($FFFFD5DA).w
	move.l	#$250019,($FFFFD5DE).w
	bsr.w	sub_1343E
	lea	($FFFFD5DA).w,a0
	bsr.w	sub_1343A
	clr.b	($FFFFD5AE).w
	rts

; ---------------------------------------------------------------------------
sub_169C6:
	movem.l	d2/a2-a3,-(a7)
	bsr.s	sub_169A4
	clr.b	($FFFFD5AE).w
	moveq	#$0,d0
	move.w	d2,d0
	mulu.w	#$3,d0
	lea	-$52(a6,d0.w),a0
	move.b	$2(a0),d0
	cmp.b	#$4E,d0
	beq.w	loc_16AC8
	cmp.b	#$8,d2
	bcc.s	loc_16A22
	movem.l	d2-d6/a0-a3,-(a7)
	move.l	d2,d6
	moveq	#$0,d4
	moveq	#$5,d2
	moveq	#$16,d3
	jsr	(sub_AC6C).l
	move.l	d6,d0
	jsr	($6EF0).w
	moveq	#$17,d2
	moveq	#$17,d3
	jsr	($752E).w
	moveq	#$1B,d2
	jsr	($7522).w
	moveq	#$1F,d2
	jsr	($7528).w
	movem.l	(a7)+,d2-d6/a0-a3
	bra.w	loc_16AC8
loc_16A22:
	bne.s	loc_16A30
	move.w	#$4F,d0
	bsr.w	sub_11BDC
	bra.w	loc_16AC4
loc_16A30:
	move.l	d2,d0
	bsr.w	sub_16984
	tst.b	($FFFFBA60).w
	bne.s	loc_16A52
	move.b	$8(a3),d0
	andi.b	#$7F,d0
	move.w	#$3,($FFFFD5AA).w
	bsr.w	sub_13376
	bsr.w	sub_1368C
loc_16A52:
	if DEUTSCH	; DEUTSCH-HOOK 7: Gegenstandsname (Laden/Beute) ueber Namenstabelle (70 Byte wie Original)
	movea.l	a3,a0
	moveq	#0,d1
	tst.b	($FFFFBA60).w
	bne.s	de_hook7_a
	move.b	$8(a3),d1
	andi.b	#$7F,d1
de_hook7_a:
	jsr	(DE_Gegenstandsname).l
	tst.b	($FFFFBA60).w
	bne.s	loc_16A98
	bra.s	loc_16AC4
	dc.w	$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71,$4E71
	else
	moveq	#$2,d2
loc_16A54:
	moveq	#$0,d0
	move.b	$1(a3,d2.w),d0
	beq.s	loc_16A60
	bsr.w	sub_11BDC
loc_16A60:
	dbf	d2,loc_16A54
	tst.b	($FFFFBA60).w
	bne.s	loc_16A98
	move.b	$8(a3),d0
	andi.b	#$7F,d0
	cmp.b	#$2,d0
	bcs.w	loc_16AC4
	lea	($FFFFD5AE).w,a0
	bsr.w	sub_11C18
	move.b	#$73,d1
	cmp.b	-$1(a0,d0.w),d1
	beq.w	loc_16AC4
	move.b	d1,(a0,d0.w)
	clr.b	$1(a0,d0.w)
	bra.s	loc_16AC4
	endif
loc_16A98:
	bsr.w	sub_16ACE
	clr.b	($FFFFD5AE).w
	bsr.w	sub_168EA
	bsr.w	sub_13268
	move.w	#$B2,d0
	bsr.w	sub_11BDC
	move.w	#$C000,($FFFFD5AC).w
	move.l	#$130017,($FFFFD5D6).w
	bsr.w	sub_11C4C
	bra.s	loc_16AC8
loc_16AC4:
	bsr.w	sub_16ACE
loc_16AC8:
	movem.l	(a7)+,d2/a2-a3
	rts

; ---------------------------------------------------------------------------
sub_16ACE:
	move.w	#$C000,($FFFFD5AC).w
	move.l	#$130016,($FFFFD5D6).w
	bsr.w	sub_11C4C
	rts
dat_16AE2:
	binclude	"data/016AE2.bin"

; ---------------------------------------------------------------------------
sub_16B28:
	movem.l	d5-d7,-(a7)
	move.b	($FFFF9BBC).w,d6
	jsr	(sub_85D6).l
	jsr	(sub_862A).l
	jsr	(sub_8A60).l
	jsr	(sub_8A76).l
	moveq	#$0,d5
	jsr	(sub_A71E).l
	jsr	(sub_B0DA).l
	move.b	#$A,($FFFF9BBC).w
	jsr	($7000).w
	jsr	(sub_860E).l
	clr.l	($FFFFD59C).w
	clr.l	($FFFFD5A0).w
	clr.b	($FFFFD595).w
	clr.b	($FFFFD596).w
	st	($FFFFD597).w
	jsr	($748C).w
	jsr	(sub_85D6).l
	move.b	d6,($FFFF9BBC).w
	jsr	(sub_C940).l
	move.w	d5,d0
	movem.l	(a7)+,d5-d7
	rts

; ---------------------------------------------------------------------------
sub_16B96:
	link	a6,#-$1E
	movem.l	d2-d7/a2-a3,-(a7)
	moveq	#$7,d7
loc_16BA0:
	move.l	d7,d0
	jsr	($6EF0).w
	tst.b	(a3)
	beq.s	loc_16BBC
	moveq	#$9,d6
	lea	$43(a2),a0
loc_16BB0:
	cmpi.b	#$3,(a0,d6.w)
	beq.s	loc_16BC2
	dbf	d6,loc_16BB0
loc_16BBC:
	dbf	d7,loc_16BA0
	bra.s	loc_16BCC
loc_16BC2:
	move.b	#$1,(a3)
	move.b	#$2D,$E(a3)
loc_16BCC:
	clr.w	-$1E(a6)
	movea.l	a6,a0
	moveq	#$9,d0
	moveq	#$0,d1
loc_16BD6:
	move.w	d1,-(a0)
	dbf	d0,loc_16BD6
	movem.l	a4-a5,-(a7)
	moveq	#$7,d7
	lea	($FFFFBA68).w,a2
	lea	($FFFFC470).w,a3
loc_16BEA:
	move.b	(a3),d0
	move.b	d0,-$10(a6,d7.w)
	beq.w	loc_16D4E
	btst	#$0,$1(a3)
	beq.w	loc_16D4E
	andi.w	#$3F,d0
	cmp.b	#$6,d0
	beq.s	loc_16C30
	tst.b	(a3)
	bmi.s	loc_16C18
	move.b	$E(a3),d1
	cmp.b	$2E(a2),d1
	beq.w	loc_16D4E
loc_16C18:
	st	-$14(a6)
	cmp.b	#$7,d0
	beq.w	loc_16D4E
	cmp.b	#$2,d0
	bne.w	loc_16C86
	bra.w	loc_16D4E
loc_16C30:
	st	-$14(a6)
	st	-$11(a6)
	moveq	#$7,d6
	lea	($FFFFBA68).w,a4
	lea	($FFFFC470).w,a5
loc_16C42:
	move.b	(a5),d0
	beq.s	loc_16C5E
	andi.b	#$80,d0
	bne.s	loc_16C5E
	move.b	$32(a4),d2
	beq.s	loc_16C5E
	moveq	#$A,d0
	jsr	($6C8C).w
	addq.w	#$4,d0
	cmp.b	d2,d0
	bls.s	loc_16C86
loc_16C5E:
	adda.w	#$D6,a4
	adda.w	#$1A,a5
	dbf	d6,loc_16C42
	move.w	-$1E(a6),d0
	move.b	$2(a3),-$1C(a6,d0.w)
	addq.w	#$1,-$1E(a6)
	move.b	#$87,-$10(a6,d7.w)
	clr.b	$E(a3)
	bra.w	loc_16D4E
loc_16C86:
	moveq	#$7,d6
	lea	($FFFFBA68).w,a4
	lea	($FFFFC470).w,a5
loc_16C90:
	move.b	(a5),d0
	beq.w	loc_16CEC
	andi.b	#$80,d0
	bne.w	loc_16CEC
	move.b	$32(a4),d2
	beq.s	loc_16CCC
	st	-$12(a6)
	asl.b	#$1,d2
	moveq	#$18,d0
	tst.b	($FFFF9930).w
	bpl.s	loc_16CB6
	asl.b	#$1,d2
	moveq	#$30,d0
loc_16CB6:
	jsr	($6C8C).w
	add.b	d2,d0
	subi.b	#$C,d0
	bmi.s	loc_16CCC
	cmp.b	-$8(a6,d7.w),d0
	bls.s	loc_16CCC
	move.b	d0,-$8(a6,d7.w)
loc_16CCC:
	move.b	$3B(a4),d2
	beq.s	loc_16CEC
	moveq	#$A,d0
	jsr	($6C8C).w
	cmp.w	d2,d0
	bhi.s	loc_16CEC
	moveq	#$6,d0
	jsr	($6C8C).w
	cmp.b	-$8(a6,d7.w),d0
	bls.s	loc_16CEC
	move.b	d0,-$8(a6,d7.w)
loc_16CEC:
	adda.w	#$D6,a4
	adda.w	#$1A,a5
	dbf	d6,loc_16C90
	move.b	(a3),d0
	bpl.s	loc_16D24
	andi.b	#$3F,d0
	cmp.b	#$4,d0
	beq.s	loc_16D12
	cmp.b	#$6,d0
	beq.s	loc_16D12
	cmp.b	#$3,d0
	bne.s	loc_16D24
loc_16D12:
	clr.b	$E(a3)
	tst.b	-$8(a6,d7.w)
	bne.s	loc_16D24
	move.b	#$84,-$10(a6,d7.w)
	bra.s	loc_16D2A
loc_16D24:
	move.b	#$1,-$10(a6,d7.w)
loc_16D2A:
	st	-$11(a6)
	move.b	$2E(a2),d0
	sub.b	$E(a3),d0
	cmp.b	-$8(a6,d7.w),d0
	bcc.s	loc_16D40
	move.b	d0,-$8(a6,d7.w)
loc_16D40:
	move.b	-$8(a6,d7.w),d0
	cmp.b	-$13(a6),d0
	bls.s	loc_16D4E
	move.b	d0,-$13(a6)
loc_16D4E:
	adda.w	#$D6,a2
	adda.w	#$1A,a3
	dbf	d7,loc_16BEA
	movem.l	(a7)+,a4-a5
	tst.b	-$11(a6)
	beq.w	loc_16E24
	jsr	(sub_862A).l
	moveq	#$0,d5
	jsr	(sub_A71E).l
	jsr	(sub_8A76).l
	jsr	(sub_8A60).l
	jsr	(sub_B0DA).l
	moveq	#$1,d0
	jsr	(sub_8A90).l
	moveq	#$7,d7
	lea	($FFFFC470).w,a3
loc_16D94:
	move.b	-$10(a6,d7.w),(a3)
	adda.w	#$1A,a3
	dbf	d7,loc_16D94
	moveq	#$8,d7
	jsr	(sub_AB5A).l
	moveq	#$18,d0
	move.l	d0,($FFFFD5D6).w
	st	($FFFFD5E2).w
	moveq	#$1E,d0
	move.w	#$E000,($FFFFD5AC).w
	bsr.w	sub_11C8E
	jsr	(sub_860E).l
	moveq	#$78,d6
	moveq	#$0,d0
	move.b	-$13(a6),d0
	beq.w	loc_16E12
	divu.w	d0,d6
	addq.w	#$1,d6
loc_16DD4:
	tst.l	-$8(a6)
	bne.s	loc_16DE0
	tst.l	-$4(a6)
	beq.s	loc_16E12
loc_16DE0:
	moveq	#$7,d7
	lea	($FFFFC470).w,a0
loc_16DE6:
	tst.b	-$8(a6,d7.w)
	beq.s	loc_16DF4
	subq.b	#$1,-$8(a6,d7.w)
	addq.b	#$1,$E(a0)
loc_16DF4:
	adda.w	#$1A,a0
	dbf	d7,loc_16DE6
	move.w	d6,d0
loc_16DFE:
	jsr	(sub_DEE6).l
	dbf	d0,loc_16DFE
	moveq	#-$8,d7
	jsr	(sub_AB5A).l
	bra.s	loc_16DD4
loc_16E12:
	jsr	($6C54).w
	bsr.w	sub_14246
	bsr.w	sub_16E2C
	jsr	(sub_85D6).l
loc_16E24:
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_16E2C:
	moveq	#$0,d5
	move.w	-$1E(a6),d7
	bra.w	loc_16EB2
loc_16E36:
	move.w	#$1F,d0
	jsr	($76C4).w
	move.l	a0,d0
	beq.w	loc_16EB6
	subq.b	#$1,$8(a0)
	bne.s	loc_16E4C
	clr.b	(a0)
loc_16E4C:
	move.l	a2,d6
	move.b	-$1C(a6,d7.w),d0
	jsr	($6EF0).w
	move.b	#$84,(a3)
	clr.b	$E(a3)
	tst.b	d5
	bne.s	loc_16E7A
	jsr	(sub_C8FC).l
	bsr.w	sub_1343E
	move.w	#$4,($FFFFD5D8).w
	move.w	#$8000,($FFFFD5AC).w
	moveq	#$1,d5
loc_16E7A:
	move.w	#$3,($FFFFD5D6).w
	lea	(a2),a0
	bsr.w	sub_11CA4
	move.w	#$130,d0
	bsr.w	sub_11C8E
	move.w	#$3,($FFFFD5D6).w
	addq.w	#$1,($FFFFD5D8).w
	move.w	#$131,d0
	bsr.w	sub_11C8E
	movea.l	d6,a0
	bsr.w	sub_11CA4
	move.w	#$132,d0
	bsr.w	sub_11C8E
	addq.w	#$2,($FFFFD5D8).w
loc_16EB2:
	dbf	d7,loc_16E36
loc_16EB6:
	tst.b	d5
	beq.s	loc_16EBE
	bsr.w	sub_14246
loc_16EBE:
	rts

; ---------------------------------------------------------------------------
sub_16EC0:
	movem.l	d6-d7,-(a7)
	moveq	#$B,d6
	lea	($FFFFBA68).w,a1
loc_16ECA:
	lea	$54(a1),a0
	moveq	#$C,d7
	move.l	#$CF,d0
loc_16ED6:
	and.b	d0,$5(a0)
	adda.w	#$A,a0
	dbf	d7,loc_16ED6
	adda.w	#$D6,a1
	dbf	d6,loc_16ECA
	movem.l	(a7)+,d6-d7
	rts

; ---------------------------------------------------------------------------
sub_16EF0:
	link	a6,#-$66
	movem.l	d2-d7/a0-a3,-(a7)
	clr.b	-$1(a6)
	clr.b	-$65(a6)
	lea	($FFFF98F6).w,a1
	moveq	#$2,d6
loc_16F06:
	clr.b	-$4(a6,d6.w)
	move.w	d6,d0
	cmp.w	#$2,d0
	bne.s	loc_16F14
	moveq	#$3,d0
loc_16F14:
	asl.w	#$1,d0
	move.w	(a1,d0.w),d1
	sub.w	$24(a1,d0.w),d1
	beq.s	loc_16F24
	st	-$1(a6)
loc_16F24:
	clr.w	-$14(a6,d0.w)
	move.w	d1,-$C(a6,d0.w)
	dbf	d6,loc_16F06
	moveq	#$3,d6
loc_16F32:
	bsr.w	sub_176CA
	move.b	$1(a2),d1
	sub.b	$2(a2),d1
	beq.s	loc_16F44
	st	-$1(a6)
loc_16F44:
	clr.b	-$1C(a6,d6.w)
	move.b	d1,-$18(a6,d6.w)
	dbf	d6,loc_16F32
	tst.b	-$1(a6)
	beq.w	loc_171D8
	moveq	#$7,d7
loc_16F5A:
	move.l	d7,d0
	moveq	#$3C,d1
	bsr.w	sub_176AA
	move.b	d0,d5
	beq.w	loc_16FF0
	moveq	#$2,d6
loc_16F6A:
	jsr	($6D06).w
	move.l	d5,d4
	lsr.l	#$1,d4
	cmp.b	#$5,d0
	bcs.s	loc_16F86
	cmp.b	#$5F,d0
	bhi.s	loc_16F82
	cmp.b	d5,d0
	bls.s	loc_16F86
loc_16F82:
	lsr.l	#$1,d4
	bra.s	loc_16F8A
loc_16F86:
	st	-$4(a6,d6.w)
loc_16F8A:
	move.w	d6,d0
	cmp.w	#$2,d0
	bne.s	loc_16F94
	moveq	#$3,d0
loc_16F94:
	asl.w	#$1,d0
	move.w	-$C(a6,d0.w),d1
	beq.s	loc_16FBE
	mulu.w	d4,d1
	divu.w	#$64,d1
	cmp.l	#$320000,d1
	bcs.s	loc_16FAC
	addq.w	#$1,d1
loc_16FAC:
	cmp.w	-$C(a6,d0.w),d1
	bcs.s	loc_16FB6
	move.w	-$C(a6,d0.w),d1
loc_16FB6:
	sub.w	d1,-$C(a6,d0.w)
	add.w	d1,-$14(a6,d0.w)
loc_16FBE:
	dbf	d6,loc_16F6A
	moveq	#$3,d6
loc_16FC4:
	moveq	#$0,d4
	move.b	-$18(a6,d6.w),d4
	bra.s	loc_16FE8
loc_16FCC:
	jsr	($6D06).w
	cmp.b	#$5,d0
	bcs.s	loc_16FE0
	cmp.b	#$5F,d0
	bhi.s	loc_16FE8
	cmp.b	d5,d0
	bhi.s	loc_16FE8
loc_16FE0:
	addq.b	#$1,-$1C(a6,d6.w)
	subq.b	#$1,-$18(a6,d6.w)
loc_16FE8:
	dbf	d4,loc_16FCC
	dbf	d6,loc_16FC4
loc_16FF0:
	dbf	d7,loc_16F5A
	moveq	#$2,d6
loc_16FF6:
	tst.b	-$4(a6,d6.w)
	beq.s	loc_17030
	move.w	d6,d0
	cmp.w	#$2,d0
	bne.s	loc_17006
	moveq	#$3,d0
loc_17006:
	asl.w	#$1,d0
	move.w	-$14(a6,d0.w),d1
	cmp.w	#$50,d1
	bcc.s	loc_17030
	clr.w	-$14(a6,d0.w)
	add.w	d1,-$C(a6,d0.w)
	move.w	-$C(a6,d0.w),d1
	cmp.w	#$50,d1
	bcs.s	loc_17028
	move.w	#$50,d1
loc_17028:
	move.w	d1,-$14(a6,d0.w)
	sub.w	d1,-$C(a6,d0.w)
loc_17030:
	dbf	d6,loc_16FF6
	bsr.w	sub_175E0
	move.b	#$5,($FFFF9BBC).w
	jsr	(sub_862A).l
	clr.l	($FFFFB3F8).w
	clr.w	($FFFFB52A).w
	jsr	(sub_8360).l
	move.w	#$C000,($FFFFD5AC).w
	bsr.w	sub_171E0
	moveq	#$0,d0
loc_1705E:
	bsr.w	sub_17270
	addq.l	#$2,d0
	cmp.l	#$8,d0
	bcs.s	loc_1705E
	bsr.w	sub_17368
	move.l	a0,-$5C(a6)
	lea	($FFFF98F6).w,a1
	st	($FFFFD87C).w
	bsr.w	sub_175BE
	move.b	#$1,($FFFFD875).w
	bsr.w	sub_17546
	bsr.w	sub_176DC
	move.w	#$126,d0
	jsr	(sub_11C8E).l
	jsr	(sub_860E).l
loc_1709E:
	moveq	#$20,d7
loc_170A0:
	jsr	(sub_DEE6).l
	dbf	d7,loc_170A0
	clr.b	-$1(a6)
	bsr.w	sub_175E0
	moveq	#$2,d6
loc_170B4:
	move.w	d6,d0
	cmp.w	#$2,d0
	bne.s	loc_170BE
	moveq	#$3,d0
loc_170BE:
	asl.w	#$1,d0
	move.w	-$14(a6,d0.w),d1
	beq.s	loc_170F6
	st	-$1(a6)
	cmp.w	#$28,d1
	bls.s	loc_170D4
	move.w	#$28,d1
loc_170D4:
	lea	($FFFF98F6).w,a1
	add.w	d1,$24(a1,d0.w)
	sub.w	d1,-$14(a6,d0.w)
	move.w	(a1,d0.w),d1
	cmp.w	$24(a1,d0.w),d1
	bcc.s	loc_170F6
	st	-$65(a6)
	move.w	d1,$24(a1,d0.w)
	clr.w	-$14(a6,d0.w)
loc_170F6:
	dbf	d6,loc_170B4
	moveq	#$3,d6
loc_170FC:
	tst.b	-$1C(a6,d6.w)
	beq.s	loc_1712E
	st	-$1(a6)
	subq.b	#$1,-$1C(a6,d6.w)
	lea	($FFFF98F6).w,a1
	bsr.w	sub_176CA
	addq.b	#$1,$2(a2)
	move.b	$1(a2),d0
	cmp.b	$2(a2),d0
	bcc.s	loc_17132
	move.b	d0,$2(a2)
	clr.b	-$1C(a6,d6.w)
	st	-$65(a6)
	bra.s	loc_17132
loc_1712E:
	dbf	d6,loc_170FC
loc_17132:
	tst.b	-$1(a6)
	beq.s	loc_17162
	move.w	#$29,d0
	tst.b	-$65(a6)
	beq.s	loc_17146
	move.w	#$1D,d0
loc_17146:
	jsr	(sub_1B900).l
	bsr.w	sub_175BE
	moveq	#$3,d6
loc_17152:
	move.l	d6,d0
	asl.l	#$1,d0
	bsr.w	sub_17270
	dbf	d6,loc_17152
	bra.w	loc_1709E
loc_17162:
	move.l	#$7001A,($FFFFD5DA).w
	move.l	#$20001A,($FFFFD5DE).w
	jsr	(sub_1343E).l
	move.l	($FFFFD5DA).w,($FFFFD582).w
	move.l	($FFFFD5DE).w,($FFFFD586).w
	jsr	(sub_14246).l
	st	($FFFFD875).w
	jsr	(sub_85D6).l
	lea	-$5C(a6),a0
	jsr	(sub_9784).l
	lea	($FFFFD878).w,a0
	jsr	(sub_9784).l
	move.b	#$0,($FFFFD861).w
	lea	($FFFFD864).w,a0
	jsr	(sub_9784).l
	lea	-$64(a6),a0
	jsr	(sub_9784).l
	lea	-$60(a6),a0
	jsr	(sub_9784).l
	move.w	#$8,($FFFFB52A).w
	jsr	(sub_8360).l
loc_171D8:
	movem.l	(a7)+,d2-d7/a0-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_171E0:
	jsr	(sub_8A76).l
	jsr	(sub_8A60).l
	lea	(dat_E7E3D).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,-$60(a6)
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$28,d4
	moveq	#$1C,d5
	moveq	#$0,d0
	bsr.w	sub_17574
	movea.l	-$60(a6),a0
	move.l	$2(a0),$8(a0)
	lea	(dat_8F97F).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,-$64(a6)
	moveq	#$0,d6
loc_17226:
	move.l	d6,d0
	bsr.w	sub_1725E
	addq.l	#$2,d6
	cmp.l	#$8,d6
	bcs.s	loc_17226
	lea	(dat_64637).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,($FFFFD864).w
	move.b	#$1,($FFFFD861).w
	lea	(dat_9B160).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,($FFFFD878).w
	rts

; ---------------------------------------------------------------------------
sub_1725E:
	bsr.w	sub_1733C
	movea.l	-$64(a6),a0
	moveq	#$2,d4
	moveq	#$8,d5
	moveq	#$1,d0
	bra.w	loc_17578

; ---------------------------------------------------------------------------
sub_17270:
	movem.l	d0-d7/a1-a3,-(a7)
	move.l	d0,d2
	lea	($FFFF98F6).w,a1
	moveq	#$0,d5
	moveq	#$0,d4
	cmp.b	#$4,d2
	bne.s	loc_17298
	moveq	#$3,d6
loc_17286:
	bsr.w	sub_176CA
	add.b	$2(a2),d4
	add.b	$1(a2),d5
	dbf	d6,loc_17286
	bra.s	loc_172A0
loc_17298:
	move.w	(a1,d2.w),d5
	move.w	$24(a1,d2.w),d4
loc_172A0:
	moveq	#$0,d0
	move.w	d4,d0
	mulu.w	#$3A,d0
	divu.w	d5,d0
	ext.l	d0
	divu.w	#$8,d0
	move.l	d0,d6
	moveq	#$0,d5
	moveq	#$8,d4
	sub.w	d6,d4
	moveq	#$0,d3
	swap	d0
	move.w	d0,d3
	beq.s	loc_172C4
	moveq	#$1,d5
	subq.w	#$1,d4
loc_172C4:
	movea.l	-$64(a6),a0
	movea.l	$2(a0),a1
	movea.l	a1,a2
	adda.l	#$20,a2
	move.w	#$0,d1
	move.w	(a1,d1.w),d0
	swap	d0
	move.w	(a1,d1.w),d0
	move.l	d4,d1
	bsr.w	sub_1732E
	move.w	#$0,d1
	lsl.w	#$1,d3
	add.w	d3,d1
	move.w	(a1,d1.w),d0
	swap	d0
	move.w	(a1,d1.w),d0
	move.l	d5,d1
	bsr.w	sub_1732E
	move.w	#$10,d1
	move.w	(a1,d1.w),d0
	swap	d0
	move.w	(a1,d1.w),d0
	move.l	d6,d1
	bsr.w	sub_1732E
	move.l	d2,d0
	bsr.w	sub_1733C
	movea.l	-$64(a6),a0
	moveq	#$2,d4
	moveq	#$8,d5
	moveq	#$1,d0
	bsr.w	sub_17574
	movem.l	(a7)+,d0-d7/a1-a3
	rts

; ---------------------------------------------------------------------------
sub_1732E:
	tst.b	d1
	beq.s	loc_1733A
	subq.w	#$1,d1
loc_17334:
	move.l	d0,(a2)+
	dbf	d1,loc_17334
loc_1733A:
	rts

; ---------------------------------------------------------------------------
sub_1733C:
	movem.l	d0/a0-a1,-(a7)
	lsr.w	#$1,d0
	moveq	#$0,d2
	moveq	#$0,d3
	lea	(sub_17360).l,a0
	lea	(dat_17364).l,a1
	move.b	(a0,d0.w),d2
	move.b	(a1,d0.w),d3
	movem.l	(a7)+,d0/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_17360:
	move.l	d4,-(a2)
	btst	d0,-(a2)
dat_17364:
	move.b	(a1),d1
	move.b	(a1),d1

; ---------------------------------------------------------------------------
sub_17368:
	lea	(dat_E772F).l,a0
	jsr	(sub_9DD4).l
	rts

; ---------------------------------------------------------------------------
sub_17376:
	movem.l	d0-d5/a0-a1,-(a7)
	moveq	#$15,d0
	jsr	(sub_976C).l
	move.w	#$8000,($FFFFD5AC).w
	movea.l	-$5C(a6),a0
	moveq	#$0,d0
	moveq	#$8,d2
	moveq	#$0,d3
	moveq	#$18,d4
	moveq	#$B,d5
	bsr.w	loc_17578
	move.l	#$0,($FFFFD5DA).w
	move.l	#$26000A,($FFFFD5DE).w
	moveq	#$4,d0
	bsr.w	sub_173CE
	moveq	#$0,d0
loc_173B2:
	bsr.w	sub_1743E
	addq.w	#$2,d0
	cmp.w	#$8,d0
	bcs.s	loc_173B2
	bsr.w	sub_17546
	move.w	#$C000,($FFFFD5AC).w
	movem.l	(a7)+,d0-d5/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_173CE:
	movem.l	d2-d3,-(a7)
	move.w	#$8000,($FFFFD5AC).w
	move.l	d0,d3
	move.l	#$0,($FFFFD5DA).w
	move.l	#$26000A,($FFFFD5DE).w
	moveq	#$3,d2
loc_173EC:
	cmp.b	d2,d3
	bne.s	loc_173F6
	move.w	#$C000,($FFFFD5AC).w
loc_173F6:
	lea	(dat_17426).l,a0
	move.l	d2,d0
	lsl.l	#$2,d0
	move.l	(a0,d0.w),($FFFFD5D6).w
	lea	(dat_17436).l,a0
	lsr.l	#$1,d0
	move.w	(a0,d0.w),d0
	bsr.w	sub_11C8E
	move.w	#$8000,($FFFFD5AC).w
	dbf	d2,loc_173EC
	movem.l	(a7)+,d2-d3
	rts
dat_17426:
	binclude	"data/017426.bin"
dat_17436:
	dc.b	$00,$F8,$00,$F9,$01,$0C,$00,$FB

; ---------------------------------------------------------------------------
sub_1743E:
	movem.l	d0-d6/a1-a3,-(a7)
	move.l	d0,d2
	lea	($FFFF98F6).w,a1
	moveq	#$0,d5
	moveq	#$0,d4
	cmp.b	#$4,d2
	bne.s	loc_17466
	moveq	#$3,d6
loc_17454:
	bsr.w	sub_176CA
	add.b	$2(a2),d4
	add.b	$1(a2),d5
	dbf	d6,loc_17454
	bra.s	loc_1747E
loc_17466:
	move.w	(a1,d2.w),d5
	move.l	d5,d0
	bsr.w	sub_17532
	move.l	d0,d5
	move.w	$24(a1,d2.w),d4
	move.l	d4,d0
	bsr.w	sub_17532
	move.l	d0,d4
loc_1747E:
	lsr.l	#$1,d2
	movea.l	-$64(a6),a0
	movea.l	$2(a0),a2
	lea	-$54(a6),a1
	moveq	#$0,d0
	move.w	$12(a2),d0
	moveq	#$0,d1
loc_17494:
	move.w	d0,(a1,d1.w)
	addq.w	#$2,d1
	cmp.w	#$38,d1
	bcs.s	loc_17494
	lea	($FFFF992C).w,a0
	moveq	#$0,d0
	move.b	(a0,d2.w),d0
	lea	(dat_174F2).l,a0
	move.b	(a0,d0.w),d0
	moveq	#$0,d3
	move.w	(a2,d0.w),d3
	move.l	d3,d0
	move.l	d4,d1
	bsr.w	sub_174FA
	sub.w	d4,d5
	move.w	$14(a2),d0
	move.l	d5,d1
	bsr.w	sub_174FA
	lea	(dat_174F6).l,a0
	moveq	#$0,d6
	move.b	(a0,d2.w),d6
	move.l	d2,d0
	bsr.w	sub_17508
	lea	-$54(a6),a3
	move.l	d2,d4
	moveq	#$7,d5
	bsr.w	sub_17656
	movem.l	(a7)+,d0-d6/a1-a3
	rts
dat_174F2:
	dc.b	$16,$18,$1A,$14
dat_174F6:
	dc.b	$04,$01,$03,$03

; ---------------------------------------------------------------------------
sub_174FA:
	tst.b	d1
	beq.s	loc_17506
	subq.w	#$1,d1
loc_17500:
	move.w	d0,(a1)+
	dbf	d1,loc_17500
loc_17506:
	rts

; ---------------------------------------------------------------------------
sub_17508:
	movem.l	d0/a0-a1,-(a7)
	moveq	#$0,d2
	moveq	#$0,d3
	lea	(dat_1752A).l,a0
	lea	(dat_1752E).l,a1
	move.b	(a0,d0.w),d2
	move.b	(a1,d0.w),d3
	movem.l	(a7)+,d0/a0-a1
	rts
dat_1752A:
	dc.b	$20,$01,$01,$20
dat_1752E:
	dc.b	$07,$07,$02,$02

; ---------------------------------------------------------------------------
sub_17532:
	divu.w	#$50,d0
	swap	d0
	tst.w	d0
	beq.s	loc_17542
	addi.l	#$10000,d0
loc_17542:
	swap	d0
	rts

; ---------------------------------------------------------------------------
sub_17546:
	movem.l	d0-d3/a0-a1,-(a7)
	move.w	#$8000,($FFFFD5AC).w
	move.l	#$A000E,($FFFFD5DA).w
	move.l	#$1D000F,($FFFFD5DE).w
	bsr.w	sub_1343E
	bsr.w	sub_17590
	move.w	#$C000,($FFFFD5AC).w
	movem.l	(a7)+,d0-d3/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_17574:
	moveq	#$2,d1
	bra.s	loc_1757A
loc_17578:
	moveq	#$4,d1
loc_1757A:
	clr.w	($FFFFB50E).w
	move.w	#$7FFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	jsr	(sub_95BE).l
	rts

; ---------------------------------------------------------------------------
sub_17590:
	st	-$66(a6)
	move.w	#$C7,d0
	tst.b	-$66(a6)
	bne.s	loc_175A4
	bsr.w	sub_11C8E
	bra.s	loc_175BC
loc_175A4:
	clr.b	($FFFFD5AE).w
	bsr.w	sub_11BDC
	move.l	#$13000E,($FFFFD5D6).w
	bsr.w	sub_11C4C
	clr.b	-$66(a6)
loc_175BC:
	rts

; ---------------------------------------------------------------------------
sub_175BE:
	movem.l	d1-d6/a0-a3,-(a7)
	lea	($FFFF992C).w,a1
	movea.l	-$5C(a6),a2
	movea.l	$2(a2),a2
	bsr.w	sub_175E0
	move.l	-$58(a6),(a1)
	bsr.w	sub_17376
	movem.l	(a7)+,d1-d6/a0-a3
	rts

; ---------------------------------------------------------------------------
sub_175E0:
	movem.l	d3-d6/a1-a3,-(a7)
	lea	($FFFF98F6).w,a1
	clr.l	-$58(a6)
	move.w	#$0,d0
	bsr.w	sub_1761E
	move.b	d0,-$58(a6)
	move.w	#$2,d0
	bsr.w	sub_1761E
	move.b	d0,-$57(a6)
	move.w	#$6,d0
	bsr.w	sub_1761E
	move.b	d0,-$55(a6)
	bsr.w	sub_17628
	move.b	d0,-$56(a6)
	movem.l	(a7)+,d3-d6/a1-a3
	rts

; ---------------------------------------------------------------------------
sub_1761E:
	move.w	$24(a1,d0.w),d4
	move.w	(a1,d0.w),d3
	bra.s	loc_1763E

; ---------------------------------------------------------------------------
sub_17628:
	moveq	#$3,d6
	moveq	#$0,d3
	moveq	#$0,d4
loc_1762E:
	bsr.w	sub_176CA
	add.b	$1(a2),d3
	add.b	$2(a2),d4
	dbf	d6,loc_1762E
loc_1763E:
	moveq	#$3,d0
	tst.w	d4
	beq.s	loc_17654
	moveq	#$0,d0
	cmp.w	d3,d4
	beq.s	loc_17654
	moveq	#$1,d0
	lsl.w	#$1,d4
	cmp.w	d3,d4
	bhi.s	loc_17654
	moveq	#$2,d0
loc_17654:
	rts

; ---------------------------------------------------------------------------
sub_17656:
	add.w	d4,d5
	add.w	d3,d6
	move.l	d3,d1
loc_1765C:
	move.l	d4,d0
loc_1765E:
	move.w	(a3)+,d2
	bsr.w	sub_17672
	addq.w	#$1,d0
	cmp.w	d5,d0
	bcs.s	loc_1765E
	addq.w	#$1,d1
	cmp.w	d6,d1
	bcs.s	loc_1765C
	rts

; ---------------------------------------------------------------------------
sub_17672:
	movem.l	d0-d1,-(a7)
	asl.w	#$1,d0
	asl.w	#$7,d1
	add.w	d1,d0
	addi.w	#$F000,d0
	jsr	(sub_8288).l
	move.w	d2,(a5)
	movem.l	(a7)+,d0-d1
	rts

; ---------------------------------------------------------------------------
sub_1768E:
	movem.l	d1/a1,-(a7)
	move.w	$24(a1,d0.w),d1
	move.w	(a1,d0.w),d0
	mulu.w	#$64,d1
	divu.w	d0,d1
	moveq	#$0,d0
	move.w	d1,d0
	movem.l	(a7)+,d1/a1
	rts

; ---------------------------------------------------------------------------
sub_176AA:
	movem.l	a1-a2,-(a7)
	jsr	($6F14).w
	jsr	($6F02).w
	movea.l	a1,a2
	subi.b	#$31,d1
	moveq	#$0,d0
	move.w	d1,d0
	jsr	($4FB0).w
	movem.l	(a7)+,a1-a2
	rts

; ---------------------------------------------------------------------------
sub_176CA:
	move.l	d0,-(a7)
	move.l	d6,d0
	ext.w	d0
	mulu.w	#$5,d0
	lea	$C(a1,d0.w),a2
	move.l	(a7)+,d0
	rts

; ---------------------------------------------------------------------------
sub_176DC:
	movem.l	d0-d1/a0-a1,-(a7)
	move.l	#$70018,($FFFFD5DA).w
	move.l	#$20001A,($FFFFD5DE).w
	bsr.w	sub_1343E
	movem.l	(a7)+,d0-d1/a0-a1
	rts
dat_176FA:
	binclude	"data/0176FA.bin"
dat_17722:
	binclude	"data/017722.bin"
dat_177EE:
	binclude	"data/0177EE.bin"

; ---------------------------------------------------------------------------
sub_17816:
	link	a6,#-$E2
	movem.l	d2-d7/a2-a3,-(a7)
	move.b	d0,-$D0(a6)
	jsr	(sub_85D6).l
	move.b	($FFFF9BBC).w,($FFFF9BBD).w
	move.b	#$5,($FFFF9BBC).w
	jsr	(sub_862A).l
	clr.l	($FFFFB3F8).w
	clr.w	($FFFFB52A).w
	jsr	(sub_8360).l
	move.w	#$C000,($FFFFD5AC).w
	st	-$D6(a6)
	move.b	($FFFF9924).w,d0
	ext.w	d0
	lea	-$BA(a6),a0
	bsr.w	sub_19C60
	bsr.w	sub_179FE
	moveq	#$0,d0
loc_17866:
	bsr.w	sub_17A9A
	addq.l	#$2,d0
	cmp.l	#$8,d0
	bcs.s	loc_17866
	moveq	#$5,d0
	bsr.w	sub_17B94
	move.l	a0,-$82(a6)
	moveq	#$0,d0
	move.b	($FFFF9924).w,d0
	bsr.w	sub_17B94
	move.l	a0,-$86(a6)
	bsr.w	sub_17EC6
	bsr.w	sub_17EEE
	clr.l	($FFFF992C).w
	clr.l	($FFFF9928).w
	move.b	#$4,-$D2(a6)
	clr.b	-$D1(a6)
	tst.b	-$D0(a6)
	beq.s	loc_178B2
	move.b	#$3,-$D2(a6)
loc_178B2:
	st	d7
	bsr.w	sub_17BEC
	bsr.w	sub_1841E
	jsr	(sub_860E).l
	bsr.w	sub_19992
loc_178C6:
	bsr.w	sub_17F46
	bsr.w	sub_1808A
	tst.b	d0
	bmi.w	loc_1794C
	beq.s	loc_17902
	bsr.w	sub_18114
	move.b	-$D2(a6),d0
	cmp.b	#$5,d0
	beq.s	loc_1794C
	bsr.w	sub_181A2
	bmi.s	loc_17950
	bne.s	loc_17954
	bsr.w	sub_18386
	tst.b	d0
	bmi.s	loc_17950
	beq.s	loc_1791E
	cmp.b	#$3,d0
	bcs.s	loc_17954
	beq.s	loc_1794C
	st	d0
	bra.s	loc_17956
loc_17902:
	bsr.w	sub_18386
	tst.b	d0
	bmi.s	loc_17950
	beq.s	loc_17918
	cmp.b	#$3,d0
	bcs.s	loc_17954
	beq.s	loc_1794C
	st	d0
	bra.s	loc_17956
loc_17918:
	bsr.w	sub_181A2
	bmi.s	loc_17950
loc_1791E:
	moveq	#$7,d2
loc_17920:
	moveq	#$0,d0
	move.b	-$5A(a6,d2.w),d0
	beq.s	loc_17940
	addq.b	#$1,d0
	cmp.b	#$A,d0
	bcs.s	loc_17940
	move.l	d2,d0
	jsr	($6F02).w
	clr.b	$E(a0)
	move.b	#$87,(a0)
	moveq	#$0,d0
loc_17940:
	move.b	d0,-$5A(a6,d2.w)
	dbf	d2,loc_17920
	bra.w	loc_178C6
loc_1794C:
	moveq	#$0,d0
	bra.s	loc_17956
loc_17950:
	moveq	#$2,d0
	bra.s	loc_17956
loc_17954:
	moveq	#$1,d0
loc_17956:
	move.b	d0,($FFFF9927).w
	clr.b	d7
	bsr.w	sub_1991C
	moveq	#$1,d5
loc_17962:
	move.l	d5,d6
	addq.l	#$1,d6
	bsr.w	sub_1992A
	move.b	$4(a2),d4
	beq.s	loc_17992
	moveq	#$0,d3
	move.b	#$C,d3
	tst.b	d5
	beq.s	loc_1797E
	move.b	#$8,d3
loc_1797E:
	move.l	d3,d2
	lsr.w	#$1,d2
	cmp.b	$3(a2),d2
	bcs.s	loc_17992
	move.b	d3,$3(a2)
	subq.b	#$1,d4
	move.b	d4,$4(a2)
loc_17992:
	dbf	d5,loc_17962
	jsr	(sub_199EA).l
	lea	($FFFFB532).w,a0
	jsr	(sub_9784).l
	clr.l	($FFFFD57E).w
	lea	($FFFFB582).w,a0
	jsr	(sub_9784).l
	lea	-$86(a6),a0
	jsr	(sub_9784).l
	lea	-$82(a6),a0
	jsr	(sub_9784).l
	lea	($FFFFD878).w,a0
	jsr	(sub_9784).l
	move.b	#$0,($FFFFD861).w
	lea	($FFFFD864).w,a0
	jsr	(sub_9784).l
	lea	-$8E(a6),a0
	jsr	(sub_9784).l
	lea	-$8A(a6),a0
	jsr	(sub_9784).l
	movem.l	(a7)+,d2-d7/a2-a3
	unlk	a6
	rts

; ---------------------------------------------------------------------------
sub_179FE:
	jsr	(sub_8A76).l
	jsr	(sub_8A60).l
	lea	(dat_E7E3D).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,-$8A(a6)
	move.w	$6(a0),-$D8(a6)
	addi.w	#$10,$6(a0)
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$28,d4
	moveq	#$1C,d5
	moveq	#$0,d0
	bsr.w	sub_17EAA
	movea.l	-$8A(a6),a0
	move.l	$2(a0),$8(a0)
	lea	(dat_8F97F).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,-$8E(a6)
	moveq	#$0,d6
loc_17A50:
	move.l	d6,d0
	bsr.w	sub_17A88
	addq.l	#$2,d6
	cmp.l	#$8,d6
	bcs.s	loc_17A50
	lea	(dat_64637).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,($FFFFD864).w
	move.b	#$1,($FFFFD861).w
	lea	(dat_9B160).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,($FFFFD878).w
	rts

; ---------------------------------------------------------------------------
sub_17A88:
	bsr.w	sub_17B68
	movea.l	-$8E(a6),a0
	moveq	#$2,d4
	moveq	#$8,d5
	moveq	#$1,d0
	bra.w	loc_17EAE

; ---------------------------------------------------------------------------
sub_17A9A:
	movem.l	d0-d7/a1-a3,-(a7)
	move.l	d0,d2
	clr.b	d7
	bsr.w	sub_1991C
	moveq	#$0,d5
	moveq	#$0,d4
	cmp.b	#$4,d2
	bne.s	loc_17AC4
	moveq	#$3,d6
loc_17AB2:
	bsr.w	sub_1992A
	add.b	$2(a2),d4
	add.b	$1(a2),d5
	dbf	d6,loc_17AB2
	bra.s	loc_17ACC
loc_17AC4:
	move.w	(a1,d2.w),d5
	move.w	$24(a1,d2.w),d4
loc_17ACC:
	moveq	#$0,d0
	move.w	d4,d0
	mulu.w	#$3A,d0
	divu.w	d5,d0
	ext.l	d0
	divu.w	#$8,d0
	move.l	d0,d6
	moveq	#$0,d5
	moveq	#$8,d4
	sub.w	d6,d4
	moveq	#$0,d3
	swap	d0
	move.w	d0,d3
	beq.s	loc_17AF0
	moveq	#$1,d5
	subq.w	#$1,d4
loc_17AF0:
	movea.l	-$8E(a6),a0
	movea.l	$2(a0),a1
	movea.l	a1,a2
	adda.l	#$20,a2
	move.w	#$0,d1
	move.w	(a1,d1.w),d0
	swap	d0
	move.w	(a1,d1.w),d0
	move.l	d4,d1
	bsr.w	sub_17B5A
	move.w	#$0,d1
	lsl.w	#$1,d3
	add.w	d3,d1
	move.w	(a1,d1.w),d0
	swap	d0
	move.w	(a1,d1.w),d0
	move.l	d5,d1
	bsr.w	sub_17B5A
	move.w	#$10,d1
	move.w	(a1,d1.w),d0
	swap	d0
	move.w	(a1,d1.w),d0
	move.l	d6,d1
	bsr.w	sub_17B5A
	move.l	d2,d0
	bsr.w	sub_17B68
	movea.l	-$8E(a6),a0
	moveq	#$2,d4
	moveq	#$8,d5
	moveq	#$1,d0
	bsr.w	sub_17EAA
	movem.l	(a7)+,d0-d7/a1-a3
	rts

; ---------------------------------------------------------------------------
sub_17B5A:
	tst.b	d1
	beq.s	loc_17B66
	subq.w	#$1,d1
loc_17B60:
	move.l	d0,(a2)+
	dbf	d1,loc_17B60
loc_17B66:
	rts

; ---------------------------------------------------------------------------
sub_17B68:
	movem.l	d0/a0-a1,-(a7)
	lsr.w	#$1,d0
	moveq	#$0,d2
	moveq	#$0,d3
	lea	(sub_17B8C).l,a0
	lea	(dat_17B90).l,a1
	move.b	(a0,d0.w),d2
	move.b	(a1,d0.w),d3
	movem.l	(a7)+,d0/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_17B8C:
	move.l	d4,-(a2)
	btst	d0,-(a2)
dat_17B90:
	move.b	(a1),d1
	move.b	(a1),d1

; ---------------------------------------------------------------------------
sub_17B94:
	move.l	d0,d6
	lsl.b	#$2,d0
	lea	(dat_17BD4).l,a0
	movea.l	(a0,d0.w),a0
	jsr	(sub_9DD4).l
	move.l	#$210,d0
	add.l	d0,$8(a0)
	cmp.b	#$5,d6
	beq.s	loc_17BD2
	movea.l	$2(a0),a2
	movea.l	a2,a1
	adda.w	#$840,a1
	moveq	#$0,d0
loc_17BC4:
	move.w	(a2,d0.w),(a1,d0.w)
	addq.w	#$2,d0
	cmp.w	#$210,d0
	bcs.s	loc_17BC4
loc_17BD2:
	rts
dat_17BD4:
	binclude	"data/017BD4.bin"

; ---------------------------------------------------------------------------
sub_17BEC:
	movem.l	d0-d5/a0-a1,-(a7)
	cmp.b	-$D6(a6),d7
	beq.s	loc_17C42
	bsr.w	sub_19A50
	movem.l	d2-d7/a0,-(a7)
	move.w	#$0,($FFFFB432).w
	clr.b	($FFFFB4C9).w
	moveq	#$40,d2
	moveq	#$0,d3
	move.w	#$FF,d4
	move.w	#$57,d5
	moveq	#$0,d6
	moveq	#$0,d7
	jsr	(sub_92FC).l
	move.l	a0,($FFFFB42E).w
	jsr	(sub_91C8).l
	movem.l	(a7)+,d2-d7/a0
	moveq	#$5,d0
	tst.b	d7
	beq.s	loc_17C36
	move.b	($FFFF9924).w,d0
loc_17C36:
	addi.l	#$10,d0
	jsr	(sub_976C).l
loc_17C42:
	move.w	#$8000,($FFFFD5AC).w
	movea.l	-$86(a6),a0
	moveq	#$4,d0
	tst.b	d7
	bne.s	loc_17C58
	movea.l	-$82(a6),a0
	moveq	#$0,d0
loc_17C58:
	moveq	#$8,d2
	moveq	#$0,d3
	moveq	#$18,d4
	moveq	#$B,d5
	bsr.w	loc_17EAE
	move.l	#$0,($FFFFD5DA).w
	move.l	#$26000A,($FFFFD5DE).w
	moveq	#$4,d0
	bsr.w	sub_17CC8
	moveq	#$0,d0
loc_17C7C:
	bsr.w	sub_17D38
	addq.w	#$2,d0
	cmp.w	#$8,d0
	bcs.s	loc_17C7C
	st	d0
	bsr.w	sub_17E48
	move.w	#$C000,($FFFFD5AC).w
	cmp.b	-$D6(a6),d7
	beq.s	loc_17CC2
	move.b	d7,-$D6(a6)
	addq.w	#$1,($FFFFB432).w
	jsr	(sub_91C8).l
	movea.l	($FFFFB42E).w,a0
	jsr	(sub_9240).l
	clr.l	($FFFFB42E).w
	bsr.w	sub_19A62
	moveq	#$26,d0
	jsr	(sub_1B900).l
loc_17CC2:
	movem.l	(a7)+,d0-d5/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_17CC8:
	movem.l	d2-d3,-(a7)
	move.w	#$8000,($FFFFD5AC).w
	move.l	d0,d3
	move.l	#$0,($FFFFD5DA).w
	move.l	#$26000A,($FFFFD5DE).w
	moveq	#$3,d2
loc_17CE6:
	cmp.b	d2,d3
	bne.s	loc_17CF0
	move.w	#$C000,($FFFFD5AC).w
loc_17CF0:
	lea	(dat_17D20).l,a0
	move.l	d2,d0
	lsl.l	#$2,d0
	move.l	(a0,d0.w),($FFFFD5D6).w
	lea	(dat_17D30).l,a0
	lsr.l	#$1,d0
	move.w	(a0,d0.w),d0
	bsr.w	sub_11C8E
	move.w	#$8000,($FFFFD5AC).w
	dbf	d2,loc_17CE6
	movem.l	(a7)+,d2-d3
	rts
dat_17D20:
	binclude	"data/017D20.bin"
dat_17D30:
	dc.b	$00,$F8,$00,$F9,$01,$0C,$00,$FB

; ---------------------------------------------------------------------------
sub_17D38:
	movem.l	d0-d6/a1-a3,-(a7)
	move.l	d0,d2
	bsr.w	sub_1991C
	moveq	#$0,d5
	moveq	#$0,d4
	cmp.b	#$4,d2
	bne.s	loc_17D60
	moveq	#$3,d6
loc_17D4E:
	bsr.w	sub_1992A
	add.b	$2(a2),d4
	add.b	$1(a2),d5
	dbf	d6,loc_17D4E
	bra.s	loc_17D78
loc_17D60:
	move.w	(a1,d2.w),d5
	move.l	d5,d0
	bsr.w	sub_17E34
	move.l	d0,d5
	move.w	$24(a1,d2.w),d4
	move.l	d4,d0
	bsr.w	sub_17E34
	move.l	d0,d4
loc_17D78:
	lsr.l	#$1,d2
	movea.l	-$8E(a6),a0
	movea.l	$2(a0),a2
	lea	-$38(a6),a1
	moveq	#$0,d0
	move.w	$12(a2),d0
	moveq	#$0,d1
loc_17D8E:
	move.w	d0,(a1,d1.w)
	addq.w	#$2,d1
	cmp.w	#$38,d1
	bcs.s	loc_17D8E
	lea	($FFFF992C).w,a0
	tst.b	d7
	beq.s	loc_17DA6
	lea	($FFFF9928).w,a0
loc_17DA6:
	moveq	#$0,d0
	move.b	(a0,d2.w),d0
	lea	(dat_17DF4).l,a0
	move.b	(a0,d0.w),d0
	moveq	#$0,d3
	move.w	(a2,d0.w),d3
	move.l	d3,d0
	move.l	d4,d1
	bsr.w	sub_17DFC
	sub.w	d4,d5
	move.w	$14(a2),d0
	move.l	d5,d1
	bsr.w	sub_17DFC
	lea	(dat_17DF8).l,a0
	moveq	#$0,d6
	move.b	(a0,d2.w),d6
	move.l	d2,d0
	bsr.w	sub_17E0A
	lea	-$38(a6),a3
	move.l	d2,d4
	moveq	#$7,d5
	bsr.w	sub_19858
	movem.l	(a7)+,d0-d6/a1-a3
	rts
dat_17DF4:
	dc.b	$16,$18,$1A,$14
dat_17DF8:
	dc.b	$04,$01,$03,$03

; ---------------------------------------------------------------------------
sub_17DFC:
	tst.b	d1
	beq.s	loc_17E08
	subq.w	#$1,d1
loc_17E02:
	move.w	d0,(a1)+
	dbf	d1,loc_17E02
loc_17E08:
	rts

; ---------------------------------------------------------------------------
sub_17E0A:
	movem.l	d0/a0-a1,-(a7)
	moveq	#$0,d2
	moveq	#$0,d3
	lea	(dat_17E2C).l,a0
	lea	(dat_17E30).l,a1
	move.b	(a0,d0.w),d2
	move.b	(a1,d0.w),d3
	movem.l	(a7)+,d0/a0-a1
	rts
dat_17E2C:
	dc.b	$20,$01,$01,$20
dat_17E30:
	dc.b	$07,$07,$02,$02

; ---------------------------------------------------------------------------
sub_17E34:
	divu.w	#$50,d0
	swap	d0
	tst.w	d0
	beq.s	loc_17E44
	addi.l	#$10000,d0
loc_17E44:
	swap	d0
	rts

; ---------------------------------------------------------------------------
sub_17E48:
	movem.l	d0-d3/a0-a1,-(a7)
	move.w	#$8000,($FFFFD5AC).w
	move.l	#$A000E,($FFFFD5DA).w
	move.l	#$1D000F,($FFFFD5DE).w
	tst.b	d0
	beq.s	loc_17E96
	bsr.w	sub_1343E
	bsr.w	sub_1921A
	tst.b	d7
	beq.s	loc_17E96
	move.l	#$A000F,($FFFFD5D6).w
	move.w	#$10D,d0
	bsr.w	sub_11C8E
	moveq	#$0,d0
	move.b	-$D2(a6),d0
	move.w	#$1,($FFFFD5AA).w
	bsr.w	sub_13376
	bsr.w	sub_11CA0
loc_17E96:
	move.l	#$13000F,($FFFFD5D6).w
	move.w	#$C000,($FFFFD5AC).w
	movem.l	(a7)+,d0-d3/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_17EAA:
	moveq	#$2,d1
	bra.s	loc_17EB0
loc_17EAE:
	moveq	#$4,d1
loc_17EB0:
	clr.w	($FFFFB50E).w
	move.w	#$7FFF,($FFFFB510).w
	clr.w	($FFFFB512).w
	jsr	(sub_95BE).l
	rts

; ---------------------------------------------------------------------------
sub_17EC6:
	moveq	#$1,d0
	jsr	(sub_982A).l
	lea	(dat_17EDC).l,a0
	jsr	(sub_A768).l
	rts
dat_17EDC:
	binclude	"data/017EDC.bin"

; ---------------------------------------------------------------------------
sub_17EEE:
	moveq	#$7,d0
	lea	-$52(a6),a2
	lea	-$4A(a6),a3
loc_17EF8:
	clr.b	-$66(a6,d0.w)
	st	-$6E(a6,d0.w)
	clr.b	-$5A(a6,d0.w)
	clr.b	(a3,d0.w)
	clr.b	(a2,d0.w)
	jsr	($6F02).w
	jsr	($6F14).w
	move.b	(a0),d1
	beq.s	loc_17F3C
	bmi.s	loc_17F3C
	btst	#$6,d1
	bne.s	loc_17F3C
	tst.b	$31(a1)
	beq.s	loc_17F2C
	move.b	#$7B,(a2,d0.w)
loc_17F2C:
	tst.b	$3B(a1)
	bne.s	loc_17F38
	tst.b	$32(a1)
	beq.s	loc_17F3C
loc_17F38:
	st	(a3,d0.w)
loc_17F3C:
	dbf	d0,loc_17EF8
	clr.b	-$E1(a6)
	rts

; ---------------------------------------------------------------------------
sub_17F46:
	movem.l	d2-d4,-(a7)
	st	-$D4(a6)
	st	d3
	st	-$D3(a6)
	st	d7
	bsr.w	sub_1991C
	bsr.w	sub_17FE0
	bne.s	loc_17F62
	clr.b	d3
loc_17F62:
	bsr.w	sub_17FEC
	bmi.s	loc_17F94
	move.l	d1,d0
	bsr.w	sub_1803C
	tst.b	-$D0(a6)
	beq.s	loc_17F7A
	clr.b	-$D0(a6)
	moveq	#$0,d0
loc_17F7A:
	move.b	d0,-$D3(a6)
	bne.s	loc_17F90
	tst.b	d3
	bne.s	loc_17F8C
	move.b	#$1,-$D3(a6)
	bra.s	loc_17FCA
loc_17F8C:
	moveq	#$1,d3
	bra.s	loc_17FCA
loc_17F90:
	moveq	#$0,d3
	bra.s	loc_17FCA
loc_17F94:
	tst.b	d3
	beq.s	loc_17F9C
	moveq	#$1,d3
	bra.s	loc_17FCA
loc_17F9C:
	st	d3
	moveq	#$7,d2
	lea	-$52(a6),a0
loc_17FA4:
	move.b	(a0,d2.w),d0
	andi.b	#$4,d0
	bne.s	loc_17FCA
	dbf	d0,loc_17FA4
	bsr.w	sub_19166
	tst.w	d0
	bne.s	loc_17FCA
	st	d7
	bsr.w	sub_1991C
	bsr.w	sub_19166
	tst.w	d0
	bne.s	loc_17FCA
	moveq	#-$2,d3
loc_17FCA:
	clr.b	d7
	cmp.b	#$1,d3
	bne.s	loc_17FD4
	st	d7
loc_17FD4:
	bsr.w	sub_1991C
	move.b	d3,d0
	movem.l	(a7)+,d2-d4
	rts

; ---------------------------------------------------------------------------
sub_17FE0:
	tst.w	$26(a1)
	beq.s	loc_17FEA
	tst.w	$2A(a1)
loc_17FEA:
	rts

; ---------------------------------------------------------------------------
sub_17FEC:
	clr.b	d7
	bsr.w	sub_1991C
	st	-$D4(a6)
	bsr.s	sub_17FE0
	beq.s	loc_18008
	bsr.w	sub_1800E
	move.b	d0,-$D4(a6)
	bmi.s	loc_18008
	moveq	#$0,d0
	bra.s	loc_1800A
loc_18008:
	st	d0
loc_1800A:
	tst.b	d0
	rts

; ---------------------------------------------------------------------------
sub_1800E:
	movem.l	d2-d4/a1-a2,-(a7)
	st	d4
	clr.b	d3
	moveq	#$7,d2
loc_18018:
	move.w	d2,d0
	move.w	#$31,d1
	bsr.w	sub_198FC
	tst.b	d0
	beq.s	loc_1802E
	cmp.b	d3,d0
	bls.s	loc_1802E
	move.l	d0,d3
	move.l	d2,d4
loc_1802E:
	dbf	d2,loc_18018
	move.l	d4,d0
	move.l	d3,d1
	movem.l	(a7)+,d2-d4/a1-a2
	rts

; ---------------------------------------------------------------------------
sub_1803C:
	movem.l	d1-d2,-(a7)
	moveq	#$0,d1
	move.b	d0,d1
	move.w	#$2,d0
	bsr.w	sub_198E0
	mulu.w	d0,d1
	divu.w	#$64,d1
	move.w	#$6,d0
	bsr.w	sub_198E0
	mulu.w	d0,d1
	divu.w	#$64,d1
	move.l	d1,-(a7)
	jsr	($6D06).w
	move.l	(a7)+,d1
	moveq	#$0,d2
	cmp.b	#$5F,d0
	bhi.s	loc_1807A
loc_18070:
	cmp.b	d1,d0
	bhi.s	loc_1807A
	addq.l	#$1,d2
	lsr.b	#$1,d1
	bra.s	loc_18070
loc_1807A:
	move.l	d2,d0
	movem.l	(a7)+,d1-d2
	cmp.b	#$4,d0
	bcs.s	loc_18088
	moveq	#$3,d0
loc_18088:
	rts

; ---------------------------------------------------------------------------
sub_1808A:
	movem.l	d6-d7/a1,-(a7)
	moveq	#$0,d7
	move.b	d0,d7
	moveq	#$0,d6
	bsr.w	sub_191FC
	move.w	#$EC,d0
	tst.b	d7
	bpl.s	loc_180B8
	move.w	#$EB,d0
	cmp.b	#$FF,d7
	beq.s	loc_180B0
	move.w	#$EA,d0
	st	d6
loc_180B0:
	bsr.w	sub_11C8E
	bra.w	loc_18102
loc_180B8:
	move.l	d7,d6
	tst.b	-$D4(a6)
	bmi.s	loc_180B0
	move.b	-$D4(a6),d0
	tst.b	d7
	beq.s	loc_180CE
	move.w	#$8000,($FFFFD5AC).w
loc_180CE:
	jsr	($6F14).w
	lea	(a1),a0
	bsr.w	sub_11CA4
	move.w	#$ED,d0
	tst.b	d7
	bne.s	loc_180E4
	add.b	-$D3(a6),d0
loc_180E4:
	bsr.w	sub_11C8E
	tst.b	d7
	bne.s	loc_18102
	bsr.w	sub_1924C
	move.b	-$D3(a6),d0
	cmp.b	#$3,d0
	bne.s	loc_18102
	move.w	#$F1,d0
	bsr.w	sub_11C8E
loc_18102:
	move.w	#$C000,($FFFFD5AC).w
	bsr.w	sub_19976
	move.l	d6,d0
	movem.l	(a7)+,d6-d7/a1
	rts

; ---------------------------------------------------------------------------
sub_18114:
	move.l	d5,-(a7)
	clr.b	d7
	bsr.w	sub_1991C
	bsr.w	sub_19166
	move.l	d0,d2
	st	d7
	bsr.w	sub_1991C
	bsr.w	sub_19166
	move.l	d1,d5
	lsr.w	#$1,d2
	cmp.w	d0,d2
	bcs.s	loc_18142
	moveq	#$0,d5
	move.w	$24(a1),d0
	cmp.w	#$7D,d0
	bhi.s	loc_18142
	moveq	#$5,d5
loc_18142:
	moveq	#$0,d1
	move.b	-$D2(a6),d1
	cmp.b	d1,d5
	bne.s	loc_1815A
	tst.b	d5
	bne.s	loc_1819E
	st	-$D1(a6)
	move.w	#$F3,d0
	bra.s	loc_1817C
loc_1815A:
	bcs.s	loc_18172
	move.w	#$E8,d0
	addq.b	#$1,d1
	move.b	d1,-$D2(a6)
	cmp.b	#$5,d1
	bne.s	loc_1817C
	move.b	#$E9,d0
	bra.s	loc_1817C
loc_18172:
	move.w	#$E7,d0
	subq.b	#$1,d1
	move.b	d1,-$D2(a6)
loc_1817C:
	bsr.w	sub_191FC
	move.w	#$8000,($FFFFD5AC).w
	bsr.w	sub_1924C
	bsr.w	sub_11C8E
	bsr.w	sub_19976
	move.w	#$C000,($FFFFD5AC).w
	st	d0
	bsr.w	sub_17E48
loc_1819E:
	move.l	(a7)+,d5
	rts

; ---------------------------------------------------------------------------
sub_181A2:
	movem.l	d2-d5/a2-a3,-(a7)
	st	d7
	tst.b	-$D1(a6)
	beq.s	loc_181CC
	clr.b	-$D1(a6)
	bsr.w	sub_1991C
	move.b	($FFFF9926).w,d0
	tst.b	-$D4(a6)
	bpl.s	loc_181C2
	addq.b	#$5,d0
loc_181C2:
	bsr.w	sub_192B2
	bne.w	loc_182CC
	bra.s	loc_181D0
loc_181CC:
	bsr.w	sub_182D4
loc_181D0:
	bsr.w	sub_1991C
	bsr.w	sub_1916A
	moveq	#$3,d6
loc_181DA:
	bsr.w	sub_1992A
	moveq	#$0,d4
	move.b	-$5E(a6,d6.w),d4
	beq.w	loc_182B2
	bsr.w	sub_191FC
	move.w	#$8000,($FFFFD5AC).w
	bsr.w	sub_1921E
	move.w	#$101,d0
	cmp.b	#$1,d4
	beq.s	loc_18204
	move.w	#$133,d0
loc_18204:
	bsr.w	sub_11C8E
	clr.b	($FFFFD5AE).w
	moveq	#$0,d0
	move.b	$4(a3),d0
	bsr.w	sub_11BDC
	cmp.b	#$1,d4
	beq.s	loc_18234
	lea	($FFFFD5AE).w,a0
	jsr	(sub_11C18).l
	if DEUTSCH	; DEUTSCH-HOOK 8: Plural Schiffswaffe (Zeichen aus deutsch/optionen.inc)
	move.b	#DE_PLURAL_WAFFE,(a0,d0.w)
	else
	move.b	#$73,(a0,d0.w)
	endif
	addq.l	#$1,d0
	move.b	#$0,(a0,d0.w)
loc_18234:
	bsr.w	sub_11CA0
	bsr.w	sub_19976
	bra.w	loc_182B2
loc_18240:
	move.b	$3(a2),d0
	beq.s	loc_1824C
	subq.b	#$1,d0
	move.b	d0,$3(a2)
loc_1824C:
	moveq	#$0,d0
	move.b	(a2),d0
	addi.b	#$13,d0
	jsr	(sub_1B900).l
	bsr.w	sub_19BAC
	bsr.w	sub_1991C
	move.b	($FFFF9925).w,d2
	add.b	-$D3(a6),d2
	move.b	#$4,d0
	sub.b	-$D2(a6),d0
	sub.b	d0,d2
	st	d0
	lea	($FFFF98F6).w,a0
	bsr.w	sub_19696
	move.b	#$14,d0
	jsr	($6C8C).w
	cmp.b	#$14,d0
	beq.s	loc_18290
	cmp.b	d2,d0
	bcs.s	loc_182B2
loc_18290:
	bsr.w	sub_1963C
	move.l	d0,-(a7)
	moveq	#$0,d1
	move.b	$2(a3),d1
	move.w	#$8000,($FFFFD5AC).w
	bsr.w	sub_19360
	move.l	(a7)+,d1
	tst.b	d0
	bne.s	loc_182C4
	move.l	d1,d0
	bsr.w	sub_17A9A
loc_182B2:
	move.w	#$C000,($FFFFD5AC).w
	dbf	d4,loc_18240
	dbf	d6,loc_181DA
	clr.b	d0
	bra.s	loc_182CC
loc_182C4:
	move.w	#$C000,($FFFFD5AC).w
	st	d0
loc_182CC:
	movem.l	(a7)+,d2-d5/a2-a3
	tst.b	d0
	rts

; ---------------------------------------------------------------------------
sub_182D4:
	movem.l	d2-d3,-(a7)
	move.b	#$3,d0
	jsr	($6C94).w
	tst.b	d0
	bne.w	loc_1837C
	jsr	($6D06).w
	bsr.w	sub_1991C
	cmp.b	($FFFF9926).w,d0
	bhi.w	loc_1837C
	moveq	#$3,d6
loc_182F8:
	bsr.w	sub_1992A
	tst.b	(a2)
	bmi.s	loc_1830A
	move.b	$2(a2),d2
	cmp.b	$1(a2),d2
	bne.s	loc_18310
loc_1830A:
	dbf	d6,loc_182F8
	bra.s	loc_1831A
loc_18310:
	addq.b	#$1,d2
	move.b	d2,$2(a2)
	moveq	#$4,d3
	bra.s	loc_18354
loc_1831A:
	lea	(dat_18382).l,a0
	moveq	#$2,d0
loc_18322:
	move.b	(a0,d0.w),d3
	ext.w	d3
	move.w	$24(a1,d3.w),d2
	cmp.w	(a1,d3.w),d2
	bne.s	loc_18338
	dbf	d0,loc_18322
	bra.s	loc_1837C
loc_18338:
	move.b	#$A,d1
	move.b	#$2,d0
	jsr	($6CE4).w
	add.w	d0,d2
	cmp.w	(a1,d3.w),d2
	bcs.s	loc_18350
	move.w	(a1,d3.w),d2
loc_18350:
	move.w	d2,$24(a1,d3.w)
loc_18354:
	bsr.w	sub_196BC
	beq.s	loc_18360
	move.l	d3,d0
	bsr.w	sub_17D38
loc_18360:
	bsr.w	sub_191FC
	move.w	#$8000,($FFFFD5AC).w
	move.w	#$102,d0
	bsr.w	sub_11C8E
	move.w	#$C000,($FFFFD5AC).w
	bsr.w	sub_19976
loc_1837C:
	movem.l	(a7)+,d2-d3
	rts
dat_18382:
	dc.b	$00,$06,$02,$00

; ---------------------------------------------------------------------------
sub_18386:
	bsr.w	sub_191FC
	clr.b	d7
	bsr.w	sub_1991C
	bsr.w	sub_19166
	moveq	#$0,d5
loc_18396:
	move.l	d5,d0
	jsr	($6F14).w
	jsr	($6F02).w
	move.b	(a0),d0
	bmi.w	loc_18414
	beq.w	loc_18414
	btst	#$6,d0
	bne.w	loc_18414
	move.l	d5,d0
	bsr.w	sub_18466
	bsr.w	sub_184DC
loc_183BC:
	bsr.w	sub_18792
	move.l	d0,-(a7)
	bsr.w	sub_19890
	move.l	(a7)+,d0
	tst.b	d0
	bmi.w	loc_18414
	bne.s	loc_183DC
	bsr.w	sub_1888E
	bmi.s	loc_183BC
	beq.s	loc_18414
	bra.w	loc_18454
loc_183DC:
	cmp.b	#$2,d0
	bcc.s	loc_183F6
	bsr.w	sub_18C30
	tst.b	d0
	bmi.s	loc_183BC
	beq.s	loc_18414
	cmp.b	#$2,d0
	bne.s	loc_18454
	st	d0
	bra.s	loc_18454
loc_183F6:
	bne.s	loc_1840E
	bsr.w	sub_18F42
	bmi.s	loc_183BC
	bsr.w	sub_18E6C
	bsr.w	sub_19890
	move.b	#$6,($FFFFD861).w
	bra.s	loc_18414
loc_1840E:
	bsr.w	sub_19052
	bne.s	loc_183BC
loc_18414:
	addq.l	#$1,d5
	cmp.w	#$8,d5
	bcs.w	loc_18396

; ---------------------------------------------------------------------------
sub_1841E:
	lea	(dat_18456).l,a2
	jsr	(sub_A9B8).l
	move.l	#$80015,($FFFFD5DA).w
	move.l	#$120015,($FFFFD5DE).w
	bsr.w	sub_1343E
	move.l	#$150015,($FFFFD5DA).w
	move.l	#$1F0015,($FFFFD5DE).w
	bsr.w	sub_1343E
	moveq	#$0,d0
loc_18454:
	rts
dat_18456:
	binclude	"data/018456.bin"

; ---------------------------------------------------------------------------
sub_18466:
	movem.l	d2-d3/a1-a3,-(a7)
	move.l	d5,d0
	addi.b	#$80,d0
	moveq	#$8,d2
	moveq	#$11,d3
	jsr	(sub_A85A).l
	move.l	d5,d0
	jsr	($6F14).w
	jsr	($6F02).w
	movea.l	a0,a2
	movea.l	a1,a3
	moveq	#$0,d0
	move.b	$18(a3),d0
	addi.b	#$1F,d0
	moveq	#$10,d2
	moveq	#$11,d3
	jsr	(sub_A85A).l
	clr.b	d0
	bsr.w	sub_184A8
	movem.l	(a7)+,d2-d3/a1-a3
	rts

; ---------------------------------------------------------------------------
sub_184A8:
	move.l	d0,-(a7)
	move.l	#$80015,($FFFFD5DA).w
	move.l	#$120015,($FFFFD5DE).w
	bsr.w	sub_1343E
	move.l	(a7)+,d0
	bmi.s	loc_184DA
	lea	($FFFFD5AE).w,a0
	moveq	#$A,d0
loc_184C8:
	move.b	(a3,d0.w),(a0,d0.w)
	dbf	d0,loc_184C8
	clr.b	$B(a0)
	bsr.w	sub_11CA0
loc_184DA:
	rts

; ---------------------------------------------------------------------------
sub_184DC:
	movem.l	d2-d6/a2-a3,-(a7)
	moveq	#$31,d1
	move.l	d5,d0
	bsr.w	sub_198FC
	move.b	d0,-$CE(a6)
	beq.w	loc_186F2
	clr.b	d7
	bsr.w	sub_1991C
	move.b	-$52(a6,d5.w),d4
	beq.w	loc_186F2
	moveq	#$6,d3
loc_18500:
	btst	d3,d4
	beq.s	loc_1852C
	cmp.b	#$3,d3
	bhi.s	loc_1851A
	move.w	d3,d0
	lsl.w	#$1,d0
	move.w	$24(a1,d0.w),d1
	cmp.w	(a1,d0.w),d1
	bne.s	loc_1852E
	bra.s	loc_1852C
loc_1851A:
	move.l	d3,d6
	subq.w	#$3,d6
	bsr.w	sub_1992A
	move.b	$2(a2),d1
	cmp.b	$1(a2),d1
	bne.s	loc_1852E
loc_1852C:
	bclr	d3,d4
loc_1852E:
	dbf	d3,loc_18500
	tst.b	d4
	beq.w	loc_186F2
	cmp.b	#$10,d4
	bcs.s	loc_18542
	bset	#$2,d4
loc_18542:
	move.b	d4,($FFFFD87C).w
	bsr.w	sub_196BC
	move.b	#$1,($FFFFD875).w
	clr.b	d0
	bsr.w	sub_17E48
	move.w	#$8000,($FFFFD5AC).w
	move.w	#$10E,d0
	bsr.w	sub_11C8E
	move.b	-$CE(a6),d1
	bsr.w	sub_198BA
	move.w	#$C000,($FFFFD5AC).w
loc_18572:
	lea	(dat_18720).l,a2
	jsr	(sub_A9B8).l
	clr.b	($FFFFD593).w
	lea	(dat_18710).l,a2
	move.l	a6,($FFFFD59C).w
	move.l	#$18728,($FFFFD5A0).l
	movea.w	#$0,a3
	move.b	#$2,($FFFFD59B).w
	bsr.w	sub_1391A
	clr.b	($FFFFD59B).w
	clr.l	($FFFFD5A0).w
	cmp.b	#$4,d0
	bcs.s	loc_185B8
	st	d0
	bra.w	loc_186E8
loc_185B8:
	ext.w	d0
	btst	d0,($FFFFD87C).w
	beq.s	loc_185CA
	lea	($FFFF992C).w,a0
	tst.b	(a0,d0.w)
	bne.s	loc_185D6
loc_185CA:
	move.w	#$2A,d0
	jsr	(sub_1B900).l
	bra.s	loc_18572
loc_185D6:
	cmp.b	#$2,d0
	bne.w	loc_1864E
	bsr.w	sub_1991C
	moveq	#$1,d6
loc_185E4:
	move.b	d6,d0
	addq.b	#$3,d0
	btst	d0,d4
	beq.s	loc_18602
	bsr.w	sub_1992A
	tst.b	$1(a3)
	beq.s	loc_1861E
	tst.b	$3(a2)
	bne.s	loc_1861E
	tst.b	$4(a2)
	bne.s	loc_1861E
loc_18602:
	addq.w	#$1,d6
	cmp.w	#$4,d6
	bcs.s	loc_185E4
	moveq	#$1,d6
	move.b	d6,d0
	addq.b	#$3,d0
	btst	d0,d4
	bne.s	loc_1861E
	addq.w	#$1,d6
	cmp.w	#$4,d6
	bcs.w	loc_1852C
loc_1861E:
	moveq	#$1,d4
	moveq	#$0,d3
	move.b	$4(a3),d3
	bsr.w	sub_18768
	bne.w	loc_186AE
	move.l	d6,d0
	addq.b	#$3,d0
	bclr	d0,-$52(a6,d5.w)
	move.b	$2(a2),d0
	addq.b	#$1,d0
	cmp.b	$1(a2),d0
	bhi.w	loc_186AE
	move.b	d0,$2(a2)
	moveq	#$4,d1
	bra.w	loc_1868C
loc_1864E:
	moveq	#$0,d4
	move.b	d0,d3
	ext.w	d3
	move.l	d3,d2
	addi.w	#$F8,d3
	bsr.w	sub_18768
	bne.w	loc_186AE
	bclr	d2,-$52(a6,d5.w)
	moveq	#$2,d0
	move.b	#$14,d1
	jsr	($6CE4).w
	move.w	d2,d1
	lsl.b	#$1,d1
	bsr.w	sub_1991C
	move.w	$24(a1,d1.w),d2
	add.w	d0,d2
	cmp.w	(a1,d1.w),d2
	bcs.s	loc_18688
	move.w	(a1,d1.w),d2
loc_18688:
	move.w	d2,$24(a1,d1.w)
loc_1868C:
	bsr.w	sub_196BC
	beq.s	loc_18698
	move.l	d1,d0
	bsr.w	sub_17D38
loc_18698:
	move.l	d1,d0
	bsr.w	sub_17A9A
	move.w	#$29,d0
	jsr	(sub_1B900).l
	move.w	#$103,d0
	bra.s	loc_186BC
loc_186AE:
	move.w	#$2A,d0
	jsr	(sub_1B900).l
	move.w	#$104,d0
loc_186BC:
	move.l	d0,-(a7)
	bsr.w	sub_191FC
	move.l	d5,d0
	jsr	($6F14).w
	lea	(a1),a0
	bsr.w	sub_11CA4
	move.l	(a7)+,d0
	bsr.w	sub_11C8E
	move.w	#$105,d0
	add.b	d4,d0
	bsr.w	sub_11C8E
	move.w	d3,d0
	bsr.w	sub_11C8E
	bsr.w	sub_19976
loc_186E8:
	st	($FFFFD875).w
	st	d7
	bsr.w	sub_17BEC
loc_186F2:
	st	d7
	st	d0
	bsr.w	sub_17E48
	clr.b	d7
	movem.l	(a7)+,d2-d6/a2-a3
	rts
	binclude	"data/018702.bin"
dat_18710:
	binclude	"data/018710.bin"
dat_18720:
	binclude	"data/018720.bin"

; ---------------------------------------------------------------------------
sub_18768:
	movem.l	d2-d3/a1-a2,-(a7)
	move.l	d5,d0
	move.w	#$31,d1
	bsr.w	sub_198FC
	move.l	d0,d3
	jsr	($6D06).w
	moveq	#$1,d1
	cmp.b	#$5F,d0
	bhi.s	loc_1878A
	cmp.b	d3,d0
	bhi.s	loc_1878A
	moveq	#$0,d1
loc_1878A:
	movem.l	(a7)+,d2-d3/a1-a2
	tst.b	d1
	rts

; ---------------------------------------------------------------------------
sub_18792:
	movem.l	d1-d6/a1-a3,-(a7)
	bsr.w	sub_17FEC
	lea	-$CD(a6),a0
	lea	(dat_1887A).l,a1
	moveq	#$9,d0
loc_187A6:
	move.b	(a1,d0.w),(a0,d0.w)
	dbf	d0,loc_187A6
	lea	-$7E(a6),a0
	lea	(dat_18884).l,a1
	moveq	#$9,d0
loc_187BC:
	move.b	(a1,d0.w),(a0,d0.w)
	dbf	d0,loc_187BC
	jsr	(sub_13DA2).l
	moveq	#$1,d4
	cmp.b	-$D4(a6),d5
	beq.s	loc_18830
	moveq	#$2,d4
	move.b	#$21,-$C8(a6)
	move.w	#$113,-$78(a6)
	bsr.w	sub_18DF6
	beq.s	loc_18830
	moveq	#$3,d4
	move.b	#$65,-$C8(a6)
	move.w	#$112,-$78(a6)
	moveq	#$3,d6
	clr.b	d7
	bsr.w	sub_1991C
	clr.b	-$CF(a6)
loc_18802:
	bsr.w	sub_1992A
	tst.b	$2(a2)
	beq.s	loc_1881C
	tst.b	$4(a2)
	beq.s	loc_1881C
	tst.b	$3(a2)
	bne.s	loc_1881C
	bset	d6,-$CF(a6)
loc_1881C:
	dbf	d6,loc_18802
	tst.b	-$CF(a6)
	bne.s	loc_18830
	lea	-$CD(a6),a0
	moveq	#$1,d0
	bsr.w	sub_13E56
loc_18830:
	moveq	#$3,d6
loc_18832:
	tst.b	-$5E(a6,d6.w)
	bne.s	loc_18846
	dbf	d6,loc_18832
	lea	-$CD(a6),a0
	moveq	#$0,d0
	bsr.w	sub_13E56
loc_18846:
	clr.b	($FFFFD593).w
	lea	-$CD(a6),a2
	lea	-$7E(a6),a3
	bsr.w	sub_1391A
	tst.b	d0
	bmi.s	loc_18846
	move.l	d0,-(a7)
	bsr.w	sub_13DD6
	st	d1
	move.l	(a7)+,d0
	cmp.b	#$1,d0
	bhi.s	loc_18872
	beq.s	loc_18870
	moveq	#$0,d1
	bra.s	loc_18872
loc_18870:
	move.l	d4,d1
loc_18872:
	move.l	d1,d0
	movem.l	(a7)+,d1-d6/a1-a3
	rts
dat_1887A:
	binclude	"data/01887A.bin"
dat_18884:
	binclude	"data/018884.bin"

; ---------------------------------------------------------------------------
sub_1888E:
	movem.l	d2-d6/a2-a3,-(a7)
	move.l	d5,d0
	jsr	($6F14).w
	moveq	#$3C,d3
	sub.b	$22(a1),d3
	sub.b	-$D3(a6),d3
	move.b	#$4,d0
	sub.b	-$D2(a6),d0
	sub.b	d0,d3
	st	d7
	bsr.w	sub_1991C
	sub.b	$8(a1),d3
	move.b	d3,-$CE(a6)
	clr.b	d7
	bsr.w	sub_13DA2
	lea	(dat_18A84).l,a0
	moveq	#$2,d6
	st	($FFFFD593).w
loc_188CC:
	tst.b	-$5D(a6,d6.w)
	bne.s	loc_188DA
	move.l	d6,d0
	bsr.w	sub_13E56
	bra.s	loc_188DE
loc_188DA:
	move.b	d6,($FFFFD593).w
loc_188DE:
	dbf	d6,loc_188CC
	moveq	#$0,d6
	move.b	-$66(a6,d5.w),d6
	tst.b	-$5D(a6,d6.w)
	beq.s	loc_188F2
	move.b	d6,($FFFFD593).w
loc_188F2:
	move.l	a6,($FFFFD59C).w
	move.l	#$18AB2,($FFFFD5A0).l
	lea	(dat_18A84).l,a2
	movea.w	#$0,a3
	bsr.w	sub_1391A
	move.l	d0,-(a7)
	clr.l	($FFFFD5A0).w
	bsr.w	sub_13DD6
	move.l	(a7)+,d0
	tst.b	d0
	bmi.w	loc_18A6C
	move.b	d0,-$66(a6,d5.w)
	moveq	#$1,d6
	add.b	d0,d6
	clr.b	d7
	bsr.w	sub_1991C
	bsr.w	sub_1992A
	moveq	#$0,d0
	move.b	$3(a3),d0
	sub.b	d0,-$CE(a6)
	clr.b	($FFFFD593).w
	tst.b	-$6E(a6,d5.w)
	bmi.s	loc_1894C
	move.b	#$1,($FFFFD593).w
loc_1894C:
	lea	(dat_18A8E).l,a2
	lea	(dat_18A98).l,a3
	bsr.w	sub_1391A
	cmp.b	#$1,d0
	bhi.w	loc_18A6C
	beq.s	loc_18970
	st	-$6E(a6,d5.w)
	bsr.w	sub_1963C
	bra.s	loc_189D8
loc_18970:
	lea	(dat_18720).l,a2
	jsr	(sub_A9B8).l
	move.b	-$6E(a6,d5.w),($FFFFD593).w
	bpl.s	loc_1898A
	move.b	-$E1(a6),($FFFFD593).w
loc_1898A:
	lea	(dat_18AA2).l,a2
	move.l	a6,($FFFFD59C).w
	move.l	#$18BC0,($FFFFD5A0).l
	movea.w	#$0,a3
	move.b	#$1,($FFFFD59B).w
	bsr.w	sub_1391A
	clr.b	($FFFFD59B).w
	clr.l	($FFFFD5A0).w
	cmp.b	#$3,d0
	bhi.w	loc_18A6C
	ext.w	d0
	move.b	d0,-$6E(a6,d5.w)
	moveq	#$0,d1
	lea	(dat_196B6).l,a0
	move.b	(a0,d0.w),d1
	add.b	d1,-$CE(a6)
	move.b	d0,-$E1(a6)
	asl.w	#$1,d0
loc_189D8:
	move.l	d0,d4
	lea	(dat_177EE).l,a0
	moveq	#$0,d0
	move.b	($FFFF9924).w,d0
	lsl.b	#$3,d0
	adda.l	d0,a0
	move.b	(a0,d4.w),-$DD(a6)
	move.b	$1(a0,d4.w),-$DE(a6)
	move.b	#$C,d0
	add.b	d6,d0
	move.b	d0,-$DF(a6)
	clr.b	-$E0(a6)
	clr.b	d7
	bsr.w	sub_1991C
	bsr.w	sub_1992A
	move.b	$3(a2),d0
	beq.s	loc_18A1A
	subq.b	#$1,d0
	move.b	d0,$3(a2)
loc_18A1A:
	moveq	#$1,d0
	sub.b	d0,-$5E(a6,d6.w)
	moveq	#$0,d0
	move.b	(a2),d0
	addi.b	#$13,d0
	jsr	(sub_1B900).l
	move.w	#$14,d0
	jsr	($6C8C).w
	cmp.b	#$14,d0
	beq.s	loc_18A44
	cmp.b	-$CE(a6),d0
	bcs.w	loc_18A48
loc_18A44:
	st	-$E0(a6)
loc_18A48:
	bsr.w	sub_19A74
	tst.b	-$E0(a6)
	beq.s	loc_18A68
	moveq	#$0,d1
	move.b	$2(a3),d1
	move.l	d4,d0
	clr.b	d7
	bsr.w	sub_19360
	tst.b	d0
	beq.s	loc_18A68
	moveq	#$1,d0
	bra.s	loc_18A7A
loc_18A68:
	clr.b	d0
	bra.s	loc_18A7A
loc_18A6C:
	st	d0
	st	d7
	bsr.w	sub_17E48
	bsr.w	sub_191FC
	st	d0
loc_18A7A:
	clr.b	d7
	movem.l	(a7)+,d2-d6/a2-a3
	tst.b	d0
	rts
dat_18A84:
	binclude	"data/018A84.bin"
dat_18A8E:
	binclude	"data/018A8E.bin"
dat_18A98:
	binclude	"data/018A98.bin"
dat_18AA2:
	binclude	"data/018AA2.bin"

; ---------------------------------------------------------------------------
sub_18C30:
	lea	(dat_177EE).l,a0
	moveq	#$0,d0
	move.b	($FFFF9924).w,d0
	lsl.b	#$3,d0
	move.b	(a0),-$DD(a6)
	move.b	$1(a0),-$DE(a6)
	move.b	#$D,-$DF(a6)
	moveq	#$0,d6
	moveq	#$3F,d4
	move.w	#$115,d3
	tst.b	-$D2(a6)
	bne.s	loc_18CBE
	moveq	#$1,d6
	moveq	#$42,d4
	move.l	#$118,d3
	st	d7
	bsr.w	sub_1991C
	bsr.w	sub_17FE0
	beq.s	loc_18CBE
	moveq	#$2,d6
	moveq	#$41,d4
	move.l	#$117,d3
	moveq	#$31,d1
	move.l	d5,d0
	bsr.w	sub_198FC
	move.b	d0,-$CE(a6)
	moveq	#$0,d0
	add.b	-$D3(a6),d0
	sub.b	$9(a1),d0
	ext.w	d0
	mulu.w	#$5,d0
	add.b	d0,-$CE(a6)
	clr.b	d0
	bsr.w	sub_17E48
	move.w	#$8000,($FFFFD5AC).w
	move.w	#$11E,d0
	bsr.w	sub_11C8E
	move.b	-$CE(a6),d1
	bsr.w	sub_198BA
	move.w	#$C000,($FFFFD5AC).w
loc_18CBE:
	lea	-$CD(a6),a2
	lea	(dat_18DC0).l,a1
	moveq	#$9,d0
loc_18CCA:
	move.b	(a1,d0.w),(a2,d0.w)
	dbf	d0,loc_18CCA
	move.b	d4,$2(a2)
	lea	-$7E(a6),a3
	lea	(dat_18DCA).l,a1
	moveq	#$9,d0
loc_18CE4:
	move.b	(a1,d0.w),(a3,d0.w)
	dbf	d0,loc_18CE4
	move.w	d3,$4(a3)
	clr.b	($FFFFD593).w
	bsr.w	sub_1391A
	cmp.b	#$1,d0
	bls.s	loc_18D06
	st	d0
	bra.w	loc_18DBC
loc_18D06:
	bne.s	loc_18D3C
	move.b	-$D2(a6),d1
	addq.b	#$1,d1
	move.b	d1,-$D2(a6)
	moveq	#$3,d0
	cmp.b	#$5,d1
	beq.w	loc_18DBC
	cmp.b	#$3,d1
	bcs.w	loc_18DB0
	clr.b	-$5D(a6)
	cmp.b	#$4,d1
	bcs.w	loc_18DB0
	clr.b	-$5C(a6)
	clr.b	-$5B(a6)
	bra.w	loc_18DB0
loc_18D3C:
	cmp.b	#$1,d6
	beq.s	loc_18D72
	bhi.s	loc_18D76
	clr.b	d7
	bsr.w	sub_1991C
	move.b	-$D2(a6),d1
	subq.b	#$1,d1
	move.b	d1,-$D2(a6)
	cmp.b	#$2,d1
	bcs.s	loc_18DB0
	beq.s	loc_18D6A
	moveq	#$2,d6
	bsr.w	sub_18DD4
	moveq	#$3,d6
	bsr.w	sub_18DD4
	bra.s	loc_18DB0
loc_18D6A:
	moveq	#$1,d6
	bsr.w	sub_18DD4
	bra.s	loc_18DB0
loc_18D72:
	moveq	#$4,d0
	bra.s	loc_18DBC
loc_18D76:
	bsr.w	sub_191FC
	move.l	d5,d0
	jsr	($6F14).w
	lea	(a1),a0
	bsr.w	sub_11CA4
	move.w	#$F3,d0
	bsr.w	sub_11C8E
	bsr.w	sub_19976
	clr.b	d7
	moveq	#$0,d0
	move.b	-$CE(a6),d0
	bsr.w	sub_192B2
	move.l	d0,-(a7)
	st	d7
	st	d0
	bsr.w	sub_17E48
	move.l	(a7)+,d0
	bpl.s	loc_18DBC
	moveq	#$2,d0
	bra.s	loc_18DBC
loc_18DB0:
	st	d7
	st	d0
	bsr.w	sub_17E48
	clr.b	d7
	moveq	#$0,d0
loc_18DBC:
	clr.b	d7
	rts
dat_18DC0:
	binclude	"data/018DC0.bin"
dat_18DCA:
	binclude	"data/018DCA.bin"

; ---------------------------------------------------------------------------
sub_18DD4:
	bsr.w	sub_1992A
	move.b	$2(a2),d0
	tst.b	(a2)
	bmi.s	loc_18DF0
	move.b	$3(a2),d1
	tst.b	$1(a3)
	beq.s	loc_18DF0
	cmp.b	d1,d0
	bcs.s	loc_18DF0
	move.l	d1,d0
loc_18DF0:
	move.b	d0,-$5E(a6,d6.w)
	rts

; ---------------------------------------------------------------------------
sub_18DF6:
	movem.l	d3-d4/d6,-(a7)
	moveq	#$1,d6
	moveq	#$5,d0
loc_18DFE:
	st	-$42(a6,d0.w)
	dbf	d0,loc_18DFE
	moveq	#$0,d3
	move.l	d5,d0
	jsr	($6F14).w
	tst.b	$32(a1)
	beq.s	loc_18E62
	moveq	#$0,d4
loc_18E16:
	move.l	d4,d0
	jsr	($6F02).w
	jsr	($6F14).w
	move.b	(a0),d0
	cmp.b	#$1,d0
	beq.s	loc_18E2E
	cmp.b	#$84,d0
	bne.s	loc_18E5A
loc_18E2E:
	tst.b	-$5A(a6,d4.w)
	bne.s	loc_18E44
	move.b	$E(a0),d0
	cmp.b	$2E(a1),d0
	beq.s	loc_18E4C
	btst	d4,-$4A(a6,d5.w)
	beq.s	loc_18E4C
loc_18E44:
	moveq	#$0,d6
	move.b	d4,-$42(a6,d3.w)
	bra.s	loc_18E58
loc_18E4C:
	move.l	#$80,d0
	add.w	d4,d0
	move.b	d0,-$42(a6,d3.w)
loc_18E58:
	addq.l	#$1,d3
loc_18E5A:
	addq.l	#$1,d4
	cmp.w	#$8,d4
	bcs.s	loc_18E16
loc_18E62:
	move.l	d6,d0
	movem.l	(a7)+,d3-d4/d6
	tst.b	d0
	rts

; ---------------------------------------------------------------------------
sub_18E6C:
	movem.l	d2-d4/d6,-(a7)
	moveq	#$0,d6
	moveq	#$0,d4
	move.b	d0,d4
	moveq	#$4,d0
	jsr	($6C8C).w
	move.l	d0,d2
	move.l	d5,d0
	move.w	#$32,d1
	bsr.w	sub_198FC
	move.w	d0,d3
	jsr	($6D06).w
	cmp.b	d3,d0
	bhi.s	loc_18E9A
	moveq	#$8,d0
	jsr	($6C8C).w
	move.l	d0,d2
loc_18E9A:
	moveq	#$0,d0
	move.b	-$42(a6,d4.w),d0
	btst	d0,-$4A(a6,d5.w)
	beq.s	loc_18ED4
	moveq	#$2,d6
	move.b	-$5A(a6,d0.w),d1
	beq.s	loc_18EB6
	cmp.b	d1,d2
	bls.s	loc_18ED4
	sub.b	d1,d2
	moveq	#$1,d6
loc_18EB6:
	jsr	($6F14).w
	jsr	($6F02).w
	move.b	$2E(a1),d1
	sub.b	$E(a0),d1
	cmp.b	d1,d2
	bcs.s	loc_18ECC
	move.b	d1,d2
loc_18ECC:
	add.b	d2,$E(a0)
	move.b	#$1,(a0)
loc_18ED4:
	bclr	d0,-$4A(a6,d5.w)
	clr.b	-$5A(a6,d0.w)
	bsr.w	sub_191FC
	jsr	($6F14).w
	lea	(a1),a0
	bsr.w	sub_11CA4
	move.l	d6,d0
	addi.w	#$107,d0
	bsr.w	sub_11C8E
	tst.b	d6
	beq.s	loc_18F38
	moveq	#$0,d0
	move.b	d2,d0
	move.w	#$1,($FFFFD5AA).w
	bsr.w	sub_13376
	bsr.w	sub_11CA0
	clr.b	($FFFFD5AE).w
	move.w	#$10A,d0
	bsr.w	sub_11BDC
	cmp.b	#$1,d2
	beq.s	loc_18F34
	lea	($FFFFD5AE).w,a0
	jsr	(sub_11C18).l
	if DEUTSCH	; DEUTSCH-HOOK 9: Plural Trefferpunkt (Zeichen aus deutsch/optionen.inc)
	move.b	#DE_PLURAL_TP,(a0,d0.w)
	else
	move.b	#$73,(a0,d0.w)
	endif
	addq.l	#$1,d0
	move.b	#$0,(a0,d0.w)
loc_18F34:
	bsr.w	sub_11CA0
loc_18F38:
	bsr.w	sub_19976
	movem.l	(a7)+,d2-d4/d6
	rts

; ---------------------------------------------------------------------------
sub_18F42:
	lea	-$CD(a6),a0
	lea	(dat_18FCE).l,a1
	moveq	#$12,d0
loc_18F4E:
	move.b	(a1,d0.w),(a0,d0.w)
	dbf	d0,loc_18F4E
	bsr.w	sub_13DA2
	moveq	#$5,d2
loc_18F5E:
	lea	-$CD(a6),a0
	moveq	#$0,d0
	move.b	-$42(a6,d2.w),d0
	cmp.b	#$FF,d0
	beq.s	loc_18F82
	move.l	d0,d3
	bset	#$7,d0
	move.l	d2,d1
	mulu.w	#$3,d1
	move.b	d0,$2(a0,d1.w)
	tst.b	d3
	bpl.s	loc_18F88
loc_18F82:
	move.l	d2,d0
	bsr.w	sub_13E56
loc_18F88:
	dbf	d2,loc_18F5E
	clr.b	($FFFFD593).w
	move.b	#$0,($FFFFD861).w
	lea	-$CD(a6),a2
	move.l	a6,($FFFFD59C).w
	move.l	#$18FE2,($FFFFD5A0).l
	movea.w	#$0,a3
	bsr.w	sub_1391A
	move.l	d0,-(a7)
	clr.l	($FFFFD5A0).w
	bsr.w	sub_13DD6
	move.l	(a7)+,d0
	tst.b	d0
	bpl.s	loc_18FCA
	bsr.w	sub_19890
	move.b	#$6,($FFFFD861).w
loc_18FCA:
	tst.b	d0
	rts
dat_18FCE:
	binclude	"data/018FCE.bin"

; ---------------------------------------------------------------------------
sub_19052:
	bsr.w	sub_13DA2
	lea	(dat_190EE).l,a0
	btst	#$1,-$CF(a6)
	bne.s	loc_1906A
	moveq	#$0,d0
	bsr.w	sub_13E56
loc_1906A:
	btst	#$2,-$CF(a6)
	bne.s	loc_19078
	moveq	#$1,d0
	bsr.w	sub_13E56
loc_19078:
	lea	(dat_190EE).l,a2
	clr.b	($FFFFD593).w
	move.l	a6,($FFFFD59C).w
	move.l	#$190F8,($FFFFD5A0).l
	movea.w	#$0,a3
	bsr.w	sub_1391A
	move.l	d0,-(a7)
	clr.l	($FFFFD5A0).w
	bsr.w	sub_13DD6
	bsr.w	sub_191FC
	move.l	(a7)+,d0
	cmp.b	#$1,d0
	bhi.s	loc_190EA
	moveq	#$1,d6
	add.b	d0,d6
	clr.b	d7
	bsr.w	sub_1991C
	bsr.w	sub_1992A
	moveq	#$1,d0
	sub.b	d0,$4(a2)
	move.b	$2(a2),d0
	moveq	#$0,d1
	move.b	$1(a3),d1
	mulu.w	d1,d0
	move.b	d0,$3(a2)
	moveq	#$0,d0
	move.b	$4(a3),d0
	bsr.w	sub_11C8E
	move.w	#$11F,d0
	bsr.w	sub_11C8E
	bsr.w	sub_19976
	moveq	#$0,d0
loc_190EA:
	tst.b	d0
	rts
dat_190EE:
	binclude	"data/0190EE.bin"

; ---------------------------------------------------------------------------
sub_19166:
	moveq	#$0,d0
	bra.s	loc_1916C

; ---------------------------------------------------------------------------
sub_1916A:
	moveq	#$1,d0
loc_1916C:
	movem.l	d3-d5,-(a7)
	move.l	d0,d5
	moveq	#$0,d3
	moveq	#$5,d4
	clr.l	-$5E(a6)
	moveq	#$3,d6
loc_1917C:
	bsr.w	sub_1992A
	move.b	$2(a2),d0
	tst.b	(a2)
	bmi.s	loc_191C4
	move.b	$3(a2),d1
	tst.b	$1(a3)
	beq.s	loc_191C4
	tst.b	d5
	beq.s	loc_191BE
	tst.b	d1
	bne.s	loc_191BE
	tst.b	$4(a2)
	beq.s	loc_191BE
	move.b	$4(a2),d1
	subq.b	#$1,d1
	move.b	d1,$4(a2)
	moveq	#$0,d1
	move.b	$1(a3),d1
	move.b	$1(a2),d0
	ext.w	d0
	mulu.w	d0,d1
	move.b	d1,$3(a2)
	moveq	#$0,d1
loc_191BE:
	cmp.b	d1,d0
	bcs.s	loc_191C4
	move.b	d1,d0
loc_191C4:
	move.b	d0,-$5E(a6,d6.w)
	beq.s	loc_191EE
	move.b	(a3),d0
	cmp.b	d4,d0
	bhi.s	loc_191D2
	move.b	d0,d4
loc_191D2:
	cmp.b	-$D2(a6),d0
	bcc.s	loc_191DE
	clr.b	-$5E(a6,d6.w)
	bra.s	loc_191EE
loc_191DE:
	moveq	#$0,d0
	move.b	$2(a3),d0
	moveq	#$0,d1
	move.b	-$5E(a6,d6.w),d1
	mulu.w	d1,d0
	add.w	d0,d3
loc_191EE:
	dbf	d6,loc_1917C
	move.b	d3,d0
	move.b	d4,d1
	movem.l	(a7)+,d3-d5
	rts

; ---------------------------------------------------------------------------
sub_191FC:
	movem.l	d0-d1/a0-a1,-(a7)
	move.l	#$70018,($FFFFD5DA).w
	move.l	#$20001A,($FFFFD5DE).w
	bsr.w	sub_1343E
	movem.l	(a7)+,d0-d1/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_1921A:
	st	-$D5(a6)

; ---------------------------------------------------------------------------
sub_1921E:
	tst.b	d7
	bne.s	sub_1924C
	move.w	#$C7,d0
	tst.b	-$D5(a6)
	bne.s	loc_19232
	bsr.w	sub_11C8E
	bra.s	loc_1924A
loc_19232:
	clr.b	($FFFFD5AE).w
	bsr.w	sub_11BDC
	move.l	#$13000E,($FFFFD5D6).w
	bsr.w	sub_11C4C
	clr.b	-$D5(a6)
loc_1924A:
	rts

; ---------------------------------------------------------------------------
sub_1924C:
	movem.l	d0-d1/a0-a1,-(a7)
	lea	-$BA(a6),a0
	clr.b	($FFFFD5AE).w
	moveq	#$0,d0
	move.b	$23(a0),d0
	move.b	d0,d1
	beq.s	loc_19272
	move.w	#$3,($FFFFD5AA).w
	bsr.w	sub_13376
	bsr.w	sub_1368C
	moveq	#$1,d1
loc_19272:
	lea	-$BA(a6),a0
	move.b	$22(a0),d0
	tst.b	d1
	bne.s	loc_19284
	bsr.w	sub_11BDC
	bra.s	loc_19288
loc_19284:
	bsr.w	sub_11B9A
loc_19288:
	move.w	#$F2,d0
	bsr.w	sub_11B9A
	tst.b	-$D5(a6)
	bne.s	loc_1929C
	bsr.w	sub_11CA0
	bra.s	loc_192AC
loc_1929C:
	move.l	#$13000E,($FFFFD5D6).w
	bsr.w	sub_11C4C
	clr.b	-$D5(a6)
loc_192AC:
	movem.l	(a7)+,d0-d1/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_192B2:
	movem.l	d2,-(a7)
	move.b	d0,d2
	bsr.w	sub_191FC
	tst.b	d7
	beq.s	loc_192C6
	move.w	#$8000,($FFFFD5AC).w
loc_192C6:
	jsr	($6D06).w
	cmp.b	#$5F,d0
	bhi.s	loc_19344
	cmp.b	d0,d2
	bcs.s	loc_19344
	move.w	#$F4,d0
	bsr.w	sub_11C8E
	bsr.w	sub_19976
	bsr.w	sub_1991C
	moveq	#$0,d1
	move.w	$20(a1),d1
	moveq	#$0,d0
	bsr.w	sub_19360
	move.w	#$C000,($FFFFD5AC).w
	moveq	#$0,d0
	bsr.w	sub_17A9A
	bsr.w	sub_19984
	tst.b	d7
	beq.s	loc_1930A
	move.w	#$8000,($FFFFD5AC).w
loc_1930A:
	bsr.w	sub_1991C
	moveq	#$0,d1
	move.w	$20(a1),d1
	moveq	#$0,d0
	bsr.w	sub_19360
	moveq	#$0,d0
	bsr.w	sub_17A9A
	bsr.w	sub_19984
	bsr.w	sub_1991C
	moveq	#-$1,d0
	lea	($FFFF98F6).w,a0
	tst.w	$24(a0)
	beq.s	loc_19352
	moveq	#$1,d0
	lea	-$BA(a6),a0
	tst.w	$24(a0)
	beq.s	loc_19352
	moveq	#$0,d0
	bra.s	loc_19352
loc_19344:
	move.w	#$F5,d0
	bsr.w	sub_11C8E
	bsr.w	sub_19976
	moveq	#$0,d0
loc_19352:
	move.w	#$C000,($FFFFD5AC).w
	movem.l	(a7)+,d2
	tst.b	d0
	rts

; ---------------------------------------------------------------------------
sub_19360:
	movem.l	d2-d7/a1-a3,-(a7)
	bsr.w	sub_19984
	bsr.w	sub_1991C
	move.l	d1,d2
	bsr.w	sub_191FC
	bsr.w	sub_19670
	move.w	d0,d3
	bpl.s	loc_1938E
	move.w	#$100,d0
	bsr.w	sub_11C8E
	bsr.w	sub_19550
	bsr.w	sub_19976
	bra.w	loc_1953A
loc_1938E:
	cmp.b	#$4,d3
	bne.s	loc_193B6
	move.b	$2(a2),d0
	subq.b	#$1,d0
	move.b	d0,$2(a2)
	moveq	#$0,d0
	move.b	$4(a3),d0
	bsr.w	sub_11C8E
	move.w	#$FA,d0
	bsr.w	sub_11C8E
	bsr.w	sub_1921E
	bra.s	loc_193FE
loc_193B6:
	moveq	#$0,d0
	move.w	$24(a1,d3.w),d0
	cmp.w	d0,d2
	bcs.s	loc_193C2
	move.w	d2,d0
loc_193C2:
	sub.w	d2,d0
	move.w	d0,$24(a1,d3.w)
	move.l	d2,d0
	move.w	#$4,($FFFFD5AA).w
	bsr.w	sub_13376
	bsr.w	sub_1368C
	bsr.w	sub_11CA0
	move.w	#$F6,d0
	bsr.w	sub_11C8E
	bsr.w	sub_1921E
	move.w	#$F7,d0
	bsr.w	sub_11C8E
	moveq	#$0,d0
	move.b	d3,d0
	lsr.w	#$1,d0
	addi.w	#$F8,d0
	bsr.w	sub_11C8E
loc_193FE:
	tst.b	d7
	bne.s	loc_19414
	move.l	#$190,d0
	moveq	#$0,d1
	moveq	#$10,d2
	jsr	(sub_A102).l
	bra.s	loc_19426
loc_19414:
	bsr.w	sub_19550
	bsr.w	sub_196BC
	beq.s	loc_19426
	move.l	d3,d0
	bsr.w	sub_17D38
	bra.s	loc_1942A
loc_19426:
	bsr.w	sub_19976
loc_1942A:
	cmp.w	#$0,d3
	bne.w	loc_194E8
	bsr.w	sub_1991C
	tst.w	$24(a1,d3.w)
	bne.w	loc_1953A
	bsr.w	sub_191FC
	bsr.w	sub_1921E
	move.w	#$FC,d0
	bsr.w	sub_11C8E
	tst.b	d7
	bne.s	loc_19486
	move.l	#$190,d0
	moveq	#$0,d1
	moveq	#$10,d2
	jsr	(sub_A102).l
	move.l	#$190,d0
	moveq	#$0,d1
	moveq	#$10,d2
	jsr	(sub_A102).l
	move.l	#$190,d0
	moveq	#$0,d1
	moveq	#$10,d2
	jsr	(sub_A102).l
	bra.w	loc_1953E
loc_19486:
	move.w	#$0,$26(a1)
	bsr.w	sub_196BC
	bne.s	loc_1949E
	moveq	#$50,d0
	moveq	#$48,d1
	moveq	#$D,d2
	jsr	(sub_A102).l
loc_1949E:
	bsr.w	sub_1991C
	move.w	#$0,$2A(a1)
	bsr.w	sub_196BC
	bne.s	loc_194BE
	move.l	#$B0,d0
	moveq	#$40,d1
	moveq	#$D,d2
	jsr	(sub_A102).l
loc_194BE:
	bsr.w	sub_1991C
	moveq	#$3,d6
loc_194C4:
	bsr.w	sub_1992A
	move.b	#$0,$2(a2)
	dbf	d6,loc_194C4
	bsr.w	sub_196BC
	move.l	#$98,d0
	moveq	#$38,d1
	moveq	#$C,d2
	jsr	(sub_A102).l
	bra.s	loc_1953E
loc_194E8:
	tst.b	d7
	bne.w	loc_1953A
	cmp.w	#$2,d3
	bne.s	loc_19510
	moveq	#$0,d0
	move.b	-$D4(a6),d0
	bmi.s	loc_1953A
	jsr	($6F14).w
	jsr	($6F02).w
	move.b	#$4,d1
	bsr.w	sub_1956E
	bmi.s	loc_1953E
	bra.s	loc_1953A
loc_19510:
	cmp.w	#$4,d3
	bne.s	loc_1953A
	move.b	#$8,d0
	jsr	($6C94).w
	jsr	($6F02).w
	move.b	(a0),d1
	beq.s	loc_1953A
	bmi.s	loc_1953A
	btst	#$6,d1
	bne.s	loc_1953A
	jsr	($6F14).w
	moveq	#$A,d1
	bsr.w	sub_1956E
	bmi.s	loc_1953E
loc_1953A:
	moveq	#$0,d0
	bra.s	loc_19548
loc_1953E:
	bsr.w	sub_1991C
	clr.w	$24(a1)
	moveq	#$1,d0
loc_19548:
	movem.l	(a7)+,d2-d7/a1-a3
	tst.b	d0
	rts

; ---------------------------------------------------------------------------
sub_19550:
	tst.b	d7
	beq.s	loc_1956C
	moveq	#$0,d0
	moveq	#$0,d1
	moveq	#$0,d2
	move.b	-$DD(a6),d0
	move.b	-$DE(a6),d1
	move.b	-$DF(a6),d2
	jsr	(sub_A102).l
loc_1956C:
	rts

; ---------------------------------------------------------------------------
sub_1956E:
	movem.l	d3-d5/a2,-(a7)
	moveq	#$0,d5
	moveq	#$0,d3
	move.l	d0,d3
	move.b	d1,d0
	jsr	($6C8C).w
	move.b	d0,d4
	moveq	#$0,d0
	move.b	$19(a1),d0
	divu.w	#$3,d0
	move.w	#$E,d1
	sub.w	d0,d1
	move.b	$17(a1),d0
	cmp.b	#$2,d0
	bcs.s	loc_195A2
	bne.s	loc_195A0
	subq.w	#$1,d1
	bra.s	loc_195A2
loc_195A0:
	addq.w	#$3,d1
loc_195A2:
	move.l	d1,-(a7)
	move.b	#$14,d0
	jsr	($6C8C).w
	move.l	(a7)+,d1
	cmp.b	d1,d0
	bcc.w	loc_19632
	move.b	$E(a0),d0
	sub.b	d4,d0
	beq.s	loc_195C4
	bpl.s	loc_195CC
	neg.b	d0
	move.b	d0,-$5A(a6,d3.w)
loc_195C4:
	move.b	#$84,(a0)
	move.b	#$0,d0
loc_195CC:
	move.b	d0,$E(a0)
	movea.l	a0,a2
	movem.l	a0-a3,-(a7)
	move.w	#$2A,d0
	jsr	(sub_1B900).l
	movem.l	(a7)+,a0-a3
	bsr.w	sub_191FC
	lea	(a1),a0
	bsr.w	sub_11CA4
	move.w	#$FD,d0
	bsr.w	sub_11C8E
	move.l	d4,d0
	move.w	#$2,($FFFFD5AA).w
	bsr.w	sub_13376
	bsr.w	sub_1368C
	bsr.w	sub_11CA0
	move.w	#$FE,d0
	bsr.w	sub_11C8E
	tst.b	(a2)
	bpl.s	loc_1961E
	move.w	#$FF,d0
	bsr.w	sub_11C8E
loc_1961E:
	bsr.w	sub_19976
	moveq	#$7,d0
loc_19624:
	jsr	($6F02).w
	tst.b	(a0)
	bgt.s	loc_19632
	dbf	d0,loc_19624
	st	d5
loc_19632:
	move.b	d5,d0
	movem.l	(a7)+,d3-d5/a2
	tst.b	d0
	rts

; ---------------------------------------------------------------------------
sub_1963C:
	movem.l	d1/a0,-(a7)
	jsr	($6D06).w
	moveq	#$3,d1
	lea	(dat_19668).l,a0
loc_1964C:
	cmp.b	(a0,d1.w),d0
	bcs.s	loc_19656
	dbf	d1,loc_1964C
loc_19656:
	lea	(dat_1966C).l,a0
	moveq	#$0,d0
	move.b	(a0,d1.w),d0
	movem.l	(a7)+,d1/a0
	rts
dat_19668:
	dc.b	$65,$59,$4C,$33
dat_1966C:
	dc.b	$02,$04,$06,$00

; ---------------------------------------------------------------------------
sub_19670:
	ext.w	d0
	cmp.b	#$4,d0
	beq.s	loc_19680
	tst.w	$24(a1,d0.w)
	beq.s	loc_19690
	bra.s	loc_19694
loc_19680:
	moveq	#$3,d6
loc_19682:
	bsr.w	sub_1992A
	tst.b	$2(a2)
	bne.s	loc_19694
	dbf	d6,loc_19682
loc_19690:
	move.w	#$0,d0
loc_19694:
	rts

; ---------------------------------------------------------------------------
sub_19696:
	sub.b	$8(a0),d2
	tst.b	d0
	bmi.s	loc_196AE
	ext.w	d0
	lea	(dat_196B6).l,a0
	lsr.b	#$1,d1
	move.b	(a0,d0.w),d0
	add.b	d0,d2
loc_196AE:
	move.b	$3(a3),d0
	sub.b	d0,d2
	rts
dat_196B6:
	dc.b	$01,$06,$03,$02,$00,$00

; ---------------------------------------------------------------------------
sub_196BC:
	movem.l	d1-d6/a0-a3,-(a7)
	lea	($FFFF992C).w,a1
	movea.l	-$82(a6),a2
	tst.b	d7
	beq.s	loc_196D4
	lea	($FFFF9928).w,a1
	movea.l	-$86(a6),a2
loc_196D4:
	movea.l	$2(a2),a2
	bsr.w	sub_197E2
	move.l	-$3C(a6),d5
	tst.b	d7
	beq.s	loc_19726
	cmp.l	(a1),d5
	beq.s	loc_19732
	lea	(dat_1973C).l,a0
	moveq	#$5,d0
	tst.b	d7
	beq.s	loc_196F8
	move.b	($FFFF9924).w,d0
loc_196F8:
	lsl.b	#$4,d0
	adda.w	d0,a0
	moveq	#$0,d6
loc_196FE:
	moveq	#$0,d2
	moveq	#$0,d3
	moveq	#$0,d4
	moveq	#$0,d5
	move.b	(a0)+,d2
	move.b	(a0)+,d3
	move.b	(a0)+,d4
	move.b	(a0)+,d5
	moveq	#$0,d0
	move.b	-$3C(a6,d6.w),d0
	cmp.b	(a1,d6.w),d0
	beq.s	loc_1971E
	bsr.w	sub_1979C
loc_1971E:
	addq.w	#$1,d6
	cmp.w	#$4,d6
	bcs.s	loc_196FE
loc_19726:
	move.l	-$3C(a6),(a1)
	bsr.w	sub_17BEC
	moveq	#$0,d0
	bra.s	loc_19734
loc_19732:
	moveq	#$1,d0
loc_19734:
	movem.l	(a7)+,d1-d6/a0-a3
	tst.b	d0
	rts
dat_1973C:
	binclude	"data/01973C.bin"

; ---------------------------------------------------------------------------
sub_1979C:
	movem.l	a0-a3,-(a7)
	moveq	#$4,d1
	mulu.w	#$210,d1
	movea.l	a2,a0
	adda.l	d1,a0
	mulu.w	#$210,d0
	movea.l	a2,a1
	adda.l	d0,a1
	subq.w	#$1,d5
	asl.w	#$1,d4
loc_197B6:
	move.l	d3,d0
	mulu.w	#$18,d0
	add.l	d2,d0
	asl.l	#$1,d0
	movea.l	a0,a2
	adda.l	d0,a2
	movea.l	a1,a3
	adda.l	d0,a3
	moveq	#$0,d0
loc_197CA:
	move.w	(a3,d0.w),(a2,d0.w)
	addq.w	#$2,d0
	cmp.w	d4,d0
	bcs.s	loc_197CA
	addq.l	#$1,d3
	dbf	d5,loc_197B6
	movem.l	(a7)+,a0-a3
	rts

; ---------------------------------------------------------------------------
sub_197E2:
	movem.l	d3-d6/a1-a3,-(a7)
	bsr.w	sub_1991C
	clr.l	-$3C(a6)
	move.w	#$0,d0
	bsr.w	sub_19820
	move.b	d0,-$3C(a6)
	move.w	#$2,d0
	bsr.w	sub_19820
	move.b	d0,-$3B(a6)
	move.w	#$6,d0
	bsr.w	sub_19820
	move.b	d0,-$39(a6)
	bsr.w	sub_1982A
	move.b	d0,-$3A(a6)
	movem.l	(a7)+,d3-d6/a1-a3
	rts

; ---------------------------------------------------------------------------
sub_19820:
	move.w	$24(a1,d0.w),d4
	move.w	(a1,d0.w),d3
	bra.s	loc_19840

; ---------------------------------------------------------------------------
sub_1982A:
	moveq	#$3,d6
	moveq	#$0,d3
	moveq	#$0,d4
loc_19830:
	bsr.w	sub_1992A
	add.b	$1(a2),d3
	add.b	$2(a2),d4
	dbf	d6,loc_19830
loc_19840:
	moveq	#$3,d0
	tst.w	d4
	beq.s	loc_19856
	moveq	#$0,d0
	cmp.w	d3,d4
	beq.s	loc_19856
	moveq	#$1,d0
	lsl.w	#$1,d4
	cmp.w	d3,d4
	bhi.s	loc_19856
	moveq	#$2,d0
loc_19856:
	rts

; ---------------------------------------------------------------------------
sub_19858:
	add.w	d4,d5
	add.w	d3,d6
	move.l	d3,d1
loc_1985E:
	move.l	d4,d0
loc_19860:
	move.w	(a3)+,d2
	bsr.w	sub_19874
	addq.w	#$1,d0
	cmp.w	d5,d0
	bcs.s	loc_19860
	addq.w	#$1,d1
	cmp.w	d6,d1
	bcs.s	loc_1985E
	rts

; ---------------------------------------------------------------------------
sub_19874:
	movem.l	d0-d1,-(a7)
	asl.w	#$1,d0
	asl.w	#$7,d1
	add.w	d1,d0
	addi.w	#$F000,d0
	jsr	(sub_8288).l
	move.w	d2,(a5)
	movem.l	(a7)+,d0-d1
	rts

; ---------------------------------------------------------------------------
sub_19890:
	movem.l	d0,-(a7)
	jsr	(sub_C8FC).l
	move.l	#$C0011,($FFFFD5DA).w
	move.l	#$E0013,($FFFFD5DE).w
	bsr.w	sub_1343E
	move.l	d5,d0
	bsr.w	sub_18466
	movem.l	(a7)+,d0
	rts

; ---------------------------------------------------------------------------
sub_198BA:
	cmp.b	#$5F,d1
	bcs.s	loc_198C4
	move.b	#$5F,d1
loc_198C4:
	moveq	#$0,d0
	move.b	d1,d0
	move.w	#$3,($FFFFD5AA).w
	bsr.w	sub_13376
	bsr.w	sub_11CA0
	move.w	#$110,d0
	bsr.w	sub_11C8E
	rts

; ---------------------------------------------------------------------------
sub_198E0:
	movem.l	d1/a1,-(a7)
	move.w	$24(a1,d0.w),d1
	move.w	(a1,d0.w),d0
	mulu.w	#$64,d1
	divu.w	d0,d1
	moveq	#$0,d0
	move.w	d1,d0
	movem.l	(a7)+,d1/a1
	rts

; ---------------------------------------------------------------------------
sub_198FC:
	movem.l	a1-a2,-(a7)
	jsr	($6F14).w
	jsr	($6F02).w
	movea.l	a1,a2
	subi.b	#$31,d1
	moveq	#$0,d0
	move.w	d1,d0
	jsr	($4FB0).w
	movem.l	(a7)+,a1-a2
	rts

; ---------------------------------------------------------------------------
sub_1991C:
	lea	($FFFF98F6).w,a1
	tst.b	d7
	beq.s	loc_19928
	lea	-$BA(a6),a1
loc_19928:
	rts

; ---------------------------------------------------------------------------
sub_1992A:
	move.l	d0,-(a7)
	move.l	d6,d0
	ext.w	d0
	mulu.w	#$5,d0
	lea	$C(a1,d0.w),a2
	bsr.w	sub_19940
	move.l	(a7)+,d0
	rts

; ---------------------------------------------------------------------------
sub_19940:
	move.l	d0,-(a7)
	moveq	#$0,d0
	move.b	(a2),d0
	bmi.s	loc_19954
	mulu.w	#$5,d0
	lea	(dat_176FA).l,a3
	adda.w	d0,a3
loc_19954:
	move.l	(a7)+,d0
	rts
	binclude	"data/019958.bin"

; ---------------------------------------------------------------------------
sub_19976:
	jsr	($75F8).w
	jsr	($75F8).w
	jsr	($75F8).w
	rts

; ---------------------------------------------------------------------------
sub_19984:
	movem.l	d0,-(a7)
	st	d0
	eor.b	d0,d7
	movem.l	(a7)+,d0
	rts

; ---------------------------------------------------------------------------
sub_19992:
	moveq	#$1,d0
	moveq	#$10,d1
	jsr	(sub_92AA).l
	move.l	a0,-$DC(a6)
	move.w	$2(a0),d7
	move.w	$4(a0),d6
	move.l	#$EC00,d0
	jsr	(sub_8288).l
	move.w	#$D8,(a5)
	move.w	d7,d4
	addi.w	#$F00,d4
	move.w	d4,(a5)
	move.w	-$D8(a6),(a5)
	move.w	#$0,(a5)
	moveq	#$0,d4
	move.b	d6,d4
	addi.w	#$F00,d4
	move.w	d7,d0
	lsl.w	#$3,d0
	addi.w	#$EC02,d0
	jsr	(sub_8288).l
	move.w	d4,(a5)
	move.w	-$D8(a6),(a5)
	move.w	#$1,(a5)
	rts

; ---------------------------------------------------------------------------
sub_199EA:
	movea.l	-$DC(a6),a0
	move.w	$4(a0),d7
	jsr	(sub_9240).l
	move.l	#$EC02,d0
	jsr	(sub_8288).l
	move.w	d7,(a5)
	rts

; ---------------------------------------------------------------------------
sub_19A08:
	movem.l	d0-d2/a0-a1,-(a7)
	move.w	d0,d2
	movea.l	-$DC(a6),a0
	moveq	#$0,d0
	move.w	$2(a0),d0
	lsl.w	#$3,d0
	addi.w	#$EC06,d0
	jsr	(sub_8288).l
	move.w	d2,(a5)
	movem.l	(a7)+,d0-d2/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_19A2C:
	movem.l	d0-d2/a0-a1,-(a7)
	move.w	d0,d2
	movea.l	-$DC(a6),a0
	moveq	#$0,d0
	move.w	$2(a0),d0
	lsl.w	#$3,d0
	addi.w	#$EC00,d0
	jsr	(sub_8288).l
	move.w	d2,(a5)
	movem.l	(a7)+,d0-d2/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_19A50:
	move.l	#$EC06,d0
	jsr	(sub_8288).l
	move.w	#$1,(a5)
	rts

; ---------------------------------------------------------------------------
sub_19A62:
	move.l	#$EC06,d0
	jsr	(sub_8288).l
	move.w	#$0,(a5)
	rts

; ---------------------------------------------------------------------------
sub_19A74:
	movem.l	d0-d7/a0-a3,-(a7)
	lea	($19B9C).l,a0
	moveq	#$0,d0
	move.b	d6,d0
	lsl.l	#$2,d0
	movea.l	(a0,d0.w),a0
	jsr	(sub_9DD4).l
	move.l	a0,d7
	clr.b	d6
	move.b	-$DD(a6),d0
	cmp.b	#$A0,d0
	bcs.s	loc_19A9E
	st	d6
loc_19A9E:
	move.w	-$D8(a6),d5
	tst.b	d6
	beq.s	loc_19AAA
	bset	#$B,d5
loc_19AAA:
	bset	#$D,d5
	movea.l	-$DC(a6),a0
	moveq	#$0,d0
	move.w	$2(a0),d0
	lsl.w	#$3,d0
	addi.w	#$EC04,d0
	jsr	(sub_8288).l
	move.w	d5,(a5)
	moveq	#$0,d5
	move.w	#$E0,d5
	move.l	#$80,d4
	tst.b	d6
	beq.s	loc_19ADC
	move.l	#$1A0,d4
loc_19ADC:
	moveq	#$0,d3
	moveq	#$0,d2
	move.b	-$DD(a6),d2
	addi.l	#$80,d2
	move.b	-$DE(a6),d3
	addi.l	#$80,d3
	tst.b	-$E0(a6)
	bne.s	loc_19B0E
	move.w	#$D8,d2
	move.w	#$98,d3
	tst.b	d6
	bne.s	loc_19B0E
	move.w	#$148,d2
	move.w	#$80,d3
loc_19B0E:
	subi.w	#$10,d2
	subi.w	#$10,d3
	moveq	#$0,d6
	moveq	#$0,d1
loc_19B1A:
	movem.l	d1-d3/a3,-(a7)
	movea.l	#$0,a3
	move.w	-$D8(a6),d1
	movea.l	d7,a0
	move.l	d6,d0
	jsr	(sub_B538).l
	movem.l	(a7)+,d1-d3/a3
	addq.l	#$1,d6
loc_19B38:
	move.w	d4,d0
	bsr.w	sub_19A08
	move.w	d5,d0
	bsr.w	sub_19A2C
	jsr	(sub_DEE6).l
	movem.l	d2-d3,-(a7)
	sub.l	d5,d3
	sub.l	d4,d2
	moveq	#$10,d0
	sub.l	d1,d0
	divs.w	d0,d3
	divs.w	d0,d2
	add.w	d2,d4
	add.w	d3,d5
	movem.l	(a7)+,d2-d3
	addq.l	#$1,d1
	cmp.l	#$10,d1
	bcc.s	loc_19B8A
	move.l	d1,d0
	tst.b	-$E0(a6)
	bne.s	loc_19B7C
	andi.b	#$7,d0
	bne.s	loc_19B38
	bra.s	loc_19B1A
loc_19B7C:
	cmp.b	#$5,d0
	beq.s	loc_19B1A
	cmp.b	#$A,d0
	beq.s	loc_19B1A
	bra.s	loc_19B38
loc_19B8A:
	move.w	#$1,d0
	bsr.w	sub_19A08
	movea.l	d7,a0
	jsr	(sub_978C).l
	movem.l	(a7)+,d0-d7/a0-a3
	rts
	binclude	"data/019BA0.bin"

; ---------------------------------------------------------------------------
sub_19BAC:
	movem.l	d0-d7/a0-a3,-(a7)
	lea	(dat_EA143).l,a0
	jsr	(sub_9DD4).l
	move.l	a0,d7
	moveq	#$0,d6
	move.b	($FFFF9924).w,d6
	asl.l	#$3,d6
	lea	(dat_177EE).l,a1
	moveq	#$0,d4
	moveq	#$0,d5
	move.b	$4(a1,d6.w),d4
	move.b	$5(a1,d6.w),d5
	addi.w	#$70,d4
	addi.w	#$70,d5
	move.w	-$D8(a6),d3
	bset	#$D,d3
	movea.l	-$DC(a6),a0
	moveq	#$0,d0
	move.w	$2(a0),d0
	lsl.w	#$3,d0
	addi.w	#$EC04,d0
	jsr	(sub_8288).l
	move.w	d3,(a5)
	moveq	#$3,d6
	moveq	#$0,d1
loc_19C04:
	movem.l	d1-d3/a3,-(a7)
	movea.l	#$0,a3
	move.w	-$D8(a6),d1
	movea.l	d7,a0
	move.l	d6,d0
	jsr	(sub_B538).l
	movem.l	(a7)+,d1-d3/a3
	subq.l	#$1,d6
	move.w	d4,d0
	bsr.w	sub_19A08
	move.w	d5,d0
	bsr.w	sub_19A2C
loc_19C2E:
	jsr	(sub_DEE6).l
	addq.l	#$1,d1
	cmp.l	#$8,d1
	bcc.s	loc_19C4A
	move.l	d1,d0
	cmp.l	#$3,d1
	bne.s	loc_19C2E
	bra.s	loc_19C04
loc_19C4A:
	move.w	#$1,d0
	bsr.w	sub_19A08
	movea.l	d7,a0
	jsr	(sub_978C).l
	movem.l	(a7)+,d0-d7/a0-a3
	rts

; ---------------------------------------------------------------------------
sub_19C60:
	move.l	d0,-(a7)
	ext.w	d0
	mulu.w	#$22,d0
	lea	(dat_17722).l,a1
	adda.l	d0,a1
	moveq	#$21,d0
loc_19C72:
	move.b	(a1,d0.w),(a0,d0.w)
	dbf	d0,loc_19C72
	moveq	#$9,d0
loc_19C7E:
	move.b	(a0,d0.w),$24(a0,d0.w)
	dbf	d0,loc_19C7E
	move.b	#$1,$23(a0)
	move.b	#$C7,$22(a0)
	move.l	(a7)+,d0
	cmp.b	#$4,d0
	bhi.s	loc_19CC8
	lea	($FFFF9987).w,a1
	moveq	#$0,d1
	move.b	(a1,d0.w),d1
	addq.b	#$1,(a1,d0.w)
	divu.w	#$5,d1
	move.b	d1,$23(a0)
	beq.s	loc_19CB8
	addq.b	#$1,$23(a0)
loc_19CB8:
	swap	d1
	mulu.w	#$5,d0
	add.w	d1,d0
	addi.w	#$C8,d0
	move.b	d0,$22(a0)
loc_19CC8:
	rts

; ---------------------------------------------------------------------------
sub_19CCA:
	jsr	(sub_F1B6C).l
	movea.l	#$200000,a0
	move.w	#$E,d3
	move.w	#$2,d4
	cmp.b	#$E0,d0
	beq.s	loc_19CEC
	cmp.b	#$B0,d0
	beq.s	loc_19D4E
	rts
loc_19CEC:
	move.w	#$1FFF,d2
loc_19CF0:
	move.w	#$1,d1
	move.w	#$7,d0
loc_19CF8:
	move.w	d1,(a0)
	cmp.b	$1(a0),d1
	bne.s	loc_19D26
	lsl.w	#$1,d1
	dbf	d0,loc_19CF8
	addq.w	#$2,a0
	dbf	d2,loc_19CF0
	movea.l	#$200000,a0
	move.l	#$120034,(a0)+
	move.l	#$560078,(a0)+
	move.w	#$E0,d3
	move.w	#$20,d4
loc_19D26:
	move.w	d3,d0
loc_19D28:
	move.l	#$C0000000,($C00004).l
	move.w	d0,d1
	and.w	d3,d1
	move.w	d1,($C00000).l
	st	($FFFFBA52).w
	clr.b	($FFFFB4C2).w
loc_19D44:
	tst.b	($FFFFB4C2).w
	beq.s	loc_19D44
	sub.w	d4,d0
	bra.s	loc_19D28
loc_19D4E:
	move.w	#$3,d1
loc_19D52:
	addq.w	#$1,a0
	lsl.l	#$8,d0
	move.b	(a0)+,d0
	dbf	d1,loc_19D52
	cmp.l	#$12345678,d0
	bne.s	loc_19D26
	move.w	#$E0,d3
	move.w	#$20,d4
	bra.s	loc_19D26

; ---------------------------------------------------------------------------
sub_19D6E:
	move.l	d0,-(a7)
	move.w	($FFFFD8DE).l,d0
	addi.w	#$28,d0
loc_19D7A:
	cmp.w	($FFFFD8DE).l,d0
	bne.s	loc_19D7A
	move.l	(a7)+,d0
	rts
dat_19D86:
	binclude	"data/019D86.bin"

; ---------------------------------------------------------------------------
sub_1B542:
	movem.l	d0-d7/a0-a6,-(a7)
	tst.b	($FFFFD8E0).w
	beq.s	loc_1B552
	addi.w	#$33,($FFFFD8F2).w
loc_1B552:
	move.w	#$100,($A11100).l
	addi.w	#$100,($FFFFD8F2).w
	move.b	($FFFFD8F2).w,($A000E6).l
	move.w	#$0,($A11100).l
	jsr	(sub_1B866).l
	addq.w	#$1,($FFFFD8DE).w
	move.w	($FFFFD8DE).w,d0
	andi.w	#$7,d0
	bne.w	loc_1B58C
	jsr	(sub_1B7BA).l
loc_1B58C:
	movem.l	(a7)+,d0-d7/a0-a6
	rts
	binclude	"data/01B592.bin"

; ---------------------------------------------------------------------------
sub_1B5CE:
	move.w	sr,-(a7)
	sf	($FFFFD8DB).w
	movem.l	d0-d2/a0-a2,-(a7)
	move.b	($A10001).l,d0
	btst	#$6,d0
	bne.s	loc_1B5EA
	sf	($FFFFD8E0).w
	bra.s	loc_1B5EE
loc_1B5EA:
	st	($FFFFD8E0).w
loc_1B5EE:
	moveq	#$0,d0
	move.l	d0,($FFFFD8EA).w
	move.l	d0,($FFFFD8F4).l
	move.l	d0,($FFFFD8F8).l
	move.w	#$2700,sr
	movea.l	#$A11200,a0
	move.w	#$100,(a0)
	move.w	#$100,($A11100).l
	lea	(dat_19D86).l,a1
	movea.l	#$A00000,a2
	move.w	#$17E0,d0
	bsr.w	sub_1B6C8
	move.w	#$0,(a0)
	move.w	#$0,($A11100).l
	move.w	#$1F4,d0
loc_1B63A:
	dbf	d0,loc_1B63A
	move.w	#$100,(a0)
	movem.l	(a7)+,d0-d2/a0-a2
	move.w	(a7)+,sr
	rts

; ---------------------------------------------------------------------------
sub_1B64A:
	movem.l	d0-d1/a0-a1,-(a7)
	bsr.w	sub_1B5CE
	move.l	d0,($FFFFD8EA).w
	movea.l	d0,a0
	move.l	-$4(a0),($FFFFD8EE).w
	move.w	sr,-(a7)
	move.w	#$2700,sr
	bsr.w	sub_1B824
	move.w	#$100,($A11100).l
	movea.l	#$A00000,a0
	move.b	#$D,$B(a0)
	move.b	#$0,$A(a0)
	move.w	#$0,($A11100).l
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d1/a0-a1
	st	($FFFFD8DB).w
	rts

; ---------------------------------------------------------------------------
sub_1B696:
	move.b	d0,$180(a0)
	ror.l	#$8,d0
	move.b	d0,$17F(a0)
	ror.w	#$8,d0
	move.b	d0,$17E(a0)
	rts

; ---------------------------------------------------------------------------
sub_1B6A8:
	move.w	#$2700,sr
	movea.l	#$A00000,a0
	move.l	d0,-(a7)
	move.w	#$100,($A11100).l
	bsr.s	sub_1B696
	moveq	#$0,d0
	move.b	d0,$18C(a0)
	move.l	(a7)+,d0
	rts

; ---------------------------------------------------------------------------
sub_1B6C8:
	bra.s	loc_1B6CC

; ---------------------------------------------------------------------------
sub_1B6CA:
	move.b	(a1)+,(a2)+
loc_1B6CC:
	dbf	d0,sub_1B6CA
	rts

; ---------------------------------------------------------------------------
sub_1B6D2:
	move.w	#$2700,sr
	move.w	#$100,($A11100).l
	movea.l	#$A00000,a0
	rts

; ---------------------------------------------------------------------------
sub_1B6E6:
	movem.l	d1/a0,-(a7)
	move.w	sr,-(a7)
	bsr.s	sub_1B6A8
loc_1B6EE:
	tst.b	d1
	bne.s	loc_1B6F4
	moveq	#$1,d1
loc_1B6F4:
	move.b	d1,$A(a0)
	move.w	#$0,($A11100).l
	move.w	(a7)+,sr
	movem.l	(a7)+,d1/a0
	rts

; ---------------------------------------------------------------------------
sub_1B708:
	move.l	a0,-(a7)
	move.w	sr,-(a7)
	bsr.s	sub_1B6A8
loc_1B70E:
	move.b	#$FF,$A(a0)
loc_1B714:
	move.w	#$0,($A11100).l
	move.w	(a7)+,sr
	movea.l	(a7)+,a0
	rts

; ---------------------------------------------------------------------------
sub_1B722:
	movem.l	d1/a0,-(a7)
	move.w	sr,-(a7)
	bsr.w	sub_1B6A8
	move.b	#$12,$B(a0)
	bra.s	loc_1B6EE

; ---------------------------------------------------------------------------
sub_1B734:
	move.l	a0,-(a7)
	move.w	sr,-(a7)
	bsr.w	sub_1B6A8
	move.b	#$12,$B(a0)
	bra.s	loc_1B70E

; ---------------------------------------------------------------------------
sub_1B744:
	move.l	a0,-(a7)
	move.w	sr,-(a7)
	bsr.s	sub_1B6D2
	move.b	#$0,$B(a0)
	bra.s	loc_1B714

; ---------------------------------------------------------------------------
sub_1B752:
	moveq	#$0,d0
	move.b	($FFFFD8DB).w,d0
	beq.s	loc_1B778
	move.l	a0,-(a7)
	move.w	sr,-(a7)
	move.w	#$2700,sr
	moveq	#$0,d0
	move.w	#$100,($A11100).l
	movea.l	#$A00000,a0
	move.b	$B(a0),d0
	bra.s	loc_1B714
loc_1B778:
	rts
	binclude	"data/01B77A.bin"

; ---------------------------------------------------------------------------
sub_1B78A:
	move.l	a0,-(a7)
	move.w	sr,-(a7)
	bsr.w	sub_1B6D2
	move.b	d0,$57(a0)
	bra.w	loc_1B714

; ---------------------------------------------------------------------------
sub_1B79A:
	move.l	a0,-(a7)
	move.w	sr,-(a7)
	bsr.w	sub_1B6D2
	move.b	d0,$56(a0)
	bra.w	loc_1B714

; ---------------------------------------------------------------------------
sub_1B7AA:
	move.l	a0,-(a7)
	move.w	sr,-(a7)
	bsr.w	sub_1B6D2
	move.b	d0,$58(a0)
	bra.w	loc_1B714

; ---------------------------------------------------------------------------
sub_1B7BA:
	tst.b	($FFFFD8DB).w
	beq.s	loc_1B822
	movem.l	d0-d1/a0-a2,-(a7)
	movea.l	($FFFFD8E2).w,a1
	movea.l	($FFFFD8E6).w,a2
	move.w	sr,-(a7)
	bsr.w	sub_1B6D2
	move.b	$B(a0),d1
	beq.w	loc_1B814
	move.b	$DA(a0),d1
	cmp.b	($FFFFD8DC).w,d1
	beq.s	loc_1B814
	move.b	d1,($FFFFD8DC).w
	move.w	#$FF,d0
	bsr.w	sub_1B6CA
	move.l	a1,($FFFFD8E2).w
	move.l	a2,($FFFFD8E6).w
	cmpa.l	($FFFFD8EE).w,a1
	bne.s	loc_1B804
	move.l	($FFFFD8EA).w,($FFFFD8E2).w
loc_1B804:
	cmpa.l	#$A01E00,a2
	blt.s	loc_1B814
	move.l	#$A01A00,($FFFFD8E6).w
loc_1B814:
	move.w	#$0,($A11100).l
	move.w	(a7)+,sr
	movem.l	(a7)+,d0-d1/a0-a2
loc_1B822:
	rts

; ---------------------------------------------------------------------------
sub_1B824:
	movem.l	d0/a1-a2,-(a7)
	movea.l	#$A01A00,a2
	move.l	a2,($FFFFD8E6).w
	move.b	#$1A,($FFFFD8DC).w
	movea.l	d0,a1
	move.w	#$100,($A11100).l
	move.w	#$3FF,d0
	move.b	#$1A,($A000DA).l
	bsr.w	sub_1B6CA
	move.w	#$0,($A11100).l
	move.l	a1,($FFFFD8E2).w
	movem.l	(a7)+,d0/a1-a2
	move.l	a1,d0
	rts

; ---------------------------------------------------------------------------
sub_1B866:
	movem.l	d0/a0-a1,-(a7)
	lea	($FFFFD8F4).w,a1
	move.l	(a1)+,d0
	beq.s	loc_1B87E
	move.l	#$0,-$4(a1)
	movea.l	d0,a0
	bsr.s	sub_1B89A
loc_1B87E:
	move.l	(a1),d0
	beq.s	loc_1B88C
	move.l	#$0,(a1)
	movea.l	d0,a0
	bsr.s	sub_1B892
loc_1B88C:
	movem.l	(a7)+,d0/a0-a1
	rts

; ---------------------------------------------------------------------------
sub_1B892:
	move.w	d1,-(a7)
	move.w	#$7,d1
	bra.s	loc_1B8A0

; ---------------------------------------------------------------------------
sub_1B89A:
	move.w	d1,-(a7)
	move.w	#$6,d1
loc_1B8A0:
	tst.b	($FFFFD8DB).w
	bne.s	loc_1B8AA
	bsr.w	sub_1B5CE
loc_1B8AA:
	movem.l	d0/d3/a1-a2,-(a7)
	move.w	sr,-(a7)
	move.w	#$2700,sr
	move.w	#$100,($A11100).l
	movea.l	#$A00000,a1
	tst.b	$C(a1)
	beq.s	loc_1B8D6
	lea	($FFFFD8F4).w,a1
	subq.w	#$6,d1
	asl.w	#$2,d1
	move.l	a0,(a1,d1.w)
	bra.s	loc_1B8EA
loc_1B8D6:
	move.b	d1,$C(a1)
	movea.l	a0,a1
	movea.l	#$A0003A,a2
	move.w	#$17,d0
	bsr.w	sub_1B6C8
loc_1B8EA:
	move.w	#$0,($A11100).l
	move.w	(a7)+,sr
	movem.l	(a7)+,d0/d3/a1-a2
	move.w	(a7)+,d1
	st	($FFFFD8DB).w
	rts

; ---------------------------------------------------------------------------
sub_1B900:
	movem.l	d0-d1/a0,-(a7)
	cmp.b	#$4B,d0
	bhi.w	loc_1B9CE
	moveq	#$0,d1
	move.b	d0,d1
	lea	(dat_1B9D4).l,a0
	moveq	#$0,d0
	move.b	(a0,d1.w),d0
	btst	#$7,d0
	bne.s	loc_1B97A
	btst	#$6,d0
	bne.s	loc_1B94A
	andi.w	#$3F,d0
	beq.w	loc_1B9CE
	move.b	d1,($FFFFD805).w
	ext.w	d0
	asl.w	#$2,d0
	lea	(dat_1BAF4).l,a0
	movea.l	(a0,d0.w),a0
	bsr.w	sub_1B89A
	bra.w	loc_1B9CE
loc_1B94A:
	andi.b	#$3F,d0
	beq.s	loc_1B974
	move.b	d1,($FFFFD807).w
	ext.w	d0
	moveq	#$0,d1
	lea	(dat_1BAA0).l,a0
	move.b	(a0,d0.w),d1
	asl.w	#$2,d0
	lea	(dat_1BA20).l,a0
	move.l	(a0,d0.w),d0
	bsr.w	sub_1B6E6
	bra.s	loc_1B9CE
loc_1B974:
	bsr.w	sub_1B744
	bra.s	loc_1B9CE
loc_1B97A:
	tst.b	($FFFFB4C3).w
	beq.s	loc_1B982
	moveq	#$0,d0
loc_1B982:
	cmp.b	($FFFFD806).w,d1
	bne.s	loc_1B98C
	tst.b	d0
	bne.s	loc_1B9CE
loc_1B98C:
	move.b	d1,($FFFFD806).w
	andi.b	#$7F,d0
	move.l	d0,-(a7)
	move.l	#$388DA,d0
	bsr.w	sub_1B64A
	moveq	#$F,d0
loc_1B9A2:
	jsr	(sub_DEE6).l
	dbf	d0,loc_1B9A2
	move.l	(a7)+,d0
	ext.w	d0
	asl.w	#$2,d0
	lea	(dat_1BAC0).l,a0
	move.l	(a0,d0.w),d0
	bsr.w	sub_1B64A
	moveq	#$1,d0
	bsr.w	sub_1B78A
	moveq	#$1,d0
	bsr.w	sub_1B7AA
	nop
loc_1B9CE:
	movem.l	(a7)+,d0-d1/a0
	rts
dat_1B9D4:
	binclude	"data/01B9D4.bin"
dat_1BA20:
	binclude	"data/01BA20.bin"
dat_1BAA0:
	binclude	"data/01BAA0.bin"
dat_1BAC0:
	binclude	"data/01BAC0.bin"
dat_1BAF4:
	binclude	"data/01BAF4.bin"
dat_38CE2:
	dc.b	$00,$03,$8D,$02
dat_38CE6:
	binclude	"data/038CE6.bin"
dat_390E2:
	binclude	"data/0390E2.bin"
dat_42B0A:
	binclude	"data/042B0A.bin"
dat_51102:
	if DEUTSCH	; DEUTSCH-HOOK 3: Zeichensatz mit Umlauten
	binclude	"deutsch/font_1bpp.bin"
	else
	binclude	"data/051102.bin"
	endif
dat_51302:
	dc.b	$70,$73,$74,$75,$76,$77,$78,$FF
dat_5130A:
	binclude	"data/05130A.bin"
dat_51326:
	binclude	"data/051326.bin"
dat_51360:
	binclude	"data/051360.bin"
dat_51444:
	binclude	"data/051444.bin"
dat_51836:
	binclude	"data/051836.bin"
dat_5198A:
	binclude	"data/05198A.bin"
dat_64637:
	binclude	"data/064637.bin"
dat_647D7:
	binclude	"data/0647D7.bin"
dat_6494C:
	binclude	"data/06494C.bin"
dat_6B888:
	binclude	"data/06B888.bin"
dat_6BAAD:
	binclude	"data/06BAAD.bin"
dat_711E4:
	binclude	"data/0711E4.bin"
dat_725C6:
	binclude	"data/0725C6.bin"
dat_72A03:
	binclude	"data/072A03.bin"
dat_733C1:
	binclude	"data/0733C1.bin"
dat_75910:
	binclude	"data/075910.bin"
dat_8D2D4:
	binclude	"data/08D2D4.bin"
dat_8E0C4:
	binclude	"data/08E0C4.bin"
dat_8F97F:
	binclude	"data/08F97F.bin"
dat_8FA8D:
	binclude	"data/08FA8D.bin"
dat_918A8:
	binclude	"data/0918A8.bin"
dat_9607B:
	binclude	"data/09607B.bin"
dat_962D9:
	binclude	"data/0962D9.bin"
dat_96D4A:
	binclude	"data/096D4A.bin"
dat_99B5F:
	binclude	"data/099B5F.bin"
dat_9AB8B:
	binclude	"data/09AB8B.bin"
dat_9ACF7:
	binclude	"data/09ACF7.bin"
dat_9AE4D:
	binclude	"data/09AE4D.bin"
dat_9AFAA:
	binclude	"data/09AFAA.bin"
dat_9B0B9:
	binclude	"data/09B0B9.bin"
dat_9B160:
	binclude	"data/09B160.bin"
dat_9B47A:
	binclude	"data/09B47A.bin"
dat_9CF13:
	binclude	"data/09CF13.bin"
dat_9E6AC:
	binclude	"data/09E6AC.bin"
dat_9E77C:
	binclude	"data/09E77C.bin"
dat_E772F:
	binclude	"data/0E772F.bin"
dat_E7E3D:
	binclude	"data/0E7E3D.bin"
dat_E8BF4:
	binclude	"data/0E8BF4.bin"
dat_E8F2E:
	binclude	"data/0E8F2E.bin"
dat_EA143:
	binclude	"data/0EA143.bin"
dat_EA350:
	binclude	"data/0EA350.bin"
dat_EA76B:
	binclude	"data/0EA76B.bin"
dat_EBE89:
	binclude	"data/0EBE89.bin"
dat_EC100:
	binclude	"data/0EC100.bin"
dat_ECFCE:
	binclude	"data/0ECFCE.bin"
dat_EF2EA:
	binclude	"data/0EF2EA.bin"
dat_F0F3F:
	binclude	"data/0F0F3F.bin"
dat_F14F2:
	binclude	"data/0F14F2.bin"
dat_F16AA:
	binclude	"data/0F16AA.bin"
dat_F17CC:
	binclude	"data/0F17CC.bin"

; ---------------------------------------------------------------------------
sub_F1B64:
	rte

; ---------------------------------------------------------------------------
sub_F1B66:
	move.b	($FFFFD8FC).w,d0
	rts

; ---------------------------------------------------------------------------
sub_F1B6C:
	move.w	#$100,($A11100).l
	move.l	d1,-(a7)
	move.b	#$40,($A10009).l
	move.b	#$0,($A10003).l
	bsr.w	sub_F1BBE
	move.b	($A10003).l,d0
	asl.b	#$2,d0
	andi.b	#$C0,d0
	move.b	#$40,($A10003).l
	bsr.s	sub_F1BBE
	move.b	($A10003).l,d1
	andi.b	#$3F,d1
	move.w	#$0,($A11100).l
	or.b	d1,d0
	not.b	d0
	move.b	d0,($FFFFD8FC).w
	move.l	(a7)+,d1
	rts

; ---------------------------------------------------------------------------
sub_F1BBE:
	move.w	#$0,($A11100).l
	move.w	#$A,d1
loc_F1BCA:
	dbf	d1,loc_F1BCA
	move.w	#$100,($A11100).l
	rts
	binclude	"data/0F1BD8.bin"
dat_FE000:
	dc.b	[4]$FF
dat_FE004:
	dc.b	[4]$FF
dat_FE008:
	dc.b	[8104]$FF

; ---------------------------------------------------------------------------
sub_FFFB0:
	moveq	#$0,d0
	suba.l	a0,a0
	move.l	#$3FFEC,d1
loc_FFFBA:
	cmpa.w	#$18C,a0
	bne.s	loc_FFFC4
	addq.w	#$4,a0
	bra.s	loc_FFFC6
loc_FFFC4:
	add.l	(a0)+,d0
loc_FFFC6:
	subq.l	#$1,d1
	bgt.s	loc_FFFBA
	cmpi.l	#$10D1310C,d0
	bne.s	loc_FFFD4
	rts
loc_FFFD4:
	movea.l	#$C00004,a4
	move.w	#$8F02,(a4)
	move.w	#$8004,(a4)
	move.w	#$8700,(a4)
	move.w	#$8144,(a4)
	move.w	#$C000,(a4)
	move.w	#$3F,d1
loc_FFFF2:
	move.w	#$E,($C00000).l
	dbf	d1,loc_FFFF2
loc_FFFFE:
	bra.s	loc_FFFFE

	if DEUTSCH	; DEUTSCH-HOOK 4: Erweiterung ab $100000
	include	"src/deutsch.asm"
	endif

	END
