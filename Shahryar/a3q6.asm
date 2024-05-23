[org 100h]
jmp start
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
swapScreen:
  push bp
  mov bp,sp
  push ax
  push bx
  push cx
  push dx
  push si
  push di
  mov ax,0xb800
  mov es,ax
  mov cx,0
  mov si,0
  mov di,2160

  outerloop:
    mov dx,39
    innerloop:
      mov ax,[es:si]
      mov bx,[es:di]
      stosw
      mov ax,bx
      mov [tmp],di
      mov di,si
      stosw
      mov di,[tmp]
      add si,2
      dec dx
      jnz innerloop
    push 0
    push cx
    push 160
    call multiply
    pop si
    mov ax,cx
    add ax,13
    push 0
    push ax
    push 160
    call multiply
    pop di
    add di,80
    inc cx
    cmp cx,11
    jle outerloop
  pop di
  pop si
  pop dx
  pop cx
  pop bx
  pop ax
  pop bp
  ret
start:
  infinite:
    call swapScreen
   ; mov ah,0
   ; int 16h
    ;jmp infinite
  mov ax,0x4c00
  int 21h
tmp: dw 0