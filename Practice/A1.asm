[org 0x0100]
jmp start
num1: db 0xA
dw 0x1234
dd 0xABCDEF09

start: 
mov ax, 66h
mov bx, 1Ah
add bl,al
mov [num1], ax
mov ax, 0x4c00 ; terminate program
int 0x21