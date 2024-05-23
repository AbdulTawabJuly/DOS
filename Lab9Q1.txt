[org 0x0100]

jmp Start

temp : dw 0


printnum: 
	 push bp 
	 mov bp, sp 
	 push es 
	 push ax 
	 push bx 
	 push cx 
	 push dx 
	 push di 

	 mov ax, 0xb800 
	 mov es, ax 

	 mov ax, [bp+4] 
	 mov bx, 10 
	 mov cx, 0  

nextdigit:

 	mov dx, 0
 	div bx 
 	add dl, 0x30  
 	push dx  
 	inc cx  
 	cmp ax, 0  
 	jnz nextdigit  
 	mov di, [temp] 

nextpos: 
 	pop dx 
 	mov dh, 0x07  
 	mov [es:di], dx  
 	add di, 2  
 	loop nextpos 

	mov [temp] , di

 	pop di 
 	pop dx 
 	pop cx 
 	pop bx 
 	pop ax 
 	pop es 
 	pop bp 
 	ret 2



myISR:

	
	mov ah,0x2A
	int 21h

	push dx
	call printnum

	push cx
	call printnum

	iret

Start:

	xor ax , ax
	mov es , ax
	mov word [es:0x80*4] , myISR
	mov [es:0x80*4+2] , cs
	int 80h
	

mov ax,0x4c00
int 21h
