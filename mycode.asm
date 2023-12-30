.MODEL SMALL
.STACK 100H
.DATA

 A DB 10 DUP(?)
 N DB ?
 MSG DB 0AH ,0DH, 'ENTER THE NO OF ELEMENTES:$'
 MSG1 DB 0AH,0DH, 'ELEMENTS:$'
 MSG2 DB 0AH,0DH, 'SORTED ARRAY:$'
 
.CODE
  MAIN PROC
       MOV AX,@DATA
       MOV DS,AX
       
       MOV AH,9
       MOV DX,OFFSET MSG
       INT 21H
       
       MOV AH,1
       INT 21H
       SUB AL,30H
       MOV N,AL
       
       MOV AH,9
       MOV DX,OFFSET MSG1
       INT 21H
       
       XOR CH,CH
       MOV CL,N
       MOV SI,OFFSET A
       
      
          
         
            
       
       
   MAIN ENDP
  
  END MAIN
