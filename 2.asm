%include "io.mac"

.DATA
	prompt_1	 	db	"Number of students: ", 0
	prompt_2		db	"Number of subjects: ", 0
	prompt_3		db	"Enter next roll no: ", 0
	prompt_4		db	"Enter marks for all students in subject ",0
	count			dw	0
	subject			db	"Student ", 0
	colon 			db	": ", 0

.UDATA	
	N 				resb	1
	M				resb	1
	student_list	resw	1000
	sub_list		resw	1000

.CODE
	.STARTUP
	PutStr prompt_1
	GetInt [N]
	mov AX, [N]
	PutStr prompt_2
	GetInt DX
	mov ECX, student_list
	mov BX, [count]
roll_input:
	PutStr prompt_3
	GetStr ECX, 7
	nwln
	Add ECX, 7
	Add BX, 1
	cmp BX, AX
	jl roll_input
 

mov ECX, sub_list

inc AX
marks_input:
	dec AX
	mov BX, [count]
	cmp AX, 0
	je done

PutStr prompt_4
PutInt AX
nwln
take_input:	
	inc BX
	PutStr subject
	PutInt BX
	PutStr colon
	GetInt CX	
	Add CX, 2
	cmp BX, [N]
	jl take_input
	je marks_input


mov ECX ,student_list
mov BX, word 0
repeat:
	cmp BX, AX
	je done
	PutStr ECX
	nwln
	inc BX
	add ECX, 7
	jmp repeat


done:
	.EXIT
	