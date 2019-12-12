@ fractionAddInt.s
@ Adds an integer to a fraction
@ Assumes (int X den) + num fits into 32 bits.
@ Calling sequence:
@        r0 <- address of the object
@        r1 <- integer to add
@        bl  fractionAddInt
@ Returns 0


@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants for assembler
        .include "fractionObject.s"  @ fraction object defs.

@ The code
        .text
        .align  2
        .global fractionAddInt
        .type   fractionAddInt, %function
fractionAddInt:
        sub     sp, sp, 16      @ space for saving regs
                                @ (keeping 8-byte sp align)
        str     r4, [sp, 4]     @ save r4
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer

        mov     r4, r0          @ this pointer

        ldr     r0, [r4, den]   @ get denominator
        mul     r2, r1, r0      @ integer X denominator
        ldr     r0, [r4, num]   @ get numerator
        add     r2, r2, r0      @ numerator + (int X den)
        str     r2, [r4, num]   @ save new numerator

        mov     r0, 0           @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @         sp
        bx      lr              @ return
