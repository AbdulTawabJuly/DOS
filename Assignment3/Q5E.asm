[org 0x0100]

jmp Start
message1 : db ' HAPPY ', 0
message2 : db ' UNHAPPY ', 0
temp : dw 0
check : db 'T', 0  ; T for Happy and F for UnHappy  
; T -> 0x54 , F -> 0x46 

Print:
	push bp 
 	mov bp, sp 
 	push es 
 	push ax 
	push bx
 	push cx
	push dx 
 	push si 
 	push di 
	
	
	mov ax, 0xb800
	mov es, ax
	xor di, di
	xor si, si

	xor ax, ax
 	mov al, 80 
 	mul byte [bp+10]
 	add ax, [bp+12] 
 	shl ax, 1 
	mov di,ax 

	mov ah, [bp+8] 
	cmp byte[check],0x54
	je HappyCheck
	cmp byte[check],0x46
	je UnHappyCheck
	jmp Popping
	
HappyCheck:
	mov cx ,7
	mov si, [bp+6]
	cld
next:
	lodsb
	stosw
	dec cx
	cmp cx, 0
	jne next
	
	jmp Popping

UnHappyCheck:
	mov cx ,9
	mov si, [bp+4]
	cld
next1:
	lodsb
	stosw
	dec cx
	cmp cx, 0
	jne next1


Popping:
	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp 
	ret 10
;-----------------------------------------------------------------------------------------------------------------------------------------------------------

PrintNum:
	push bp 
 	mov bp, sp 
 	push es 
 	push ax 
	push bx
 	push cx
	push dx 
 	push si 
 	push di 

	mov ax, 0xb800
	mov es, ax
	xor di, di
	xor si, si

	xor ax, ax
 	mov al, 80 
	mul byte [bp+10]
 	add ax, 1 
 	shl ax, 1 
	mov di,ax 

	mov cx ,4
	mov di, 4
loo1:
	mov si, [bp+4]
	cld
next2:
	mov ax, [bp+4]
	mov [es:di],ax
	add di, 2
	mov ax, [bp+6]
	mov [es:di],ax
	add di, 2
	mov ax, [bp+8]
	mov [es:di],ax
	add di, 2
	mov ax, [bp+10]
	mov [es:di],ax
	add di, 2
	

	pop es
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp 
	ret 8
;-----------------------------------------------------------------------------------------------------------------------------------------------------------

HappyNumber:

	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di

Emptying:
	xor cx, cx
	xor dx, dx
	xor si, si
	xor di, di
	xor ax, ax
	xor bx, bx

	mov ax, [bp+4]		; First Number
	mul byte[bp+4]
	mov [temp], ax

	mov ax, [bp+6]		; Second Number
	mul byte [bp+6]
	add [temp], ax

	mov ax, [bp+8]		; Third Number
	mul byte [bp+8]
	add [temp], ax
	
	mov ax, [bp+10]		; Fourth Number
	mul byte [bp+10]
	add [temp], ax

Check:
	cmp dx, 0x100
	je MoveFalse
	mov ax, [temp]
	mov [bp+4], ax
	inc dx
	cmp ax, 1		;cmp word[temp],1
	je MoveTrue

	mov si, 6
	mov di, 4
Storing:

	mov bl, 10
	div bl
	mov [bp+si], ah
	add si, 2
	inc cx
	cmp al, 0
	mov ah, 0
	jne Storing
	
	xor ax, ax
	mov word[temp], 0
	mov si, 6

Adding:
	mov ax, [bp+si]
	mul byte[bp+si]
	add [temp], ax
	dec cx
	xor ax, ax
	add si, 2
	cmp cx, 0
	jne Adding
	jmp Check
	
	
MoveTrue:

	mov byte[check], 0x54
	jmp Exit

MoveFalse:

	mov byte[check], 0x46

Exit:

	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp 
	ret 8
;-----------------------------------------------------------------------------------------------------------------------------------------------------------
	
Start:
	xor ax, ax 

	mov ah,0
	int 0x16
	push ax
	xor ax, ax

	mov ah,0
	int 0x16
	push ax
	xor ax, ax

	mov ah,0
	int 0x16
	push ax
	xor ax, ax

	mov ah,0
	int 0x16
	push ax

	call PrintNum
	;call HappyNumber

	mov ax, 10
 	push ax ; push x position 
 	mov ax, 5
 	push ax ; push y position 
 	mov ax, 7 ; white on black attribute 
 	push ax ; push attribute 
	mov ax, message1
	push ax
	mov ax, message2
	push ax

	call Print

End:
	mov ax,0x4c00
	 int 0x21

;========================================================================================

mov ah,0
	int 0x16
	push ax
	xor ax, ax

	mov ah,0
	int 0x16
	push ax
	xor ax, ax

	mov ah,0
	int 0x16
	push ax
	xor ax, ax

	mov ah,0
	int 0x16
	push ax

	;call PrintNum
	xor ax, ax