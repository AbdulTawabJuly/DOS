[org 0x0100]

jmp start

buffer : db 32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,31
xor ax,ax
mov ax,3
xor bx,bx
mov bx,4
xor di,di
mov di,31
No_of_bits : db 0
Bit_Number : db 0
start:

mov [No_of_bits],bl
mov [Bit_Number],al
mov bx,0
mov bx,8
div bl
mov bx,0
mov bl ,al
mov si,bx
cmp ah,0
jz Case1
jne Case2

Case1:
mov bx,0
mov cl,[No_of_bits]
cmp cl,8
ja Case1_loop2

Case1_loop1:
sub di,si
mov bl,[buffer+di]
mov dl,11111110b
InnerLoop1:
and bl,dl
rcl dl,1
dec cl
cmp cl,0
jne InnerLoop1
mov [buffer+di],bl
jmp End

Case1_loop2:
sub di,si
mov bl,[buffer+di]
dec di
mov bh,[buffer+di]
mov dx,1111111111111110b
InnerLoop2:
and bx,dx
rcl dx,1
dec cl
cmp cl,0
jne InnerLoop2
mov[buffer+di],bh
inc di
mov [buffer+di],bl
jmp End

Case2:
mov bx,0
mov cl,[No_of_bits]
cmp cl,8
ja Case2_loop2

Case2_loop1:
sub di,si
mov bl,[buffer +di]
mov dl,11111110b
rcl dl ,cl
InnerLoop3:
and bl,dl
rcl dl,1
dec cl
cmp cl,0
jne InnerLoop3
mov [buffer+di],bl
jmp End

Case2_loop2:
sub di,si
mov bl,[buffer+di]
dec di
mov bh,[buffer+di]
mov dx,1111111111111110b

rcl dx,cl
InnerLoop4:
and bx,dx
rcl dx,1
dec cl
cmp cl,0
jne InnerLoop4
mov[buffer+di],bh
inc di
mov [buffer+di],bl
jmp End

End:
mov ax,0x4c00
int 0x21