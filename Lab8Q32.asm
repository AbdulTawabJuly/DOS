; print string and keyboard wait using BIOS services 
[org 0x100] 
 jmp start 
msg1: db 'hello world', 0 
msg2: db 'hello world again', 0 
msg3: db 'hello world again and again', 0 
;;;;; COPY LINES 005-024 FROM EXAMPLE 7.1 (clrscr) ;;;;; 
;;;;; COPY LINES 050-090 FROM EXAMPLE 7.4 (printstr) ;;;;; 
;;;;; COPY LINES 028-050 FROM EXAMPLE 7.4 (strlen) ;;;;; 
start: mov ah, 0x10 ; service 10 – vga attributes 
 mov al, 03 ; subservice 3 – toggle blinking 
 mov bl, 01 ; enable blinking bit 
 int 0x10 ; call BIOS video service 
 mov ah, 0 ; service 0 – get keystroke 
 int 0x16 ; call BIOS keyboard service 
 call clrscr ; clear the screen 
 mov ah, 0 ; service 0 – get keystroke 
 int 0x16 ; call BIOS keyboard service 
 mov ax, 0 
 push ax ; push x position 
 mov ax, 0 
 push ax ; push y position 
 mov ax, 1 ; blue on black 
 push ax ; push attribute 
 mov ax, msg1 
 push ax ; push offset of string 
 call printstr ; print the string 
 mov ah, 0 ; service 0 – get keystroke 
 int 0x16 ; call BIOS keyboard service 
 mov ax, 0 
 push ax ; push x position 
 mov ax, 0 
 push ax ; push y position 
 mov ax, 0x71 ; blue on white 
 push ax ; push attribute 
 mov ax, msg2 
 push ax ; push offset of string 
 call printstr ; print the string 
 mov ah, 0 ; service 0 – get keystroke 
 int 0x16 ; call BIOS keyboard service 
 mov ax, 0 
 push ax ; push x position 
 mov ax, 0 
 push ax ; push y position 
 mov ax, 0xF4 ; red on white blinking 
 push ax ; push attribute 
 mov ax, msg3 
 push ax ; push offset of string 
 call printstr ; print the string 
 mov ah, 0 ; service 0 – get keystroke 
 int 0x16 ; call BIOS keyboard service 
 mov ax, 0x4c00 ; terminate program 
 int 0x21 