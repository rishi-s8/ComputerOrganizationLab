%include "io.mac" 

.DATA
    prompt_msg  db  "Enter the string: ",0      ; This is the prompt message
    output_msg  db  "Encrypted string: ",0      ; This is the output message
    cont_msg    db  "Would that be all? ",0     ; Confirmation prompt

.UDATA
    string  resb    1000                     ; Input String
    conf    resb    1                           ; Confirmation character

.CODE
        .STARTUP
            encrypt:
                PutStr prompt_msg                       ; request string
                GetStr string, 100                 ; string input
                mov EBX, string
                PutStr output_msg
                repeat:
                    mov AL, [EBX] 
                    cmp AL, 0
                    je encrypted
                    cmp AL, '0'
                    jl continue
                    cmp AL, '9'
                    jg continue
                    je encrypt9
                    cmp AL, '2'
                    jle encrypt0_2
                    jg encrypt3_8
                
                encrypt9:
                    mov AL, '0'
                    jmp continue
                
                encrypt0_2:
                    add AL, 40
                    jmp continue
                
                encrypt3_8:
                    add AL, 14
                    jmp continue

                continue:
                    PutCh AL
                    inc EBX
                    jmp repeat

                
                encrypted: 
                    nwln
                    PutStr cont_msg
                    GetCh BL
                    cmp BL, 'Y'
                    je done
                    cmp BL, 'y'
                    je done
                    jmp encrypt

            done:
                .EXIT    
