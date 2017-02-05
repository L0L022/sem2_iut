%include	"iut.inc"

segment	.text

global	start

start:
	mov	eax,tab
	mov	ebx,1000
	call	read_string

	mov	eax,msg1
	call	write_string

	mov	ecx,tab

.ici:	mov	bl,[ecx]

	cmp	bl,0
	je	.fin

	cmp	bl,'a'
	jl	.suite

	cmp	bl,'z'
	jg	.suite

	cmp	bl,'a'
	je	.a

.bz:	dec	bl
	jmp	.suite

.a:	mov	bl,'z'

.suite:	mov	al,bl
	call	write_char

	inc	ecx
	jmp	.ici

.fin:	ret

segment	.data

msg1:		db	"Resultat",10,0

segment .bss

tab:		resb	1000
