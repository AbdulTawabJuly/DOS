[org 0x100]

mov dx, 0x123E 
mov cx, 4
mov [0x123F] , cx 
add dx , cx 
mov ax , [0x1242] 
mov [0x1243] , ch 
mov word [0x123F] , 5

int 0x21