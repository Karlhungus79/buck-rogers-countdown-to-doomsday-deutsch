; ===========================================================================
; Deutsche Fassung - Erweiterung ab $100000 (nur mit -D DEUTSCH=1)
; Stand: 23.10.2026. Beschreibung: claude/Textablage.md
; ===========================================================================

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
; Erzeugt von 03_Tools/text_einsetzen.py (nicht von Hand aendern):
;   DE_Modultabelle: 27 Langworte (Reihenfolge wie dat_38CE6) -> Zeigertabelle je Modul
;   danach Zeigertabellen und Texte
	org	$108000
DE_Modultabelle:
	binclude	"deutsch/texte.bin"
