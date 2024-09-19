; Daniel Yoas
; First Program
; August 17, 2022

section .data
; Variables/Constants with known values go here.
; This data will be stored within the program and on the hard drive.

LF		EQU	10
NULL	EQU	0

msg         db    "Hello World!", LF, NULL
msglen      EQU   $-msg

section .bss
; Undefined varibles until process execution go here

section .text
global _start
_start:

print:
   mov  rax, 1
   mov  rdi, 1
	mov  rsi, msg
	mov  rdx, msglen
	syscall

exit:
	mov  rax, 60
	mov  rdi, 0
	syscall

