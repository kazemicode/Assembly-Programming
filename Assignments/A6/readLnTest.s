@ writeLnTest.s
@ Tests readLn by echoing a string the user inputs
@ Sara Kazemi

@ Define raspi
    .cpu    cortex-a53
    .fpu    neon-fp-armv8
    .syntax unified

@ Constant data
    .equ      nBytes, 50 @ amount of memory for string
    .section  .rodata
    .align    2
prompt:
    .asciz    "Enter a string: "

@ Code start
    .text
    .align  2
    .global main
    .type   main, %function

main:
    sub   sp, sp, 16    @ space for saving regs
    str   r4, [sp, 4]   @ save r4 to stack
    str   fp, [sp, 8]   @ save fp to stack
    str   lr, [sp, 12]  @ save lr to stack
    add   fp, sp, 12    @ set frame pointer

    mov r0, nBytes      @ memory from heap
    bl  malloc          @ memory allocation
    mov r4, r0          @ pointer to new memory

    ldr   r0, promptAddr    @ prompt user
    bl    writeStr          @ call function


@ After writeStr finished executing
    mov   r0, r4        @ free heap memory
    bl    free

    ldr   r4, [sp, 4]   @ restore r4
    ldr   fp, [sp, 8]   @ restore caller fp
    ldr   lr, [sp, 12]  @ restore lr
    add   sp, sp, 16    @ restore sp
    bx    lr            @ return

promptAddr:
    .word   prompt    @ address of myString
