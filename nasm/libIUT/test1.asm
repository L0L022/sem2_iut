%include	"iut.inc"

segment	.text

global	start

start:
	mov	eax,msg1
	call	write_string
	call	maxxy
	shl	eax,1
	mov	ecx,eax
	mov	al,'X'
loop1:
	call	write_char
	dec	ecx
	jne	loop1

	mov	eax,msg3
	call	write_string
	call	press_key
	call	clear_screen

	mov	eax,msg2
	call	write_string
	call	press_key
	call	maxxy
	shl	ebx,1
	mov	ecx,ebx
loop2:
	mov	eax,msg2b
	call	write_string
	mov	eax,ecx
	call	write_int
	dec	ecx
	jne	loop2

	ret

segment .data

msg1:	db	"Test de passage a la ligne suivante. Deux lignes de X doivent s'ecrire a l'ecran.",10,0

msg3:	db	10,10,"L'ecran va maintenant etre efface lorsque vous aurez appuye sur une touche.",10,0

msg2:	db	"Test de scrolling de l'ecran. L'ecran doit scroller, et la derniere ligne visible doit indiquer Y1.",10,0
msg2b:	db	10,"Y : ",0


