; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

    include binpath.inc

    .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

NOSTACKFRAME

intdiv proc

  ; --------------------------
  ; rcx = number to be divided
  ; rdx = its divisor
  ; --------------------------

    mov r11, rdx
    xor rdx, rdx
    mov rax, rcx
    div r11

    ret

intdiv endp

STACKFRAME

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

    end
