[org 0x0100]

jmp start

temp: db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32

Bit: db 105

start:
mov dx,1111111100000000b
mov bx,8
mov cx,0
mov ax,0
mov si,0
mov al,[Bit]
div bl
mov bx,0
mov bl,al
mov si,bx
cmp ah,0
jz case1
jnz case2


case2:
mov cl,ah
mov bh,[temp+si]
mov bl,[temp+si+1]
shl bx,cl
and dx,bx
mov ax,0
mov al,dh
jmp end


case1:
mov bl,[temp+si]
mov ax,bx
jmp end


end:
mov ax,0x4c00
int 0x21