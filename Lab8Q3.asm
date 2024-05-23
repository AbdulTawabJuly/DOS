[org 0x0100]

jmp start

msg1: db 'hello world', 0
msg2: db 'hello world again', 0
msg3: db 'hello world again and again', 0 

start:
 
;-------------------------

	
	mov ah, 0
	int 0x16

	mov ah, 0x13 
	mov al, 1
	mov bh, 0
	
	mov bl, 1
	mov dx, 0000
	mov cx, 11
	push cs
	pop es
	
	mov bp, msg1	
	int 0x10	
;-----------------------

	mov ah, 0
	int 0x16

	mov ah, 0x13 
	mov al, 1
	mov bh, 0
	
	mov bl, 71
	mov dx, 0000
	mov cx, 17
	push cs
	pop es
	
	mov bp, msg2	
	int 0x10	
	
;---------------------

	mov ah, 0
	int 0x16

	mov ah, 0x13 
	mov al, 1
	mov bh, 0
	
	mov bl, 0xF4
	mov dx, 0000
	mov cx, 27
	push cs
	pop es
	
	mov bp, msg3	
	int 0x10

	
mov ax, 0x4c00 ; terminate program
int 0x21