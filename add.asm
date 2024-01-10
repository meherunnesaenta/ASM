; Put 100H to register BX, then move the contents of this register to AX register.
; After  that ADD 10H to the contents of AX register. 

.MODEL SMALL
.STACK 100H
.DATA

.CODE
MOV AX, @DATA
MOV DS, AX

MAIN PROC
    MOV BX, 100H    ; Put 100H to register BX
    MOV AX, BX      ; Move the contents of BX to AX
    ADD AX, 10H     ; Add 10H to the contents of AX


    ; Exit the program
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

END MAIN
