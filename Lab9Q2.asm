[org 0x100]
jmp Start
msg1 : db 'A is Pressed$'
msg2 : db 'A is Released$'


Print:
	push ax
	push es

	mov ax, 0xb800
	mov es, ax
	
	in al,0x60
	shl al, 1
	jc No

	mov byte[es:0],'P'
	mov byte[es:2],'r'
	mov byte[es:4],'e'
	mov byte[es:6],'s'
	mov byte[es:8],'s'
	mov byte[es:10],'s'
	mov byte[es:12],'e'
	mov byte[es:14],'d'

	jmp Skip
No:
	mov byte[es:0],'R'
	mov byte[es:2],'e'
	mov byte[es:4],'l'
	mov byte[es:6],'e'
	mov byte[es:8],'a'
	mov byte[es:10],'s'
	mov byte[es:12],'e'
	mov byte[es:14],'d'

Skip:
	mov al, 0x20
	out 0x20, al

	pop ax	
	pop es

	iret

Start:

	xor ax, ax
	mov es,ax
	cli
	mov word [es:9*4], Print
	mov[es:9*4+2],cs
	sti


End:
	mov ax, 0x4c00
	int 21h