; fichier exemple2.asm

%include	"iut.inc"

segment	.text

global	start

start:
	mov	eax,msg1
	call	write_string	; La

	mov	eax,1
	call	write_int	; 1
	
	mov	eax,msg2
	call	write_string	; ere lettre de l'alphabet est :

	mov	al,41h
	call	write_char	; A
	call	write_nl	; <NL>

	call	press_key	; Attend l'appui sur une touche quelconque.

	mov	eax,msg3
	call	write_string

	mov	ebx,10		; On met 10 dans ebx.

ici:				; On designe cet endroit par le nom "ici" de maniere
				; a pouvoir y revenir.
	mov	eax,ebx		; On copie la valeur de ebx dans eax.
	call	write_int	; On ecrit la valeur de eax.
	call	write_nl	; On passe a la ligne.
	mov	eax,1000	; On met 1000 dans eax...
	call	sleep_ms	; pour attendre 1 seconde.
	dec	ebx		; On diminue ebx de un,
	jnz	ici		; et si on n'a pas obtenu 0 a l'operation precedante,
				; on retourne a la ligne "ici",
				; si on a obtenu 0, on continue.
	mov	eax,msg4
	call	write_string	; et on ecrit BOOM !!!
	ret

segment .data

msg1:	db	"La ",0
msg2:	db	"ere lettre de l'alphabet est : ",0
msg3:	db	"Une ligne imprimee apres la pause.",10,"Maintenant, je "
		db	"decompte a partir de 10 :",10,0
msg4:	db	"BOOM!!!",0
