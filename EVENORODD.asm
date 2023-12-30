 .MODEL SMALL
 .STACK 100H
 .DATA
     MSG DB 'Enter the 1st number : $'
     EVEN DB 0DH,0AH,'ITS EVEN $'
     ODD DB 0DH,0AH,'ITS ODD  $'
 
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
      
      
       
        MOV AH,0H
        MOV AL,BH
        MOV BL,2
        DIV BL
         
        MOV CL,AH
        
        CMP CL,0
        JE EVENE
         MOV AH,9
         LEA DX,ODD
         INT 21H
         JMP END
          
    EVENE:
         MOV AH,9
         LEA DX,EVEN
         INT 21H
      
      END: MOV AH,4CH
           INT 21H
  MAIN ENDP
END MAIN

