assume cs: code, ds: data
data segment
	zi db 3
	luna db 2
	an dw 1998
	czi db ?
	cluna db ?
	can dw ?
	varsta dw ?
	fileName db 'out.txt$'
	fileHandle dw ?
	buffer db 100 dup(?)
data ends
code segment
start:
	mov ax, data
	mov ds, ax
	
	mov ah, 2Ah
	int 21h
	
	mov czi, dl
	mov cluna, dh
	mov can, cx
	
	mov ax, can
	sub ax, an
	
	mov cl, cluna
	cmp cl, luna
	jl subStep
	jg step
	mov cl, czi
	cmp cl, zi
	jl subStep
	jmp step
		
	subStep:
		sub ax, 1
	step:
	
	mov varsta, ax
	
	mov ah, 3Dh
	mov al, 1
	mov dx, offset fileName
	int 21h
	
	mov fileHandle, ax
	
	mov ax, varsta
	mov bx, 10
	mov cx, 0
	
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
		add al, '0'
		mov buffer[di], al
		inc di
	loop repeta2
	
	mov ah, 40h
	mov bx, fileHandle
	mov cx, di
	mov dx, offset buffer
	int 21h
	
	mov ax, 4C00h
	int 21h
code ends
end start