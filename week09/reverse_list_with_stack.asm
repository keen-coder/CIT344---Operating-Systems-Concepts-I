; Keenan Knaur, CIT-344
;-------------------------------------------------------------------------------

section .data ;-----------------------------------------------------------------

EXIT_SUCCESS   equ   0     ; successful program execution
SYS_exit       equ   60    ; call code for termination

numbers        dq    121, 122, 123, 124, 125
length         dq    5

;-------------------------------------------------------------------------------

section .text ;-----------------------------------------------------------------

global _start

_start:

   mov   rcx, qword [length]     ; load the size of the array into the C register
   mov   rbx, numbers         ; load the base address of the array into the B register
   mov   r12, 0               ; 0 out the r12 register
   mov   rax, 0               ; 0 out the A register

; loop and push all the values from the array onto the stack
pushLoop:
   push  qword [rbx+r12*8]    ; push the next value from the array onto the 
                              ; stack (8 is the size of each item in the array)
   inc   r12                  ; increment the r12 register (for the next array index)
   loop  pushLoop             ; loop

   ; AT THIS POINT all the numbers are on the stack (in reverse order)

   mov   rcx, qword [length]        ; load the size of the array into the C register
   mov   rbx, numbers            ; load the base address of the array into the B register
   mov   r12, 0                  ; 0 out the r12 register

; loop to pop all the values back out
popLoop:
   pop   rax                     ; pop the next value from the stack into the A register
   mov   qword [rbx+r12*8], rax  ; save the A register into the next index of the array
   inc   r12                     ; increment the array
   loop  popLoop

exit:
   mov   rax, SYS_exit
   mov   rdi, EXIT_SUCCESS
   syscall