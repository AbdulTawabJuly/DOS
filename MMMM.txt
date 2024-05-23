[org 0x0100]

jmp Start
string1 : db 'Alignmenting',0

PrintStr: 
 	push bp 
 	mov bp, sp 
 	push es 
 	push ax 
	push bx
 	push cx
	push dx 
 	push si 
 	push di 

 	push ds 
 	pop es 

 	mov di, [bp+4] 
 	mov cx, 0xffff 
 	xor al, al 
 	repne scasb 
 	mov ax, 0xffff 
 	sub ax, cx 
 	dec ax 

 	jz exit 

 	mov cx, ax 
 	mov ax, 0xb800 
 	mov es, ax
 	mov al, 80 
 	mul byte [bp+8]
 	add ax, [bp+10] 
 	shl ax, 1 
	mov di,ax 
 	mov si, [bp+4] 
 	mov ah, [bp+6] 

 	cld 
nextchar: 
	lodsb 
	stosw 
 	loop nextchar 

exit: 
	pop di 
 	pop si 
	pop dx
 	pop cx 
	pop bx
 	pop ax 
 	pop es 
 	pop bp 
 	ret 8

RightAlign:
 
	mov ax, 0xb800
	mov es, ax
	mov ds, ax

	;mov al , 0x20

	;mov si, 0
	;mov di , 0
	;mov cx, 0xffff 
 
 	;repne scasb 
 	;mov ax, 0xffff 
 	;sub ax, cx 
 	;dec ax 

	;jz exit 

 	mov cx, 12 
	mov di , 160
	sub di , cx
loop1:
	movsw
	loop loop1


	ret

	
Start:

	mov ax, 4
 	push ax ; push x position 
 	mov ax, 1
 	push ax ; push y position 
 	mov ax, 7 ; white on black attribute 
 	push ax ; push attribute 
 	mov ax, string1
 	push ax ; push address of message 
	call PrintStr

	call RightAlign

End:

	mov ax , 0x4c00
	int 21h