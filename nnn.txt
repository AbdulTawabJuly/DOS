[org 0x0100]

jmp start

start:
mov ax,0xb800
mov es,ax
mov di,0

loop1:
mov word[es:di],0x0720
add di,2
cmp di,4000
jne loop1

mov ax,0x4c00
int 0x21