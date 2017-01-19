assume cs: code, ds: data
data segment
	maxBufferRead db 12
	readChars db ?
	fileName db 12 dup(?)
	
	maxBufferRead2 db 12
	dimCuvant db ?
	cuvant db 12 dup(?)
	
	fileHandle dw ?
	newLine db 10, 13, '$'
	
	buffer db 2 dup(?)
	index dw 0
	
	msg1 db 'Am gasit cuvantul$'
	msg2 db 'Nu am gasit cuvantul$'
data ends
code segment
start:
	mov ax, data
	mov ds, ax
	
	mov ah, 0Ah
	mov dx, offset maxBufferRead
	int 21h
	
	mov ah, 09h
	mov dx, offset newLine
	int 21h
	
	mov cl, readChars
	xor ch, ch
	mov si, cx
	mov fileName[si], '$'
	
	mov ah, 3Dh
	mov al, 0
	mov dx, offset fileName
	int 21h
	
	mov fileHandle, ax
	
	mov ah, 0Ah
	mov dx, offset maxBufferRead2
	int 21h
	
	mov ah, 09h
	mov dx, offset newLine
	int 21h
	
	repeta:
		mov ah, 3Fh
		mov bx, fileHandle
		mov cx, 1
		mov dx, offset buffer
		int 21h
		
		mov readChars, al
		
		mov si, index
		mov al, buffer
		cmp al, cuvant[si]
		jne step
			inc si
			mov index, si
			jmp step2
		step:
			mov index, 0
		step2:
		mov si, index
		mov al, dimCuvant
		xor ah, ah
		cmp si, ax
		je gasit
		
		mov al, readChars
		cmp al, 1
	je repeta
	
	mov ah, 09h
	mov dx, offset msg2
	int 21h
	
	jmp step3
	gasit:
		mov ah, 09h
		mov dx, offset msg1
		int 21h
	step3:
		
	mov ax, 4C00h
	int 21h
code ends
end start








