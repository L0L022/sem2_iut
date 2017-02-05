%include	"iut.inc"

segment	.text

global	start

start:
	mov	eax,msg1
	call	write_string
	mov	eax,123456
	call	write_uint
	mov	eax,msg2
	call	write_string
	ret

segment .data

msg1:	db	"Ce programme teste les differentes fonctions de sortie existantes.",10
	db	"Vous devez voir '123456' write_uint : ",0

msg2:	db	"Les autres tests ne sont pas encore implantes.",10,0

