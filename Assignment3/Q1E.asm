[org 0x0100]

jmp Start

string1 : db '      ',0
Value : dw 0xD6D6

SplitOctel:

	push bp
	mov bp, sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di

	mov dl, 00000111b
	mov dh, 00000111b

	mov si, [bp+6]
	add si, 5

	mov ax, [bp+4]
	and al, dl
	mov [si], al
	dec si

	mov ax, [bp+4]
	shr al, 3
	and al, dl
	mov [si], al
	dec si

	mov ax, [bp+4]
	shr al, 6
	shr dl, 1
	and al, dl
	mov [si], al
	dec si

	mov ax, [bp+4]
	and ah, dh
	mov [si], ah
	dec si

	mov ax, [bp+4]
	shr ah, 3
	and ah, dh
	mov [si], ah
	dec si

	mov ax, [bp+4]
	shr ah, 6
	shr dh, 1
	and ah, dh
	mov [si], ah

Returning:
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp

	ret 4

Start:

	mov ax, string1
	push ax
	mov ax, [Value]
	push ax
	
	call SplitOctel


End:

	mov ax, 0x4c00
	int 0x21