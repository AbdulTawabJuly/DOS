[org 0x100]
jmp start



; I have used int 0x16 to help debug the whole execution process.. keep pressing some key until the program terminates
; after termination the printed string will be trimmed accordingly
clrscr:
      push ax
      push es
      push di
      push cx
      mov ax,0xB800
      mov es,ax
      mov di,0
      mov ax,0x0720
      mov cx,2000
      rep stosw
      pop cx
      pop di
      pop es
      pop ax
      ret

strlen: 
        push bp
        mov bp,sp
        push ds
        push es
        push cx
        push di
        push ds
        pop es
        mov di,[bp+4]
        mov cx,0xFFFF
        mov ax,0
        repne scasb
        mov ax,0xFFFF
        sub ax,cx
        sub ax,1
        pop di
        pop cx
        pop es
        pop ds
        pop bp
        ret 2
printstr: push bp                                    ;prints at specific position
          mov bp,sp                                  ;takes(string+length+row no.+column no.)
          push bx
          push si
          push cx
          push ax
          push es
          push di
          mov ax,0xB800
          mov es,ax
          mov bx,160
          mov al,[bp+8]
          mul bl
          mov bx,[bp+10]
          shl bx,1
          add ax,bx
          mov di,ax
         
          mov si,[bp+4]
          mov cx,[bp+6]
          mov ah,0x07

again:    lodsb
          stosw
          loop again
          pop di
          pop es
          pop ax
          pop cx
          pop si
          pop bx
          pop bp
          ret 8

FindWord :         
         push bp
         mov bp,sp
         push bx
         push dx
         push es
         push si
         push cx
         mov ax,0xB800
         mov es,ax
         
         mov ah,0x07
         mov si,[bp+6]                           ;bp+6 points to substring
         lodsb                                   ;first char is loaded
         mov cx,0xFF
         
         repne scasw                            ;first char's first occurence is searched
         mov dx,0
again1: 
          mov bx,[es:di]
         mov bh,0x01
         mov[es:di],bx
          mov ah,0
         int 16h
         mov bx,[es:di]
         mov bh,0x07
         mov[es:di],bx
         mov ah,0x07
         
         lodsb                                  ;next characters are loaded and whole string 2 in compared whether it is there or not
         inc dx    
         
         scasw

         
         je again1
         cmp dx,[bp+4]            ;if the number of element equal are equal to the length of string to then string found(di='ending of found word' is returned)
         je senddi
         
         mov ax,0                ; this ax tells whether the string is found or not
         
senddi : sub di,2                ;subtract 2 from di because at the end o stos di is pointing at +2
         pop cx
         pop si        
         pop es
         pop dx
         pop bx
         pop bp
         ret 4
shifting:
          push bp
          mov bp,sp
          push ds
          push bx
          push si
          push cx
          push ax
          push es
          push di
          push dx
          mov dx,0
         mov cx,[bp+8]
         mov ax,0xB800
         mov es,ax
         push es
         pop ds
again2:  mov bx,[bp+8]
         mov di,[bp+6]                                       ;point di to the starting letter o subtring initially
         mov cx,bx
         add cx,cx
         sub cx,2
         sub di,cx
         mov si,di                                           ;point si to the second letter of substring
         sub di,2
         mov cx,[bp+4]
         sub cx,di
         rep movsw                                           ;it will keep shifiting one time
         inc dx
         cmp dx,bx
         jne again2
         pop dx
         pop di
         pop es
         pop ax
         pop cx
         pop si
         pop bx
         pop ds
         pop bp
         ret 6

Trimmer: push bp
         mov bp,sp
         push string2
         call strlen                                 
         mov bx,ax
         mov dx,[bp+6]                ;move size of string1 in dx 

         push bx
         mov bx,160                   ;point di to start of string on video screen
         mov ax,[bp+8]   
         mul bl
         mov bx,[bp+10]
         shl bx,1
         add ax,bx
         mov di,ax
         pop bx

         mov cx,dx
         add cx,di
         add cx,cx
again3:
         mov ax,[bp+4]                      
         push ax                        ;substring
         push bx                        ;ending of string
        
         call FindWord
         cmp ax,0                      ;if not found
         jne shift
         jmp check1
shift :
         push bx
         push di
         push cx         
         call shifting
        
check1: 
         cmp di,cx                            ;if di is below double of size
         jb again3
             
 end1:       
         pop bp
         ret 8

start: 
       call clrscr
       push string1
       call strlen
       mov dx,ax                            ; dx keeps length of string1
       mov ax,5
       push ax
       mov ax,10
       push ax
       push dx
       push string1
       call printstr
       
       mov ax,5             ;row number
       push ax
       mov ax,10             ;column number
       push ax
       push dx              ;size of string1

       mov ax,string2
       push ax              ;string2
       call Trimmer
       mov ax,0x4c00
       int 21h


string1: db 'The alignment-check exception can also be used by interpreters to flag some pointers as special by misaligning the pointer',0
string2: db 'align',0