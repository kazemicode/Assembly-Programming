@ helloSara.s
@ Writes Hello, Sara! to screen
@ Sara Kazemi

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Useful source code constant
        .equ    STDOUT,1

@ Constant program data
        .section  .rodata
        .align  2
helloMsg:
        .asciz	 "Hello, Sara!\n"
        .equ    helloLngth,.-helloMsg

@ Program code
        .text
        .align  2
        .global main
        .type   main, %function
main:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer

        mov     r0, STDOUT      @ file number to write to
        ldr     r1, helloMsgAddr   @ pointer to message
        mov     r2, helloLngth  @ number of bytes to write
        bl      write           @ write the message

        mov     r0, 0           @ return 0;
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return

        .align  2
helloMsgAddr:
        .word   helloMsg
