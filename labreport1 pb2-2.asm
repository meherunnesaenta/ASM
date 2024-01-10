; Convert 1000 °F to Celsius using the following expression and
; store IN a C variable:  °C = (°F - 32) × 5/9 + 1 



.MODEL SMALL
.STACK 100H
.DATA
    Fahrenheit DW 1000 ; Fahrenheit value
    C DW ?            ; Variable to store Celsius result

.CODE
MOV AX, @DATA
MOV DS, AX

MAIN PROC
    MOV AX, Fahrenheit ; Load Fahrenheit value into AX
    SUB AX, 32         ; AX = Fahrenheit - 32

    MOV BX, 5
    IMUL BX            ; AX = (Fahrenheit - 32) * 5

    MOV BX, 9
    IDIV BX            ; AX = (Fahrenheit - 32) * 5 / 9

    MOV BX, 1
    ADD AX, BX         ; AX = (Fahrenheit - 32) * 5 / 9 + 1

    MOV C, AX          ; Store result in C variable

   

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

END MAIN

