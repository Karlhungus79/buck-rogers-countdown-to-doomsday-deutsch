; Grundeinstellungen fuer den Macro Assembler AS
	cpu 68000
	padding off		; dc.b nicht automatisch auf gerade Adressen auffuellen
	supmode on		; keine Warnungen fuer privilegierte Befehle
	listing purecode
	page 0

; Deutsche Fassung: Aufruf mit -D DEUTSCH=1 (build.py --deutsch). Ohne: Original, bit-genau.
	ifndef DEUTSCH
DEUTSCH = 0
	endif
	ifndef DEUTSCH_TEST
DEUTSCH_TEST = 0
	endif
