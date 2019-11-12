@ writeStr.s
@ Write a C-style text string to stdout (terminal)
@ Calling sequence:
@     r0 : address of string to writeStr
@     bl : writeStr
@     returns # of characters written
@ Sara Kazemi


@ Define raspi
    .cpu    cortex-a53
    .fpu    neon-fp-armv8
    .syntax unified

@ Useful constants
    .equ  STDOUT, 1
    .equ  NUL, 0

@ Code start
    .text
    .align  2
    .global writeStr
    .type   writeStr, %function

writeStr:
    sub   sp, sp, 16    @ space for saving registers
    str   r4, [sp, 0]   @ save r4 to stack
    str   r5, [sp, 4]   @ save r5 to stack
    str   fp, [sp, 8]   @ save fp to stack
    str   lr, [sp, 12]  @ save lr to stack
    add   fp, sp, 12    @ set frame pointer

    mov   r4, r0        @ r4 = string pointer
    mov   r5, 0         @ r5 = counter variable

whileLoop:
    ldrb  r3, [r4]      @ get a char from r4
    cmp   r3, NUL       @ Empty string?
    beq   allDone       @ Yes? End of string, done.

    mov   r0, STDOUT    @ No? Write char to stdout
    mov   r1, r4        @ Address of current char
    mov   r2, 1         @ # of bytes
    bl    write         @ Write first byte r4 to stdout

    add   r4, r4, 1     @ increment pointer var to next byte
    add   r5, r5, 1     @ Counter variable incremented
    b     whileLoop     @ Back to whileLoop

allDone:
    mov   r0, r5        @ return count of characters written
    ldr   r4, [sp, 0]   @ restore r4
    ldr   r5, [sp, 4]   @ restore r5
    ldr   fp, [sp, 8]   @ restore fp
    ldr   lr, [sp, 12]  @ restore lr
