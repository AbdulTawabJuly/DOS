[org 0x100]

mov ax,[num1+1]
mov bx,[num1+2]
add ax,bx
mov bx,[num1+4]
add ax,bx
mov[num1+6],ax
mov ax,0x4c00cls
int 21h
num1:dw 5,10,15,0
