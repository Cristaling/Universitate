assume cs: code, ds: data
data segment
	maxBufferRead db 12
	readChars db ?
	fileName db 12 dup(?)
	fileHandle dw ?
	buffer1 db 100 dup(?)
	buffer2 db 100 dup(?)
	liniePara db 0
data ends
code segment
start:
	mov ax, data
	mov ds, ax
	
	mov ah, 0Ah
	mov dx, offset maxBufferRead
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
	
	repeta:
		mov ah, 3Fh
		mov bx, fileHandle
		mov cx, 99
		mov dx, offset buffer1
		int 21h
		
		mov readChars, al
		
		mov si, 0
		mov di, 0
		
		repeta2:
			mov al, buffer1[si]
			cmp al, 10
			je lineChg
			mov cl, liniePara
			cmp cl, 1
			jne step
			mov buffer2[di], al
			inc di
			step:
			jmp step2
			lineChg:
				mov cl, liniePara
				cmp cl, 1
				je step3
					mov liniePara, 1
					jmp step2
				step3:
					mov liniePara, 0
					mov buffer2[di], 10
					inc di
					mov buffer2[di], 13
					inc di
			step2:
			inc si
			mov cl, readChars
			xor ch, ch
			cmp si, cx
		jne repeta2
		
		mov buffer2[di], '$'
		
		mov ah, 09h
		mov dx, offset buffer2
		int 21h
		
		mov cl, readChars
		cmp cl, 99
	je repeta
	
	mov ax, 4C00h
	int 21h
code ends
end start