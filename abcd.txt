[org 0x0100]

jmp Start
String : db 'I am a student of COAL'
SubString : db 'student'

Start:
xor si,si
xor di,di
xor ax,ax
mov di,0
xor cx,cx
mov ax,0xb800
mov es,ax
Match:
mov bl,[String+si]
mov bh,0x07
mov word[es:di],bx
add di,2
add si,1
cmp si,22
jne Match
jmp End


End:
mov ax,0x4c00
int 0x21
