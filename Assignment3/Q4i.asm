[org 0x0100] 

jmp start 

message : db 'The alignment-check exception can also be used by interpreters to flag some pointers as special by misaligning the pointers.', 0 
tofind : db 'alignment',0
Remove : db ' ',0

Trimmer:

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

 	mov di, [bp+6]  ; Message
	mov si, [bp+4]	; tofind
				

FindingLength:

	mov cx, 0xffff 
 	xor al, al
 	repne scasb 
 	mov ax, 0xffff 
 	sub ax, cx 
 	dec ax 
	mov cx, ax	; length is in cx
	mov bx, cx
	xor ax,ax

	mov di, [bp+6]

Check:
	mov si, [bp+4]
	cmp cx, 0
	je Popping
	
MainCheck:
	cmp cx, 0
	je Popping
	dec cx
	lodsb
 	scasb
	jne NotEqual
	jmp Equal

Popping:

	mov cx, bx			;total length is in bx 
	sub cx,18                       ;minus total length of ending letters
	mov bx, 0
	mov di, [bp+6]
L1:		
	inc bx
	inc di
	cmp bx, cx
	jne L1
	
	mov bx,18                    ;<-------------------------- Double Length of pointer
L2:
	mov al,[Remove]
	stosb
	dec bx
	cmp bx, 0
	jne L2  
	
	pop di 
 	pop si 
	pop dx
 	pop cx 
	pop bx
 	pop ax 
 	pop es 
 	pop bp 

	ret 

Equal:

	inc dx
	cmp dx, 9                   ;<------------------------------
	je Removing
	jmp MainCheck

NotEqual:

	xor dx,dx
	mov si, [bp+4]
	jmp MainCheck

Removing:
	cld
	mov si, di               ;<---------------------------------
	dec di
	dec di
	dec di
	dec di
	dec di
	dec di
	dec di
	dec di
	dec di
	push cx 
	push di

Removing1:

	movsb
	dec cx
	cmp cx, 0
	jne Removing1
	pop di
	pop cx
	jmp Check


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

 	mov di, [bp+6] 
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
 	mul byte [bp+10]
 	add ax, [bp+12] 
 	shl ax, 1 
	mov di,ax 
 	mov si, [bp+6] 
 	mov ah, [bp+8] 

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
 	ret 10 

start: 

 	mov ax, 4
 	push ax ; push x position 
 	mov ax, 1
 	push ax ; push y position 
 	mov ax, 7 ; white on black attribute 
 	push ax ; push attribute 
 	mov ax, message 
 	push ax ; push address of message 
	mov ax, tofind
	push ax

 	call PrintStr 
	mov ah, 0
	int 0x16
	xor ax, ax
	
	mov ax, 4
 	push ax ; push x position 
 	mov ax, 1
 	push ax ; push y position 
 	mov ax, 7 ; white on black attribute 
 	push ax ; push attribute 
 	mov ax, message 
 	push ax ; push address of message 
	mov ax, tofind 
	push ax

	call Trimmer

	call PrintStr

End:
 	mov ax, 0x4c00 ; terminate program 
 	int 0x21 