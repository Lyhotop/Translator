; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

    include \masm32\include64\masm64rt.inc

    .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

wait_key proc

    invoke FlushConsoleInputBuffer,function(GetStdHandle,STD_INPUT_HANDLE)

  @@:
    invoke SleepEx,1,0
    call vc__kbhit
    test rax, rax
    jz @B

    call vc__getch      ; recover the character in the keyboard
                        ; buffer and return it in RAX
    ret

wait_key endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

    end
