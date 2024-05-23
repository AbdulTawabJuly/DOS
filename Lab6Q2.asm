[org 0x0100]

mov ax,0xb800
mov es,ax
mov di,0

jmp Start

delay: 
	push cx
	mov cx, 3 ; change the values to increase delay time 

delay_loop1: 
	push cx
	mov cx, 0xFFFF 
delay_loop2: 
	loop delay_loop2 
	pop cx 
	loop delay_loop1 
	pop cx 
ret


Start:
xor si,si
xor di,di

TopLine:
mov di,20
Inn:
mov word[es:di],0x07B2
add di,2
add si,1
cmp si,30
jne Inn
jmp RightLine


RightLine:
xor si,si
InnerLoop:
mov word[es:di],0x07B2
add di,160
add si,1
cmp si,10
jne InnerLoop
jmp DownLine

DownLine:
xor si,si
InnerLoop2:
mov word[es:di],0x07B2
sub di,2
add si,1
cmp si,30
jne InnerLoop2
jmp LeftLine


LeftLine:
xor si,si
InnerLoop3:
mov word[es:di],0x07B2
sub di,160
add si,1
cmp si,10
jne InnerLoop3
je End

End:
mov ax,0x4c00
int 0x21