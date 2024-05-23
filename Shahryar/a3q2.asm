[org 100h]
jmp start
minOfMany:
  push bp
  mov bp,sp
  push di
  push bx
  push si
  mov di,[bp+4] ; number of arguments
  mov si,6
  findMinLoop:
    mov bx,[bp+si]
    cmp di,[bp+4]
    jne skipInit
    mov ax,bx
    skipInit:
    cmp bx,ax
    jge skipUpdate
    ; bx < ax so update ax
    mov ax,bx
    skipUpdate:
    add si,2
    dec di
    jnz findMinLoop
  mov di,[bp+4]
  mov [n],di
  mov di,[bp+2] ;return address
  mov [tmp],di
  pop si
  pop bx
  pop di
  pop bp    
  add sp,4
  shl word [n],1
  add sp,[n]
  push word [tmp]
  ret
start:
  push 10
  push 5
  push 8
  push 4
  push 4
  call minOfMany
  mov ax,0x4c00
  int 21h
tmp: dw 0
n: dw 0quit