%include "iut.inc"

global start

segment .text

start:
	mov		eax,msg1
	call	write_string
	mov		ebx,0 ; La compteur de valeur sera dans ebx.
	mov		ecx,0 ; La somme sera dans ecx.
	mov		edx,0 ; Le plus grand sera dans edx.
saisie:
	call	read_int
	cmp		eax,-1
	je		fin
	inc		ebx
	add		ecx,eax
	cmp		eax,edx
	jle		.suite
	mov		edx,eax
.suite:
	jmp		saisie
fin:
	mov		eax,msg2
	call	write_string
	mov		eax,ebx
	call	write_int
	mov		eax,msg3
	call	write_string
	mov		eax,ecx
	call	write_int
	mov		eax,msg4
	call	write_string
	mov		eax,edx
	call	write_int
	mov		eax,msg5
	call	write_string
moyenne:
	mov		eax,ecx 
	mov		edx,0   ; ainsi edx:eax vaut la somme.
	div		ebx
	call	write_int
	mov		eax,msg6
	call	write_string
	ret

section .data

msg1:	db	"Tappez une suite de valeurs positives et utilisez la valeur -1 pour terminer.",10,0
msg2: 	db	"Vous avez tape ",0
msg3:	db	" nombres.",10,"Leur somme vaut ",0
msg4:	db	10,"Le plus grand est ",0
msg5:	db	".",10,"Leur moyenne (entiere) est ",0
msg6:	db	".",10,0