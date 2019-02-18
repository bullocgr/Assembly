TITLE Program Template     (template.asm)
; Author: Grace Bullock
; CS271 / Project 4              Date: 2-17-19
; Description:

INCLUDE Irvine32.inc

.const
LOWERLIMIT = 1
UPPERLIMIT = 400


.data

intro1			BYTE	"Composite Numbers", 0
programBy		BYTE	"By: Grace Bullock", 0

instructions	BYTE	"Enter the number of composite numbers you want to see [1-400]: ", 0
goodbye			BYTE	"Results certified by Grace Bullock. Goodbye.", 0

userInput		DWORD	?
currentNum		DWORD	6

.code

main PROC

	call	introduction
	call	getNum
	call	printComp
	call	peaceOut

exit  ; exit to operating system

main ENDP

introduction	PROC

	mov		edx, OFFSET intro1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET programBy
	call	WriteString
	call	CrLf
	ret

introduction	ENDP

getNum		PROC
	
	mov		edx, OFFSET instructions
	call	WriteString
	mov		eax, userInput
	call	ReadInt
	mov		userInput, eax
	call	WriteInt
	call	CrLf
	call	validate
	ret

getNum		ENDP

validate	PROC
	
	mov		eax, userInput
	cmp		eax, LOWERLIMIT
	jl		error
	mov		eax, userInput
	cmp		eax, UPPERLIMIT
	jg		error
	jmp		return

	error:
	call	getNum
	jmp		return

	return:
	ret

validate	ENDP

printComp		PROC

	mov		eax, 4		;base case
	call	WriteInt

	sub		userInput, 1
	mov		ecx, userInput		;need to subtract the base case
	;ecx is the one that decrements

	printLoop:
	call	CrLf
	call	isComposite
	mov		eax, currentNum
	call	WriteInt
	inc		currentNum			;increment this to calculate for the next composite
	loop	printLoop

	ret

printComp		ENDP

isComposite		PROC

	checkComposite:
	mov		eax, currentNum
	cdq	
	mov		ebx, 2
	div		ebx
	cmp		edx, 0
	je		good

	mov		eax, currentNum
	cdq	
	mov		ebx, 3
	div		ebx
	cmp		edx, 0
	je		good

	mov		eax, currentNum
	cdq
	mov		ebx, 5
	div		ebx
	cmp		edx, 0
	je		good

	jmp		bad

	good:
	ret

	bad:
	inc		currentNum
	jmp		checkComposite

isComposite		ENDP

peaceOut	PROC

	call	CrLf
	mov		edx, OFFSET goodbye
	call	WriteString
	call	CrLf
	ret

peaceOut	ENDP

END main

