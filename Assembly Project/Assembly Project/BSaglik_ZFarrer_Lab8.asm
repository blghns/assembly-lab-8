;(BSaglik_ZFarrer_Lab8.asm)
TITLE Bilgehan and Zach Farrer LAB 8
INCLUDE Irvine32.inc
INCLUDE Macros.inc
BufSize = 80

.data

	key BYTE 6, 4, 1, 2, 7, 5, 2, 4, 3, 6
	myText BYTE "This text is going to be encrypted.", 0

	buffer BYTE BufSize DUP(?),0,0
	stdInHandle HANDLE ?
	bytesRead DWORD ?

.code
main PROC
	;Pass the pointer to the text string in EDX,
	MOV EDX, OFFSET myText
	
	;the array size to ECX
	MOV ECX, SIZEOF myText
	
	;pointer to the key array in ESI,	
	MOV ESI, OFFSET key

	;the direction value (0 or 1) in EBX
	MOV EBX, 0 ; rotate left for encryption

	call WriteString
	call Crlf

	call encDecText

	call WriteString
	call Crlf

	MOV EBX, 1
	call encDecText

	call WriteString
	call Crlf

	;bonus - get string from console and encrypt
	mWriteln "Write a text to be encrypted."
	; Get handle to standard input
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov stdInHandle,eax
	; Wait for user input
	INVOKE ReadConsole, stdInHandle, ADDR buffer,
	BufSize, ADDR bytesRead, 0

	;encrypt and output to console
	MOV EDX, OFFSET buffer
	MOV ECX, BufSize
	MOV EBX, 0
	call encDecText
	call WriteString
	call Crlf

	;decrypt and output to console
	MOV EBX, 1
	call encDecText
	call WriteString

	INVOKE ExitProcess,0 ; end the program
main ENDP

encDecText PROC
	;Receives EDX - OFFSET of the text
	;         ECX - SIZE of the text
	;         ESI - OFFSET of the key
	;         EBX - rotation direction 0 for left 1 for right

	PUSHAD

	CMP EBX, 0
	JE equals
		MOV EBX, ESI
		ADD EBX, 9 ;the length of key
		loopNotEquals:

		MOV AL, [EDX] ; value of the text
		PUSH ECX
		MOV CL, [ESI] ; value of the key
		ROR AL, CL    ; ror the text by the key
		MOV [EDX], AL
		POP ECX

		CMP ESI, EBX ; if all the keys are used, reset the offset so it uses the beginning
		JE reset1
		
		INC ESI
		
		JMP endReset1
		reset1:
		SUB ESI, 9
		endReset1:
		
		INC EDX
		loop loopNotEquals

		mWriteln "Input decrypted."
	JMP endCMP
	equals:
		MOV EBX, ESI
		ADD EBX, 9 ; the length of key
		loopEquals:

		MOV AL, [EDX] ; value of the text
		PUSH ECX
		MOV CL, [ESI] ; value of the key
		ROL AL, CL    ; rol the text by the key
		MOV [EDX], AL
		POP ECX

		CMP ESI, EBX ; if all the keys are used, reset the offset so it uses the beginning
		JE reset2
		INC ESI
		
		JMP endReset2
		reset2:
		SUB ESI, 9
		endReset2:

		INC EDX
		loop loopEquals
		mWriteln "Input encrypted."
	endCMP:

	POPAD
	RET
encDecText ENDP
END main