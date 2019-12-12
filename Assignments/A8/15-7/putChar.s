@ putChar.s
@ Writes a character to the standard output (screen).
@ Calling sequence:
@       r0 <- the character
@       bl    putChar

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants for assembler
        .equ    STDOUT,1
        .equ    theChar,-5     @ for  string
        .equ    locals,8       @ space for local var

@ The code
        .text
        .align  2
        .global putChar
        .type   putChar, %function
putChar:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer
        sub     sp, sp, locals

        strb    r0, [fp, theChar]  @ write needs address
        mov     r0, STDOUT      @ write to screen
        add     r1, fp, theChar    @ address of theChar
        mov     r2, 1           @ write 1 byte
        bl      write

        mov     r0, 0           @ return 0;
        add     sp, sp, locals  @ deallocate local var
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return
