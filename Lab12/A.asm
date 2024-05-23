[org 0x0100]
jmp start

clrscr:	push es
		push ax
		push cx
		push di
		mov ax, 0xb800
		mov es, ax
		xor di, di
		mov ax, 0x0720
		mov cx, 2000
		cld
		rep stosw
		pop di
		pop cx
		pop ax
		pop es
		ret

printstr:	push bp
			mov bp, sp
			push es
			push ax
			push cx
			push si
			push di
			push ds
			pop es
			mov di, [bp+4]
			mov cx, 0xffff
			xor al, al
			repne scasb
			mov ax, 0xffff
			sub ax, cx
			dec ax
			jz exit
			mov cx, ax
			mov ax, 0xb800
			mov es, ax
			mov al, 80
			mul byte [bp+8]
			add ax, [bp+10]
			shl ax, 1
			mov di,ax
			mov si, [bp+4]
			mov ah, [bp+6]
			cld

nextchar:	lodsb
			stosw
			loop nextchar
			
exit:	pop di
		pop si
		pop cx
		pop ax
		pop es
		pop bp
		ret 8

printnum:	push bp
			mov bp, sp
			push es
			push ax
			push bx
			push cx
			push dx
			push di
			mov ax, 0xb800
			mov es, ax
			mov ax, [bp+4]
			mov bx, 10
			mov cx, 0
			
nextdigit:	mov dx, 0
			div bx
			add dl, 0x30
			push dx
			inc cx
			cmp ax, 0
			jnz nextdigit
			mov di, 152

nextpos:	pop dx
			mov dh, 0x07
			mov [es:di], dx
			add di, 2
			loop nextpos
			pop di
			pop dx
			pop cx
			pop bx
			pop ax
			pop es
			pop bp
			ret 2

prntscreen:	push ax
			call clrscr
			mov ax, 70
			push ax
			mov ax, 0
			push ax
			mov ax, 2
			push ax
			mov ax, score
			push ax
			call printstr
			mov ax, [score1]
			push ax
			call printnum
			pop ax
			pusha
			mov ax, 0xb800
			mov es, ax
			mov ax,0x4020	;red colour
			mov bx,0x2020	;green colour
			mov cx, 250
			mov dx, 600
			mov si, 0
			mov di, 0
			
			prtr:	add si, cx
					mov [es:si], ax
					cmp si, 4000
					jb prtr

			prtg:	add di, dx
					mov [es:di], bx
					cmp di, 4000
					jb prtg

			popa
			ret

movement:	push es
			push ax
			push bx
			push cx
			push di
			mov ax, 0xb800
			mov es, ax
			mov ax, 0x072A
			mov cx,[cs:direction]
			cmp cx, 0
			je right
			cmp cx, 1
			je down1
			cmp cx, 2
			je left1
			cmp cx, 3
			je up1

down1:	jmp down

left1:	jmp left

up1:	jmp upm

right:	mov di, [cs:position]
		mov bx, word[cs:back]
		mov word[es:di], bx
		cmp bx, 0x2020
		jne skp
		mov word[es:di], 0x0720
		mov dx, [gcount]
		dec dx
		mov [gcount], dx
		mov dx, [score1]
		inc dx
		mov [score1], dx
		push dx
		call printnum
		mov dx, [gcount]
		cmp dx, 0
		je stop1
		jmp skp1
skp:	cmp bx, 0x4020
		jne skp1
stop1:	mov word[stop], 1
		jmp cont1
skp1:	add di, 2
		cmp di, 158
		jne nextdirection
		mov di, 0
nextdirection:	cmp di, 3998
			jne cont1
			sub di, 158

cont1:	mov [cs:position], di
			mov bx, word[es:di]
			mov word[cs:back], bx
			mov word[es:di], ax
			jmp endfunc

down:	mov di, [cs:position]
		mov bx, word[cs:back]
		mov word[es:di], bx
		cmp bx, 0x2020
		jne skp2
		mov word[es:di], 0x0720
		mov dx, [gcount]
		dec dx
		mov [gcount], dx
		mov dx, [score1]
		inc dx
		mov [score1], dx
		push dx
		call printnum
		mov dx, [gcount]
		cmp dx, 0
		je stop2
		jmp skp3
skp2:	cmp bx, 0x4020
		jne skp3
stop2:	mov word[stop], 1
		jmp cont2
skp3:	add di, 160
		cmp di, 4000
		jna cont2
		sub di, 4000
cont2:	mov [cs:position], di
			mov bx, word[es:di]
			mov word[cs:back], bx
			mov word[es:di], ax
			jmp endfunc

left:	mov di, [cs:position]
		mov bx, word[cs:back]
		mov word[es:di], bx
		cmp bx, 0x2020
		jne skp4
		mov word[es:di], 0x0720
		mov dx, [gcount]
		dec dx
		mov [gcount], dx
		mov dx, [score1]
		inc dx
		mov [score1], dx
		push dx
		call printnum
		mov dx, [gcount]
		cmp dx, 0
		je stop3
		jmp skp5
skp4:	cmp bx, 0x4020
		jne skp5
stop3:	mov word[stop], 1
		jmp cont3
skp5:	sub di, 2
		cmp di, 0
		jne nextdirection1
		mov di, 158
		nextdirection1:	cmp di, 3840
					jne cont3
					mov di, 3998

cont3:	mov [cs:position], di
			mov bx, word[es:di]
			mov word[cs:back], bx
			mov word[es:di], ax
			jmp endfunc

upm:	mov di, [cs:position]
		mov bx, word[cs:back]
		mov word[es:di], bx
		cmp bx, 0x2020
		jne skp6
		mov word[es:di], 0x0720
		mov dx, [gcount]
		dec dx
		mov [gcount], dx
		mov dx, [score1]
		inc dx
		mov [score1], dx
		push dx
		call printnum
		mov dx, [gcount]
		cmp dx, 0
		je stop4
		jmp skp7
skp6:	cmp bx, 0x4020
		jne skp7
stop4:	mov word[stop], 1
		jmp cont4
skp7:	sub di, 160
		cmp di, 4000
		jna cont4
		add di, 4000

cont4:	mov [cs:position], di
			mov bx, word[es:di]
			mov word[cs:back], bx
			mov word[es:di], ax
			jmp endfunc
		
endfunc:	pop di
				pop cx
				pop bx
				pop ax
				pop es
				ret

kbisr:	push ax
		push es
		in al, 0x60
		cmp al, 0x2A ; scan code of LShift
		jne nextcmp
		mov word[stop], 1
		
		nextcmp:	cmp al, 0x36 ; scan code of RShift
					jne nextcmp1
					mov word[stop], 0
					jmp matched
		
		nextcmp1:	cmp al, 0x50 ; scan code of Down
					jne nextcmp2
					mov word[cs:direction], 1
					jmp matched
		
		nextcmp2:	cmp al, 0x4B ; scan code of Left
					jne nextcmp3
					mov word[cs:direction], 2
					jmp matched
		
		nextcmp3:	cmp al, 0x48 ; scan code of Up
					jne nextcmp4
					mov word[cs:direction], 3
					jmp matched
		
		nextcmp4:	cmp al, 0x4D ; scan code of Right
					jne nochange
					mov word[cs:direction], 0
					jmp matched
		
		nochange:	pop es
					pop ax
					jmp far [cs:old]
		
		matched:	mov al, 0x20
					out 0x20, al
					pop es
					pop ax
					iret
			
timer:	push ax
		push cx
		mov cx, [stop]
		cmp cx, 1
		je nexttic
		inc byte [cs:timmercounter]
		cmp byte[cs:timmercounter], 2
		jne nexttic
		call movement
		mov byte[cs:timmercounter], 0
	
		nexttic:	mov al, 0x20
					out 0x20, al
					pop cx
					pop ax
					iret

start:	call prntscreen
		xor ax, ax
		mov es, ax
		mov ax, [es:9*4]
		mov [old], ax
		mov ax, [es:9*4+2]
		mov [old+2], ax
		xor ax, ax
		mov es, ax
		cli
		mov word [es:8*4], timer
		mov [es:8*4+2], cs
		mov word [es:9*4], kbisr
		mov [es:9*4+2], cs
		sti
		mov dx, start
		add dx, 15
		mov cl, 4
		shr dx, cl
		mov ax, 0x3100
		int 0x21
		
score: db 'Score:',0
score1: dw 0
timmercounter: dw 0
direction: dw 0
position: dw 0
back: dw 0
old: dd 0
stop: dw 0
gcount: dw 6