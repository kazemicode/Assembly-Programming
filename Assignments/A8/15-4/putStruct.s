@ putStruct.s
@ Displays values for a theTag struct on screen
@ Calling sequence:
@        r0 <- address of the struct
@        bl  putStruct
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
dispAChar:
        .asciz        "         aChar = "
dispAnInt:
        .asciz        "         anInt = "
dispOtherChar:
        .asciz        "   anotherChar = "

@ The program
        .text
        .align  2
        .global putStruct
        .type   putStruct, %function
putStruct:
        sub     sp, sp, 16      @ space for saving regs
                                @ (keeping 8-byte sp align)
        str     r4, [sp, 4]     @ save r4
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer

        mov     r4, r0             @ pointer to the struct

        ldr     r0, dispACharAddr  @ display aChar
        bl      writeStr
        ldrb    r0, [r4, aChar]
        bl      putChar
        bl      newLine
        ldr     r0, dispAnIntAddr  @ display anInt
        bl      writeStr
        ldr     r0, [r4, anInt]
        bl      putDecInt
        bl      newLine
        ldr     r0, dispOtherCharAddr @ display anotherChar
        bl      writeStr
        ldrb    r0, [r4, anotherChar]
        bl      putChar
        bl      newLine

        mov     r0, 0              @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @         sp
        bx      lr              @ return

        .align  2
@ addresses of messages
dispACharAddr:
        .word   dispAChar
dispAnIntAddr:
        .word   dispAnInt
dispOtherCharAddr:
        .word   dispOtherChar
