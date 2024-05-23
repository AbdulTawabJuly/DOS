[org 0x0100]

mov ax,0xA425
xor si,si
xor di,di

loop1:
shl ah,1
inc si
jc Left_Set_1
jnc Left_Set_0

loop2:
shr al,1
inc di
jc Right_Set_1
jnc Right_Set_0

Left_Set_1:   
mov ch,1
jmp loop2

Left_Set_0:
mov ch,0
jmp loop2

Right_Set_1:
mov bh,1
jmp Compare1

Right_Set_0:
mov bh,0
jmp Compare2

Compare1:
cmp ch,bh
je Compare2
jne NotEqual

Compare2:
cmp si,8
je Equal
jmp loop1

Equal:
mov dx,1
jmp End

NotEqual:
mov dx ,0
jmp End

End:
mov ax,0x4c00
int 0x21

end:
mov ax,0x4c00
int 0x21
