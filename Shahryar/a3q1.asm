[org 100h]
jmp start
splitOctal:
  push bp
  mov bp,sp
  push ax
  push bx
  push cx
  push dx
  mov bx,[bp+4] ; addr of string
  mov ax,[bp+6] ; word
  ;process ah and al 
  ; Using bitwise magic
  xor dx,dx
  shl ah,1
  rcl dh,1
  shl ah,1
  rcl dh,1
  add dh,48
  mov [bx],dh
  inc bx
  xor dx,dx
  ;
  shl ah,1
  rcl dh,1
  shl ah,1
  rcl dh,1
  shl ah,1
  rcl dh,1
  add dh,48
  mov [bx],dh
  inc bx
  xor dx,dx
  ;
  shl ah,1
  rcl dh,1
  shl ah,1
  rcl dh,1
  shl ah,1
  rcl dh,1
  add dh,48
  mov [bx],dh
  inc bx
  ;;;;;;;;;;;;;;;
  xor dx,dx
  shl al,1
  rcl dh,1
  shl al,1
  rcl dh,1
  add dh,48
  mov [bx],dh
  inc bx
  xor dx,dx
  ;
  shl al,1
  rcl dh,1
  shl al,1
  rcl dh,1
  shl al,1
  rcl dh,1
  add dh,48
  mov [bx],dh
  inc bx
  xor dx,dx
  ;
  shl al,1
  rcl dh,1
  shl al,1
  rcl dh,1
  shl al,1
  rcl dh,1
  add dh,48
  mov [bx],dh
  inc bx
  
  pop dx
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
  push 0xd6d6
  push string
  call splitOctal
  push string
  push 6
  push 15
  push 10
  call printAt
  mov ax,0x4c00
  int 21h
string: db 'aaaaaa'