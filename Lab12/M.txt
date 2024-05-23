[org 0x0100]

count : dw 0
Dflag : dw 4
oldkb : dd 0
oldt : dd 0
previous : dw 0 
count1: dw 0

jmp start
skip:  ;Pattern of red Dots
add cx,160
mov bx,0
red:
add bx,1
cmp bx,4
je skip
mov ah,01000000b
add cx,20
jmp l1

display:
mov ax,0xb800
mov es,ax
add di,0
mov bx,0
jmp l0

score:
mov ah,0x07
mov al,0x65
mov word[es:di],ax
ret

l0: ;blue Strip
mov al,0h
mov ah,0x0010
mov word[es:di],ax
add di,2
cmp di,140
call score
cmp di,160
jne l0
;Green screen
mov al,00h
mov ah,00100000b
mov cx,180

l1:
mov word[es:di],ax
mov ah,00100000b
add di,2
cmp di,cx
je red
cmp di,4000
jne l1
ret

;=======================================================================================

PrintAss:

	push es
	push ax
	push dx
	mov ax,0xb800
	mov es,ax

	mov si, [previous] 
	mov dx,0x072A
	mov ax,0x0720

	mov [es:si],ax
	mov [es:di],dx
	
	pop dx
	pop ax
	pop es
	ret 2

KBISR:
	
	push ax 
	in al, 0x60  
	
	cmp al, 0x50 ; down
	jne upD

	mov word[Dflag],1 ; 1 Down
	jmp P
	
upD: 
	cmp al, 0x48 ; up
	jne leftD
	mov word[Dflag],2 ; 2 Up
	jmp P
	
leftD: 
	cmp al,0x4B ; left
	jne rightD
	mov word[Dflag],3  ; 3 Left
	jmp P

rightD: 
	cmp al,0x4D ; right
	jne nomatch
	mov word[Dflag],4  ; 4 Right
	jmp P
nomatch: 
	pop ax 
	jmp far [cs:oldkb] ; jumps at last instance
	

P:
	mov al, 0x20 
 	out 0x20, al 
 	
 	pop ax 
 	iret 


clrscr:
	push ax
	push es
	push di
	mov ax, 0xb800
	mov es,ax
	mov di,0
nextchar:
	mov word[es:di],0x0720
	add di,2
	cmp di,4000
	jne nextchar
		
	pop di
	pop es
	pop ax 
	
	ret

;==========================================================================================

timer: 
	
	push ax 
 cmp word [cs:Dflag], 1 
	je setdown 
 cmp word [cs:Dflag], 2 
	je setup 
 cmp word [cs:Dflag], 3 
	je setleft
 cmp word [cs:Dflag], 4 
	je setright
	
	jmp skipall
	
setdown:
mov word[previous],di 
	add di,160
	push di
	call PrintAss
		jmp skipall
setup:
mov word[previous],di 
	sub di,160
	push di
	call PrintAss
		jmp skipall
setright:
mov word[previous],di 
	add di,2
	push di
	call PrintAss
	jmp skipall
setleft:
mov word[previous],di 
	sub di,2 
	push di
	call PrintAss
skipall:
	pop ax
	jmp far [cs:oldt]


start:

	call display

	mov di, 164

	xor ax, ax 
 	mov es, ax ; point es to IVT base 
 	mov ax, [es:9*4] 
 	mov [oldkb], ax ; save offset of old routine 
 	mov ax, [es:9*4+2] 
 	mov [oldkb+2], ax ; save segment of old routine 

	mov ax, [es:8*4] 
 	mov [oldt], ax ; save offset of old routine 
 	mov ax, [es:8*4+2] 
 	mov [oldt+2], ax ; save segment of old routine 
 
	cli 

	mov word [es:9*4], KBISR ; store offset at n*4 
 	mov [es:9*4+2], cs ; store segment at n*4+2 
 	mov word [es:8*4], timer ; store offset at n*4 
 	mov [es:8*4+2], cs ; store segment at n*4+ 
 	
	sti 


l2: 
	mov ah, 0 ; service 0 – get keystroke 
 	int 0x16 ; call BIOS keyboard service 

 	cmp al, 0x1b ; is the Esc key pressed 
 	jne l1 ; if no, check for next key 

 	mov ax, [oldkb] ; read old offset in ax 
 	mov bx, [oldkb+2] ; read old segment in bx 

 	cli ; disable interrupts 
 	mov [es:9*4], ax ; restore old offset from ax 
 	mov [es:9*4+2], bx ; restore old segment from bx 
 	sti ; enable interrupts 

	mov ax, [oldt] ; read old offset in ax 
 	mov bx, [oldt+2] ; read old segment in bx 

 	cli ; disable interrupts 
 	mov [es:8*4], ax ; restore old offset from ax 
 	mov [es:8*4+2], bx ; restore old segment from bx 
 	sti ; enable interrupts 



end:
mov ax,0x4c00
int 21h