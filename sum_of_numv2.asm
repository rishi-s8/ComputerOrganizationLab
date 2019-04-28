;Test routine for GetPut.asm      
;
;       Objective: find the sum of two numbers 
;       Input: Requests two  integers  from the user.
;       Output: Outputs the input number.
%include "io.mac"

.DATA
prompt_msg1  db   "Please input the first number : ",0
n1 dw   4862  
n2 dw   4523 
.UDATA 
number1   resd   1343 
number2   resd   134

.CODE
      .STARTUP
  mov  [number2], AX 
L1     mov cx, [n1]
     mov dx,[n2]
     push word [n1+2]
     call P1
     inc CL
     jmp  L1
    PutInt  AX  
   call P2  
done:
      .EXIT



; -----------------------------------------------------
; Procedure sum receives two integers in CX  and DX 
; The sum of the two integers is returned in AX 
;-------------------------------------------
P1:
  mov AX, CX   ; sum= first number
  add AX,DX    ; sum=sum+second number 
  ret

  

P2:
            mov cx, 5
            mov dx, 10
            call P1 
           add cx,5 
            add CL,1  
         PutInt   AX
ret 
 






