@ numerals.s
@ Displays all numerals 0-9
@ Sara Kazemi

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants
        .equ    STDOUT,1
        .equ    numeral,-20     @ for offset in register
        .equ    local,8         @ for memory allocation

@ Constant program data
        .section .rodata
        .align 2

@ The Program
        .text
        .align 2
        .global main
        .type main, %function

@ main function
main:
        sub   sp, sp, 16      @ reserve space for regs
                              @ using 8-byte sp align
        str   r4, [sp, 4]     @ store r4
        str   fp, [sp, 8]     @ store fp
        str   lr, [sp, 12]    @ store lr
        add   fp, sp, 12      @ set our frame pointer
        sub   sp, sp, local   @ allocate mem for local var
        mov   r4, '0          @ move numeral 0 to r4

@ loop
loop:
        strb  r4, [fp, numeral] @ store register byte in r4
                                @ using numeral offset
        mov   r0, STDOUT        @ write to stdout
        add   r1, fp, numeral   @ addr of numeral in r1
        mov   r2, 1             @ 1 byte
        bl    write

        add   r4, r4, 1         @ next numeral
        cmp   r4, '9            @ have gone past max numeral?
        ble   loop              @ false, loop again
        mov   r0, 0             @ true, return 0
        add   sp, sp            @ deallocate local var mem
        ldr   r4, [sp, 4]       @ restore r4
        ldr   fp, [sp, 8]       @ restore fp
        ldr   lr, [sp, 12]      @ restore lr
        add   sp, sp, 16        @ restore sp
        bx    lr                @ return
