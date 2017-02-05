; a rajouter pour des objets en COFF 
%ifdef UNDERSCORE
%define go_asm	_go_asm
%endif
; fin de COFF

global	go_asm
extern	start

segment .text

go_asm:
	pusha
	call	start
	mov	[res],eax
	popa
	mov	eax,[res]
	ret

segment	.data

res:	dd	0
