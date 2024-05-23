[org 0x0100]
Arr : dw 0,1,2,3,4,5
temp dw 0
Size : db 6
Rotation : db 3
Choice :  db 0
xor ax,ax
xor bx,bx
xor cx,cx
xor dx,dx


Sort:
mov si,0
mov bx,0
mov cl,1
cmp byte[Choice],0
je RotateLeft
jne SetRight
	
SetRight:
mov bx,[Size]
jmp RotateRight
	
RotateLeft:
mov dx,[Arr+bx]			
add bx,2
mov ax,[Arr+bx]			
mov [Arr+bx],dx
mov [Arr+bx-2],ax
inc cl
cmp cl,[Size]
je CheckLeft
jmp RotateLeft

CheckLeft:
inc si
cmp si,[Rotation]
je end1
mov cl,0
mov bx,0
jne RotateLeft
				
RotateRight:
mov dx,[Arr+bx]			
sub bx,2
mov ax,[Arr+bx]			
mov [Arr+bx],dx			
mov [Arr+bx+2],ax	
inc cl
cmp cl,[Size]
je CheckRight
jmp RotateRight

CheckRight:
inc si
cmp si,[Rotation]
je end1
mov cl,0
mov bx,[Size]
jne RotateRight

push Arr
push Size
push Rotation
push Choice

call Sort

end1
mov ax,0x4c00
int 21h