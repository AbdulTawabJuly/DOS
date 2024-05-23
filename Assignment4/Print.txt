[org 0x0100]

jmp Start

Score : dw 00

Clear: 

 	push es 
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

PrintBackGround:

	push es
	push ax
	push bx
	push cx
	push dx
	push si
	push di

	mov ax,0xb800
	mov es, ax
	xor di, di
	xor si, si
	xor cx, cx
	xor dx, dx
FirstRow:
	mov word[es:di], 0x6620
	add di, 2
	inc cx
	cmp cx, 80
	jne FirstRow
	mov di, 160
	mov cx, 0
FirstCol:
	mov word[es:di], 0x6620
	add di, 160
	inc cx
	cmp cx, 25
	jne FirstCol
	mov di, 158
	mov cx, 0
LastCol:
	mov word[es:di], 0x6620
	add di, 160
	inc cx
	cmp cx, 25
	jne LastCol
	mov di, 3840
	mov cx, 0
LastRow:
	mov word[es:di], 0x6620
	add di, 2
	inc cx
	cmp cx, 80
	jne LastRow
	mov cx, 0	
Row3:
	mov di, 340
	mov word[es:di], 0x2220 ;Green
	mov di, 460
	mov word[es:di], 0x4420 ;Red
Row4:
	mov di, 520
	mov word[es:di], 0x4420 ;Red
	mov di, 570
	mov word[es:di], 0x2220 ;Green
	
Row5:
	mov di, 644
	mov word[es:di], 0x2220 ;Green
	mov di, 690
	mov word[es:di], 0x4420 ;Red
Row6:
	mov di, 860
	mov word[es:di], 0x4420 ;Red
	mov di, 900
	mov word[es:di], 0x2220 ;Green
Row7:
	mov di, 1000
	mov word[es:di], 0x2220 ;Green
	mov di, 1044
	mov word[es:di], 0x4420 ;Red
Row8:
	mov di, 1138
	mov word[es:di], 0x2220 ;Green
	mov di, 1198
	mov word[es:di], 0x4420 ;Red
Row9:
	mov di, 1310
	mov word[es:di], 0x4420 ;Red
	mov di, 1398
	mov word[es:di], 0x2220 ;Green
Row10:
	mov di, 1450
	mov word[es:di], 0x4420 ;Red
	mov di, 1500
	mov word[es:di], 0x2220 ;Green
Row11:
	mov di, 1644
	mov word[es:di], 0x2220 ;Green
	mov di, 1696
	mov word[es:di], 0x4420 ;Red
Row12:
	mov di, 1798
	mov word[es:di], 0x2220 ;Green
	mov di, 1810
	mov word[es:di], 0x4420 ;Red
Row13:
	mov di, 1968
	mov word[es:di], 0x4420 ;Red
	mov di, 2030
	mov word[es:di], 0x2220 ;Green
	
Row14:
	mov di, 2120
	mov word[es:di], 0x4420 ;Red
	mov di, 2200
	mov word[es:di], 0x2220 ;Green
Row15:
	mov di, 2260
	mov word[es:di], 0x2220 ;Green
	mov di, 2310
	mov word[es:di], 0x4420 ;Red
Row16:
	mov di, 2450
	mov word[es:di], 0x4420 ;Red
	mov di, 2500
	mov word[es:di], 0x2220 ;Green
Row17:
	mov di, 2600
	mov word[es:di], 0x2220 ;Green
	mov di, 2700
	mov word[es:di], 0x4420 ;Red
Row18:
	mov di, 2730
	mov word[es:di], 0x4420 ;Red
	mov di, 2796
	mov word[es:di], 0x2220 ;Green
Row19:
	mov di, 2930
	mov word[es:di], 0x2220 ;Green
	mov di, 3020
	mov word[es:di], 0x4420 ;Red
Row20:
	mov di, 3060
	mov word[es:di], 0x4420 ;Red
	mov di, 3138
	mov word[es:di], 0x2220 ;Green
Row21:
	mov di, 3248
	mov word[es:di], 0x2220 ;Green
	mov di, 3302
	mov word[es:di], 0x4420 ;Red
Row22:
	mov di, 3398
	mov word[es:di], 0x4420 ;Red
	mov di, 3438
	mov word[es:di], 0x2220 ;Green
Row23:
	mov di, 3528
	mov word[es:di], 0x2220 ;Green
	mov di, 3602
	mov word[es:di], 0x2220 ;Green
Row24:
	mov di, 3698
	mov word[es:di], 0x2220 ;Green
	mov di, 3802
	mov word[es:di], 0x4420 ;Red

	xor di, di
	mov di, 232
ScoreBoard:
	mov ah, 0xF4
	mov al, 0x53
	mov word[es:di], ax
	add di, 2
	mov al, 0x43
	mov word[es:di], ax
	add di, 2
	mov al, 0x4F
	mov word[es:di], ax
	add di, 2
	mov al, 0x52
	mov word[es:di], ax
	add di, 2
	mov al, 0x45
	mov word[es:di], ax
	add di, 2
	mov al, 0x3A
	mov word[es:di], ax
	add di, 2
	mov al, [Score]
	mov word[es:di], ax

	
	
Popping:

	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop es

	ret


Start:
	call Clear
	call PrintBackGround
	
End:
	mov ax , 0x4c00
	int 21h