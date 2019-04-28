segment .data 
string1   db   "Hello world : ",0xa 

 segment .bss
 segment .text
 global _start
 _start:
	MOV ECX, string1 
	mov EDX, 15
	mov EAX,4
	mov EBX,1
	int 0x80
done:
       mov EAX,1 
       xor EBX,EBX
       int 0x80


