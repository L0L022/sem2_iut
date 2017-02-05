%include	"iut.inc"

segment	.text

global	start

start:
	call	zeros
	call	compter
	call	aff_res
	ret	

zeros:
	mov		ecx,0
.loop:
	mov		[tab+ecx*4],DWORD 0
	inc		ecx
	cmp		ecx,26
	jne		.loop
	ret

aff_res:
	mov		ecx,0
.loop:
	mov		eax,ecx
	add		al,'a'
	call	write_char
	mov		al,':'
	call	write_char
	mov		eax,[tab+ecx*4]
	call	write_int
	call	write_nl
	inc		ecx
	cmp		ecx,26
	jne		.loop
	ret

compter:
	mov		eax,0
	mov		ebx,msg
.loop:
	mov		al,[ebx]
	inc		ebx
	cmp		al,0
	je		.fin
	cmp		al,'a'
	jl		.loop
	cmp		al,'z'
	jg		.loop
	sub		al,'a'
	inc		DWORD [tab+eax*4]
	jmp		.loop
.fin:
	ret

segment	.data

msg:		db	"meme si la chaine contient de la ponctuation, la routine doit marcher ! et c'est normal...",0

segment .bss

tab:		resd	26