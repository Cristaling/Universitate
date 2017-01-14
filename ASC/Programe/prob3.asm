assume cs: code, ds: data
data segment
	fileName db 'out.txt$'
	sir dw '12', '34', '56'
	l EQU $ - sir
	fileHandle dw ?
	buffer db 100 dup(?)
data ends
code segment
start:
	mov ax, data
	mov ds, ax
	
	mov ah, 3Dh
	mov al, 1
	mov dx, offset fileName
	int 21h
	
	mov fileHandle, ax
	
	mov si, l
	mov di, 0
	
	repeta:
		dec si
		mov al, byte ptr sir + si
		dec si
		mov ah, byte ptr sir + si
		mov buffer[di], ah
		inc di
		mov buffer[di], al
		
		cmp si, 0
		je step
		inc di
		mov buffer[di], ','
		inc di
		mov buffer[di], ' '
		step:
		
		inc di
		cmp si, 0
		jne repeta
	
	mov buffer[di], '$'
	
	mov ah, 09h
	mov dx, offset buffer
	int 21h
	
	mov ax, 4C00h
	int 21h
code ends
end start