[org 0x0100]
jmp start

boundstart: dw 0
boundend: dw 0
coloumnflag: dw 0
rowflag: dw 0
;----------

Lost: dw ' Game has Ended You Lost, Please Press Esc for Exit $'
Win : dw 'You won the Game! $'
Score : dw 0
PrintMsg: dw 'Score'
ticks : dw 0 
prev : dw 0
CurrPos : dw 20
ColRowCheck : dw 1
DirectionFlag : dw 3
GameFlag : dw 0
oldkbisr : dd 0 
oldtimer : dd 0
;--------

clear: 

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

setcoloumn:
mov word[coloumnflag],1
add di,160
jmp cont1

setrow:
mov word[rowflag],1
add di,2
jmp cont2

printboundary:
push es
push ax
push di

mov ax,0xb800
mov es,ax
mov di,[boundstart]

nextloc:
mov word[es:di],0x9e00

cmp word[coloumnflag], 1
je setcoloumn
cont1:
cmp word[rowflag],1
je setrow
cont2:

cmp di,[boundend]
jne nextloc

pop di
pop ax
pop es
ret


backgroundyellow:
push es
push ax
push di

mov ax,0xb800
mov es,ax
mov di,0

nextloc2:
mov word[es:di],0x6e00
add di,2
cmp di,4000
jne nextloc2

pop di
pop ax
pop es
ret

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
	call clear
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
	call clear
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

	mov ax, 0x6e00
	mov word[es:si], ax

	mov ax, word[es:di]
	mov word[CurrPos], ax

	mov ax, 0x3e3e
	mov word[es:di], ax

	cmp word[CurrPos], 0x6e00
	je Yellow
	cmp word[CurrPos], 0x9e00
	je Blue
	jmp Else

Yellow:
	mov word[cs:GameFlag], 1
	call ScoreCount
	jmp Else

Blue:
	mov word[cs:GameFlag], 2
	call GameEnd

Else:
	mov word [cs:ticks], 0

	pop es 
 	pop bp 
 	ret 2 


InputKey: 
 	push ax 
	
 	in al, 0x60 
 	cmp ah, 0x48	; Up Key 
 	jne DownCompare
 	mov word [cs:DirectionFlag], 1
 	jmp Pop2 
 
DownCompare:
	cmp ah, 0x50	; Down Key
 	jne RightCompare 
 	mov word [cs:DirectionFlag], 2
 	jmp Pop2 

RightCompare:
	cmp ah, 0x4D	; Right Key
 	jne LeftCompare 
 	mov word [cs:DirectionFlag], 3
 	jmp Pop2

LeftCompare:
	cmp ah, 0x4B	; Left Key
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
;---------------

Clock:

	push ax

	cmp word[cs:GameFlag], 2
	je Nomatch
	
	cmp word[cs:GameFlag], 3
	je Nomatch
 	
 	inc word [cs:ticks]
	cmp word [cs:ticks], 18
	jne  Nomatch

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
	
honeycomb:

push ax
push es
push di
push cx
mov ax, 0xb800
mov es, ax 
mov di, 464
mov cx,di

l2:
mov word [es:di],0xA823
add di,2
cmp di,478
jne l2

mov di,cx
add di,160

l3:
mov word [es:di],0xA823
add di,2
cmp di,638
jne l3

pop cx
pop di
pop es
pop ax
ret

start:

;display yellow
call backgroundyellow
call honeycomb

; coordinates map
mov word [rowflag],1
mov word [boundstart],0
mov word [boundend],160
call printboundary

mov word[rowflag],0
mov word[coloumnflag],1
mov word [boundstart],160
mov word [boundend],4000
call printboundary

mov word[rowflag],0
mov word[coloumnflag],1
mov word [boundstart],20
mov word [boundend],820
call printboundary


mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],900
mov word [boundend],1540
call printboundary

mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],1400
mov word [boundend],1440
call printboundary

mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],1480
mov word [boundend],1500
call printboundary


mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],1530
mov word [boundend],1550
call printboundary



mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],1000
mov word [boundend],1800
call printboundary

mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],3200
mov word [boundend],3218
call printboundary

mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],3226
mov word [boundend],3240
call printboundary


mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart], 1100
mov word [boundend],1140
call printboundary



mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart], 1150
mov word [boundend],1180
call printboundary

mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],3226
mov word [boundend],3240
call printboundary

mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],66
mov word [boundend],866
call printboundary


mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],80
mov word [boundend],1200
call printboundary

mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],580
mov word [boundend],740
call printboundary


mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],760
mov word [boundend],1080
call printboundary


mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],676
mov word [boundend],696
call printboundary


mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],330
mov word [boundend],340
call printboundary


mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],1900
mov word [boundend],2540
call printboundary

mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],1500
mov word [boundend],1980
call printboundary



mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],1670
mov word [boundend],1688
call printboundary

mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],1780
mov word [boundend],2260
call printboundary



mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],2260
mov word [boundend],2280
call printboundary

mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],2630
mov word [boundend],2660
call printboundary

mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],2670
mov word [boundend],2690 
call printboundary


mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],3090
mov word [boundend],3126
call printboundary


mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],2800
mov word [boundend],3280
call printboundary


mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],3470
mov word [boundend],3500
call printboundary


mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],2990
mov word [boundend],3470
call printboundary


mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],160
mov word [boundend],4000
call printboundary


mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],3840
mov word [boundend],4000
call printboundary


mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],1770
mov word [boundend],1796
call printboundary

mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],1400
mov word [boundend],2200
call printboundary


mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],2300
mov word [boundend],2360
call printboundary

mov word[rowflag],0
mov word [coloumnflag],1
mov word [boundstart],158
mov word [boundend],3998
call printboundary

; honey comb

mov word[rowflag],1
mov word [coloumnflag],0
mov word [boundstart],610
mov word [boundend],620
call printboundary

;--------------------------------------------------------------------
;arrow functionality 


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

end:
 	mov ax, 0x4c00
	int 0x21
