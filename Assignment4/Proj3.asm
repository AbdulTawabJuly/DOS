[org 0x0100] 

jmp Start 

Lost: dw ' Game Ended !!!  You Lost......  Press Escape to Exit $'
Win : dw ' Hurrah !!! You Won the Game......  Press Escape to Exit $'
Score : dw 0
prev : dw 0
CurrPos : dw 0
ColRowCheck : dw 1
DirectionFlag : dw 3
GameFlag : dw 0
oldkbisr : dd 0 
oldtimer : dd 0

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
	mov word[es:di], 0x2720 ;Green
	mov di, 460
	mov word[es:di], 0x4720 ;Red
Row4:
	mov di, 520
	mov word[es:di], 0x4720 ;Red
	mov di, 570
	mov word[es:di], 0x2720 ;Green
	
Row5:
	mov di, 644
	mov word[es:di], 0x2720 ;Green
	mov di, 690
	mov word[es:di], 0x4720 ;Red
Row6:
	mov di, 860
	mov word[es:di], 0x4720 ;Red
	mov di, 900
	mov word[es:di], 0x2720 ;Green
Row7:
	mov di, 1000
	mov word[es:di], 0x2720 ;Green
	mov di, 1044
	mov word[es:di], 0x4720 ;Red
Row8:
	mov di, 1138
	mov word[es:di], 0x2720 ;Green
	mov di, 1198
	mov word[es:di], 0x4720 ;Red
Row9:
	mov di, 1310
	mov word[es:di], 0x4720 ;Red
	mov di, 1398
	mov word[es:di], 0x2720 ;Green
Row10:
	mov di, 1450
	mov word[es:di], 0x4720 ;Red
	mov di, 1500
	mov word[es:di], 0x2720 ;Green
Row11:
	mov di, 1644
	mov word[es:di], 0x2720 ;Green
	mov di, 1696
	mov word[es:di], 0x4720 ;Red
Row12:
	mov di, 1798
	mov word[es:di], 0x2720 ;Green
	mov di, 1810
	mov word[es:di], 0x4720 ;Red
Row13:
	mov di, 1968
	mov word[es:di], 0x4720 ;Red
	mov di, 2030
	mov word[es:di], 0x2720 ;Green
	
Row14:
	mov di, 2120
	mov word[es:di], 0x4720 ;Red
	mov di, 2200
	mov word[es:di], 0x2720 ;Green
Row15:
	mov di, 2260
	mov word[es:di], 0x2720 ;Green
	mov di, 2310
	mov word[es:di], 0x4720 ;Red
Row16:
	mov di, 2450
	mov word[es:di], 0x4720 ;Red
	mov di, 2500
	mov word[es:di], 0x2720 ;Green
Row17:
	mov di, 2600
	mov word[es:di], 0x2720 ;Green
	mov di, 2700
	mov word[es:di], 0x4720 ;Red
Row18:
	mov di, 2730
	mov word[es:di], 0x4720 ;Red
	mov di, 2796
	mov word[es:di], 0x2720 ;Green
Row19:
	mov di, 2930
	mov word[es:di], 0x2720 ;Green
	mov di, 3020
	mov word[es:di], 0x4720 ;Red
Row20:
	mov di, 3060
	mov word[es:di], 0x4720 ;Red
	mov di, 3138
	mov word[es:di], 0x2720 ;Green
Row21:
	mov di, 3248
	mov word[es:di], 0x2720 ;Green
	mov di, 3302
	mov word[es:di], 0x4720 ;Red
Row22:
	mov di, 3398
	mov word[es:di], 0x4720 ;Red
	mov di, 3438
	mov word[es:di], 0x2720 ;Green
Row23:
	mov di, 3528
	mov word[es:di], 0x2720 ;Green
	mov di, 3602
	mov word[es:di], 0x2720 ;Green
Row24:
	mov di, 3698
	mov word[es:di], 0x2720 ;Green
	mov di, 3802
	mov word[es:di], 0x4720 ;Red

	xor di, di
	mov di, 232

ScoreBoard:
	mov ah, 0xF4
	mov al, 0x53
	mov word[es:di], ax  ; 232
	add di, 2
	mov al, 0x43
	mov word[es:di], ax  ; 234
	add di, 2
	mov al, 0x4F
	mov word[es:di], ax  ; 236
	add di, 2
	mov al, 0x52
	mov word[es:di], ax  ; 238
	add di, 2
	mov al, 0x45
	mov word[es:di], ax  ; 240
	add di, 2
	mov al, 0x3A
	mov word[es:di], ax  ; 242
	add di, 2
	mov al, [Score]
	mov word[es:di], ax  ; 244

Popping:

	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop es

	ret

PrintScore:
	push bp
	mov bp, sp
	push es
	push ax
	push bx
	push cx
	push dx
	push si
	push di

	mov ax, 0xb800
	mov es, ax
	mov ax, [bp+4]
	mov bx, 10
	mov cx, 0
NextDigit:
	mov dx,0
	div bx
	add dl, 0x30
	push dx
	inc cx
	cmp ax, 0
	jnz NextDigit
	
	mov di, 246
	
NextPosition:
	pop dx
	mov dh, 0xF4
	mov [es:di], dx
	add di, 2
	loop NextPosition
	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop es	
	pop bp
	ret 2
WinEnd:
	call Clear
	mov dx, Win
	mov ah, 09h
	int 21h
	mov bl, 0x39
	mov word[cs:GameFlag], 3
	ret

ScoreCount:
	inc word[cs:Score]
	push word[cs:Score]
	call PrintScore	
	cmp word[cs:Score] , 23
	je WinEnd
	ret

GameEnd:
	call Clear
	mov dx, Lost
	mov ah, 09h
	int 21h
	mov bl, 0x39
	ret

PrintAsterik:

	push bp 
 	mov bp, sp 
	push es
 	
	mov ax, 0xb800 
	mov es, ax 
	mov di, [bp+4] 

	mov si, [prev]

	mov ax, 0x0720
	mov word[es:si], ax

	mov ax, word[es:di]
	mov word[CurrPos], ax

	mov ax, 0x0701
	mov word[es:di], ax

	cmp word[CurrPos], 0x2720
	je Green
	cmp word[CurrPos], 0x4720
	je Red
	jmp Else

Green:
	mov word[cs:GameFlag], 1
	call ScoreCount
	jmp Else

Red:
	mov word[cs:GameFlag], 2
	call GameEnd

Else:
	pop es 
 	pop bp 
 	ret 2 

InputKey: 
 	push ax 
	
 	in al, 0x60 
 	cmp al, 0x48	; Up Key 
 	jne DownCompare
 	mov word [cs:DirectionFlag], 1
 	jmp Pop2 
 
DownCompare:
	cmp al, 0x50	; Down Key
 	jne RightCompare 
 	mov word [cs:DirectionFlag], 2
 	jmp Pop2 

RightCompare:
	cmp al, 0x4D	; Right Key
 	jne LeftCompare 
 	mov word [cs:DirectionFlag], 3
 	jmp Pop2

LeftCompare:
	cmp al, 0x4B	; Left Key
 	jne NoMatch 
 	mov word [cs:DirectionFlag], 4
 	jmp Pop2

NoMatch:

 	pop ax 
 	jmp far [cs:oldkbisr] 

Pop2:
 	mov al, 0x20 
 	out 0x20, al 
 	
 	pop ax 
 	iret 

Clock:

	push ax

	cmp word[cs:GameFlag], 2
	je Nomatch
	
	cmp word[cs:GameFlag], 3
	je Nomatch
 	
 	cmp word [cs:DirectionFlag], 1 
 	je Up 
	cmp word [cs:DirectionFlag], 2
	je Down
	cmp word [cs:DirectionFlag], 3
	je Right
	cmp word [cs:DirectionFlag], 4
	je Left
	jmp Nomatch

Nomatch:
 	mov al, 0x20 
 	out 0x20, al
 	pop ax 
 	iret 
;-------------------------------------------------------------------
Up:
	mov [prev], di
	sub di, 160
	cmp di, 320
	jb L1
	jmp U1
L1:
	add di, 3520
U1:	
	jmp Print
;-------------------------------------------------------------------
Down:
	mov [prev], di
	add di, 160
	cmp di, 3838
	ja G1
	jmp D1
G1:
	sub di, 3520
D1:
	jmp Print
;-------------------------------------------------------------------
Right:
	mov [prev], di
	add di, 2
	inc word[cs:ColRowCheck]
	cmp word[cs:ColRowCheck], 79
	ja G2
	jmp R1
G2:
	sub di, 156
	mov word[cs:ColRowCheck], 1
R1:
	jmp Print
;-------------------------------------------------------------------
Left: 
	mov [prev], di
	sub di, 2
	dec word[cs:ColRowCheck]
	cmp word[cs:ColRowCheck], 1
	jb L2
	jmp Le1
L2
	add di, 156
	mov word[cs:ColRowCheck], 79
Le1:
	jmp Print
;-------------------------------------------------------------------
Print: 
 	push di 
 	call PrintAsterik
	jmp Nomatch

Start:

	call Clear
	call PrintBackGround

	xor ax, ax 
	xor bx, bx
	xor di, di
 	mov es, ax 
	mov di ,322

 	mov ax, [es:9*4] 
 	mov [oldkbisr], ax 
 	mov ax, [es:9*4+2] 
 	mov [oldkbisr+2], ax 

	mov ax, [es:8*4] 
 	mov [oldtimer], ax 
 	mov ax, [es:8*4+2] 
 	mov [oldtimer+2], ax 

 	cli 
 	mov word [es:9*4], InputKey
 	mov [es:9*4+2], cs

 	mov word [es:8*4], Clock
 	mov [es:8*4+2], cs 

 	sti 	

Loop1:

	mov ah, 0
	int 0x16
	
	cmp al, 0x1b
	jne Loop1

Ending:
	mov ax, [oldkbisr]
	mov bx, [oldkbisr+2]

	cli
	mov [es:9*4], ax
	mov [es:9*4+2], bx
	sti 
	
	mov ax, [oldtimer]
	mov bx, [oldtimer+2]

	cli
	mov [es:8*4], ax
	mov [es:8*4+2], bx
	sti 

Exit:
 	mov ax, 0x4c00
	int 0x21
