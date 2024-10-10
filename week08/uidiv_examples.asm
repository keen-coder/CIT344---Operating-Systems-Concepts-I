; Keenan Knaur, CIT-344
; This file shows examples of how to use the 'div' instruction for unsigned
; division.

; REMEMBER!: the dividend must be larger size than the divisior and split between 
;            A and D registers.

; NOTE: Based on examples from Ed Jorgensen's Book "x86-64 Assembly Language
; Programming with Ubuntu"

; Compile -> Link -> Execute Commands
; assembler command:    yasm -felf64 -gdwarf2 uidiv_examples.asm -l uidiv_examples.lst
; linker command:       ld -g -o uidiv_examples uidiv_examples.o
; execute command:      ./uidiv_examples


; +-------------------------------------------------------------
; | 64-bits | 32-bits | 16-bits | upper 8-bits | lower 8-bits  |
; |         |         |         |    of ax     |    of ax      |
; +------------------------------------------------------------+ 
; |   rax   |   eax   |   ax    |      ah      |      al       |
; +------------------------------------------------------------+



section .data ;=================================================================

; Constants for program exit
EXIT_SUCCESS   equ   0    ; successful program execution
SYS_exit       equ   60   ; call code for termination

; Variables defined for examples
bNumA    db 63
bNumB    db 17
bNumC    db 5
bAns1    db 0
bAns2    db 0
bRem2    db 0
bAns3    db 0

wNumA    dw 4321
wNumB    dw 1234
wNumC    dw 167
wAns1    dw 0
wAns2    dw 0
wRem2    dw 0
wAns3    dw 0


;================================================================================

; section .bss omitted

section .text ;=================================================================

global _start

_start:
   
   
   ; 
   
   ; wAns3 = (wNumA * wNumC) / wNumB     ; unsigned


   ; EXAMPLES 01 ~ 03 demonstrate byte operands

   ; EXAMPLE 01: bAns1 = bNumA / 3 (unsigned)
   mov   al, byte [bNumA]     ; move 63 from memory into al register
                              ; this is the lower order portion of the dividend
   
   mov   ah, 0                ; move 0 into the ah register
                              ; this is the upper order portion of the dividend
                              ; we just set it to be 0 since we are doing unsigned division
   
   mov   bl, 3                ; move 3 into the bl register for the divisor
                              ; we do this because the divisor cannot be an immediate value
   
   div   bl                   ; al = ax / 3
                              ; divide ax by 3 and store the value in al
   
   mov   byte [bAns1], al     ; store the result back into memory


   ; EXAMPLE 02: 
   ;     bAns2 = bNumA / bNumB (unsigned)
   ;     bRem2 = bNumA % bNumB
   mov   ax, 0                ; zero out the ax register, another way to set all 0s
                              ; to the upper portion of ax.  this is the same as
                              ; mov  ah, 0
   
   mov   al, byte [bNumA]     ; mov 63 into the lower portion of ax (al)
   
   div   byte [bNumB]         ; al = ax / bNumB
                              ; divide ax by bNumB, store the result in al, and the
                              ; remainder in ah

   mov   byte [bAns2], al     
   mov   byte [bRem2], ah     ; ah = ax % bNumB

   
   ; EXAMPLE 03: bAns3 = (bNumA * bNumC) / bNumB (unsigned)
   mov   al, byte [bNumA]
   mul   byte [bNumC]         ; result in ax

   ; NOTE: the previous multiplication already puts the result in the correct registers
   ; ax in this case

   div   byte [bNumB]         ; al = ax / bNumB
   mov   byte [bAns3], al

   

   ; Examples 04 ~ 06 demonstrate word or 16-bit operands
   ; for these examples we need to set the upper portion of the D register to 0
   ; or use the result of a prior multiplication operation to set the D register
   

   ; EXAMPLE 04: wAns1 = wNumA / 5 (unsigned)

   mov   ax, word [wNumA]     ; move 4321 into the ax register
   mov   dx, 0                ; zero out the dx register
   mov   bx, 5                ; move the immediate value 5 into the bx register
   div   bx                   ; ax = dx:ax / 5
   mov   word [wAns1], ax     ; the result is stored in ax, save it to memory


   ; EXAMPLE 05:
   ;     wAns2 = wNumA / wNumB (unsigned)
   ;     wRem2 = wNumA % wNumB 
   mov   dx, 0
   mov   ax, word [wNumA]
   div   word [wNumB]
   mov   word [wAns2], ax     ; save the result
   mov   word [wRem2], dx     ; save the remainder

   ; EXAMPLE 06: wAns3 = (wNumA * wNumC) / wNumB (unsigned)
   mov   ax, word [wNumA]
   mul   word [wNumC]
   
   ; NOTE: previous multiplication correctly sets the dx:ax registers

   div   word [wNumB]
   mov   word [wAns3], ax

exit:
   mov   rax, SYS_exit
   mov   rdi, EXIT_SUCCESS
   syscall
;===============================================================================