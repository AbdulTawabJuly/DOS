[org 0x0100]

	mov di,2000
	call clrscr
	call printasterik
jmp start


up:
	sub di,320
	call clrscr
	call printasterik
	jmp a
	
down:
	add di,320
	call clrscr
	call printasterik
	jmp b
	
left :
	sub di,10
	call clrscr
	call printasterik
	jmp c
right:
	add di,10
	call clrscr
	call printasterik
	jmp d

clrscr:
	push es:
	push ax
	push di
	
	mov ax,0xb800
	mov es,ax
	mov di,0
	
	
nextloc:
	mov word[es:di], 0x0720
	add di,2
	cmp di,4000
	jne nextloc

	pop di
	pop ax
 	pop es
	
	ret


printasterik:
	
	push es
	push ax

	mov ax,0xb800
	mov es,ax
	
	
	
	
	mov word[es:di],0x072A

	

	pop ax
	pop es
	
	
	ret	


start:
	
	mov ah,01h
	int 21h
	cmp al,0x31
	je up
a:
	cmp al,0x32
	je down 

b:	cmp al,0x33
	je left

c:	cmp al,0x34
	je right

d:	cmp al,0x1B
	je end
	jmp start
	


end:

mov ax,0x4c00
int 21h