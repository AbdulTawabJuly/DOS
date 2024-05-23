[org 0x0100]

jmp Start

Ass : db '*',0

clrscr: 
	push es
	push ax
	push cx
	push di
	mov ax, 0xb800
	mov es, ax ; point es to video base
	xor di, di ; point di to top left column
	mov ax, 0x0720 ; space char in normal attribute
	mov cx, 2000 ; number of screen locations

	cld ; auto increment mode
	rep stosw ; clear the whole screen
	pop di 
	pop cx
	pop ax
	pop es
	ret 

PrintAss:
	
	push bp
	mov bp,sp
		
	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte[bp+6]
	add ax, [bp+8]
	shl ax,1
	mov di, ax
	mov si, [bp+4]
	mov ah, 0x07
	mov cx,1
	
	cld
	lodsb	
	stosw	
		
exit:
	pop bp
	ret 6

Move:
	call clrscr
	
	push bp
	mov bp,sp
		
	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte[bp+6]
	add ax, [bp+8]
	shl ax,1
	mov di, ax
	mov si, [bp+4]
	mov ah, 0x07
	mov cx,1
	
	cld
	lodsb	
	stosw	
		
exit2:
	pop bp
	ret 6

Start:
	
	call clrscr
	
	mov ax,40
	push ax
	mov ax,12
	push ax
	mov ax, Ass
	push ax

	call PrintAss

	mov ah,0	
	int 0x16

	cmp al, 0x31
	je l1
	jmp else1	
l1:
	mov ax,36
	push ax
	mov ax,12
	push ax
	mov ax, Ass
	push ax
	call Move
	jmp End

else1:
	cmp al, 0x32
	je l2
	jmp else2

l2:
	mov ax,44
	push ax
	mov ax,12
	push ax
	mov ax, Ass
	push ax
	call Move
	jmp End
else2:
	cmp al, 0x33
	je l3
	jmp else3
	
l3:
	mov ax,40
	push ax
	mov ax,8
	push ax
	mov ax, Ass
	push ax
	call Move
	jmp End

else3:
	cmp al, 0x34
	je l4
	jmp else4

l4:
	mov ax,40
	push ax
	mov ax,16
	push ax
	mov ax, Ass
	push ax
	call Move
	jmp End

else4:

	jmp End


End: 
	mov ax, 0x4c00
	int 0x21 