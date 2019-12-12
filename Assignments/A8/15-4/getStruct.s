@ getStruct.s
@ Gets values for a theTag struct from keyboard
@ Calling sequence:
@        r0 <- address of the struct
@        bl  getStruct
@ Returns 0


@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants for assembler
        .include "theTagStruct.s"  @ theTag struct defs.

@ Constant program data
        .section .rodata
        .align  2
charPrompt:
        .asciz        "Enter a character: "
intPrompt:
        .asciz        "Enter an integer: "

@ The program
        .text
        .align  2
        .global getStruct
        .type   getStruct, %function
getStruct:
        sub     sp, sp, 16      @ space for saving regs
                                @ (keeping 8-byte sp align)
        str     r4, [sp, 4]     @ save r4
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer

        mov     r4, r0          @ pointer to the struct

        ldr     r0, charPromptAddr
        bl      writeStr        @ ask for a char
        bl      getChar         @ get it
        strb    r0, [r4, aChar] @ aStruct->aChar = firstChar;


        ldr     r0, intPromptAddr
        bl      writeStr        @ ask for a char
        bl      getDecInt       @ get it
        str     r0, [r4, anInt] @ aStruct->anInt = aNumber;

        ldr     r0, charPromptAddr
        bl      writeStr        @ ask for a char
        bl      getChar         @ get it
        strb    r0, [r4, anotherChar] @ aStruct->anotherChar = secondChar;

        mov     r0, 0           @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @         sp
        bx      lr              @ return

        .align  2
@ addresses of messages
charPromptAddr:
        .word   charPrompt
intPromptAddr:
        .word   intPrompt
