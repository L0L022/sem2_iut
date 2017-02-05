; TP2

%include "iut.inc"

segment .text

global start

start:

.nuit:
      call  write_nl
      call  write_nl
      mov   eax,msg1
      call  write_string
      call  read_char ; lit le caractère J ou N
      call  write_nl
      cmp   al,'N'
      jne   .false
      mov   eax,msg2
      call  write_string
      jmp   .fin
.false:
      cmp   al,'J'
      je    .jour
      mov   eax,msg4
      call  write_string
      jmp   .nuit 
.jour:
      mov   eax,msg3
      call  write_string
.fin:
      ret

segment .data

msg1: db "(J)our ou (N)uit?",0
msg2: db "Vive la nuit!",0
msg3: db "Vive le jour!",0
msg4: db "Tapez soit J soit N (en majuscule) !",0
