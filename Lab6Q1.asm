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


loop1:
mov al,[String+si]
inc cx

loop2:
mov ah,[SubString+di]
cmp al , 0x20
je Space
cmp al,ah
je Equal
jne NotEqual

Equal:
inc si
inc di
cmp di,7
je Match1
jmp loop1
 
Space:
inc si
jmp loop1

NotEqual:
add si,2
mov di,0
jmp loop1

Match1:
mov si,0
mov ax,0xb800
mov es,ax
mov di,0

Match:
mov bl,[String+si]
mov bh,0x07
mov word[es:di],bx
add di,2
add si,1
cmp si,22
jne Match
jmp PrintSub

PrintSub:
mov si,0
mov di,120
Print:
mov bl,[String+si]
mov bh,0x07
mov word[es:di],bx
add di,2
add si,1
cmp si,7
je PrintDiff
jmp Print

PrintDiff:

mov bl,[String+si]
mov bh,0x47
mov word[es:di],bx
add di,2
add si,1
cmp si,14
je PrintDiff2
jmp PrintDiff

PrintDiff2:

mov bl,[String+si]
mov bh,0x07
mov word[es:di],bx
add di,2
add si,1
cmp si,22
je End
jne PrintDiff2

End:
mov ax,0x4c00
int 0x21
