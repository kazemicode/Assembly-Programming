@ incFraction.s
@ Gets values from user for a fraction, adds 1
@ to the fraction, and then displays the result.


@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants for assembler
        .equ    x,-12           @ x fraction object
        .equ    locals,8        @ space for fraction

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
        sub     sp, sp, locals  @ for the structs

@ construct the fraction
        add     r0, fp, x       @ address of x struct
        bl      fractionConstr

@ get user input
        add     r0, fp, x       @ get user values
        bl      fractionGet

@ add 1
        add     r0, fp, x       @ add 1 to it
        mov     r1, 1
        bl      fractionAddInt

@ display result
        add     r0, fp, x       @ get user values
        bl      fractionDisplay

        mov     r0, 0           @ return 0;
        add     sp, sp, locals  @ deallocate local var
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return
