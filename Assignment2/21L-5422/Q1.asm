[org 0x0100]

jmp start

myArray :db 1,2,2,3,1,3,2,3
size: db 8
MEAN : db 2

start:
xor ax,ax
xor dx,dx
xor bx,bx
xor cx,cx

mov dl,[size]

Keep_Adding:
add al,[myArray+bx]  ; Adding Elements of myArray into al 
add bx,1
cmp dx,bx
jne Keep_Adding

Keep_Sub:
sub al,dl           ; Subtracting dx from ax until it becomes less than ax
add cl,1            ; cx is the Quotient(Answer) 
cmp al,dl
jae Keep_Sub

mov[MEAN],cl

mov ax,0x4c00
int 0x21