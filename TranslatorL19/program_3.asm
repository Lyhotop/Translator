include masm64\include64\masm64rt.inc
printf proto
scanf proto
_getch proto

.data
	a	dq	00h
	b	dq	00h
	x	dq	00h
	i	dq	00h
	j	dq	00h
	buf	dq	0

.code
mainCRTStartup proc
sub rsp, 28h
	invoke printf, cfm$("Input a: ")
	invoke scanf, "%lld", addr a
	mov r8, a
	cmp r8, 32768
	jge __end200
	cmp r8, -32768
	jl __end200
	invoke printf, cfm$("Input b: ")
	invoke scanf, "%lld", addr b
	mov r8, b
	cmp r8, 32768
	jge __end200
	cmp r8, -32768
	jl __end200
	mov r8, a
mov i, r8
mITKA1:
	mov r8, i
	mov r9, b
	cmp r8, r9
	setl r9b
	and r9, 255
	mov r8, r9
mov buf, r8
	cmp qword ptr buf, 0
	jz __end1
	mov r8, i
	mov r9, i
	imul r8, r9
mov x, r8
	mov r8, x
mov buf, r8
	mov r8, buf
	cmp r8, 32768
	jge __end201
	cmp r8, -32768
	jl __end201
	invoke printf, " %lld", buf
	invoke printf, cfm$("\n")
	mov r8, i
	mov r9, 1
	add r8, r9
mov i, r8
	jmp mITKA1
__end1:
	mov r8, 0
mov x, r8
	mov r8, 1
mov i, r8
	mov r8, 1
mov j, r8
mITKA2:
	mov r8, i
	mov r9, a
	cmp r8, r9
	setl r9b
	and r9, 255
	mov r8, r9
mov buf, r8
	cmp qword ptr buf, 0
	jz __end4
	mov r8, 1
mov j, r8
mITKA3:
	mov r8, j
	mov r9, b
	cmp r8, r9
	setl r9b
	and r9, 255
	mov r8, r9
mov buf, r8
	cmp qword ptr buf, 0
	jz __end5
	mov r8, x
	mov r9, 1
	add r8, r9
mov x, r8
	mov r8, j
	mov r9, 1
	add r8, r9
mov j, r8
	jmp mITKA3
__end5:
	mov r8, i
	mov r9, 1
	add r8, r9
mov i, r8
	jmp mITKA2
__end4:
	invoke printf, cfm$("x: ")
	mov r8, x
mov buf, r8
	mov r8, buf
	cmp r8, 32768
	jge __end201
	cmp r8, -32768
	jl __end201
	invoke printf, " %lld", buf
	jmp __end
	__end200:
	invoke printf, cfm$("\nVariable that doesn't belong to the Integer16\n") 
 	jmp __end
	__end201:
	invoke printf, cfm$("\nPut var that doesn't belong to the Integer16\n") 
 	__end:
invoke _getch
invoke ExitProcess, 0
add rsp, 28h
mainCRTStartup endp
end
