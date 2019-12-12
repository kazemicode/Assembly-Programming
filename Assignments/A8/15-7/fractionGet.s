@ fractionGet.s
@ Gets values for a fraction from keyboard
@ Calling sequence:
@        r0 <- address of the struct
@        bl  getStruct
@ Returns 0


@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants for assembler
        .include "fractionObject.s"  @ fraction object defs.

@ Constant program data
        .section .rodata
        .align  2
numPrompt:
        .asciz        "  Enter numerator: "
denPrompt:
        .asciz        "Enter denominator: "

@ The code
        .text
        .align  2
        .global fractionGet
        .type   fractionGet, %function
fractionGet:
        sub     sp, sp, 16      @ space for saving regs
                                @ (keeping 8-byte sp align)
        str     r4, [sp, 4]     @ save r4
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer

        mov     r4, r0          @ pointer to the object

        ldr     r0, numPromptAddr
        bl      writeStr        @ ask for numerator
        bl      getDecInt       @ get it
        str     r0, [r4, num]   @ store at this->num

        ldr     r0, denPromptAddr
        bl      writeStr        @ ask for denominator
        bl      getDecInt       @ get it
        str     r0, [r4, den]   @ store at this->den

        mov     r0, 0           @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @         sp
        bx      lr              @ return

        .align  2

@ addresses of messages
numPromptAddr:
.word   numPrompt
denPromptAddr:
.word   denPrompt
