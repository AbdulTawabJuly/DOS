[org 0x0100]

jmp Start

PrintScr:
	push es
	push ax
	push bx
	push cx
	push dx
	push si
	push di


	mov ax,0xb800
	mov es, ax
	xor di, di
	xor si, si
	xor cx, cx
	xor dx, dx

loop1:
	mov word[es:di], 0x4420
	add di, 2
	inc cx
	cmp cx, 80
	jne loop1

Equal1:
	mov cx, 0
	inc dx
	cmp dx, 12
	jne loop1
	
	xor dx, dx
	xor cx, cx

loop2:
	mov word[es:di], 0x2220
	add di, 2
	inc cx
	cmp cx, 80
	jne loop2

Equal2:
	mov cx, 0
	inc dx
	cmp dx, 12
	jne loop2

	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop es

	ret



flipMem:
	push es
	push ax
	push bx
	push cx
	push dx
	push si
	push di

	mov ax,0xb800
	mov es, ax
	mov ds, ax
	mov di,2000	; [(80*12)+40]*2 =2000
	mov si,0  	
	mov cx, 0
	mov dx, 0
	
Repeat:

	mov ax,[es:si]
	mov bx,[es:di]
	stosw
	mov [es:si],bx
	add si,2
	inc cx
	cmp cx,40
	jne Repeat	
	jmp Equal

Equal:
	
	add di, 80
	add si, 80
	mov cx, 0
	inc dx 
	cmp dx,12
	je Popping
	jmp Repeat
	

	
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
	call PrintScr

Start1:
	mov ah, 0
	int 0x16	

	cmp al,0x1B
	je End
	
	call flipMem
	jmp Start1



End:

	mov ax,0x4c00
	int 21h