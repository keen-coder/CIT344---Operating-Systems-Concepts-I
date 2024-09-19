; Author:   .
; Purpose:  .
; Date:     .

section .data
; Static declarations are saved to disk and initialized at process start

LF    EQU    10
NULL  EQU    0

ExitStatement     db    "Program Completed Successfully!", LF, NULL
ExitStatementLen  EQU   $-ExitStatement

Prompt            db "Please type in a word: ", NULL
PromptLen         EQU   $-Prompt

Response          db "You Typed ", NULL
ResponseLen       EQU   $-Response

Input             db "                ", NULL
InputLen          EQU   $-Input
InputSize         dq 0

section .bss
; Undefined varibles until process execution go here

section .text
global _start
_start:

   mov   rcx, 3

next:
   push  rcx

   mov   rax, 1
   mov   rdi, 1
   mov   rsi, Prompt
   mov   rdx, PromptLen
   syscall

   mov   rax, 0
   mov   rdi, 0
   mov   rsi, Input
   mov   rdx, InputLen
   syscall
   mov   qword [InputSize], rax

   mov   rax, 1
   mov   rdi, 1
   mov   rsi, Response
   mov   rdx, ResponseLen
   syscall

   mov   rax, 1
   mov   rdi, 1
   mov   rsi, Input
   mov   rdx, qword [InputSize]
   syscall

   pop   rcx
   dec   rcx
   jnz   next

exit:
   mov   rax, 1
   mov   rdi, 1
   mov   rsi, ExitStatement
   mov   rdx, ExitStatementLen
   syscall           ; Print out an exit statement

   mov   rax, 60
   mov   rdi, 0
   syscall           ; Terminate process

