;; ============================ ASSEMBLY 8086 WORD HUNT ============================
;; Author: Meherun Nesa Enta
;;
;; Email: 221002178@student.green.edu.bd 
;; =================================================================================
.stack 100h
.data  
    counter           DB   0
    column_counter    DB   0
    column            DW   0
    line              DW   0
    number_of_letters DW   0
    search            DB   20, 22 dup('?')
    cursor_color      DW   00100000B          
    area_color        DB   00110000B
    
    WORD_HUNT         DB   "ASDFKASJFSKASJDFLKJASKRUEIJDSLFJKLSAJKDSVMNMSDPMKVLSADFDSART"
                      DB   "KSAOJFLKASTFLKASAJSDKFJSADKFJKSADJFEMAGJFKLJSALIFJLKASJCFKAA"
                      DB   "ASJEASYADKFASKAREJADSREWUUTJBKNBDKGFPTHHFKSJRKDCJDKSHHAASDBB"
                      DB   "JDSAKFJESIURRMLNFSKTYRSIUOMHKLSDFGREUIFSLKGHRESROHKSDNKLSUAA"
                      DB   "RUQLIOTOROIQEWURIODSMSADFJKODJVXCMJASDKFVSALKFJOLSADNFLKSDUU"
                      DB   "ASKCFJKALSDGFLKASDJFLKSAMDFLFASJDKLFJSALIKFJLSDPAJKESASLKAHH"
                      DB   "RQWLIRUQWEIADFJHSADJFWAODIFUIIQUERIUEWASDDJSATKRFJRDOKJFSSEE"
                      DB   "ASDIFPOASIDMOPSAIDFOPAFSDOPFIAQOPFISAPODEIOPASDOFOPSAIFOOFHH"
                      DB   "ASDNWSDKFLSEDKFLASKDFILSAIDOFRIEJJVDFSAIOOSADIFCSDIOPFISDODD"
                      DB   "ASPUOIASPOAFIPAOSDFIDACOCOMPUTERFOPSADIFOPSDIFOESDAOPFDSATJA"
                      DB   "ASDXREWCPAIEWOIRARYAQIROQWEIROPEWQIRPOWQEOOPREWSORIWQEPOAAEE"
                      DB   "ASDFKSCJRKASDJFKLASDSEEKDSAJFLKSDAJFASLKCDJFOICSADFDSKSYPDEE"
                      DB   "ASDFAIDOISADFISOADILAEDFISAODIFOSADIFSAODPICPVSODIFOPDRAISAA"
                      DB   "ASDOSFSADFINVNCXJDFIIEDSNFLSDAFUSADFUSDAIFEISODRFIODSANISDDD"
                      DB   "QWEUUSIDWERUIOQWEURZOWEQUERWECUIORUQWOEIUANVDMSADFKLYEDALKBB"
                      DB   "LSMDEPOOESNVMXNCFDSAKLSEESNAFSHVAFDJNFSYNDSNFSDAYUEOSDSAAMCC"
                      DB   "ALSRKLAODKYCASDLIURRWEUIRTRTEEIOQEWURIOFDSHFJSADHFJESDADEDAD"
                      DB   "VXPMZXEGUOMSZNCVMIEBNOTILISOADIOFISDAOFIOSADIFODSIFOSDATODVD"
                      DB   "QMIERUQIWERUIQWEURIOQWRURIQWUARIUQWEIRUQWIOERUIQWEURIEYUUQAA"
                      DB   "IWERQUWIRUQWEIORUQIWOEYUOIQWEUJOIQWUEROIUQWOIEWRUIWSDSFSDHJQ",0
                      ENDS    
             ;ENTA/MOFID/COMPUTER/GAME/WORK THOSE WORD ARE WRITTEN HERE


.code 

   main PROC
start:                     
               MOV  AX,@data
               MOV  DS, AX
               MOV  AX, 0b800h;show video of text mood And Video Memory      
               MOV  ES, AX
                                                    
SET_BACKGROUND_COLOR:      
               MOV  CX, 4001
               MOV  DX, 11111111B

SET_BACKGROUND:            
               MOV  BX, CX
               MOV  ES:[BX], DX;dx store in address of es and bx combine location

               INC  counter

               CMP  counter, 5
               JE   ALTERNATE_BACKGROUND_COLOR

               CMP  CX, 0
               JL   DRAW_AREA

               DEC  CX

               LOOP SET_BACKGROUND

ALTERNATE_BACKGROUND_COLOR:
               MOV  counter, 0

               CMP  DX, 11111111B
               JE   cor_2
               MOV  DX, 11111111B
               JMP  SET_BACKGROUND
                                                    

 cor_2:                     
               MOV  DX, 00H
               JMP  SET_BACKGROUND
        
DRAW_AREA:                 
               MOV  column_counter, 0;Track colom number
               MOV  SI, 1200   ; total size of word hunt=20*60=1200
               MOV  counter, 0
               MOV  DL, area_color
               MOV  CX, 3501  ;counter value is define
               MOV  BX, CX        


PAINT_AREA:                
               CMP  column_counter, 20
               JE   DRAW_CURSOR

               CMP  counter, 0
               JE   FIRST_COLUMN

               DEC  SI

               MOV  DH, WORD_HUNT[SI]

               CMP  DH, 90 ;Check dh>'Z' then dh is others char 
               JG   LETTER_FOUND

               MOV  DL, area_color
               JMP  SHOW_LETTER
    
LETTER_FOUND:              
               INC  CX
               MOV  BX, CX
               MOV  ES:[BX], DX
               DEC  CX
               MOV  DH, WORD_HUNT[SI]
               MOV  DL, area_color
               SUB  DH, 26
               JMP  SHOW_LETTER
    
FIRST_COLUMN:              
               MOV  DH, 0
               MOV  DL, area_color
    
SHOW_LETTER:               
               MOV  BX, CX
               MOV  ES:[BX], DX

CONTINUE:                  
               DEC  CX
               INC  counter
               CMP  counter, 60
               JG   NEW_LINE_AREA

               LOOP PAINT_AREA
        
NEW_LINE_AREA:             
               MOV  counter, 0
               INC  column_counter
               SUB  CX, 38
               MOV  DL, area_color
               LOOP PAINT_AREA

DRAW_SUCCESS_CURSOR:       
               MOV  cursor_color, 00100000B
               JMP  DRAW_AREA

DRAW_ERROR_CURSOR:         
               MOV  cursor_color, 01000000B
               JMP  DRAW_CURSOR
        
DRAW_CURSOR:               
               MOV  CX, 3775
               MOV  DX, cursor_color

DRAW_CURSOR_LOOP:          
               MOV  BX, CX
               MOV  ES:[BX], DX

               CMP  BX, 3739
               JL   SET_CURSOR
               DEC  CX
               LOOP DRAW_CURSOR_LOOP

SET_CURSOR:    
               ;CURSER COMING INTO THE SEARCH BOX            
               MOV  DH, 23 ;row
               MOV  DL, 28 ;colom
               MOV  BH, 0
               MOV  AH, 2
               INT  10h ;provide video services
               
            ;input section
            LEA  DX, search    ; Load the address of the 'search' array into the dx register
            MOV  AH, 0ah       ; Set the DOS function number for buffered input (0Ah)
            INT  21h           ; Call the DOS interrupt to perform buffered input

            MOV  BX, DX        ; Move the address of 'search' into bx
            MOV  AH, 0         ; Clear the ah register
            MOV  AL, DS:[BX+1] ; Load the length of the input (excluding the '$') into al
            MOV  number_of_letters, AX ; Move the length into the 'number_of_letters' variable

            ADD  BX, AX        ; Move the bx register to the end of the input string
            MOV  BYTE PTR [BX+2], '$' ; Add the '$' terminator at the end of the input string
            MOV  SI, 0         ; Initialize si to 0, pointing to the beginning of the 'search' array


               CMP  number_of_letters, 4
               JL   SEARCH_WORD

               CMP  search[2], "E"
               JNE  CHECK_HARD
               CMP  search[3], "X"
               JNE  CHECK_HARD
               CMP  search[4], "I"
               JNE  CHECK_HARD
               CMP  search[5], "T"
               JNE  CHECK_HARD
               JMP  EXIT  
               
               ;HARD SECTION START

CHECK_HARD:                
               CMP  search[2], "H"
               JNE  CHECK_EASY
               CMP  search[3], "A"
               JNE  CHECK_EASY
               CMP  search[4], "R"
               JNE  CHECK_EASY
               CMP  search[5], "D"
               JNE  CHECK_EASY
               MOV  area_color, 11111111B
               JMP  DRAW_AREA
               
               ;EASY SECTION

CHECK_EASY:                
               CMP  search[2], "E"
               JNE  CHECK_RESET
               CMP  search[3], "A"
               JNE  CHECK_RESET
               CMP  search[4], "S"
               JNE  CHECK_RESET
               CMP  search[5], "Y"
               JNE  CHECK_RESET
               MOV  area_color, 00110000B
               JMP  DRAW_AREA 
               
               ;RESET SECTION
 
CHECK_RESET:               
               CMP  number_of_letters, 5
               JNE  SEARCH_WORD
               CMP  search[2], "R"
               JNE  SEARCH_WORD
               CMP  search[3], "E"
               JNE  SEARCH_WORD
               CMP  search[4], "S"
               JNE  SEARCH_WORD
               CMP  search[5], "E"
               JNE  SEARCH_WORD
               CMP  search[6], "T"
               JMP  RESET_GAME
               
              
               ;SEARCH HERE
             
SEARCH_WORD:               
               CMP  WORD_HUNT[SI], 0
               JE   DRAW_ERROR_CURSOR

               MOV  AL, search[2] ; Load the third character of the user input
               CMP  AL, WORD_HUNT[SI]
               JE   FOUND_FIRST_LETTER

               INC  SI; Move to the next position in the WORD_HUNT array.
               INC  column

               CMP  column, 60
               JE   NEW_LINE

               JMP  SEARCH_WORD

NEW_LINE:                  
               MOV  column, 0
               INC  line
               JMP  SEARCH_WORD

FOUND_FIRST_LETTER:        
               PUSH SI; Save the current position in the WORD_HUNT array.

               MOV  CX, 60 ; Set the limit for searching in one direction.
               MOV  DX, 1; Set the search direction to the right.
               CALL RESET
               CALL SEARCH_COMPLETE_WORD
               POP  SI
               PUSH SI
               MOV  DX, -1
               CALL RESET
               CALL SEARCH_COMPLETE_WORD
               
               ; Similar blocks follow for other search directions (up, down, diagonals).

               MOV  CX, 1199
               CALL RESET
               POP  SI
               PUSH SI
               MOV  DX, 60
               CALL SEARCH_COMPLETE_WORD
               MOV  DX, -60
               CALL RESET
               POP  SI
               PUSH SI
               CALL SEARCH_COMPLETE_WORD

               MOV  CX, 1199
               CALL RESET
               POP  SI
               PUSH SI
               MOV  DX, 59
               CALL SEARCH_COMPLETE_WORD
               MOV  DX, -59
               CALL RESET
               POP  SI
               PUSH SI
               CALL SEARCH_COMPLETE_WORD

               MOV  CX, 1199
               CALL RESET
               POP  SI
               PUSH SI
               MOV  DX, 61
               CALL SEARCH_COMPLETE_WORD
               MOV  DX, -61
               CALL RESET
               POP  SI
               PUSH SI
               CALL SEARCH_COMPLETE_WORD

               POP  SI
               INC  SI
               JMP  SEARCH_WORD

SEARCH_COMPLETE_WORD:      
    INC  DI                    ; Increment the index di representing the position in the search word.

    CMP  DI, number_of_letters ; Compare di with the total number of letters in the search word.
    JE   FOUND_WORD             ; If di is equal to the total number of letters, the entire word is found.

    INC  BX                    ; Increment bx, which represents the position in the search buffer.
    ADD  SI, DX                ; Add dx (direction) to si, updating the index in the WORD_HUNT array.

    CMP  BX, CX                ; Compare bx with cx, which represents the total length of the search buffer.
    JG   RETURN                ; If bx is greater than cx, return from the subroutine.

    CMP  SI, 0                 ; Compare si with 0 to ensure it doesn't go below zero.
    JL   RETURN                ; If si is less than 0, return from the subroutine.

    MOV  AL, search[BX]        ; Load the character at position bx in the search buffer into the al register.
    CMP  AL, WORD_HUNT[SI]     ; Compare the loaded character with the character in the WORD_HUNT array at position si.
    JE   SEARCH_COMPLETE_WORD  ; If they match, continue searching for the next character.

    RET                         ; Return from the subroutine.

RETURN:                         ; Label for returning from the subroutine.
    RET


FOUND_WORD:    
               ;find letter so create sound
                         
               CMP  number_of_letters, 0
               JE   DRAW_SUCCESS_CURSOR
               ADD  WORD_HUNT[SI], 26
               SUB  number_of_letters, 1
               SUB  SI, DX
               JMP  FOUND_WORD

RESET:                     
               MOV  BX, 2
               MOV  DI, 0
               RET
               ; Reset counters: BX for direction, DI for a temporary variable.

RESET_GAME:                
               MOV  SI, -1
LOOP_RESET:                
               INC  SI
               MOV  AH, WORD_HUNT[SI]
               CMP  AH, 0
               JE   DRAW_AREA
    
               CMP  AH, 90
               JG   RESET_CHAR
    
               JMP  LOOP_RESET
    
RESET_CHAR:                
               SUB  AH, 26
               MOV  WORD_HUNT[SI], AH
               JMP  LOOP_RESET


EXIT:                       
       MOV  AX, 4c00h
       INT  21h
       ENDS
       
   main ENDP

END main 