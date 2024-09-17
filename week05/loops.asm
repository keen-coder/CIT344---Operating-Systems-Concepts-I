; Author:	Daniel Yoas
; Program:	Work with Loops and dynamic memory
; Date: 	09/13

LF: 		EQU	0x0A
NULL: 		EQU	0x00

WORDLEN:	EQU	16
NUMWORDS:	EQU	5

section .data
initMsg:	db	"You will be asked to enter five (5) words:", LF, NULL
initMsgLen:	EQU	$-initMsg
prompt:		db	"Enter a word: ", NULL
promptLen:	EQU	$-prompt
resultMsg:	db	"The words you provided are:", LF, NULL
resultMsgLen:	EQU	$-resultMsg


exitstr:	db	"Program Completed Successfully", LF, NULL
exitstrlen:	EQU	$-exitstr

section .bss

; Declare multiple buffers for words and a parallel array to store the siazes read
words:		resb	WORDLEN * NUMWORDS
wordsLens:	resq	NUMWORDS
wordAddr:	resq	1
lenAddr:	resq	1

section .text
global _start

;************************************************************
;  bool ReadString(char *str, quad size, quad *chread) 
;     rdi = buffer address, rsi = buffer size, rdx = size read address
;***********************************************************
ReadString:
	push	rdx

	mov	rdx, rsi
	mov	rsi, rdi
	mov	rax, 0
	mov	rdi, 0
	syscall

	pop	rdx		; Retrieve the read size address
	mov	[rdx], rax	; Save the bytes read
	ret

;************************************************************

;************************************************************
; null printString(char *str, quad size)
;	rdi = string address, rsi = size of the string
;************************************************************
PrintString:

	mov	rdx, rsi
	mov	rsi, rdi
	mov	rax, 1
	mov	rdi, 1
	syscall

	ret
;***********************************************************

_start:
	mov	rdi, initMsg
	mov	rsi, initMsgLen
	call	PrintString

	mov	rcx, 0
	mov	r10, words
	mov	r11, wordsLens
readLoop:
	push	rcx
	mov	[wordAddr], r10
	mov	[lenAddr], r11

	mov	rdi, prompt
	mov	rsi, promptLen
	call 	PrintString

	mov	rdi, [wordAddr]
	mov	rsi, WORDLEN
	mov	rdx, [lenAddr]
	call	ReadString

	mov	r10, [wordAddr]	; move to the next word in the array
	add	r10, WORDLEN
	mov	r11, [lenAddr]	; move to the next length in the paired array
	add	r11, 8

	pop	rcx
	inc	rcx
	cmp	rcx, NUMWORDS
	jl	readLoop
readNext:

;**********************************************************************
;  Print out the words collected
;**********************************************************************

	mov	rdi, resultMsg
	mov	rsi, resultMsgLen
	call	PrintString

	mov	rcx, 0
	mov	r10, words
	mov	r11, wordsLens
printLoop:

	push	rcx
	mov	[wordAddr], r10
	mov	[lenAddr], r11		; Save the values so they aren't lost

	mov	rdi, r10		; The FOR loop walks the paired array
	mov	rsi, [r11]
	call	PrintString

	mov	r10, [wordAddr]
	add	r10, WORDLEN		; move to next string in the array
	mov	r11, [lenAddr]
	add	r11, 8			; move to next quad number

	pop	rcx
	inc	rcx			; Add 1 to the loop count
	cmp	rcx, NUMWORDS		; check to see if above the max
	jl	printLoop		; Repeat the for loop
printNext:

exit:

	mov	rdi, exitstr
	mov	rsi, exitstrlen
	call	PrintString

	mov	rax, 60
	mov	rdi, 0
	syscall
