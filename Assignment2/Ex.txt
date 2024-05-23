[org 0x0100]

jmp Start
buffer : db 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,31

Start:
xor si,si
mov si,31
xor ax,ax
mov ax,10
xor bx,bx
xor cx,cx
mov bx ,1
xor dx,dx
mov dl , 00000000b
dec al

Loop1:
cmp bx,0
jz MoveBack
cmp ch,8
je MoveBack
mov ah,[buffer+si]

Loop2:
shr ah,1
cmp cl,al
je ClearBits
jmp MoveCarry

MoveCarry:
rcr dl,1
inc cl 		; al register check
inc ch		; 8 Bits Check
cmp ch,8
je MoveBack
jnz Loop2

ClearBits:
cmp bx,0
je MoveCarry
shr dl,1
dec bx
inc cl
inc ch
jmp Loop2

MoveBack:
mov [buffer+si],dl
dec si
mov ch,0
cmp bx,0
jz End
jmp Loop1

End:
mov ax,0x4c00
int 0x21