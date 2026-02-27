; another_example.asm
org 0x7c00
bits 16
start: jmp boot

; const and var definitions
msg db "Welcome to this OS", 0ah, 0dh, 0h

boot:
  cli       ; clear interrupts (allows system to respond to i/o)
  cld       ; all we need to init
  
  mov ax, 0x50

  ; set the buffer
  mov es, ax 
  xor bx, bx

  mov al, 2     ; read 2 sector
  mov ch, 0     ; track 0
  mov cl, 2     ; sector to read
  mov dh, 0     ; head number
  mov dl, 0     ; drive number

  mov ah, 0x02  ; read sectors from disk
  
  int 0x13      ; call BIOS routine
  jmp 0x50:0x0  ; jump and execute the sector

  hlt           ; halt the system

; We have to be 512 bytes. Clear the rest of the bytes with 0.
times 510 - ($-$$) db 0
dw 0xAA55   ; Boot signature
