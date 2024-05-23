[org 0x0100]

jmp Start
Character : db '%'
Start_Row : db 5
End_Row : db 11
Difference : dw 7
Start_DI : dw 880
Mid : dw 40

HollowTriangle:
push bp
mov bp,sp
push ax
push bx
push cx
push dx
push di
push si

mov ax,0xb800
mov es,ax
xor ax,ax
mov bl,[Start_Row]
mov cx,[Mid]
			
xor si,si
inc bl
 
PrintLeft:
mov al ,80
mul bl	
dec cx
add ax ,cx
shl ax,1
mov di,ax
mov dl ,[Character]
mov dh , 0x04
mov word[es:di],dx
jmp Check1


PrintRight:
mov al ,80
mul bl
	
inc cx
add ax ,cx
shl ax,1
mov di,ax
mov dl ,[Character]
mov dh , 0x01
mov word[es:di],dx
jmp Check2

Check1:
inc bl
inc si
cmp si,[Difference]
jne PrintLeft

mov bl,[Start_Row]
mov cx,[Mid]			
xor si,si
inc bl

jmp PrintRight

Check2:
inc bl
inc si
cmp si,[Difference]
jne PrintRight
Check3:

pop si
pop di
pop dx
pop cx
pop bx
pop ax
pop bp 
ret 6
	

Start:

    ; First Row
	mov ax,0xb800
	mov es,ax
	mov di , [Start_DI]
	mov dl ,[Character]
	mov dh , 0x07
	mov word[es:di],dx
    	
    ; Rest of the Triangle

xor ax,ax
mov ax, [Character]
push ax
xor ax,ax
mov ax,[Start_Row]
push ax
xor ax,ax
mov ax,[End_Row]
push ax
xor ax,ax
call HollowTriangle

mov ax,0x4c00
int 0x21
