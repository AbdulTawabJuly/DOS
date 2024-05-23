[org 0x0100]

jmp Start

ChangeString:
mov ah,[ReplaceWith]
mov [String+si],ah
inc si
inc cx
ret


PrintStr:
mov si,0
mov ax,0xb800
mov es,ax
mov di,0

Print2:
mov bl,[String+si]
mov bh,0x07
mov word[es:di],bx
add di,2
add si,1
cmp si,22
jne Print2
ret



String : db 'Hello this is a string'
Replace : db 'i'
ReplaceWith: db 't' 

Start:
xor si,si
xor di,di
xor ax,ax
mov di,0
xor cx,cx


loop1:
mov al, [String+si]
inc cx
mov ah,[Replace]
cmp ah , al
je CallFunc
jmp NoChange

	

CallFunc:
call ChangeString
jmp loop1

	
		
NoChange:
inc si
cmp si,22
jne loop1
call PrintStr
jmp End


End:
mov ax,0x4c00
int 0x21
