%include "io.mac" 

.DATA
    prompt_N db "Enter N: ",0
    prompt_M db "Enter M: ",0
    prompt_roll_no db "Enter roll number of Student ",0
    prompt_marks db "Enter marks of Student ",0
    subject_text db "Subject ",0
    max_marks dw 0
    prompt_helper db ": ",0
    output_prompt db "Roll Number for Maximum marks in Subject ",0

.UDATA
    roll_nos resw 1000
    N resw 1
    M resw 1
    cur_marks resw 1
    sub_counter resw 1
    student_counter resw 1

.CODE
    .STARTUP
    PutStr prompt_N
    GetInt [N]
    PutStr prompt_M
    GetInt [M]
    mov AX,[N]
    cmp AX, 0
    je done
    mov AX,[M]
    cmp AX, 0
    je done
    
    mov AX, 1
    mov EBX, roll_nos
    get_roll_no:
        PutStr prompt_roll_no
        PutInt AX
        PutStr prompt_helper
        GetStr EBX
        add AX, 1
        add EBX, 10
        cmp AX, [N]
        jle get_roll_no
    
    mov word [sub_counter], 1
    subject:
        nwln
        mov word [max_marks], 0
        PutStr subject_text
        PutInt [sub_counter]
        PutStr prompt_helper
        nwln
        mov word [student_counter], 1
        mov EBX, roll_nos
        get_marks:
            PutStr prompt_marks
            PutStr EBX
            PutStr prompt_helper
            GetInt [cur_marks]
            mov AX, [cur_marks]
            mov CX, [max_marks]
            cmp AX, CX
            jg update_roll_no
        continue_get_marks:
            mov AL, [student_counter]
            add AL, 1
            mov [student_counter], AL
            add EBX, 10
            cmp AL, [N]
            jle get_marks
            jg print_roll_no
        update_roll_no:
            mov EDX, EBX
            mov word [max_marks], AX
            jmp continue_get_marks
        print_roll_no:
            PutStr output_prompt
            PutInt [sub_counter]
            PutStr prompt_helper
            PutStr EDX
            nwln
            mov CL, [sub_counter]
            add CL, 1
            mov [sub_counter], CL
            cmp CL, [M]
            jle subject
            jg done

    done:
        .EXIT
