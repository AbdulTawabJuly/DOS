[org 0x0100]

jmp Start


Flip:
	push es
	push ax
	push bx
	push cx
	push dx
	push si
	push di

	mov ax,0xb800
	mov es,ax
	mov di,0
	mov si,4000
	
Repeat:
	mov bx,[es:di]
	mov [es:si],bx
	sub si,2
	add di,2
	cmp di,2000
	jne Repeat


Popping:
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop es

	ret

Start:
	call Flip
	



End:
	mov ax,0x4c00
	int 21h