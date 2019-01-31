TITLE Program Template     (template.asm)
; Author: Grace Bullock
; CS271 / Project 2                 Date: 1-20-19
; Description: Take in the player's name through string input
; Take input from the user and the number must be 1-46
; Loop through n times and print the Fibonacci sequence
; then close the program

INCLUDE Irvine32.inc

MAXSIZE	=	100
upperLimit = 47
lowerLimit = 0

.data

numTerms	DWORD		?			;user input for number
b			DWORD		1			;This will be where we store the numbers to print
fib			DWORD		0			;fib sequence
intro1		BYTE		"Fibonacci Sequence",0
intro2		BYTE		"Program by: Grace Bullock",0
userName	BYTE		33 dup(0)	;this will hold the name of the user
welcome		BYTE		"Please enter your name: ",0
greet		BYTE		"Hello, ",0
rules1		BYTE		"Enter a number between 1-46: ",0
rules2		BYTE		"The fibonacci sequence up to your number is: ",0
outro		BYTE		"Results certified by Grace Bullock",0
outro2		BYTE		"Goodbye, ",0

.code
main PROC

;This is the welcome function that will intake and print out the string
Intro:
	mov		edx, OFFSET intro1		;print out the intro1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET intro2		;print out the intro 2
	call	WriteString
	Call	CrLf

;get the user name
	mov		edx, OFFSET welcome		
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, 32					;this sets the limit of the name to be 32
	call	ReadString				;read it in
	call	CrLf
	mov		edx, OFFSET greet
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf
	
instructions:
	mov		edx, OFFSET rules1
	call	WriteString
	call	ReadInt

;get the number of loops
	mov		numTerms, eax			;numTerms is the number they input
	mov		eax, numTerms
	cmp		eax, upperLimit			;compare the upper limit
	JG		instructions			;if it is in things keep going
	cmp		eax, lowerLimit		
	JL		instructions
	call	CrLf

;printing the numbers
	mov		ebx, 1
	mov		edx, 0
	mov		ecx, numTerms

fLoop:
	mov		eax, ebx
	add		eax, edx
	mov		ebx, edx
	call	WriteDec
	call	CrLf
	mov		edx, eax
	loop	fLoop

callOutro:
	mov		edx, OFFSET outro
	call	WriteString
	call	CrLf
	mov		edx, OFFSET outro2
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString

	
	
exit  ; exit to operating system

main ENDP

; (insert additional procedures here)

END main

