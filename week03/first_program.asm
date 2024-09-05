; Keenan Knaur, CIT-344
; First Program
; Demonstrates some basics of assembly programming.  

; assembler command:    yasm -felf64 -gdwarf2 first_program.asm -l first_program.lst
; linker command:       ld -g -o first_program first_program.o
; execute command:      ./first_program


section .data ;-----------------------------------------------------------------
; Define any constants or variables with known values here
; constant syntax = <CONSTANT_NAME> equ <value>
; variable syntax = <variableName> <data_type> <value>

; Constant definitions
NUM_CATS       equ   8
COLOR          equ   "blue"
LF             equ   10       ; LineFeed / newline character
NULL           equ   0        ; NULL character, required to terminate a string.
EXIT_SUCCESS   equ   0        ; successful program execution
SYS_exit       equ   60       ; call code for termination

; Variable definitions (these already have values)
pi       dd    3.14159
msg      db    "Hello World", LF, NULL
myArray  dd    100, 200, 300
total    dw    1428
bVar1    db    42
bVar2    db    13
bResult  db    0
;-------------------------------------------------------------------------------

section .bss ;------------------------------------------------------------------
; Define any uninitialized variables here.
; variable syntax = <variableName> <resType> <count>

bNames    resb    20    ; declare a 20 element byte array
wArr      resw    50    ; declare a 50 element word array
dScores   resd    30    ; declare a 30 element double array
qArr      resq    200   ; declare a 200 element quad array
dqArr     resdq   500   ; delcare a 500 element doublw quad array
;-------------------------------------------------------------------------------

section .text ;-----------------------------------------------------------------
global _start
_start:

	; Summing the values of bVar1 and bVar2
	; bResult = bVar1 + bVar2

	mov   al, byte [bVar1]
	add   al, byte [bVar2]
	mov   byte [bResult], al

last:
	mov   rax, SYS_exit
	mov   rdi, EXIT_SUCCESS
	syscall
;--------------------------------------------------------------------------------