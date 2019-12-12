@ fractionDisplay.s
@ Displays a fraction struct on screen
@ Calling sequence:
@        r0 <- address of the struct
@        bl  fractionDisplay
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
        .global fractionDisplay
        .type   fractionDisplay, %function
fractionDisplay:
        sub     sp, sp, 16      @ space for saving regs
                                @ (keeping 8-byte sp align)
        str     r4, [sp, 4]     @ save r4
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer

        mov     r4, r0          @ this pointer

        ldr     r0, [r4, num]   @ display numerator
        bl      putDecInt
        mov     r0, '/          @ slash for fraction
        bl      putChar
        ldr     r0, [r4, den]   @ display denominator
        bl      putDecInt
        bl      newLine

        mov     r0, 0           @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @         sp
        bx      lr              @ return
