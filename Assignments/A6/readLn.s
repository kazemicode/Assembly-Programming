@ readLn.s
@ Reads characters from the keyboard and stores them
@ in a character array as a C-style string
@ Does NOT store newline characters
@ Calling sequence:
@       r0: Address of char array where C-style string stored
@       bl: readLn
@ param: char * (pointer to a char array)
@ return: # of characters (excluding NUL) stored in array
@ Sara Kazemi

@ Define raspi
    .cpu    cortex-a53
    .fpu    neon-fp-armv8
    .syntax unified

@ Useful constants
    .equ  STDIN, 0
    .equ  NUL, 0
    .equ  LF, 10 @ Newline character in Linux

@ Code start
    .text
    .align  2
    .global readLn
    .type   readLn, %function

writeStr:
    sub   sp, sp, 16    @ space for saving registers
    str   r4, [sp, 0]   @ save r4 to stack
    str   r5, [sp, 4]   @ save r5 to stack
    str   fp, [sp, 8]   @ save fp to stack
    str   lr, [sp, 12]  @ save lr to stack
    add   fp, sp, 12    @ set frame pointer

    mov   r4, r0        @ r4 = string pointer
    mov   r5, 0         @ r5 = counter variable

    mov   r0, STDIN     @ read from keyboard
    mov   r1, r4        @ address of string pointer
    mov   r2, 1         @ read one byte
    bl    read          @ read byte from string


whileLoop:
    ldrb  r3, [r4]      @ get char from r4 that was just read
    cmp   r3, LF        @ End of input?
    beq   allDone       @ Yes? new line, done.

    mov   r4, r4, 1     @ No? Increment pointer var
    mov   r5, r5, 1     @ Increment counter var

    mov   r0, STDIN     @ read from keyboard
    mov   r1, r4        @ address of next char
    bl    read
    b     whileLoop     @ Loop again


allDone:
    mov   r0, NUL       @ string terminator
    strb  r0, [r4]      @ overwrite newline with NUL
    mov   r0, r5        @ return count of characters stored
    ldr   r4, [sp, 0]   @ restore r4
    ldr   r5, [sp, 4]   @ restore r5
    ldr   fp, [sp, 8]   @ restore fp
    ldr   lr, [sp, 12]  @ restore lr
    add   sp, sp, 16    @ restore sp
    bx    lr            @ return
