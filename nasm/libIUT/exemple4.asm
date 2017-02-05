; fichier exemple4.asm

%include	"iut.inc"

segment	.text

global	start

start:
	mov	eax,msg1
	call	write_string
	call	read_char
	call	write_nl
	mov	[car],al	; on copie al dans la case designee par "car"
	mov	eax,msg2
	call	write_string
	mov	al,[car]	; on copie la valeur de la case designee par "car" dans al.
	call	write_char	; on ecrit le caractere.

	call	write_nl	; on saute
	call	write_nl	; deux lignes.

	call	press_key	; on attend l'appui sur une touche.

	mov	eax,msg3
	call	write_string
	mov	eax,str1	; on met dans eax l'adresse de la premiere des cases prevues
				; pour contenir les lettres du message.
	mov	ebx,200		; on met dans ebx le nombre total de cases disponibles.
	call	read_string	; on lit le message.

	mov	eax,msg4
	call	write_string

	mov	al,34		; 34 est le code ASCII pour le guillemet
	call	write_char	; ecrit " a l'ecran

	mov	eax,str1
	call	write_string

	mov	al,34
	call	write_char
	call	write_nl

	ret

segment .data

msg1:	db	"Donnez un char a mettre dans EBX >",0
msg2:	db	"Vous avez tape la lettre >",0

; Remarquez dans le message suivant que les 10 reprensentent le code ASCII
; "Line Feed" qui permet de passer a la ligne. Remarquez aussi que le message
; continue a la ligne suivante puisqu'il ne se termine qu'au zero final !
msg3:	db	"Donnez une chaine de caracteres a ranger en memoire.",10
		db	"(Seuls les 199 premieres lettres seront conservees, les autres",10
		db	"seront ignorees).",10,">",0

msg4:	db	"Vous avez tape la chaine ",0

segment .bss	; ce segment permet de prendre une place pour des donnees pour 
		; lesquelles on ne souhaite pas preciser une valeur au momment
		; de la compilation.

str1:	resb	200	; 200 octets pour pouvoir lire 199 codes ASCII et le 0 terminal
car:	resb	1	; 1 octet pour pouvoir stocker un seul code ASCII

