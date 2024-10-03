; Keenan Knaur, CIT-344



section .data ;-----------------------------------------------------------------

%include "constants.asm"

strPrompt      db    "Enter a string: "
strPromptLen   equ   $-strPrompt

strInput       db    "                              "
strInputLen    equ   $-strInput

strResultText  db    "You printed: "
strResultLen   equ   $-strResultText

charsRead      db    0

;-------------------------------------------------------------------------------

section .text ;-----------------------------------------------------------------

global _start
_start:

   ; display prompt
   mov  rax, SYS_write
   mov  rdi, STDOUT
   mov  rsi, strPrompt
   mov  rdx, strPromptLen
   syscall

   ; read input
   ; instructions to read the string
   mov   rax, SYS_read
   mov   rdi, STDIN
   mov   rsi, strInput
   mov   rdx, strInputLen
   syscall

   mov  byte [charsRead], al

   mov  rax, SYS_write
   mov  rdi, STDOUT
   mov  rsi, strResultText
   mov  rdx, strResultLen
   syscall

   mov  rax, SYS_write
   mov  rdi, STDOUT
   mov  rsi, strInput
   mov  dl, byte [charsRead]
   syscall



last:
   mov   rax, SYS_exit
   mov   rdi, EXIT_SUCCESS
   syscall
;--------------------------------------------------------------------------------
