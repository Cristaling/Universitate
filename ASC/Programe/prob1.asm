assume cs: code, ds: data
data segment
	msg db 'Introduceti numele fisierului: $'
	newLine db 10, 13, '$'
	maxFileName db 12
	readChars db ?
	fileName db 12 dup(?)
	fileHandle dw ?
	buffer db 100 dup(?)
	readBuffer dw ?
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
	
	repeta:
		mov ah, 3Fh
		mov bx, fileHandle
		mov cx, 100
		mov dx, offset buffer
		int 21h
		
		mov readBuffer, ax
		mov si, ax
		mov buffer[si], '$'
		
		mov ah, 09h
		mov dx, offset buffer
		int 21h
		
		mov ax, readBuffer
		cmp ax, 100
		je repeta
	
	mov ax, 4C00h
	int 21h
code ends
end start