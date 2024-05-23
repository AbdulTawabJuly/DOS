[org 0x0100]

jmp Start

Var : dw 0

Sleep:
	 push cx
	mov cx, 0xFFFF
	delay: loop delay
	pop cx
	ret

Start:

	mov ax, 0xb800
	mov es, ax
	mov cs, ax

	mov si, 0
	mov di, Var
	
	mov cx, 2000

Copy:

	movsw
	loop Copy

	call Sleep

	mov si, Var
	mov di, 0
	mov cx, 2000
Paste:

	movsw
	loop Paste

mov ax, 0x4c00
int 21h