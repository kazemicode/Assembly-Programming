@ incrementSigned.s
@ Prompts user for signed decimal number and adds 1 to it.

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constant program data
        .section .rodata
        .align  2
prompt:
        .asciz        "Enter a signed integer between -2147483648 and +2147483646: "

@ The program
        .text
        .align  2
        .global main
        .type   main, %function
main:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer

        ldr     r0, promptAddr  @ prompt user
        bl      writeStr

        bl      getDecInt       @ convert it

        add     r0, r0, 1       @ increment user's number
        bl      putDecInt       @ print result
        bl      newLine

        mov     r0, 0           @ return 0;
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return

promptAddr:
        .word    prompt
