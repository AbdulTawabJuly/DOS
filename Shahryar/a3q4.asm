[org 100h]
jmp start
printnum: 
  push bp
  mov bp, sp
  push es
  push ax
  push bx
  push cx
  push dx
  push di
  mov ax, 0xb800
  mov es, ax ; point es to video base
  mov ax, [bp+4] ; load number in ax
  mov bx, 10 ; use base 10 for division
  mov cx, 0 ; initialize count of digits
  nextdigit: 
    mov dx, 0 ; zero upper half of dividend
    div bx ; divide by 10
    add dl, 0x30 ; convert digit into ascii value
    push dx ; save ascii value on stack
    inc cx ; increment count of values
    cmp ax, 0 ; is the quotient zero
    jnz nextdigit ; if no divide it again
    mov di, 0 ; point di to top left column
  nextpos: 
    pop dx ; remove a digit from the stack
    mov dh, 0x07 ; use normal attribute
    mov [es:di], dx ; print char on screen
    add di, 2 ; move to next screen location
    loop nextpos ; repeat for all digits on stack
  pop di
  pop dx
  pop cx
  pop bx
  pop ax
  pop es
  pop bp
  ret 2
multiply:
  push bp
  mov bp,sp
  push ax
  push bx
  push cx
  push dx
  mov ax,0
  mov bx,[bp+4]
  mov cx,[bp+6]
  cmp cx,0
  je skip
  addLoop:
    add ax,bx
    loop addLoop
  skip:
  mov [bp+8],ax
  pop dx
  pop cx
  pop bx
  pop ax
  pop bp
  ret 4
Trimmer:
  push bp
  mov bp,sp
  push ax
  push bx
  push cx
  push dx
  push si
  push di
  ;;
  mov di,[bp+10] ; row number
  push 0
  push di
  push 160
  call multiply 
  pop di
  mov bx,di
  add di,[bp+8] ; add col number
  mov ax,0xb800
  mov es,ax

  mov cx,[bp+6] ;length
  shl cx,1
  add bx,cx
  mov cx,[len]
  shl cx,1
  sub bx,cx
  add bx,2 ; IMPORTANT
  mov si,bx

  mov dx,di
  outerloop:
    mov di,dx
    mov si,str1

    innerloop:
      mov ah,0x07
      lodsb ; loaded into al
      scasw ; compares es:di and ax
      je innerloop
    sub si,1
    sub di,2

    sub si,str1
    cmp si,[len]
    jne skip69
       sub di,2
       mov dx,di
       mov si,[len]
       shl si,1
       sub di,si
       add di,2
       mov si,[len]
       jmp Trim
    mov byte [es:di+1],0x04
    skip69:
    add dx,2
    cmp dx,bx
    jle outerloop
  jmp end
  Trim:
    mov ax,[len]
    shl ax,1
    mov si,di
    add si,ax
    ;;
    mov cx,bx
    mov ax,[len]
    sub ax,1
    shl ax,1
    add cx,ax
    sub cx,si
    add cx,2
    shr cx,1
    theloop:
      mov ax,[es:si]
      stosw
      add si,2
      dec cx
      jnz theloop
    mov ax,[len]
    shl ax,1
    sub si,ax
    mov cx,[len]
    mov di,si
    mov ax,0x0720
    rep stosw
    jmp skip69
  end:
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
  pop bp
  ret 8
printAt:
  push bp
  mov bp,sp
  push ax
  push bx
  push cx
  push dx
  push si
  push di

  mov si,[bp+10]; string offset
  mov dx,[bp+8] ; length
  mov bx,[bp+6] ; row number
  mov cx,[bp+4] ; col number
  mov ax,0xb800
  mov es,ax
  push 0
  push bx
  push 160
  call multiply
  pop bx
  add bx,cx
  mov di,bx
  printLoop:
    mov al,[ds:si]
    mov ah,0x07
    mov [es:di],ax
    add di,2
    add si,1
    dec dx
    jnz printLoop
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
  pop bp
  ret 8
start:
  push str2
  push 124
  push 10
  push 2
  call printAt
  ;;
  mov ah,0
  int 16h
  push 10
  push 2
  push 124
  push str1
  call Trimmer
  mov ax,0x4c00
  int 21h
str1: db "alignment"
len: dw 9
str2: db "The alignment check exception can also align be used by interpreters to flag some pointers as special by missing the pointer"
