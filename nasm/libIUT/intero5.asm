%include "iut.inc"

global start

segment .text

start:
	mov	eax,msg1
	call	write_string
	mov	eax,tampon
	mov	ebx,1000
	call	read_string
.choix:	mov	eax,msg2
	call	write_string
	call	read_char
	cmp	al,'c'
	je	.code
	cmp	al,'d'
	je	.decode
	jmp	.choix
.code:	call	coder
	jmp	.suite
.decode:call	decoder
	jmp	.suite
.suite:	mov	eax,msg3
	call	write_string
	mov	eax,tampon
	call	write_string	
	ret

coder:	mov	eax,tampon
	mov	ebx,clair
	mov	ecx,code
	call	codec
	ret

decoder:mov	eax,tampon
	mov	ebx,code
	mov	ecx,clair
	call	codec
	ret

codec:	mov	edx,eax
.suite:	mov	al,[edx]
	cmp	al,0
	je	.fini
	call	cherche
	mov	al,[ecx+eax]
	cmp	al,0
	je	.saute
	mov	[edx],al
.saute:	inc	edx
	jmp	.suite
.fini:	ret

cherche:push	ecx
	mov	ecx,0
.encore:mov	ah,[ebx+ecx]
	cmp	al,ah
	je	.fini
	cmp	ah,0
	je	.fini
	inc	ecx
	jmp	.encore
.fini:	mov	eax,ecx
	pop	ecx
	ret

segment .data

msg1:	db	"Donnez le message a coder ou a decoder.",10,0
msg2:	db	"c - coder",10,"d - decoder",10,0
msg3:	db	"Le resultat du codage/decodage est :",10,0
clair:	db	"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?,.%*",0
code:	db	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz9876543210?!.,*%",0

segment	.bss
tampon:	resb	1000
