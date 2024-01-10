;Convert 260° C to Fahrenheit using the following expression and 
;store IN a F  variable: °F = °C×9/5 + 32-1 


.MODEL SMALL
.STACK 100H
.DATA
    Celsius DW 260   ; Celsius value
    F DW ?           ; Variable to store Fahrenheit result

.CODE
MOV AX, @DATA
MOV DS, AX

MAIN PROC
    MOV AX, Celsius   ; Load Celsius value into AX
    MOV BX, 9
    MUL BX            ; AX = Celsius * 9

    MOV BX, 5
    DIV BX            ; AX = (Celsius * 9) / 5

    MOV BX, 32
    ADD AX, BX        ; AX = (Celsius * 9 / 5) + 32

    MOV BX, 1
    SUB AX, BX        ; AX = (Celsius * 9 / 5) + 32 - 1

    MOV F, AX         ; Store result in F variable

    ; Exit 
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

END MAIN
