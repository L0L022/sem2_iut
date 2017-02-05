; a rajouter pour des objets en COFF 
%ifdef UNDERSCORE
%define printw		_printw
%define refresh		_refresh
%define sleep		_sleep
%define sleep_ms_c	_sleep_ms_c
%endif
; fin de COFF

extern	printw
extern	refresh
extern	sleep_ms_c

global	sleep_ms
global	write_mark1
global	write_mark2
global	write_mark3
global	write_mark4
global	write_mark5
global	write_registers
global	write_flags

segment .text

sleep_ms:
	pusha
	push	eax
	call	sleep_ms_c
	add	esp,4
	popa
	ret

write_mark1:
	pusha
	push	DWORD str_mark1
	jmp	write_markn
write_mark2:
	pusha
	push	DWORD str_mark2
	jmp	write_markn
write_mark3:
	pusha
	push	DWORD str_mark3
	jmp	write_markn
write_mark4:
	pusha
	push	DWORD str_mark4
	jmp	write_markn
write_mark5:
	pusha
	push	DWORD str_mark5
	jmp	write_markn
write_markn:	
	call	printw
	add	esp,4
	call	refresh
	popa
	ret

write_registers:
	pusha
	push	edx
	push	ecx
	push	ebx
	push	eax
	push	str_regs1
	call	printw
	add	esp,20
	push	esi
	push	edi
	push	ebp
	push	esp
	mov	eax,fs
	push	eax
	mov	eax,gs
	push	eax
	push	str_regs2
	call	printw
	add	esp,28
	call	refresh
	popa
	ret
	
write_flags:	; cette fonction n'a jamais ete testee
	pusha
	mov	bx,3130h	; bh="1" bl="0" en ASCII
	mov	[str_flags1+3],bl
	mov	[str_flags1+8],bl
	mov	[str_flags1+13],bl
	mov	[str_flags1+18],bl
	mov	[str_flags1+23],bl
	lahf
.cf:	bt	ax,0+8
	jnc	.pf
	mov	[str_flags1+3],bh
.pf:	bt	ax,2+8
	jnc	.af
	mov	[str_flags1+8],bh
.af:	bt	ax,4+8
	jnc	.zf
	mov	[str_flags1+13],bh
.zf:	bt	ax,6+8
	jnc	.sf
	mov	[str_flags1+18],bh
.sf:	bt	ax,7+8
	jnc	.suite
	mov	[str_flags1+23],bh
.suite:
	push	DWORD str_flags1
	call	printw
	add	esp,4
	call	refresh
	popa
	ret

segment .data
	
str_mark1:	db	"mark1",10,0
str_mark2:	db	"mark2",10,0
str_mark3:	db	"mark3",10,0
str_mark4:	db	"mark4",10,0
str_mark5:	db	"mark5",10,0

str_regs1:	db	"EAX=%08X EBX=%08X ECX=%08X EDX=%08X",10,0
str_regs2:	db	"ESI=%08X EDI=%08X EBP=%08X ESP=%08X",10,0 ;" FS= GS=",10,0

str_flags1:	db	"CF:  PF:  AF:  ZF:  SF: ",10,0

