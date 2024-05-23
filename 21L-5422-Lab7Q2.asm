[org 0x0100]

jmp start

segment1 : dw 0x19F5
offset1  : dw 0xFFFF
middle   : dw 0x7FFF

 

Swapping:
	mov dh,[es:di]			; swapping starting and ending values of the segment
	mov dl,[es:si]
	mov [es:di],dl
	mov [es:si],dh
	add di,2				; words ahead starting from 0th index till half the segment
	sub si,2				; words behind starting from last index till half the segment
	cmp cx,[middle]				; to traverse it till half the values (as swapping is done on both sides)
	jge end1
	inc cx
	jmp Swapping

start:
	xor ax,ax
	xor bx,bx
	xor cx,cx
	xor dx,dx
	mov ax,[segment1]
	mov es,ax
	mov di,0
	mov si,[offset1]
	mov cx,0
	push si
	push ax
	call Swapping
	
	
end1:
	mov ax,0x4c00
	int 21h