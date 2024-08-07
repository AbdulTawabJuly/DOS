[org 0x0100]

jmp start
myArray : db 1,2,2,3,1,3,2
size : db 7
MOD : db 0
Counter_curr : db 0
Counter_prev : db 0

start:
xor ax,ax
xor bx,bx
xor cx,cx
xor dx,dx
mov cl,[size]

loop1:

mov si,0
mov al,[myArray+bx]


loop2:

mov dl,[myArray+si]
cmp al,dl
je Increment
add si,1
cmp si,cx
je Set_Again
jmp loop2

Increment:

add byte[Counter_curr],1
add si,1
cmp si,cx
je Set_Again
jmp loop2


Set_Again:

mov si,0
mov ah,[Counter_curr]
mov dh,[Counter_prev]
cmp ah,dh
jae Set_Counter_curr
jmp Set_Counter_prev


Set_Counter_curr:

mov [MOD],al
add bx ,1
mov byte[Counter_prev],ah	; Storing Counter_curr into Counter_prev 
mov byte[Counter_curr],0	; Setting Counter_curr for Next Iteration
cmp cx,bx
je End
jmp loop1


Set_Counter_prev:

mov dh,[myArray+bx-1]
mov [MOD],dh
add bx,1
cmp cx,bx
je End
jmp loop1


End:
mov ax,0x4c00
int 0x21 
