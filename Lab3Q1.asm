[org 0x0100]

mov al,[num1]
mov bl,[num1+1]
mov [num1],bl
mov [num1+1],al

mov ax,0x4c00 
int 0x21
num1 : dw 0xAABB