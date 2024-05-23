[org 0x0100]
jmp start

dash: db '------------------------------------------------------------'
line: db '||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'
asterik: db '********************'




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


start:
	call clrscr
;	mov ax,dash
;	mov cx,line
;	push ax ; push address of message 
;	push cx
	call printstr
	call printLine
	call printstr2
	call printLine2
	mov cx,0
	mov ax,0
	delay_loop:
		mov ax,0
		inc cx
		cmp cx,100
		je infiniteLoop
		delay_loop2:
			inc ax
			cmp ax,9999
			je delay_loop
			jmp delay_loop2
	
	infiniteLoop:
		call moveprintstr1
		call moveprintLine1
		call moveprintstr21
		call moveprintLine21
		jmp infiniteLoop


printstr:
	mov bx,0
	mov ax,0xb800
	mov es,ax
	mov di,162
	printDash:
		mov dl,[dash+bx]
		mov dh,0x47
		mov word[es:di],dx
		add di,2
		inc bx
		cmp bx,60
		jne printDash
		ret


printstr2:
	mov bx,0
	mov ax,0xb800
	mov es,ax
	mov di,1602
	printDash2:
		mov dl,[dash+bx]
		mov dh,0x47
		mov word[es:di],dx
		add di,2
		inc bx
		cmp bx,60
		jne printDash2
		ret

printLine:
	mov bx,0
	mov ax,0xb800
	mov es,ax
	mov di,160
	printline1:
		mov dl,[line+bx]
		mov dh,0x47
		mov word[es:di],dx
		add di,160
		inc bx
		cmp bx,10
		jne printline1
		ret	
		

printLine2:
	mov bx,0
	mov ax,0xb800
	mov es,ax
	mov di,280
	printline3:
		mov dl,[line+bx]
		mov dh,0x47
		mov word[es:di],dx
		add di,160
		inc bx
		cmp bx,10
		jne printline3
		ret
		
		
		
moveprintstr1:
	mov bx,0
	mov ax,0xb800
	mov es,ax
	mov di,162
	printDash1:
		mov dl,[asterik+bx]
		mov dh,0x47
		mov word[es:di],dx
		add di,2
		inc bx
		cmp bx,60
		jne printDash1
		ret


moveprintstr21:
	mov bx,0
	mov ax,0xb800
	mov es,ax
	mov di,1602
	printDash21:
		mov dl,[asterik+bx]
		mov dh,0x47
		mov word[es:di],dx
		add di,2
		inc bx
		cmp bx,60
		jne printDash21
		ret

moveprintLine1:
	mov bx,0
	mov ax,0xb800
	mov es,ax
	mov di,160
	printline11:
		mov dl,[asterik+bx]
		mov dh,0x47
		mov word[es:di],dx
		add di,160
		inc bx
		cmp bx,10
		jne printline11
		ret	
		

moveprintLine21:
	mov bx,0
	mov ax,0xb800
	mov es,ax
	mov di,280
	printline31:
		mov dl,[asterik+bx]
		mov dh,0x47
		mov word[es:di],dx
		add di,160
		inc bx
		cmp bx,10
		jne printline31
		ret
	
	
end1:
	mov ax,0x4c00
	int 21h