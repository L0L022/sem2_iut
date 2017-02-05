; a rajouter pour des objets en COFF 
%ifdef UNDERSCORE
%define win		_win
%define maxx		_maxx
%define maxy		_maxy
%define	addch		_addch
%define	waddch		_waddch
%define addstr		_addstr
%define waddstr		_waddstr
%define wgetch		_wgetch
%define printw		_printw
%define wprintw		_wprintw
%define move		_move
%define refresh		_refresh
%define clear		_clear
%endif
; fin de COFF

extern	win
extern	maxx
extern	maxy
extern	addch
extern	waddch
extern	addstr
extern	waddstr
extern	wgetch
extern	printw
extern	wprintw
extern	move
extern	refresh
extern	clear

global	movexy
global	maxxy
global	write_nl
global	write_int
global	write_uint
global	write_hex
global	write_char
global	write_string
global	clear_screen

segment .text

movexy:
	pusha
	push	eax
	push	ebx
	call	move
	add	esp,8
	popa
	ret

maxxy:
	mov	eax,[maxx]
	mov	ebx,[maxy]	
	ret

clear_screen:
	pusha
	call	clear
	call	refresh
	popa
	ret

write_nl:
	pusha
	push	DWORD 10
	mov	eax,[win]
	push	eax
	call	waddch
	add	esp,8
	call	refresh
	popa
	ret

write_char:
	pusha
	and	eax,0FFh
	push	eax
	mov	eax,[win]
	push	eax
	call	waddch
	add	esp,8
	call	refresh
	popa
	ret

; Les fonctions suivantes sont indiscociables.
write_int:
	pusha
	push	eax
	push	DWORD fmt_int
	jmp	write

write_uint:
	pusha
	push	eax
	push	DWORD fmt_uint
	jmp	write

write_hex:
	pusha
	push	eax
	push	DWORD fmt_hex
	jmp	write

write_string:
	pusha
	push	eax
	push	DWORD fmt_string
	jmp	write

write:
	mov	eax,[win]
	push	eax
	call	wprintw
	add	esp,12
	call	refresh
	popa
	ret
	
segment .data

fmt_int:	db	"%d",0
fmt_uint:	db	"%u",0
fmt_hex:	db	"%x",0
fmt_string:	db	"%s",0

