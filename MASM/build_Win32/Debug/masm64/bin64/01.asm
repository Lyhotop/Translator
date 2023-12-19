include \masm64\include64\masm64rt.inc
.data ; 
buf1 dq 0 ; буфер
a1 dq 20
.code
entry_point proc
xor rdx,rdx 
mov rax,35
div a1
invoke wsprintf,addr buf1, "Результат операции. RAX = %d",rax
invoke MessageBox,0,addr buf1,chr$(" Титул сообщения "), 0
invoke ExitProcess,0
entry_point endp
end
