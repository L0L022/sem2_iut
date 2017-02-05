%include	"iut.inc"

segment	.text

global	start

start:
	mov	eax,msg1
	call	write_string

	call	press_key

	call	clear_screen
	call	maxxy		; maxx dans eax et maxy dans ebx
	mul	ebx		; eax <- maxx*maxy
	mov	ecx,eax		; ecx <- eax
	mov	al,'X'		; prepare 'X'
	dec	ecx
	dec	ecx
loop1:
	call	write_char
	dec	ecx
	jne	loop1

	mov	eax,3000
	call	sleep_ms

	call	press_key

	mov	al,'O'
	call	write_char

	mov	eax,3000
	call	sleep_ms

	ret

segment .data

msg1:	db	"Test de restoration sous la boite de 'Appuyez sur une touche'.",10
	db	"L'ecran va se couvrir de 'X', puis pauser 3 secondes, puis afficher la boite "
	db	"d'attente et pauser de nouveau 3 secondes. "
	db	"Lorsqu'on appuie sur une touche, la boite doit disparaitre en remontrant les 'X' "
	db	"et un 'O' doit etre dessine a la suite des 'X' avant que le programme pause "
	db	"3 nouvelles secondes.",10,10
	db	"Il faut que les 'X' soient bien recris sous la boite et le 'O' visible "
	db	"a la suite.",10,0



