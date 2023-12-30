 .MODEL SMALL
 .STACK 100H
 .DATA
     MSG DB 'Enter the 1st number : $'
     MSG2 DB 0DH,0AH,'Enter the 2nd number : $'
     DIVISION DB 0DH,0AH,'DIVISION : $'
     MULTI DB 0DH,0AH,'Multiplication : $'
 
 .CODE
   MAIN PROC
       
      MOV AX,@DATA
      MOV DS,AX
      
      MOV AH,9
      LEA DX,MSG
      INT 21H
      
      ;TAKE INPUT
      
      MOV AH,1
      INT 21H
      SUB AL,30H
      MOV BH,AL
      
      
      MOV AH,9
      LEA DX,MSG2
      INT 21H
      
      MOV AH,1
      INT 21H
      SUB AL,30H
      MOV BL,AL
      
      ;MULTIPLICATION
      
      MOV AH,9
      LEA DX,MULTI
      INT 21H
      
      MOV AH,0H
      MOV AL,BH
      MUL BL
      ADD AL,30H
      
      
      MOV AH,2
      MOV DL,AL
      INT 21H
      
      
      ;DIVISION
      
      MOV AH,9
      LEA DX,DIVISION
      INT 21H
      
      MOV AH,0H
      MOV AL,BH 
      DIV BL
      ADD AL,30H
      
     
      MOV AH,2
      MOV DL,AL
      INT 21H
      
      
      END: MOV AH,4CH
           INT 21H
  MAIN ENDP
END MAIN

