DATA_SEG SEGMENT
    title_msg    DB 'C P E 4 6 3 1','$'
    course_msg   DB 'COMPUTER ORGANIZATION AND ARCHITECTURE','$'
    mid_msg      DB 'W/','$'
    lang_msg     DB 'ASSEMBLY LANGUAGE','$'
    prog_msg     DB 'PROGRAMMING','$'
    name_msg     DB 'Wilfred Justin D. Peteros','$'
    section_msg  DB 'BSCpE - 4','$'
DATA_SEG ENDS
 
CODE_SEG SEGMENT
    ASSUME CS:CODE_SEG, DS:DATA_SEG
 
START:
    MOV AX, DATA_SEG
    MOV DS, AX
 
    ; ------------------------------------------------
    ; 1. CLEAR SCREEN (Dark Gray Background)
    ; ------------------------------------------------
    MOV AH, 06h
    MOV AL, 00h
    MOV BH, 80h      
    MOV CX, 0000h
    MOV DX, 184Fh    ; Max screen boundary (Row 24, Col 79)
    INT 10h
 
    ; ------------------------------------------------
    ; 2. TOP BANNER 
    ; ------------------------------------------------
    ; Shadow
    MOV AH, 06h
    MOV AL, 00h
    MOV BH, 80h      
    MOV CH, 01h      
    MOV CL, 02h      
    MOV DH, 05h      
    MOV DL, 4Dh      
    INT 10h
 
    ; Brown Foreground
    MOV AH, 06h
    MOV BH, 60h      
    MOV CH, 01h      
    MOV CL, 03h      
    MOV DH, 04h      
    MOV DL, 4Ch      
    INT 10h
 
    ; ------------------------------------------------
    ; 3. MAIN CENTER RECTANGLE (Compressed Upward)
    ; ------------------------------------------------
    ; Shadow
    MOV AH, 06h
    MOV BH, 80h      
    MOV CH, 07h      
    MOV CL, 02h      
    MOV DH, 14h      
    MOV DL, 4Dh      
    INT 10h
 
    ; Green Background Box 
    MOV AH, 06h
    MOV BH, 20h      
    MOV CH, 08h      
    MOV CL, 05h      
    MOV DH, 13h      
    MOV DL, 4Ah      
    INT 10h
 
    ; Brown Main Box 
    MOV AH, 06h
    MOV BH, 6Eh      
    MOV CH, 09h      
    MOV CL, 04h      
    MOV DH, 14h      
    MOV DL, 49h      
    INT 10h
 
    ; Left Green Vertical Stripes
    MOV AH, 06h
    MOV BH, 20h      
    MOV CH, 09h      
    MOV DH, 13h      
    MOV CL, 06h      
    MOV DL, 06h      
    INT 10h
    MOV CL, 08h      
    MOV DL, 08h      
    INT 10h
    MOV CL, 0Ah      
    MOV DL, 0Ah      
    INT 10h
 
    ; Right Green Vertical Stripes
    MOV CL, 43h      
    MOV DL, 43h
    INT 10h
    MOV CL, 45h      
    MOV DL, 45h
    INT 10h
    MOV CL, 47h      
    MOV DL, 47h
    INT 10h
 
    ; ------------------------------------------------
    ; 4. BOTTOM LEFT BOX (Name) - SAFELY WITHIN BOUNDS
    ; Row 15h is left empty for spacing
    ; ------------------------------------------------
    ; Shadow
    MOV AH, 06h
    MOV BH, 80h      
    MOV CH, 17h      
    MOV CL, 05h      
    MOV DH, 18h      
    MOV DL, 20h      
    INT 10h
 
    ; Brown Box 
    MOV AH, 06h
    MOV BH, 6Eh      
    MOV CH, 16h      
    MOV CL, 04h      
    MOV DH, 17h      
    MOV DL, 1Fh      
    INT 10h
 
    ; ------------------------------------------------
    ; 5. BOTTOM RIGHT BOX (Section) 
    ; ------------------------------------------------
    ; Shadow
    MOV AH, 06h
    MOV BH, 80h      
    MOV CH, 17h      
    MOV CL, 3Ah      
    MOV DH, 18h      
    MOV DL, 4Dh      
    INT 10h
 
    ; Brown Box 
    MOV AH, 06h
    MOV BH, 6Eh      
    MOV CH, 16h      
    MOV CL, 39h      
    MOV DH, 17h      
    MOV DL, 4Ch      
    INT 10h
 
    ; ------------------------------------------------
    ; 6. SET CURSOR & PRINT TEXT 
    ; ------------------------------------------------
    ; Print Title
    MOV AH, 02h      
    MOV BH, 00h      
    MOV DH, 0Ah      
    MOV DL, 20h      
    INT 10h
    MOV AH, 09h      
    LEA DX, title_msg
    INT 21h
 
    ; Print Course
    MOV AH, 02h
    MOV DH, 0Ch      
    MOV DL, 11h      
    INT 10h
    MOV AH, 09h
    LEA DX, course_msg
    INT 21h
 
    ; Print "W/"
    MOV AH, 02h
    MOV DH, 0Eh      
    MOV DL, 26h      
    INT 10h
    MOV AH, 09h
    LEA DX, mid_msg
    INT 21h
 
    ; Print Language
    MOV AH, 02h
    MOV DH, 10h      
    MOV DL, 1Ch      
    INT 10h
    MOV AH, 09h
    LEA DX, lang_msg
    INT 21h
 
    ; Print Programming
    MOV AH, 02h
    MOV DH, 12h      
    MOV DL, 22h      
    INT 10h
    MOV AH, 09h
    LEA DX, prog_msg
    INT 21h
 
    ; Print Name 
    MOV AH, 02h
    MOV DH, 16h      
    MOV DL, 05h      
    INT 10h
    MOV AH, 09h
    LEA DX, name_msg
    INT 21h
 
    ; Print Section 
    MOV AH, 02h
    MOV DH, 16h      
    MOV DL, 3Eh      
    INT 10h
    MOV AH, 09h
    LEA DX, section_msg
    INT 21h
 
    ; ------------------------------------------------
    ; 7. RESET CURSOR & EXIT
    ; Park the cursor at the absolute bottom left (18h)
    ; so the DOS prompt doesn't overwrite your boxes
    ; ------------------------------------------------
    MOV AH, 02h
    MOV DH, 18h
    MOV DL, 00h
    INT 10h
 
    MOV AH, 4Ch
    MOV AL, 00h
    INT 21h
 
CODE_SEG ENDS
END START