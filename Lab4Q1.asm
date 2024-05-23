[org 0x0100]

mov bx,0xB189
mov ax,0xAB45
mov cx,0

L:
SHR bx,1
jc increment

Loo:
inc cx
cmp cx,16
jne L
xor cx,cx
mov cl,[count]
mov dx,1
mov bl,0

Loo2:
xor ax,dx
SHL dx,1
inc bl
cmp bl,cl
jne Loo2

jmp end

increment:
add byte[count],1
jmp Loo

end:
mov ax, 0x4c00
int 21h

count : db 0