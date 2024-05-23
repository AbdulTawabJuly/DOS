[org 0x0100]
mov cx,0
mov bx,0
l1:
add [myarr+bx],cx
add bx,2
add cx,1
cmp [arrlen],cx
jnz l1

mov ax,0x4c00 
int 0x21
myarr : dw 10,34,6,67,24,656,75,59,34
arrlen: dw 9