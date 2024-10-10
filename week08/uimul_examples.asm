; Keenan Knaur, CIT-344
; This file shows examples of how to use the 'mul' instruction for unsigned
; multiplication.

; REMEMBER!: one of the operands must be placed on the A register (rax, eax, ax, al), 
; REMEMBER!: The resulting bits may be split between the A and D registers for
;            any operands greater than a byte.

; NOTE: Based on examples from Ed Jorgensen's Book "x86-64 Assembly Language
; Programming with Ubuntu"

; Compile -> Link -> Execute Commands
; assembler command:    yasm -felf64 -gdwarf2 uimul_examples.asm -l uimul_examples.lst
; linker command:       ld -g -o uimul_examples uimul_examples.o
; execute command:      ./uimul_examples

section .data ;=================================================================

; Constants for program exit
EXIT_SUCCESS   equ   0    ; successful program execution
SYS_exit       equ   60   ; call code for termination

; Variables defined for examples
bNumA        db        42
bNumB        db        73
wSquared     dw        0
wAns1        dw        0

wNumA        dw        4321
wNumB        dw        1234
dAns2        dd        0

dNumA        dd        42000
dNumB        dd        73000
qAns3        dq        0

qNumA        dq        420000
qNumB        dq        730000
dqAns4       ddq       0


;================================================================================

; section .bss omitted

section .text ;=================================================================

global _start

_start:
   ; EXAMPLE 01: Perform a simple square of a value.---------------------------- 
   ; The result will be saved in the ax register.
   
   ; wSquared = bNumA * bNumA
   ; ax = al * <src>, result will be in the ax register
   mov   al, byte [bNumA]     ; move bNumA into al (since one of the operands must
                              ; be in the A register)
   mul   al                   ; multiply al by itself, result in ax register
   mov   word [wSquared], ax  ; save the result into memory
   ;----------------------------------------------------------------------------

   ; EXAMPLE 02: 8-bit Multiplication-------------------------------------------
   ; The operands are 8-bit values, the result will be stored in ax register.

   ; wAns1 = bNumA * bNumB 
   mov     al, byte [bNumA] 
   mul     byte [bNumB]
   mov     word [wAns1], ax
   ;----------------------------------------------------------------------------

   ; EXAMPLE 03: 16-bit Multiplication------------------------------------------
   ; Both operands are 16-bit values, the result will be split between the A and
   ; D registers.  The upper 16-bits of the result will be in D, the lower 16-bits
   ; in A. 

   ; dAns2 = wNumA * wNumB 
   mov     ax, word [wNumA]         ; store wNumA in ax
   mul     word [wNumB]             ; multiply wNumB by ax, store result in ax and dx
   mov     word [dAns2], ax         ; save ax to memory
   mov     word [dAns2+2], dx       ; save dx to memory, NOTE the +2 next to the
                                    ; variable name.  This will add 2 to the memory
                                    ; address so the bits from dx will be placed
                                    ; in the correct order when combined with ax.
                                    ; The process is similar for the remaining examples.
   ;---------------------------------------------------------------------------- 
   
   ; EXAMPLE 03: 32-bit Multiplication------------------------------------------
   
   ; qAns3 = dNumA * dNumB
   mov     eax, dword [dNumA] 
   mul     dword [dNumB]             
   mov     dword [qAns3], eax 
   mov     dword [qAns3+4], edx
   ;---------------------------------------------------------------------------- 
   
   ; EXAMPLE 04: 64-bit Multiplication------------------------------------------

   ; dqAns4 = qNumA * qNumB
   mov     rax, qword [qNumA] 
   mul     qword [qNumB]          
   mov     qword [dqAns4], rax 
   mov     qword [dqAns4+8], rdx
   ;----------------------------------------------------------------------------

exit:
   mov   rax, SYS_exit
   mov   rdi, EXIT_SUCCESS
   syscall
;===============================================================================