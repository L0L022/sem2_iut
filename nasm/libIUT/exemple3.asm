; fichier exemple3.asm

%include	"iut.inc"

segment	.text

global	start

start:
	mov	eax,msg1
	call	write_string
	mov	eax,-12345
	call	write_int	; on ecrit -12345

	mov	al,10		; on met 10 dans al
	call	write_char	; ecrit le code ASCII 10 (passage a la ligne) a l'ecran

	mov	eax,msg2
	call	write_string
	mov	eax,-12345
	call	write_uint	; on ecrit nombre -12345 code en complement a deux comme
				; s'il etait juste un nombre positif en binaire
	call	write_nl

	mov	eax,msg3
	call	write_string
	mov	eax,-12345
	call	write_hex	; Idem mais en representation hexadecimale (base 16).
	call	write_nl	; On saute
	call	write_nl	; deux lignes.
	
	mov	eax,msg4
	call	write_string
	call	read_uint	; on lit un entier non-signe
	mov	ebx,eax		; on le recopie dans ebx
	
	mov	eax,msg5
	call	write_string
	call	read_int	; on lit un entier eventuellement negatif
	mov	ecx,eax		; et on le recopie dans ecx

	mov	eax,msg6
	call	write_string
	call	read_hexa	; on lit un entier positif en base 16
	mov	edx,eax		; et on le recopie dans edx
	
	mov	eax,msg7
	call	write_string
	call	write_registers	; on affiche tous les registres.
	
	ret

segment .data

msg1:	db	"La meme valeur -12345 affichee :",10
	db	"en decimal (signe)     '-12345'     : ",0
msg2:	db	"en decimal (non-signe) '4294954951' : ",0
msg3:	db	"en hexadecimal         'ffffcfc7'   : ",0
msg4:	db	"Donnez un entier non-signe a mettre dans EBX >",0
msg5:	db	"Donnez un entier signe a mettre dans ECX >",0
msg6:	db	"Donnez un entier en hexadecimal a mettre dans EDX >",0
msg7:	db	"Voici le contenu des registres :",10,0

