.MODEL SMALL
.STACK 100H
.DATA

N DB ?
a DB ' $'
l DB 0ah,0dh,'The fectorial is : $' 

.CODE
   MAIN PROC 
       
       MOV AX,@DATA
       MOV DS,AX
       
       MOV AH,1
       INT 21h
       MOV n,AL
       
       MOV CL,AL
       
       MOV AH,9
       LEA DX,l
       INT 21h
       
 start:CMP CL,30h
       JE END
       MOV AH,2
       MOV DL,a
       INT 21h
       MOV DL,CL
       INT 21h
       
       DEC CL
       JMP start
       
       
   END: MOV AH, 4CH
        INT 21H
   
   MAIN ENDP
END MAIN


