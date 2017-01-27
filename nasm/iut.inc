; E.Remy -  Architecture des ordinateurs - IUT d'Arles
; 09/2002 - 1ere version simple (flots C)
; 09/2003 - 2eme version (interface avec curses)

extern	read_int		; valeur de retour dans eax
extern	read_uint		; valeur de retour dans eax
extern	read_hexa		; valeur de retour dans eax
extern	read_char		; valeur du code ASCII dans al
extern	read_string		; appel avec l'adresse du tableau dans eax, taille du tableau dans ebx, pas de valeur de retour
extern	press_key		; pas de parametre, ni de valeur de retour

extern	movexy			; deplace la position du curseur en (eax,ebx)
extern	maxxy			; renvoie dans eax et ebx respectivement la largeur et la hauteur de l'ecran
extern	write_nl		; pas de parametre
extern	write_int		; appel avec l'entier dans eax
extern	write_uint		; appel avec l'entier dans eax
extern	write_hex		; appel avec l'entier dans eax
extern	write_char		; appel avec le code ASCII dans al
extern	write_string	; appel avec l'adresse de la suite de code ASCII termine par 0 dans eax
extern	clear_screen	; efface l'ecran

extern	sleep_ms		; nombre de microseconde a attendre dans eax
extern	write_registers ; pas de parametre
extern	write_mark1 	; pas de parametre
extern	write_mark2 	; pas de parametre
extern	write_mark3 	; pas de parametre
extern	write_mark4 	; pas de parametre
extern	write_mark5		; pas de parametre
