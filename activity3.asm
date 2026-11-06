; ============================================================
;  CPE 463 - Activity No. 3: Basic Assembly Graphics
;  Colors (attribute = background*16 + foreground):
;     00h black bg   10h blue bg   20h green bg
;     40h red bg     60h brown bg  4Eh yellow text on red
; ============================================================
 
; ---- Draw a filled rectangle: BOX attr, top, left, bottom, right
BOX MACRO ATTR, TOP, LEFT, BOT, RIGHT
    MOV     AX, 0600H        ; AH=06 scroll up, AL=0 -> fill whole window
    MOV     BH, ATTR         ; color
    MOV     CH, TOP          ; upper-left row
    MOV     CL, LEFT         ; upper-left col
    MOV     DH, BOT          ; lower-right row
    MOV     DL, RIGHT        ; lower-right col
    INT     10H
ENDM
 
CTEXT MACRO STR, ROW, LEFT, RIGHT, ATTR
    MOV     SI, OFFSET STR
    MOV     DH, ROW
    MOV     CH, LEFT
    MOV     CL, RIGHT
    MOV     BL, ATTR
    CALL    CPRINT
ENDM
 
DATA_SEG    SEGMENT
    T1      DB 'C P E 4 6 3  1','$'
    T2      DB 'COMPUTER ORGANIZATION AND ARCHITECTURE','$'
    T3      DB 'W/','$'
    T4      DB 'A S S E M B L Y   L A N G U A G E','$'
    T5      DB 'P R O G R A M M I N G','$'
    N1      DB 'Wilfred Justin','$'
    N2      DB 'D. Peteros','$'
    S1      DB 'BSCpE','$'
    S2      DB '-4','$'
DATA_SEG    ENDS
 
CODE_SEG    SEGMENT
    ASSUME CS:CODE_SEG, DS:DATA_SEG
 
START:
    MOV     AX, DATA_SEG
    MOV     DS, AX
 
    ; ---- clear screen to black (whole 80x25)
    MOV     AX, 0600H
    MOV     BH, 07H
    MOV     CX, 0000H
    MOV     DX, 184FH
    INT     10H
 
    ; ---- TOP BANNER: blue frame + brown bar
    BOX 10H, 0, 0, 4, 78
    BOX 60H, 1, 1, 3, 77
 
    ; ---- MAIN PANEL
    BOX 20H, 7, 2, 18, 78        ; green backdrop
    BOX 10H, 9, 0, 20, 76        ; blue shadow (left + bottom)
    BOX 40H, 8, 1, 19, 77        ; red panel (cols 1-77)
 
    ; ---- green stripes (left and right)
    BOX 20H, 9, 2, 18, 2
    BOX 20H, 9, 4, 18, 4
    BOX 20H, 9, 6, 18, 6
    BOX 20H, 9, 8, 18, 8
    BOX 20H, 9, 70, 18, 70
    BOX 20H, 9, 72, 18, 72
    BOX 20H, 9, 74, 18, 74
    BOX 20H, 9, 76, 18, 76
 
    ; ---- bottom-left name box
    BOX 10H, 23, 3, 24, 23       ; shadow
    BOX 40H, 22, 2, 23, 22       ; red box (cols 2-22)
 
    ; ---- bottom-right section box
    BOX 10H, 23, 59, 24, 76      ; shadow
    BOX 40H, 22, 57, 23, 75      ; red box (cols 57-75)
 
    ; ---- main panel text, centered in cols 1-77
    CTEXT T1, 9,  1, 77, 4EH
    CTEXT T2, 11, 1, 77, 4EH
    CTEXT T3, 13, 1, 77, 4EH
    CTEXT T4, 15, 1, 77, 4EH
    CTEXT T5, 17, 1, 77, 4EH
 
    ; ---- bottom-left box text, centered in cols 2-22
    CTEXT N1, 22, 2, 22, 4EH
    CTEXT N2, 23, 2, 22, 4EH
 
    ; ---- bottom-right box text, centered in cols 57-75
    CTEXT S1, 22, 57, 75, 4EH
    CTEXT S2, 23, 57, 75, 4EH
 
    ; ---- park the cursor out of the way, wait for a key
    MOV     AH, 2
    MOV     BH, 0
    MOV     DH, 24
    MOV     DL, 79
    INT     10H
 
    MOV     AH, 0
    INT     16H
 
    ; ---- restore text mode and exit
    MOV     AX, 0003H
    INT     10H
    MOV     AH, 4CH
    MOV     AL, 0
    INT     21H
 
; ------------------------------------------------------------
; CPRINT: centers a string between two columns.
;   SI = string offset ('$' ends), DH = row,
;   CH = left col, CL = right col, BL = color attribute
;   col = left + ((right - left + 1) - length) / 2
; NOTE: BX is NOT touched here (BL holds the color!).
; ------------------------------------------------------------
CPRINT PROC NEAR
    PUSH    SI                   ; remember start of string
    XOR     DI, DI               ; DI = string length
LEN_LP:
    CMP     BYTE PTR [SI], '$'   ; end of string?
    JE      GOT_LEN
    INC     SI                   ; walk SI along the string
    INC     DI                   ; count characters
    JMP     LEN_LP
GOT_LEN:
    POP     SI                   ; SI back to start of string
    MOV     AX, DI               ; AL = length
    MOV     DL, CL
    SUB     DL, CH
    INC     DL                   ; DL = box width
    SUB     DL, AL               ; DL = width - length
    SHR     DL, 1                ; divide by 2
    ADD     DL, CH               ; DL = starting column
    CALL    PRINT
    RET
CPRINT ENDP
 
; ------------------------------------------------------------
; PRINT: SI = string offset ('$' ends), DH = row, DL = col,
;        BL = color attribute
; Writes each char with INT 10h/09h so the color is applied.
; ------------------------------------------------------------
PRINT PROC NEAR
NEXT_CH:
    LODSB                    ; AL = [SI], SI++
    CMP     AL, '$'
    JE      DONE
    PUSH    AX
    MOV     AH, 2            ; set cursor (DH,DL)
    MOV     BH, 0
    INT     10H
    POP     AX
    MOV     AH, 9            ; write char + attribute
    MOV     BH, 0
    MOV     CX, 1
    INT     10H
    INC     DL               ; next column
    JMP     NEXT_CH
DONE:
    RET
PRINT ENDP
 
CODE_SEG    ENDS
    END     START