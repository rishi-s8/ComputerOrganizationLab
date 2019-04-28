%include "io.mac"

.DATA
prompt_msg1  db   "Hello world : ",0

.CODE
      .STARTUP
      PutStr  prompt_msg1   ; request first number 
  nwln 
done:
      .EXIT







