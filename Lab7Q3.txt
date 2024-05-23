[org 0x0100]

jmp start

string: db '%'
start_row dw 4
end_row dw 27
spaces db 0
start_di dw 1200

clrscr: push es 
 push ax 
 push di
mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov di, 0 ; point di to top left column 
nextloc: mov word [es:di], 0x0720 ; clear next char on screen 
 add di, 2 ; move to next screen location 
 cmp di, 4000 ; has the whole screen cleared
 jne nextloc ; if no clear next position 
 pop di
 pop ax
 pop es
 ret


Triangle:
	add si,2
	push cx
	push di
	push ax
	push dx
	mov di,ax
	sub di,1
	mov ax,0xb800
	mov es,ax
	add di,159
	mov ax,di
	mov bx,-1
	add cx,2
	mov [spaces],cx
	sub byte[spaces],1
	cmp cx,[end_row]
	je end1
print_string:
		inc bx
		cmp bx,0
		je pprint
		cmp cx,25
		je pprint
		cmp bx,[spaces]
		je pprint
		jmp increment
pprint:
		mov dl,[string]
		mov dh,0x07
		mov word[es:di],dx
		add di,2
		cmp bx,cx
		jl print_string
		je change_string
		pop cx
		pop bx
		pop ax
		pop di
		pop es
		ret
		
increment:
		add si,2
		add di,2
		cmp bx,cx
		jl print_string
		je change_string
		

		
change_string:
	mov di,ax
	jmp Triangle



start:
	xor ax,ax
	xor bx,bx
	xor cx,cx
	xor dx,dx
	call clrscr
	mov cx,1
	mov bx,0
	
	; first row
	mov di,[start_di]
	mov ax, 0xb800 
	mov es, ax ; point es to video base 
	mov dl,[string]
	mov dh,0x07
	mov word[es:di],dx
	
	
	; remaining rows
	mov dl,0
	mov dh,0
	mov dx,[end_row]
	sub dx,[start_row]
	mov ax,[start_di]
	push end_row
	push string
	call Triangle
		

end1:
	mov ax,0x4c00
	int 21h	