include masm64\include64\masm64rt.inc
printf proto
scanf proto
_getch proto

.data
	a	dq	00h
	b	dq	00h
	cC	dq	00h
	x	dq	00h
	buf	dq	0

.code
mainCRTStartup proc
sub rsp, 28h
	invoke printf, cfm$("Input a: ")
	invoke scanf, "%lld", addr a
	invoke printf, cfm$("Input b: ")
	invoke scanf, "%lld", addr b
	invoke printf, cfm$("Input c: ")
	invoke scanf, "%lld", addr cC
	mov r8, a
	mov r9, b
	cmp r8, r9
	setl r9b
	and r9, 255
	mov r8, r9
mov buf, r8
	cmp qword ptr buf, 0
	jz __end1
	mov r8, b
mov x, r8
	jmp __end2
__end1:
	mov r8, a
mov x, r8
__end2:
	mov r8, x
	mov r9, cC
	cmp r8, r9
	setl r9b
	and r9, 255
	mov r8, r9
mov buf, r8
	cmp qword ptr buf, 0
	jz __end5
	invoke printf, cfm$("The largest number: ")
	mov r8, cC
mov buf, r8
	invoke printf, " %lld", buf
	jmp __end6
__end5:
	invoke printf, cfm$("The largest number: ")
	mov r8, x
mov buf, r8
	invoke printf, " %lld", buf
__end6:
invoke _getch
invoke ExitProcess, 0
add rsp, 28h
mainCRTStartup endp
end
