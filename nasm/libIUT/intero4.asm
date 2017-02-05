%include "iut.inc"

global start

segment .text

start:
	mov	eax,msg1
	call	write_string
	call	read_int
	push	eax
	mov	eax,msg2
	call	write_string
	pop	eax
	call	write_bin_int
	ret

write_bin_int:
	mov	ebx,32	; 32 bits a imprimer
	mov	ecx,eax	; entier a ecrire dans ecx
.loop:	cmp	ebx,0
	jz	.fini
	rol	ecx,1
	jc	.even
.odd:	mov	al,'0'
	jmp	.suite
.even:	mov	al,'1'
.suite:	call	write_char
	dec	ebx
	jmp	.loop
.fini:	ret

segment .data
msg1:	db	"Donnez un entier en base 10 >",0
msg2:	db	"Sa valeur en base 2 est :",0
