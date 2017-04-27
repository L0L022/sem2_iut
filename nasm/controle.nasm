%include	"iut.inc"

segment	.text

global	start

Somme_des_Valeurs_Absolus:
  mov ebx, 0
  mov ecx, 0
  mov edx, 0

.debut:
  call read_int

  cmp eax, 0
  je .fin

  jge .jge_pos
; le nombre est négatif
  inc ecx
  neg eax
  jmp .jge_fin
.jge_pos:
; le nombre est positif
  inc ebx
.jge_fin:
  add edx, eax
  jmp .debut

.fin:
  mov eax, edx

  ret

start:
  mov eax, msgAcceuil
  call write_string

  call Somme_des_Valeurs_Absolus
  mov edx, eax

  mov eax, msgAbsolus
  call write_string
  mov eax, edx
  call write_int

  mov eax, msgPositif
  call write_string
  mov eax, ebx
  call write_int

  mov eax, msgNegatif
  call write_string
  mov eax, ecx
  call write_int

	ret

segment .data

msgAcceuil:	db "Entrer la liste des nombres (0 pour finir) :",10,0
msgAbsolus: db "Somme des valeurs absolus : ",0
msgPositif: db 10,"Nombre de nombres positifs: ",0
msgNegatif: db 10,"Nombre de nombres negatifs: ",0
