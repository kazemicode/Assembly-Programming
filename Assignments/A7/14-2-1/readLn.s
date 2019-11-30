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

readLn:
    sub   sp, sp, 24    @ space for saving registers
    str   r4, [sp, 4]   @ save r4 to stack
    str   r5, [sp, 8]   @ save r5 to stack
    str   r6, [sp, 12]  @ save r6 to stack
    str   fp, [sp, 16]   @ save fp to stack
    str   lr, [sp, 24]  @ save lr to stack
    add   fp, sp, 20    @ set frame pointer

    mov   r4, r0        @ r4 = string pointer
    mov   r6, r1        @ r6 = max chars
    sub   r6, 1         @ for NUL, max char - 1
    mov   r5, 0         @ r5 = counter variable

    mov   r0, STDIN     @ read from keyboard
    mov   r1, r4        @ address of string pointer
    mov   r2, 1         @ read one byte
    bl    read          @ read byte from string


whileLoop:
    ldrb  r3, [r4]      @ get char from r4 that was just read
    cmp   r3, LF        @ End of input?
    beq   allDone       @ Yes? new line, done.

    cmp   r5, r6        @ max chars?
    bge   ignore        @ yes, ignore rest of chars

    add   r4, r4, 1     @ No? Increment pointer var
    add   r5, r5, 1     @ Increment counter var

    mov   r0, STDIN     @ read from keyboard
    mov   r1, r4        @ address of next char
    bl    read
    b     whileLoop     @ Loop again

ignore:
    mov   r0, STDIN     @ Read from keyboard
    mov   r1, r4        @ address of current storage
    mov   r2, 1         @ read 1 byte
    bl    read
    b     whileLoop     @ check for end


allDone:
    mov   r0, NUL       @ string terminator
    strb  r0, [r4]      @ overwrite newline with NUL
    mov   r0, r5        @ return count of characters stored
    ldr   r4, [sp, 4]   @ restore r4
    ldr   r5, [sp, 8]   @ restore r5
    ldr   r5, [sp, 12]   @ restore r6
    ldr   fp, [sp, 16]   @ restore fp
    ldr   lr, [sp, 24]  @ restore lr
    add   sp, sp, 24    @ restore sp
    bx    lr            @ return
