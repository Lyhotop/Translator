include masm64\include64\masm64rt.inc
printf proto
scanf proto
_getch proto

.data
	a	dq	00h
	b	dq	00h
	rESULT	dq	00h
	x	dq	00h
	y	dq	00h
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
	jmp __end200
	__end201:
	invoke printf, " %lld", buf
	jmp __end201
	invoke printf, cfm$("Input b: ")
	invoke scanf, "%lld", addr b
	mov r8, b
	cmp r8, 32768
	jge __end2
	cmp r8, -32768
	jl __end2
	jmp __end2
	__end3:
	invoke printf, " %lld", buf
	jmp __end3
	mov r8, a
	mov r9, b
	add r8, r9
mov rESULT, r8
	invoke printf, cfm$("a + b = ")
	mov r8, rESULT
mov buf, r8
	invoke printf, " %lld", buf
	invoke printf, cfm$("\n")
	mov r8, a
	mov r9, b
	sub r8, r9
mov rESULT, r8
	invoke printf, cfm$("a -- b = ")
	mov r8, rESULT
mov buf, r8
	invoke printf, " %lld", buf
	invoke printf, cfm$("\n")
	mov r8, a
	mov r9, b
	xor rdx, rdx
	mov rax, r8
	test r9 , r9
	jz __DivZero
	idiv r9
	mov r8, rax
mov rESULT, r8
	invoke printf, cfm$("a Div b = ")
	mov r8, rESULT
mov buf, r8
	invoke printf, " %lld", buf
	invoke printf, cfm$("\n")
	mov r8, a
	mov r9, b
	xor rdx, rdx
	mov rax, r8
	test r9 , r9
	jz __DivZero
	div r9
	mov r8, rdx
mov rESULT, r8
	invoke printf, cfm$("a Mod b = ")
	mov r8, rESULT
mov buf, r8
	invoke printf, " %lld", buf
	invoke printf, cfm$("\n")
	mov r8, a
	mov r9, b
	sub r8, r9
	mov r9, 10
	imul r8, r9
	mov r9, a
	mov r10, b
	add r9, r10
	mov r10, 10
	xor rdx, rdx
	mov rax, r9
	test r10 , r10
	jz __DivZero
	idiv r10
	mov r9, rax
	add r8, r9
mov x, r8
	invoke printf, cfm$("x = (a - b) * 10 + (a + b) / 10 = ")
	mov r8, x
mov buf, r8
	invoke printf, " %lld", buf
	invoke printf, cfm$("\n")
	mov r8, x
	mov r9, x
	mov r10, 10
	xor rdx, rdx
	mov rax, r9
	test r10 , r10
	jz __DivZero
	div r10
	mov r9, rdx
	add r8, r9
mov y, r8
	invoke printf, cfm$("y = x + x Mod 10 = ")
	mov r8, y
mov buf, r8
	invoke printf, " %lld", buf
	invoke printf, cfm$("\n")
jmp __exit
__DivZero:
	invoke printf, cfm$("\nExeption! divide or modulos by zero\n") 
 __exit:
invoke _getch
invoke ExitProcess, 0
add rsp, 28h
mainCRTStartup endp
end
