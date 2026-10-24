; ===========================================================================
; Deutsche Fassung - Erweiterung ab $100000 (nur mit -D DEUTSCH=1)
; Stand: 24.10.2026. Beschreibung: claude/Textablage.md, claude/Systemtexte.md
; ===========================================================================

	include	"deutsch/optionen.inc"	; erzeugt von text_einsetzen.py (DE_PLURAL_WAFFE, DE_PLURAL_TP)

	org	$100000

; ---------------------------------------------------------------------------
; Text-Operand ($80) eines ECL-Befehls aufloesen (Sprungziel von DEUTSCH-HOOK 2).
; Eingang: d0 = Byte-Offset des Textes im ORIGINAL-Textblock (0..$FFFF)
;          ($FFFFB9A4) = Zeigertabelle des geladenen Moduls (Langwort je Original-Offset)
; Ausgang: a0 = d0 = Adresse des deutschen Textes in der ROM
DE_TextZeiger:
	add.l	d0,d0
	add.l	d0,d0
	add.l	($FFFFB9A4).w,d0
	movea.l	d0,a0
	movea.l	(a0),a0
	move.l	a0,d0
	rts

; ---------------------------------------------------------------------------
; Gegenstandsname in den Puffer $FFFFD5AE anhaengen (Sprungziel von DEUTSCH-HOOK 6 und 7).
; Eingang: a0 = Gegenstand (Bytes $1-$3 = Namensteile, Systemtext-Nummern)
;          d1.b = Anzahl (unter 2 = Einzahl)
; Ist das Namens-Tripel in DE_Namenstabelle, wird der fertige deutsche Name
; (Einzahl bzw. Mehrzahl) angehaengt, sonst wie im Original aus den Teilen
; zusammengesetzt (Mehrzahl: Zeichen aus dem Tabellenkopf, 0 = keins).
; Eintrag: dc.b p1,p2,p3,0 / dc.w Einzahl, Mehrzahl (0 = wie Einzahl). Ende: Langwort 0.
DE_Gegenstandsname:
	movem.l	d2-d4/a2-a3,-(a7)
	movea.l	a0,a2
	moveq	#0,d4
	move.b	d1,d4
	moveq	#0,d3
	move.b	$1(a2),d3
	lsl.l	#8,d3
	move.b	$2(a2),d3
	lsl.l	#8,d3
	move.b	$3(a2),d3
	lsl.l	#8,d3
	lea	(DE_Namenstabelle+2).l,a3
de_gn_suchen:
	move.l	(a3)+,d2
	beq.s	de_gn_teile
	cmp.l	d2,d3
	beq.s	de_gn_gefunden
	addq.l	#4,a3
	bra.s	de_gn_suchen
de_gn_gefunden:
	move.w	(a3)+,d0
	cmp.w	#2,d4
	bcs.s	de_gn_anhaengen
	tst.w	(a3)
	beq.s	de_gn_anhaengen
	move.w	(a3),d0
de_gn_anhaengen:
	jsr	(sub_11BDC).l
	bra.s	de_gn_ende
de_gn_teile:
	moveq	#2,d2
de_gn_teil:
	moveq	#0,d0
	move.b	$1(a2,d2.w),d0
	beq.s	de_gn_weiter
	jsr	(sub_11BDC).l
de_gn_weiter:
	dbf	d2,de_gn_teil
	cmp.w	#2,d4
	bcs.s	de_gn_ende
	move.w	(DE_Namenstabelle).l,d1
	beq.s	de_gn_ende
	lea	($FFFFD5AE).w,a0
	jsr	(sub_11C18).l
	cmp.b	-$1(a0,d0.w),d1
	beq.s	de_gn_ende
	move.b	d1,(a0,d0.w)
	clr.b	$1(a0,d0.w)
de_gn_ende:
	movem.l	(a7)+,d2-d4/a2-a3
	rts

; ---------------------------------------------------------------------------
; Monstername ersetzen (Sprungziel von DEUTSCH-HOOK 12, Ende des Ladens in sub_48E8).
; Eingang: a3 = geladener Datensatz (Name = Byte 0-15), d2 = Monster-Nummer, d3 wie Original
; Ersetzt die 2 Original-Befehle "move.b d3,$3F(a3) / moveq #0,d0".
; DE_Monstertabelle: je Eintrag 1 Byte Nummer + 16 Byte Name, Ende $FF.
DE_Monstername:
	move.b	d3,$3F(a3)
	movem.l	d1/a0-a1,-(a7)
	lea	(DE_Monstertabelle).l,a0
de_mn_suchen:
	move.b	(a0)+,d0
	cmp.b	#$FF,d0
	beq.s	de_mn_ende
	cmp.b	d2,d0
	beq.s	de_mn_gefunden
	lea	$10(a0),a0
	bra.s	de_mn_suchen
de_mn_gefunden:
	movea.l	a3,a1
	moveq	#$F,d1
de_mn_kopie:
	move.b	(a0)+,(a1)+
	dbf	d1,de_mn_kopie
de_mn_ende:
	movem.l	(a7)+,d1/a0-a1
	moveq	#$0,d0
	rts

; ---------------------------------------------------------------------------
; Erzeugt von 03_Tools/text_einsetzen.py (nicht von Hand aendern):
;   DE_Systemtexte: Systemtexttabelle (16-Bit-Offsets wie dat_11DC4, Nr. 0-392 wie Original,
;                   ab 393 neue Texte, z. B. fertige Gegenstandsnamen), danach die Texte
;   DE_Namenstabelle: Kopf (Plural-Zeichen) + Eintraege, siehe DE_Gegenstandsname
	org	$101000
DE_Systemtexte:
	binclude	"deutsch/systemtexte.bin"
	align	2
DE_Namenstabelle:
	binclude	"deutsch/namen.bin"
	align	2
DE_Monstertabelle:
	binclude	"deutsch/monster.bin"
	align	2
DE_Abspann:
	binclude	"deutsch/abspann.bin"
	align	2
DE_Systemende:
	if DE_Systemende > $108000
	error	"Systemtexte zu gross (Grenze $108000)"
	endif

; ---------------------------------------------------------------------------
; Erzeugt von 03_Tools/text_einsetzen.py (nicht von Hand aendern):
;   DE_Modultabelle: 27 Langworte (Reihenfolge wie dat_38CE6) -> Zeigertabelle je Modul
;   danach Zeigertabellen und Texte
	org	$108000
DE_Modultabelle:
	binclude	"deutsch/texte.bin"
