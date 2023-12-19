; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    include \masm32\include64\masm64rt.inc

    .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

Get_Vendor proc pBuffer:QWORD

  ; -----------------------------------------------
  ; pBuffer needs to be at least 16 bytes in length
  ; -----------------------------------------------

    LOCAL .ebx :DWORD

    mov .ebx, ebx
   
    mov eax, 0                          ; set ID string for Intel
    cpuid

    mov rax, pBuffer                    ; (pBuffer) load buffer address into RAX

    mov [rax],    ebx                   ; write results to buffer
    mov [rax+4],  edx
    mov [rax+8],  ecx
    mov BYTE PTR [rax+12], 0

    mov ebx, .ebx
   
    ret

Get_Vendor endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end
