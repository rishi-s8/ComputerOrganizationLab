%include "io.mac"

.DATA
    prompt_N db "Enter number of rows of matrix ",0
    prompt_M db "Enter number of columns of matrix ",0
    prompt_matrix db "Enter matrix ",0
    prompt_helper db ": ",0
    space db " ",0
    dim_mis dw "Dimensions Mismatch, ABORT!",10
    out_mat dw "Output Matrix: ",10
    mat_inp dw "Matrix Input Succeeded",10
    debug_i db "i: ",0
    debug_j db "j: ",0
    debug_k db "k: ",0
    debug_sum db "sum: ",0
    back dw "Back Here",10

.UDATA
    N1 resw 1
    N2 resw 1
    M1 resw 1
    M2 resw 1
    temp_r resw 1
    temp_c resw 1
    i resw 1
    j resw 1
    k resw 1
    tempw resw 1

    mat1 resd 100
    mat2 resd 100
    mat3 resd 100
    temp1 resd 1
    temp2 resd 1
    temp3 resd 1
    sum resd 1
    temp resd 1
.CODE
    .STARTUP

    mov CX, 1
    PutStr prompt_N
    PutInt CX
    PutStr prompt_helper
    GetInt [N1]

    PutStr prompt_M
    PutInt CX
    PutStr prompt_helper
    GetInt [M1]

    mov CX, 2
    PutStr prompt_N
    PutInt CX
    PutStr prompt_helper
    GetInt [N2]

    PutStr prompt_M
    PutInt CX
    PutStr prompt_helper
    GetInt [M2]

    mov CX, [N2]
    mov BX, [M1]
    cmp CX, BX
    jne failed

    mov EAX, mat1
    mov CX, [N1]
    mov DX, [M1]
    call read_matrix
    
    mov EAX, mat2
    mov CX, [N2]
    mov DX, [M2]
    call read_matrix

    mov EAX, mat1
    mov EBX, mat2
    mov ECX, mat3
    call matrix_multiply

    mov EAX, mat3
    mov CX, [N1]
    mov DX, [M2]
    call print_matrix



    done:
        .EXIT

    failed:
    PutStr dim_mis
    jmp done




    matrix_multiply:
        mov [temp1], EAX
        mov [temp2], EBX
        mov [temp3], ECX
        mov DX, 0
        mov [i], DX
        mult_row:
            mov DX, [N1]
            cmp [i], DX
            je mult_row_completed
            mov DX, 0
            mov word [j], 0
            mult_col:
                mov DX, [M2]
                cmp [j], DX
                je mult_col_completed

                mov DX, 0
                mov [k], DX
                mov EDX, 0
                mov [sum], EDX
                mult_val:
                    mov DX, [M1]
                    cmp DX, [k]
                    je mult_val_completed
                    PutStr debug_k
                    PutInt [k]
                    nwln

                    mov EAX, [temp1]
                    mov DX, [i]
                    mov [tempw], DX
                    mov DX, [M1]
                    imul DX, 4
                    imul DX, [tempw]
                    movzx EBX, DX
                    add EAX, EBX
                    mov DX, [k]
                    imul DX, 4
                    movzx EBX, DX
                    add EAX, EBX


                    mov EBX, [temp2]
                    mov DX, [k]
                    mov [tempw], DX
                    mov DX, [M2]
                    imul DX, 4
                    imul DX, [tempw]
                    movzx ECX, DX
                    add EBX, ECX
                    mov DX, [j]
                    imul DX, 4
                    movzx ECX, DX
                    add EBX, ECX


                    mov EDX, [EAX]
                    imul EDX, [EBX]
                    add [sum], EDX

                    add word [k], 1
                    jmp mult_val
                mult_val_completed:
                    mov ECX, [temp3]
                    mov DX, [i]
                    mov [tempw], DX
                    mov DX, [M2]
                    imul DX, 4
                    imul DX, [tempw]
                    movzx EAX, DX
                    add ECX, EAX
                    mov DX, [j]
                    imul DX, 4
                    movzx EAX, DX
                    add ECX, EAX

                    mov EDX, [sum]
                    mov [ECX], EDX
                    add word [j], 1
                    jmp mult_col

            mult_col_completed:
                add word [i], 1
                jmp mult_row
        mult_row_completed:
            ret

                    




    read_matrix:

        mov [temp_r], CX
        mov [temp_c], DX

        PutStr prompt_matrix
        mov CX, 1
        PutInt CX
        PutStr prompt_helper

        mov CX, 0
        mov [i], CX
        input_row:
            mov CX, [temp_r]
            cmp [i], CX
            je input_complete
            mov CX, 0
            mov [j], CX
            input_column:
                mov CX, [j]
                cmp CX, [temp_c]
                je input_row_complete
                GetLInt EBX
                mov [EAX], EBX
                add EAX, 4
                inc CX
                mov [j], CX
                jmp input_column
            input_row_complete:
                mov CX, [i]
                inc CX
                mov [i], CX
                jmp input_row

        input_complete:
            PutStr mat_inp
            ret

    
    print_matrix:

        mov [temp_r], CX
        mov [temp_c], DX

        PutStr out_mat
        nwln

        mov CX, 0
        mov [i], CX
        print_row:
            mov CX, [temp_r]
            cmp [i], CX
            je print_complete
            mov CX, 0
            mov [j], CX
            print_column:
                mov CX, [j]
                cmp CX, [temp_c]
                je print_row_complete
                PutLInt [EAX]
                PutStr space
                add EAX, 4
                inc CX
                mov [j], CX
                jmp print_column
            print_row_complete:
                nwln
                mov CX, [i]
                inc CX
                mov [i], CX
                jmp print_row

        print_complete:
            ret