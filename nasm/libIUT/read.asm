; a rajouter pour des objets en COFF 
%ifdef UNDERSCORE
%define scanw		_scanw
%define getch		_getch
%define getnstr		_getnstr
%define	echochar	_echochar
%define	refresh		_refresh
%define une_pause_c	_une_pause_c
%endif
; fin de COFF

extern	scanw
extern	getch
extern	getnstr
extern	echochar
extern	refresh
extern	une_pause_c

; Attention fonctions non re-entrantes !
global	read_int
global	read_uint
global	read_hexa
global	read_char
global	read_string
global	press_key

segment	.text

read_int:
	pusha
	push	DWORD tmp_int
	push	DWORD fmt_int
	call	scanw
	add	esp,8
	popa
	mov	eax,[tmp_int]
	ret

read_uint:
	pusha
	push	DWORD tmp_uint
	push	DWORD fmt_uint
	call	scanw
	add	esp,8
	popa
	mov	eax,[tmp_uint]
	ret
	
read_hexa:
	pusha
	push	DWORD tmp_hexa
	push	DWORD fmt_hexa
	call	scanw
	add	esp,8
	popa
	mov	eax,[tmp_hexa]
	ret

read_char:
	pusha
	call	getch
	mov	[tmp_char],al
%ifidn __OUTPUT_FORMAT__, win32 
	; cas particulier de PDCurses : il faut faire l'echo à l'écran de la lettre tapée.
	; (bug de PDCurses ?)
	mov	eax,0
	mov	al,[tmp_char]
	push	eax
	call	echochar
	add	esp,4
	call	refresh
%elifidn __OUTPUT_FORMAT__, elf32
	; Cas de Linux : l'écho est fait automatiquement puisqu'il n'est pas désactivé !
%endif
	popa
	mov	al,[tmp_char]
	ret

read_string:
	pusha
	push	ebx ; nombre d'octets max à lire, y compris 0 terminal.
	push	eax ; adresse du tableau.
	call	getnstr
	add	esp,8
	popa
	ret

press_key:
	pusha
	call	une_pause_c
	popa
	ret

segment	.data

fmt_int:	db	"%d",0
fmt_uint:	db	"%u",0
fmt_hexa:	db	"%X",0

segment	.bss

tmp_char:
		resb	1
tmp_int:
tmp_uint:
tmp_hexa:
		resd	1
