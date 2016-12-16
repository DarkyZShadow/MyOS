[BITS 16]
[ORG 0x0]

; Initialisation des segments en 0x07C00
MOV AX, 0x07C0
MOV DS, AX
MOV ES, AX
MOV AX, 0x8000
MOV SS, AX
MOV SP, 0xF000

; Affiche un message
MOV SI, hello_str
CALL print_string

end:
    JMP end



;--------------------- Variables ---------------------
hello_str DB "Welcome !", 13, 10, 0
;-----------------------------------------------------


;--------------------- Functions ---------------------
print_string:
    PUSH AX
    PUSH BX
.ps_start:
    LODSB		; ds:si -> al
    CMP AL, 0
    JZ .ps_end
    MOV AH, 0x0E	; Sous fonction 0x0E
    MOV BX, 0x07	; Params
    INT 0x10		; Appel a l'interruption 0x10
    JMP .ps_start
.ps_end:
    POP BX
    POP AX
    RET
;-----------------------------------------------------


;----------------------- NOPs ------------------------
TIMES 510-($-$$) DB 144	; NOP jusqu'a 510
DW 0xAA55
