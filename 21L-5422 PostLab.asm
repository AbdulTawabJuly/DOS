[org 0x0100]

jmp Start
Set1 : db -3,-1,2,5,6,8,9
Set2 : db -2,2,6,7,9
Size1 : db 7
Size2 : db 5
Set3 : db 0

Start:
xor si,si
xor ax,ax
xor bx,bx
xor di,di
Loop1:
mov al,[Set1+si]

Loop2:
mov ah,[Set2+bx]
cmp al,ah
jne NotEqual
je Equal

NotEqual:
inc bx
cmp bx,5
jne Loop2
je Move

Move:
mov [Set3+di],al
inc di
inc si
mov bx,0
cmp si,7
je End
jmp Loop1

Equal:
inc si
mov bx,0
cmp si,7
je End
jmp Loop1

End:
mov ax,0x4c00
int 0x21