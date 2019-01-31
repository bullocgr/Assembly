TITLE Program Template     (template.asm)
; Author: Grace Bullock
; CS271 / Project 3            Date: 1-27-19
; Description: 

INCLUDE Irvine32.inc


.const

LOWER_LIMIT		EQU		-100
UPPER_LIMIT		EQU		-1
;this is to make it easier and to be inclusive when checking the data

.data

programName		BYTE	"Negative Number Play",0
myName			BYTE	"By: Grace Bullock",0
userName		BYTE	"Please enter your name: ",0
inputName		BYTE	33 dup(0)
greetUser		BYTE	"Hello, ",0
getNumber		BYTE	"Please enter a number between -100 and -1 (inclusive): ",0
noInput			BYTE	"You didn't enter any valid numbers!",0
printSum		BYTE	"The sum of your numbers is: ",0
printAvg		BYTE	"The rounded average of your values is: ",0
closing			BYTE	"Thanks for playing, ",0
validInputs		BYTE	"You entered this many valid numbers: ",0
inputNumber		SDWORD	LOWER_LIMIT
numInputs		DWORD	0
sumInputs		SDWORD	0



.code

main PROC

intro:
;this will print out the program name and print out the coder's name (aka my name)
	mov		edx, OFFSET programName
	call	WriteString
	call	CrLf
	mov		edx, OFFSET myName
	call	WriteString
	call	CrLf

;this will get the user's name and print it to the screen
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET inputName
	mov		ecx, 32
	call	ReadString
	call	CrLf
	mov		edx, OFFSET greetUser
	call	WriteString
	mov		edx, OFFSET inputName
	call	WriteString
	call	CrLf

getInput:
;right now this will only take in one number to see if the number is correct
	mov		edx, OFFSET getNumber
	call	WriteString
	mov		eax, numInputs
	mov		edx, inputNumber
	call	ReadInt
	mov		inputNumber, eax

	
checkInput:
;this will check to see if the user's numbers are in range of (-100 and -1)
	cmp		eax, LOWER_LIMIT
	jl		getInput
	cmp		eax, UPPER_LIMIT
	jg		print
	inc		numInputs

addFunction:
;this adds then gets the next input
	add		sumInputs, eax
	jmp		getInput

print:
;this will print all the information
	cmp		numInputs, 0		;check to see if numInputs is equal to 0
	jne		printCalculations
	mov		edx, OFFSET noInput
	call	WriteString
	call	CrLf
	jmp		closingFunction

printCalculations:
;this will print out the number of valid inputs
	mov		edx, OFFSET validInputs
	call	WriteString
	mov		eax, numInputs
	call	WriteInt
	call	CrLf

;this will print out everything that was calculated if there were valid inputs
	mov		edx, OFFSET printSum
	call	WriteString
	mov		eax, sumInputs
	call	WriteInt
	call	CrLf

;this will get the average of all the values
	mov		eax, sumInputs
	cdq
	idiv	numInputs
	
	mov		edx, OFFSET printAvg
	call	WriteString
	call	WriteInt
	call	CrLf

closingFunction:
;this is what the player will see when they are done
	mov		edx, OFFSET closing
	call	WriteString
	mov		edx, OFFSET inputName
	call	WriteString

exit  ; exit to operating system

main ENDP

; (insert additional procedures here)

END main

