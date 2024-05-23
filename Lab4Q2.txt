[org 0x100]
mov ax,0x8BCD
mov bx,0x7BCD
mov cx,ax
and cx,bx
cmp cx,ax
jne notEqual
mov dx,1
jmp end
notEqual:
	mov dx,0
end:
mov ax,0x4c00
int 21h