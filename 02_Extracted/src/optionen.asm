; ===========================================================================
; Optionsmenue (Extra, nur -D DEUTSCH=1), eingebunden aus src/deutsch.asm
; Stand: 03.11.2026. Beschreibung und Entscheidungen: claude/Optionen.md
;
; Einstellungen: 12 Optionen je 4 Bit in 6 Byte RAM oberhalb des Stapels ($FFFFF6-$FFFFFB, vom Spiel
; nie benutzt; der Stapel beginnt bei $FFFFF6 und waechst nach unten). Beim Einschalten loescht das Spiel
; den ganzen RAM -> 0. Gespeichert wird "Wert XOR Standardwert", damit 0 im RAM immer den Standard bedeutet
; (deutsch: alles Original, Testfassung: Raumkampf-Hilfen an). Gilt bis zum Ausschalten (Entscheidung O4 = A).
; ===========================================================================

DE_OPT		= $FFFFFFF6

OPT_RAUM_EIGEN	= 0	; Raumkampf: eigene Treffer, Zusatzchance 0/25/50/75/100 %
OPT_RAUM_GEGNER	= 1	; Raumkampf: Gegner daneben, 0/25/50/75/100 %
OPT_BODEN_EIGEN	= 2	; Bodenkampf: eigene Treffer, Zusatzchance 0/25/50/75/100 %
OPT_BODEN_GEGNER = 3	; Bodenkampf: Gegner daneben, 0/25/50/75/100 %
OPT_UNVERWUNDBAR = 4	; Maelstrom Rider unverwundbar: aus/an
OPT_MUNITION	= 5	; eigene Munition unbegrenzt: aus/an
OPT_BEGEGNUNG	= 6	; Begegnungen im All: normal / halb / keine / Merkur+
OPT_WUERFEL	= 7	; Attribute wuerfeln: Original / 2 Wuerfe / mindestens 14 / Maximum
OPT_TP		= 8	; TP beim Stufenaufstieg: Original / Maximum
OPT_EP		= 9	; Erfahrungspunkte: x1 / x1,5 / x2 / x3
OPT_CREDITS	= 10	; Credits aus Beute: x1 / x2 / x3
OPT_HEILUNG	= 11	; volle Heilung nach gewonnenem Kampf: aus/an

; Standardwerte (Entscheidung O3 = A)
DE_OptStandard:
	if DEUTSCH_TEST
	dc.b	4,4,0,0,1,0,0,0,0,0,0,0		; Testfassung: wie bisher Hooks 20-22 (immer Treffer, Gegner nie, unverwundbar)
	else
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0		; deutsche Fassung: alles wie im Original
	endif
	align	2

; ---------------------------------------------------------------------------
; d0.w = Option -> d0.l = Wert (0..15). Alle anderen Register bleiben.
DE_OptLesen:
	movem.l	d1/a0,-(a7)
	moveq	#0,d1
	move.w	d0,d1
	lsr.w	#1,d1
	lea	(DE_OPT).w,a0
	move.b	(a0,d1.w),d1
	btst	#0,d0
	beq.s	de_ol_unten
	lsr.b	#4,d1
de_ol_unten:
	andi.w	#$F,d1
	lea	(DE_OptStandard).l,a0
	move.b	(a0,d0.w),d0
	eor.b	d1,d0
	andi.l	#$F,d0
	movem.l	(a7)+,d1/a0
	rts

; d0.w = Option, d1.b = neuer Wert. Alle Register bleiben.
DE_OptSchreiben:
	movem.l	d0-d2/a0,-(a7)
	lea	(DE_OptStandard).l,a0
	move.b	(a0,d0.w),d2
	eor.b	d2,d1
	andi.b	#$F,d1
	move.w	d0,d2
	lsr.w	#1,d2
	lea	(DE_OPT).w,a0
	adda.w	d2,a0
	btst	#0,d0
	beq.s	de_os_unten
	lsl.b	#4,d1
	andi.b	#$0F,(a0)
	or.b	d1,(a0)
	bra.s	de_os_ende
de_os_unten:
	andi.b	#$F0,(a0)
	or.b	d1,(a0)
de_os_ende:
	movem.l	(a7)+,d0-d2/a0
	rts

; d0.w = Prozent-Option -> d0.l = 1 (Ergebnis erzwingen) oder 0 (normal wuerfeln).
; Wert n (0..4): Zusatzwurf 1..100, erzwingen wenn Wurf <= n * 25. Andere Register bleiben.
DE_Erzwingen:
	bsr.s	DE_OptLesen
	tst.b	d0
	beq.s	de_ez_nein
	cmp.b	#4,d0
	bcc.s	de_ez_ja
	move.l	d1,-(a7)
	moveq	#0,d1
	move.b	d0,d1
	mulu.w	#25,d1
	moveq	#100,d0
	jsr	(sub_6C8C).l
	cmp.w	d1,d0
	bhi.s	de_ez_nein2
	move.l	(a7)+,d1
de_ez_ja:
	moveq	#1,d0
	rts
de_ez_nein2:
	move.l	(a7)+,d1
de_ez_nein:
	moveq	#0,d0
	rts

; ---------------------------------------------------------------------------
; DEUTSCH-HOOK 20: Trefferwurf des Gegners im Raumkampf (loc_1824C). Eingang d2 = Zielwert.
; Ausgang: Carry gesetzt = daneben (Original: W20, 20 trifft, Wurf < d2 daneben).
DE_RaumGegner:
	moveq	#OPT_RAUM_GEGNER,d0
	bsr.s	DE_Erzwingen
	tst.b	d0
	bne.s	de_rg_daneben
	move.b	#$14,d0
	jsr	(sub_6C8C).l
	cmp.b	#$14,d0
	beq.s	de_rg_treffer
	cmp.b	d2,d0
	rts
de_rg_treffer:
	andi.b	#$FE,ccr
	rts
de_rg_daneben:
	ori.b	#$01,ccr
	rts

; DEUTSCH-HOOK 21: eigener Trefferwurf im Raumkampf (loc_18A1A). Zielwert -$CE(a6) im Rahmen des Aufrufers.
; Ausgang: Carry gesetzt = daneben.
DE_RaumEigen:
	moveq	#OPT_RAUM_EIGEN,d0
	bsr.s	DE_Erzwingen
	tst.b	d0
	bne.s	de_re_sicher
	move.w	#$14,d0
	jsr	(sub_6C8C).l
	cmp.b	#$14,d0
	beq.s	de_re_treffer
	cmp.b	-$CE(a6),d0
	rts
de_re_sicher:
	moveq	#$14,d0
de_re_treffer:
	andi.b	#$FE,ccr
	rts

; DEUTSCH-HOOK 33: ersetzt "subq.b #1,d0 / move.b d0,$3(a2)" (eigene Munition)
DE_Munition:
	move.l	d0,-(a7)
	moveq	#OPT_MUNITION,d0
	bsr.w	DE_OptLesen
	tst.b	d0
	movem.l	(a7)+,d0
	bne.s	de_mu_ende
	subq.b	#1,d0
	move.b	d0,$3(a2)
de_mu_ende:
	rts

; DEUTSCH-HOOK 28: Attributwurf bei der Figurenerschaffung (Original W8, das Spiel addiert 10).
DE_Attributwurf:
	moveq	#OPT_WUERFEL,d0
	bsr.w	DE_OptLesen
	cmp.b	#3,d0
	beq.s	de_aw_max
	move.l	d1,-(a7)
	move.b	d0,d1
	moveq	#8,d0
	jsr	(sub_6C8C).l
	tst.b	d1
	beq.s	de_aw_ende
	cmp.b	#2,d1
	beq.s	de_aw_min
	move.l	d0,d1			; Modus 1: zweimal wuerfeln, der bessere Wurf zaehlt
	moveq	#8,d0
	jsr	(sub_6C8C).l
	cmp.b	d1,d0
	bcc.s	de_aw_ende
	move.l	d1,d0
	bra.s	de_aw_ende
de_aw_min:
	cmp.b	#4,d0			; Modus 2: mindestens 4 (= Attribut mindestens 14)
	bcc.s	de_aw_ende
	moveq	#4,d0
de_aw_ende:
	move.l	(a7)+,d1
	rts
de_aw_max:
	moveq	#8,d0			; Modus 3: Hoechstwert (18)
	rts

; DEUTSCH-HOOK 29: Trefferpunkte-Wurf (sub_B1C, Stufenaufstieg und Erschaffung).
; Ersetzt "move.b (a0,d0.w),d0 / bsr.w sub_6C8C": Trefferwuerfel der Klasse oder dessen Hoechstwert.
DE_TPWurf:
	move.b	(a0,d0.w),d0
	move.l	d0,-(a7)
	moveq	#OPT_TP,d0
	bsr.w	DE_OptLesen
	tst.b	d0
	movem.l	(a7)+,d0
	bne.s	de_tp_ende
	jsr	(sub_6C8C).l
de_tp_ende:
	rts

; d0.l = Erfahrungspunkte -> d0.l mal Faktor (Option EP: x1, x1,5, x2, x3). Andere Register bleiben.
DE_EPFaktor:
	movem.l	d1-d2,-(a7)
	move.l	d0,d2
	moveq	#OPT_EP,d0
	bsr.w	DE_OptLesen
	move.l	d0,d1
	move.l	d2,d0
	tst.b	d1
	beq.s	de_ef_ende
	cmp.b	#1,d1
	bne.s	de_ef_2
	lsr.l	#1,d2
	add.l	d2,d0
	bra.s	de_ef_ende
de_ef_2:
	add.l	d2,d0
	cmp.b	#2,d1
	beq.s	de_ef_ende
	add.l	d2,d0
de_ef_ende:
	movem.l	(a7)+,d1-d2
	rts

; DEUTSCH-HOOK 30: Ende von sub_1631E (EP je Figur nach dem Kampf)
DE_EPEnde:
	bsr.s	DE_EPFaktor
	move.l	d0,($FFFFD514).w
	movem.l	(a7)+,d2-d7/a2-a4
	rts

; DEUTSCH-HOOK 31: ECL-Befehl Erfahrung (loc_3BCE), ersetzt "bsr.w sub_404A / move.l d0,d3"
DE_EPEcl:
	jsr	(sub_404A).l
	bsr.s	DE_EPFaktor
	move.l	d0,d3
	rts

; DEUTSCH-HOOK 32: Credits eines besiegten Gegners (sub_1631E), ersetzt
; "move.l $1A(a1),d0 / add.l d0,($FFFFBA34).w"
DE_Credits:
	movem.l	d1-d2,-(a7)
	move.l	$1A(a1),d2
	moveq	#OPT_CREDITS,d0
	bsr.w	DE_OptLesen
	move.l	d2,d1
	tst.b	d0
	beq.s	de_cr_add
	add.l	d2,d1
	cmp.b	#1,d0
	beq.s	de_cr_add
	add.l	d2,d1
de_cr_add:
	add.l	d1,($FFFFBA34).w
	move.l	d1,d0
	movem.l	(a7)+,d1-d2
	rts

; DEUTSCH-HOOK 34: sub_16560 (EP an jede Figur nach gewonnenem Kampf), a0 = Kampfplatz, a1 = Figur.
; Wie Original EP gutschreiben; Option Heilung: aktuelle TP ($E Platz) = hoechste TP ($2E Figur).
DE_EPHeilung:
	move.l	$1E(a1),d0
	move.l	($FFFFD514).w,d1
	add.l	d1,d0
	move.l	d0,$1E(a1)
	moveq	#OPT_HEILUNG,d0
	bsr.w	DE_OptLesen
	tst.b	d0
	beq.s	de_eh_ende
	move.b	$2E(a1),$E(a0)
de_eh_ende:
	rts

; DEUTSCH-HOOK 35: Trefferwurf im Bodenkampf (loc_10804) und Zielwurf der Flaechenwaffen (sub_10FAA).
; a3 = Angreifer (Kampfplatz), Bit 0 von $1(a3) gesetzt = eigenes Team. ($FFFFD511) = Trefferzahl 1..19.
; Ausgang: d0 und Flags wie "cmp.b ($FFFFD511).w,d0" im Original (Wurf groesser = daneben).
DE_BodenWurf:
	btst	#0,$1(a3)
	beq.s	de_bw_gegner
	moveq	#OPT_BODEN_EIGEN,d0
	bsr.w	DE_Erzwingen
	tst.b	d0
	beq.s	de_bw_wurf
	moveq	#1,d0			; sicherer Treffer
	bra.s	de_bw_vergleich
de_bw_gegner:
	moveq	#OPT_BODEN_GEGNER,d0
	bsr.w	DE_Erzwingen
	tst.b	d0
	beq.s	de_bw_wurf
	moveq	#$14,d0			; sicher daneben (Trefferzahl hoechstens 19)
	bra.s	de_bw_vergleich
de_bw_wurf:
	moveq	#$14,d0
	jsr	(sub_6C8C).l
de_bw_vergleich:
	cmp.b	($FFFFD511).w,d0
	rts

; DEUTSCH-HOOK 36: zweiter Wurf der Zufallsbegegnung im All (Karte, sub_B91A). Original: W100 <= 10 = Begegnung.
; Ausgang: d0 und Flags wie "cmp.b #Grenze,d0" (Wurf groesser = keine Begegnung).
; Normal und Merkur+: Grenze 10, halb: 5, keine: 0.
DE_Begegnung:
	move.l	d1,-(a7)
	moveq	#OPT_BEGEGNUNG,d0
	bsr.w	DE_OptLesen
	moveq	#10,d1
	cmp.b	#1,d0
	bne.s	de_bg_keine
	moveq	#5,d1
de_bg_keine:
	cmp.b	#2,d0
	bne.s	de_bg_wurf
	moveq	#0,d1
de_bg_wurf:
	moveq	#100,d0
	jsr	(sub_6C8C).l
	cmp.b	d1,d0
	movem.l	(a7)+,d1		; movem aendert die Flags nicht
	rts

; DEUTSCH-HOOK 37: ECL-Befehl RANDOM (loc_351E). Eingang d0 = n, Ausgang d0 = Zufall 0..n wie im Original.
; Einzige Ausnahme: M034 $71CA "RANDOM 7 $97FB" (Schiffstyp der Zufallsbegegnung, a2 steht hinter dem Operanden).
; Mit Option Merkur+ ist der Typ zur Haelfte 4 (mittlerer Merkur-Kreuzer), sonst Wurf wie im Original
; (ca. 56 % statt 12,5 %). Solange kein Merker gesetzt ist, ueberschreibt das Skript den Typ (nur RAM).
DE_EclZufall:
	cmpa.l	#$FFFF71CD,a2
	bne.s	de_ez_normal
	cmpi.b	#34,($FFFFB9F0).w
	bne.s	de_ez_normal
	move.l	d0,-(a7)
	moveq	#OPT_BEGEGNUNG,d0
	bsr.w	DE_OptLesen
	cmp.b	#3,d0
	movem.l	(a7)+,d0
	bne.s	de_ez_normal
	move.l	d0,-(a7)
	moveq	#2,d0
	jsr	(sub_6C94).l
	tst.b	d0
	movem.l	(a7)+,d0
	beq.s	de_ez_normal
	moveq	#4,d0
	rts
de_ez_normal:
	addq.l	#1,d0
	jmp	(sub_6C94).l

; ===========================================================================
; Menues (DEUTSCH-HOOK 24, Anfang sub_13C9C). Menue 0 = Hauptmenue mit 6. Symbol "Optionen",
; Menue 2 und 4 = START-Menue mit zusaetzlichem Symbol "Optionen";
; alle anderen Menues wie im Original (loc_13CA2).
DE_Menue:
	movem.l	a2-a3,-(a7)
	tst.w	d0
	beq.s	de_me_haupt
	cmp.w	#2,d0
	beq.s	de_me_start2
	cmp.w	#4,d0
	beq.s	de_me_start4
	asl.w	#2,d0
	jmp	(loc_13CA2).l
de_me_start2:
	lea	(DE_M2_Symbole).l,a2
	lea	(DE_M2_Text).l,a3
	moveq	#6,d1
	bra.s	de_me_start
de_me_start4:
	lea	(DE_M4_Symbole).l,a2
	lea	(DE_M4_Text).l,a3
	moveq	#5,d1
de_me_start:
	move.w	d1,-(a7)
	jsr	(sub_1391A).l
	move.w	(a7)+,d1
	cmp.w	d1,d0
	bne.s	de_me_start_ende
	bsr.w	DE_OptionenSpiel
	moveq	#-1,d0			; zurueck ins Spiel wie das Symbol "Ende"
de_me_start_ende:
	movem.l	(a7)+,a2-a3
	rts
de_me_haupt:
	move.b	($FFFFD592).w,-(a7)	; Einstellungen des Aufrufers fuer Wiederholung merken
	move.b	($FFFFD595).w,-(a7)
de_me_wieder:
	lea	(DE_M0_Symbole).l,a2
	lea	(DE_M0_Text).l,a3
	jsr	(sub_1391A).l
	cmp.w	#5,d0
	bne.s	de_me_ende
	bsr.w	DE_Optionen
	jsr	(sub_DEE6).l		; wie die Hauptmenue-Schleife nach einer Aktion
	jsr	(sub_8A44).l
	jsr	(sub_4C0).l
	move.b	(a7),($FFFFD595).w
	move.b	$2(a7),($FFFFD592).w
	move.b	#5,($FFFFD593).w	; Zeiger bleibt auf "Optionen"
	bra.s	de_me_wieder
de_me_ende:
	addq.l	#4,a7
	movem.l	(a7)+,a2-a3
	rts

; START-Menue im Spiel (Original x = 9/13/17/21/25/29). Reihenfolge wie Original, "Optionen" zuletzt.
DE_M2_Symbole:
	dc.b	7,21,$00, 11,21,$02, 15,21,$03, 19,21,$04, 23,21,$43, 27,21,$26, 31,21,110, $FF
	align	2
DE_M2_Text:
	dc.b	5,25,32,25
	dc.w	79,64,65,126,316,127,DE_TXT_OPTIONEN
DE_M4_Symbole:
	dc.b	7,21,$00, 11,21,$02, 15,21,$03, 19,21,$04, 23,21,$43, 27,21,110, $FF
	align	2
DE_M4_Text:
	dc.b	5,25,32,25
	dc.w	79,64,65,126,316,DE_TXT_OPTIONEN
; Symbolbank fuer den Optionsbildschirm im Spiel
DE_BankOpt:
	dc.b	$00,$3C,$65,$42,$1B,$66,$50,$67,$4D,$44,$2C,$05,$2A,$FF
	align	2

; Hauptmenue: x, y, Symbol (Original x = 8/13/18/23/28, jetzt 6 Symbole mit gleicher Mitte)
DE_M0_Symbole:
	dc.b	6,21,$4A, 11,21,$63, 16,21,$02, 21,21,$03, 26,21,$4C, 31,21,110, $FF
	align	2
DE_M0_Text:
	dc.b	2,25,37,25
	dc.w	$3D,$3F,$40,$41,$42,DE_TXT_OPTIONEN
; Symbolbank Hauptmenue: Original dat_4EE (66 Symbole) + 110 + Symbole des Optionsbildschirms, die dort fehlen.
; Eine eigene Bank fuer den Optionsbildschirm geht nicht: der Grafikspeicher wird als Stapel verwaltet
; ("GRAPHICS FREED OUT OF ORDER", Testemulator 02.11.2026).
DE_Bank0:
	binclude	"data/0004EE.bin",0,66
	dc.b	110,$3C,$42,$44,$65,$66,$67,$FF
	align	2

; ===========================================================================
; Optionsbildschirm. Oben je Option eine Zeile (Name links, Wert rechts), unten die Symbole.
; C = naechster Wert, B = vorheriger Wert, START oder Symbol "Ende" = zurueck.
DE_Optionen:
	movem.l	d2-d4/a2-a3,-(a7)
	jsr	(sub_8A44).l
	bsr.w	DE_OptFenster
	move.w	#$C000,($FFFFD5AC).w
	move.w	#2,($FFFFD5D6).w
	move.w	#2,($FFFFD5D8).w
	st	($FFFFD5E2).w
	move.w	#DE_TXT_OPTIONEN,d0
	jsr	(sub_11C8E).l
	moveq	#0,d2
de_op_zeilen:
	move.w	d2,d0
	bsr.w	DE_OptZeile
	addq.w	#1,d2
	cmp.w	#DE_OPT_ANZAHL,d2
	bcs.s	de_op_zeilen
	moveq	#0,d3
de_op_menue:
	move.b	d3,($FFFFD593).w
	move.b	#$10,($FFFFD595).w	; B liefert $FExx
	clr.b	($FFFFD592).w		; START liefert -1
	lea	(DE_OptSymbole).l,a2
	lea	(DE_OptText).l,a3
	jsr	(sub_1391A).l
	cmp.w	#-1,d0
	beq.s	de_op_ende
	moveq	#1,d4
	tst.w	d0
	bpl.s	de_op_eintrag
	move.w	d0,d1
	lsr.w	#8,d1
	cmp.b	#$FE,d1
	bne.s	de_op_menue
	andi.w	#$FF,d0
	moveq	#-1,d4
de_op_eintrag:
	cmp.w	#DE_OPT_ANZAHL,d0
	bcc.s	de_op_ende		; Symbol "Ende"
	move.w	d0,d3
	; Wert weiterschalten: (Wert + d4) modulo Anzahl
	lsl.w	#2,d0
	lea	(DE_OptEintraege).l,a2
	adda.w	d0,a2
	moveq	#0,d0
	move.b	$1(a2),d0		; Typ
	lsl.w	#2,d0
	lea	(DE_WertTab).l,a0
	movea.l	(a0,d0.w),a0
	move.w	(a0),d2			; Anzahl Werte
	moveq	#0,d0
	move.b	(a2),d0			; Option
	bsr.w	DE_OptLesen
	add.w	d4,d0
	bpl.s	de_op_nichtneg
	move.w	d2,d0
	subq.w	#1,d0
de_op_nichtneg:
	cmp.w	d2,d0
	bcs.s	de_op_setzen
	moveq	#0,d0
de_op_setzen:
	move.b	d0,d1
	moveq	#0,d0
	move.b	(a2),d0
	bsr.w	DE_OptSchreiben
	move.w	d3,d0
	bsr.w	DE_OptZeile
	bra.w	de_op_menue
de_op_ende:
	movem.l	(a7)+,d2-d4/a2-a3
	rts

; Optionsbildschirm aus dem START-Menue (Spiel). Ablauf wie "Speichern" (sub_1930/sub_1A9E): Szenengrafik
; freigeben, Bildschirm neu aufbauen, am Ende stellt sub_AF00 das Spielbild wieder her.
DE_OptionenSpiel:
	movem.l	d2-d7/a2-a3,-(a7)
	move.b	($FFFFD592).w,-(a7)
	move.b	($FFFFD595).w,-(a7)
	move.w	($FFFFD5AC).w,-(a7)
	jsr	(sub_4C8E).l		; Symbolbank des START-Menues freigeben
	move.b	($FFFF9BBC).w,($FFFF9BBD).w
	move.b	#0,($FFFF9BBC).w
	move.b	($FFFF9AFB).w,-(a7)
	move.b	($FFFF9BBE).w,-(a7)
	move.b	($FFFFB524).w,-(a7)
	move.w	($FFFFB530).w,-(a7)
	move.b	($FFFFBA5F).w,($FFFF9BBE).w
	clr.w	($FFFFB52A).w
	clr.b	($FFFFB525).w
	moveq	#1,d5
	jsr	(sub_AF00).l		; Grundbild wie im Hauptmenue (Rahmen, Schrift)
	lea	(DE_BankOpt).l,a0
	jsr	(sub_A768).l
	bsr.w	DE_Optionen
	jsr	(sub_4C8E).l
	move.w	(a7)+,($FFFFB52A).w
	move.b	(a7)+,($FFFFB525).w
	move.b	(a7)+,($FFFF9BBE).w
	move.b	(a7)+,($FFFF9AFB).w
	move.w	#$F000,($FFFFB436).w
	move.b	($FFFF9BBD).w,($FFFFBA5E).w
	moveq	#1,d5
	jsr	(sub_AF00).l		; Spielbild wiederherstellen
	move.w	(a7)+,($FFFFD5AC).w
	move.b	(a7)+,($FFFFD595).w
	move.b	(a7)+,($FFFFD592).w
	movem.l	(a7)+,d2-d7/a2-a3
	rts

DE_OptFenster:
	move.l	#$00020002,($FFFFD5DA).w	; links 2, oben 2
	move.l	#$00250018,($FFFFD5DE).w	; rechts 37, unten 24
	rts

; d0.w = Eintrag -> Zeile 4 + Eintrag: Name ab x = 2 (weiss), Wert ab x = 29 (gelb)
DE_OptZeile:
	movem.l	d0-d3/a0-a2,-(a7)
	bsr.s	DE_OptFenster
	move.w	d0,d3
	addq.w	#4,d3
	lsl.w	#2,d0
	lea	(DE_OptEintraege).l,a2
	adda.w	d0,a2
	clr.b	($FFFFD5E2).w
	move.w	#$E000,($FFFFD5AC).w
	move.w	#2,($FFFFD5D6).w
	move.w	d3,($FFFFD5D8).w
	move.w	$2(a2),d0
	jsr	(sub_11C8E).l
	move.w	#$8000,($FFFFD5AC).w
	move.w	#29,($FFFFD5D6).w
	move.w	d3,($FFFFD5D8).w
	moveq	#0,d0
	move.b	(a2),d0
	bsr.w	DE_OptLesen
	moveq	#0,d1
	move.b	$1(a2),d1
	lsl.w	#2,d1
	lea	(DE_WertTab).l,a0
	movea.l	(a0,d1.w),a0
	add.w	d0,d0
	move.w	$2(a0,d0.w),d0
	jsr	(sub_11C8E).l
	movem.l	(a7)+,d0-d3/a0-a2
	rts

; Eintraege in Bildschirmreihenfolge: Option, Werte-Typ, Name
DE_OptEintraege:
	dc.b	OPT_RAUM_EIGEN,0
	dc.w	DE_TXT_O_RAUM_EIGEN
	dc.b	OPT_RAUM_GEGNER,0
	dc.w	DE_TXT_O_RAUM_GEGNER
	dc.b	OPT_BODEN_EIGEN,0
	dc.w	DE_TXT_O_BODEN_EIGEN
	dc.b	OPT_BODEN_GEGNER,0
	dc.w	DE_TXT_O_BODEN_GEGNER
	dc.b	OPT_UNVERWUNDBAR,1
	dc.w	DE_TXT_O_UNVERWUNDBAR
	dc.b	OPT_MUNITION,1
	dc.w	DE_TXT_O_MUNITION
	dc.b	OPT_BEGEGNUNG,6
	dc.w	DE_TXT_O_BEGEGNUNG
	dc.b	OPT_WUERFEL,2
	dc.w	DE_TXT_O_WUERFEL
	dc.b	OPT_TP,3
	dc.w	DE_TXT_O_TP
	dc.b	OPT_EP,4
	dc.w	DE_TXT_O_EP
	dc.b	OPT_CREDITS,5
	dc.w	DE_TXT_O_CREDITS
	dc.b	OPT_HEILUNG,1
	dc.w	DE_TXT_O_HEILUNG
DE_OPT_ANZAHL	= (*-DE_OptEintraege)/4

; Symbole (gleiche Reihenfolge wie die Eintraege, zuletzt "Ende")
DE_OptSymbole:
	dc.b	4,17,$3C, 9,17,$65, 14,17,$42, 19,17,$1B, 24,17,$66, 29,17,$50, 34,17,$67
	dc.b	6,21,$4D, 11,21,$44, 16,21,$2C, 21,21,$05, 26,21,$2A, 31,21,$00, $FF
	align	2
DE_OptText:
	dc.b	2,25,37,25
	dc.w	DE_TXT_O_RAUM_EIGEN,DE_TXT_O_RAUM_GEGNER,DE_TXT_O_BODEN_EIGEN,DE_TXT_O_BODEN_GEGNER
	dc.w	DE_TXT_O_UNVERWUNDBAR,DE_TXT_O_MUNITION,DE_TXT_O_BEGEGNUNG
	dc.w	DE_TXT_O_WUERFEL,DE_TXT_O_TP,DE_TXT_O_EP,DE_TXT_O_CREDITS,DE_TXT_O_HEILUNG,$4F

; Werte-Typen: Anzahl, dann Text je Wert
DE_WertTab:
	dc.l	DE_WT_Prozent,DE_WT_AnAus,DE_WT_Wuerfel,DE_WT_TP,DE_WT_EP,DE_WT_Credits,DE_WT_Begegnung
DE_WT_Prozent:
	dc.w	5,DE_TXT_W_AUS,DE_TXT_W_25,DE_TXT_W_50,DE_TXT_W_75,DE_TXT_W_100
DE_WT_AnAus:
	dc.w	2,DE_TXT_W_AUS,DE_TXT_W_AN
DE_WT_Wuerfel:
	dc.w	4,DE_TXT_W_ORIGINAL,DE_TXT_W_2WUERFE,DE_TXT_W_MIN14,DE_TXT_W_MAXIMUM
DE_WT_TP:
	dc.w	2,DE_TXT_W_ORIGINAL,DE_TXT_W_MAXIMUM
DE_WT_EP:
	dc.w	4,DE_TXT_W_NORMAL,DE_TXT_W_X15,DE_TXT_W_X2,DE_TXT_W_X3
DE_WT_Credits:
	dc.w	3,DE_TXT_W_NORMAL,DE_TXT_W_X2,DE_TXT_W_X3
DE_WT_Begegnung:
	dc.w	4,DE_TXT_W_NORMAL,DE_TXT_W_HALB,DE_TXT_W_KEINE,DE_TXT_W_MERKUR
