@ incrementDec.s
@ Prompts user for unsigned decimal number and adds 1 to it.

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants for assembler
        .equ    maxChars,11     @ max input chars
        .equ    inputString,-16 @ for input string
        .equ    outputString,-28 @ for output string
        .equ    locals,32       @ space for local vars

@ Constant program data
        .section .rodata
        .align  2
prompt:
        .asciz        "Enter an unsigned number up to 4294967294: "

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
        sub     sp, sp, locals  @ for local vars

        ldr     r0, promptAddr  @ prompt user
        bl      writeStr

        add     r0, fp, inputString  @ place for user input
        mov     r1, maxChars    @ limit input size
        bl      readLn

        add     r0, fp, inputString  @ user input
        bl      uDecToInt       @ convert it

        add     r1, r0, 1       @ increment user's number
        add     r0, fp, outputString
        bl      uIntToDec

        add     r0, fp, outputString
        bl      writeStr
        bl      newLine

        mov     r0, 0           @ return 0;
        add     sp, sp, locals  @ deallocate local var
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return

promptAddr:
        .word    prompt
