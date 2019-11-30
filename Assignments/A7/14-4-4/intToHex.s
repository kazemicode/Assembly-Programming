@ intToHex.s
@ Converts 32-bit int to a hex text string.
@ Calling sequence:
@       r0 <- address of place to store string
@       r1 <- int to convert
@       bl intToHex
@ returns equivalent int


@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constant for assembler
        .equ    gap,7   @ between alpha and numerical
        .equ    to_ascii,0x30
        .equ    NUL,0   @ NUL for end of string

@ The program
        .text
        .align  2
        .global intToHex
        .type   intToHex, %function
intToHex:
        sub     sp, sp, 24      @ space for saving regs
                                @ (keeping 8-byte sp align)
        str     r4, [sp, 4]     @ save r4
        str     r5, [sp, 8]     @      r5
        str     r6, [sp,12]     @      r6
        str     fp, [sp, 16]    @      fp
        str     lr, [sp, 20]    @      lr
        add     fp, sp, 20      @ set our frame pointer

        mov     r4, r0          @ string pointer
        mov     r5, r1          @ number to convert
        mov     r6, 0           @ counter = 0;

        mov     r0, '0          @ hex prefix in string
        strb    r0, [r4]        @ store the char
        add     r4, r4, 1       @ next char
        mov     r0, 'x
        strb    r0, [r4]        @ store the char
        add     r4, r4, 1
loop:
        cmp     r6, 8           @ all bits?
        beq     allDone         @ yes
        ror     r5, r5, 28      @ no, get next 4 bits
        and     r0, r5, 0xf     @ isolate the four bits
        cmp     r0, 9           @ need alpha char?
        addhi   r0, r0, gap     @ yes, add gap
        add     r0, r0, to_ascii  @ convert to acsii
        strb    r0, [r4]        @ store the char
        add     r4, r4, 1       @ next char location
        add     r6, r6, 1       @ next four bits
        b       loop
allDone:
        mov     r0, NUL
        strb    r0, [r4]        @ NUL char

        mov     r0, 0           @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     r5, [sp, 8]     @      r5
        ldr     r6, [sp,12]     @      r6
        ldr     fp, [sp, 16]    @      fp
        ldr     lr, [sp, 20]    @      lr
        add     sp, sp, 24      @      sp
        bx      lr              @ return
