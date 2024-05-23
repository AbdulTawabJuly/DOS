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
mod:
  push bp
  mov bp,sp
  push ax
  push bx
  mov ax,[bp+6]
  mov bx,[bp+4]
  modLoop:
    cmp ax,bx
    jl end
    sub ax,bx
    jmp modLoop
  end:
  mov [bp+8],ax
  pop bx
  pop ax
  pop bp
  ret 4
divide:
  push bp
  mov bp,sp
  push ax
  push bx
  push cx
  mov ax,[bp+6]
  mov bx,[bp+4]
  mov cx,0
  divLoop:
    cmp ax,bx
    jl end1
    sub ax,bx
    inc cx
    jmp divLoop
  end1:
  mov [bp+8],cx
  pop cx
  pop bx
  pop ax
  pop bp
  ret 4
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
isHappy:
  push bp
  mov bp,sp
  push ax
  push bx
  push cx
  push dx
  push si

  mov dx,[bp+4]
  mov si,256
  outerloop:
  mov ax,0
    loop1:
        push 0
        push dx
        push 10
        call mod
        pop bx
        push 0
        push bx
        push bx
        call multiply
        pop bx
        add ax,bx
        push 0
        push dx
        push 10
        call divide
        pop dx
        cmp dx,0
        jnz loop1
    cmp ax,1
    je returnTrue
    mov dx,ax
    dec si
    jnz outerloop
  mov word [bp+6],0
  jmp exit
  returnTrue:
   mov word [bp+6],1
  exit:
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
  pop bp
  ret 2
start:
  mov dx,0
  mov cx,4
  inputLoop:
    mov ah,0
    int 0x16
    push 0
    push dx
    push 10
    call multiply
    pop dx
    mov ah,0
    sub al,48
    add dx,ax
    loop inputLoop  
  push 0
  push dx
  call isHappy
  call printnum
  mov ax,0x4c00
  int 21h