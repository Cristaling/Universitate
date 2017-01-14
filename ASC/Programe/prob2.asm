assume cs: code, ds: data
data segment
	msg db 'Introduceti numele fisierului: $'
	newLine db 10, 13, '$'
	maxFileName db 12
	readChars db ?
	fileName db 12 dup(?)
	fileHandle dw ?
	buffer db 10 dup(?)
	readBuffer dw ?
	myNumber dw ?
data ends
code segment
start:
	mov ax, data
	mov ds, ax
	
	mov ah, 09h
	mov dx, offset msg
	int 21h
	
	mov ah, 0Ah
	mov dx, offset maxFileName
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
	
	mov ah, 3Fh
	mov bx, fileHandle
	mov cx, 10
	mov dx, offset buffer
	int 21h
	
	mov readBuffer, ax
	
	mov si, 0
	mov ax, 0
	mov cx, 10
	
	repeta:
		mov bl, buffer[si]
		mul cx
		sub bl, '0'
		xor bh, bh
		add ax, bx
		inc si
		cmp si, readBuffer
		jne repeta
	
	mov myNumber, ax
	
	mov cx, 16
	mov si, 0
	
	repeta2:
		xor dx, dx
		div cx
		cmp dl, 10
		jb cif
			add dl, 'A'
			sub dl, 10
			jmp step
		cif:
			add dl, '0'
		step:
		mov buffer[si], dl
		cmp ax, 0
		je step2
		inc si
		jmp repeta2
	
	step2:
	
	repeta3:
		mov ah, 02h
		mov dl, buffer[si]
		int 21h
		cmp si, 0
		je step3
		dec si
		jmp repeta3
	
	step3:
	
	mov ax, 4C00h
	int 21h
code ends
end start