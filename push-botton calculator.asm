name "single-digit-calculator_Amos"

org 100h

mov cx, 9       ;totaly useless for the sake of this experiment
mov al, 0
mov bx, 0

;dl is reserved for manual input of the keyboard inputs
;or maybe al? I can use al for now, later we'll see 

main:
call decodeKbrd     ;for the sake of this progress this is useless as well




decodeKbrdOne:
mov bx, numOne
mov ah, vctrKybrd[bx]   
cmp ah, dl                  ;dl is where the click stored
jz decodeOperation          ;incase of match next op
 
;"else" go on and scan the input vector
inc bx
mov numOne,bx 
jmp decodeKbrdOne



;keep in mind that the previous input num is stored in "numOne" variable    
decodeOperation:
;here the decode and impliment the math op 
pusha
mov bx, mathOp          ;nullify the bx registry 
mov ah, vctrOps[bx]
cmp ah, dl
jz decodeKbrdTwo

inc bx
mov mathOp, bx
jmp decodeOperation

       
       
       
       
       
decodeKbrdTwo:
mov bx, numTwo
mov ah, vctrKybrd[bx]   
cmp ah, dl                  ;dl is where the click stored
jz solve          ;incase of match next op
 
;"else" go on and scan the input vector
inc bx
mov numTwo,bx 
jmp decodeKbrdTwo



solve:
;milestone trial and err the next step will be preformed only if ---
mov cl, mathOp
cmp cl, 11h
jz addition
cmp cl, 21h
jz substraction

;cmp dl, 82h <- check if the input is "equal"
 

addition:
;add numOne to numTwo


substraction:
;sub numOne from numTwo

    
numOne dw 0
numTwo dw 0
mathOp dw 0

;input vectors - nums and math ops
vctrKybrd db 84h, 18h, 14h, 12h, 28h, 24h, 22h, 48h, 44h, 42h   ;kbd inputs from 0 to 9
vctrOps db 82h, 11h, 21h       ;kbd math.ops-Equal, addition, substraction