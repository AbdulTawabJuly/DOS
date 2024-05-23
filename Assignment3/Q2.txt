[org 0x0100]

jmp Start
temp : dw 0

MinofMany:

	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	push si
	push di

	mov cx,[bp+4]
	mov di,6
	mov ax,65535

	Loop1:
		mov bx,[bp+di]
		cmp ax,bx
		jae GreatororEqual
		jmp Less

	GreatororEqual:
		mov ax,bx
		add di,2
		dec cx
		cmp cx,0
		je Returning
		jmp Loop1

	Less:
		add di,2
		dec cx
		cmp cx,0
		je Returning
		jmp Loop1
	
	Returning:
		mov [temp],ax
		pop di
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		mov cx,[bp+4]
		inc cx
		pop bp
	ret 

Start:
	mov ax,0

	push 5
	push 10
	push 6
	push 8
	push 11
	push 5
	push 4
	push 9
	push 8
	call MinofMany 
 
	Popping:
        	pop ax
		dec cx
		cmp cx,0
		jne Popping
	
	mov ax,[temp]

End:
	mov ax,0x4c00
	int 0x21
