assume cs: code, ds: data
data segment
	fileName db 'out.txt$'
	fileHandle dw ?
	buffer db 100 dup(?)
	myNumber dw 1234
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
	
	mov ax, myNumber
	
	mov cx, 0
	mov bx, 10
	
	repeta:
		xor dx, dx
		div bx
		push dx
		inc cx
		cmp ax, 0
		jne repeta
		
	mov di, 0
		
	repeta2:
		pop ax
		add ax, '0'
		mov buffer[di], al
		inc di
	loop repeta2
	
	mov buffer[di], ','
	inc di
	mov buffer[di], ' '
	inc di
	
	mov cx, 0
	mov bx, 16
	mov ax, myNumber
	
	repeta3:
		xor dx, dx
		div bx
		cmp dl, 10
		jb cif
			add dl, 'A'
			sub dl, 10
			jmp step
		cif:
			add dl, '0'
		step:
		push dx
		inc cx
		cmp ax, 0
		jne repeta3
	
	repeta4:
		pop ax
		mov buffer[di], al
		inc di
	loop repeta4
	
	mov ah, 40h
	mov bx, fileHandle
	mov cx, di
	mov dx, offset buffer
	int 21h
	
	mov ax, 4C00h
	int 21h
code ends
end start