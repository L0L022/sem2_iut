; fichier exemple1.asm

%include	"iut.inc"	; Necessaire pour pouvoir utiliser les routines
				; externes de la bibliotheque libIUT.

segment	.text			; Cette partie du programme (segment) contient les
				; instructions.

global	start			; Cette directive de compilation rend visible
				; l'etiquette start a l'exterieur de ce fichier. Il est
				; indispensable de la mettre.

start:
	call	maxxy		; Permet d'otenir le nombre de ligne et le nombre de
				; colones.
	shr	eax,1		; En decalant, on divise par 2 le nombre de lignes...
	shr	ebx,1		; et le nombre de colones.
	sub	eax,7		; Le message fait 15 lettres, donc on soustrait 7 a eax
				; pour arriver au milieu de l'ecran.
	call	movexy		; On deplace le curseur a cette position.
	mov	eax,hw		; On met l'adresse de la premiere lettre du message
				; dans eax.
	call	write_string	; On appelle la routine d'affichage pour obtenir :
				; Hello world !!!

	call	maxxy		; On reprend le nombre de lignes et de colones.
	mov	eax,0		; On met eax a 0.
	dec	ebx		; On soustrait un a ebx (decrementation)
	call	movexy		; On place donc le curseur en premiere colone et
				; derniere ligne.
	mov	eax,dlig	; On met l'adresse de la premiere lettre du deuxieme
				; message dans eax.
	call	write_string	; On ecrit le deuxieme message : derniere ligne.

	mov	eax,0		; On met 0 dans eax,
	mov	ebx,0		; et 0 dans ebx.
	call	movexy		; On va donc en premiere ligne et premiere colone.
	mov	eax,plig	; On met l'adresse de la premiere lettre du troisieme
				; message dans eax.
	call	write_string	; On ecrit le deuxieme message : premiere ligne.

	mov	eax,3000	; On met 3000 dans eax pour
	call	sleep_ms	; attendre 3000 millisecondes, soit 3 secondes.

	ret			; fin du programme, et retour au systeme d'exploitation

segment	.data			; Cette partie du programme contient des donnees.

hw:		db	"Hello world",32,"!!!",0
dlig:	db	"derniere ligne",0
plig:	db	"premiere ligne",0
