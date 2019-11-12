@ writeStrTest.s
@ Tests the writeStr function
@ Sara Kazemi

@ Define raspi
    .cpu    cortex-a53
    .fpu    neon-fp-armv8
    .syntax unified

@ Constant data
    .section  .rodata
    .align    2
myString:
    .asciz    "Hello world.\n"

@ Code start
    .text
    .align  2
    .global main
    .type   main, %function

main:
    sub   sp, sp, 8     @ space for saving fp and lr
    str   fp, [sp, 0]   @ save fp to stack
    str   lr, [sp, 4]   @ save lr to stack
    add   fp, sp, 4     @ set frame pointer

    ldr   r0, myStringAddr  @ r0 = string address
    bl    writeStr          @ call function


@ After writeStr finished executing
    mov   r0, 0         @ return 0
    ldr   fp, [sp, 0]   @ restore caller fp
    ldr   lr, [sp, 4]   @ restore lr
    add   sp, sp, 8     @ restore sp
    bx    lr            @ return

myStringAddr:
    .word   myString    @ address of myString
