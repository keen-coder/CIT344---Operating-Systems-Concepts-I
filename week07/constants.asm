; Constants for program exit
EXIT_SUCCESS   equ   0    ; successful program execution
SYS_exit       equ   60   ; call code for termination

; Constants for output
STDOUT         equ   1  ; The standard output code (1 is for the console)
SYS_write      equ   1  ; Call code for the write system service

; Constants for input
STDIN          equ   0  ; Standard input code (0 for keyboard)
SYS_read       equ   0  ; Call code for the read system service 

; String Constants
LF             equ   10
NULL           equ   0