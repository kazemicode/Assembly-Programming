@ uDecToInt.s
@ Converts a decimal text string to an unsigned int.
@ Calling sequence:
@       r0 <- address of string
@       bl uDecToInt
@ returns equivalent int

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constant for assembler
        .equ    no_ascii,0xf
        .equ    NUL,0

@ The program
        .text
        .align  2
        .global uDecToInt
        .type   uDecToInt, %function
uDecToInt:
        sub     sp, sp, 24      @ space for saving regs
        str     r4, [sp, 0]     @ save r4
        str     r5, [sp, 4]     @      r5
        str     r6, [sp, 8]     @      r6
        str     r7, [sp, 12]    @      r7
        str     fp, [sp, 16]    @      fp
        str     lr, [sp, 20]    @      lr
        add     fp, sp, 20      @ set our frame pointer

        mov     r4, r0          @ string pointer
        mov     r5, 0           @ accumulator = 0;
        mov     r7, 10          @ decimal constant
loop:
        ldrb    r6, [r4]        @ get char
        cmp     r6, NUL         @ end of string?
        beq     allDone         @ yes
        mov     r0, r5          @ mul wants 2nd source reg
        mul     r5, r0, r7      @ accumulator X 10
        and     r6, r6, no_ascii  @ strip off acsii
        add     r5, r5, r6      @ add in the new value
        add     r4, r4, 1       @ next char
        b       loop
allDone:
        mov     r0, r5          @ return accumulator;
        ldr     r4, [sp, 0]     @ restore r4
        ldr     r5, [sp, 4]     @      r5
        ldr     r6, [sp, 8]     @      r6
        ldr     r7, [sp, 12]    @      r7
        ldr     fp, [sp, 16]    @      fp
        ldr     lr, [sp, 20]    @      lr
        add     sp, sp, 24      @      sp
        bx      lr              @ return
