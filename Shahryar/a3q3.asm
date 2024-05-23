[org 100h]
jmp start
flip:
  push bp
  mov bp,sp
  push si
  push di
  push ax
  push bx
  push cx
  push dx
  push es
  mov ax,0xb800
  mov es,ax
  mov si,0
  mov di,3998
  outerloop:
    mov ax,[es:si]
    mov [es:di],ax
    add si,2
    sub di,2
    cmp si,1920
    jl outerloop
    cmp di,2078
    jg outerloop
  pop es
  pop dx
  pop cx
  pop bx
  pop ax
  pop di
  pop si
  pop bp
  ret
start:
  call flip
  mov ax,0x4c00
  int 21h