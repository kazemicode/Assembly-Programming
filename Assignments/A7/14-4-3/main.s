@ main.s
@ Prompts user for hex number and converts
@ it to an int.

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constant for assembler
        .equ    maxChars,9      @ max input chars
        .equ    theString,-16   @ for input string
        .equ    locals,16       @ space for local vars

@ Constant program data
        .section .rodata
        .align  2
prompt:
        .asciz        "Enter up to 32-bit hex number: "
display:
        .asciz        "The integer is: %i\n"

@ The program
        .text
        .align  2
        .global main
        .type   main, %function
main:
        sub     sp, sp, 8       @ space for fp, lr
        str     fp, [sp, 0]     @ save fp
        str     lr, [sp, 4]     @   and lr
        add     fp, sp, 4       @ set our frame pointer
        sub     sp, sp, locals  @ for local vars

        ldr     r0, promptAddr  @ prompt user
        bl      writeStr

        add     r0, fp, theString  @ place for user input
        mov     r1, maxChars    @ limit input size
        bl      readLn

        add     r0, fp, theString  @ user input
        bl      hexToInt        @ convert it

        mov     r1, r0          @ result returned in r0
        ldr     r0, displayAddr @ show user the result
        bl      printf          @ from C Standard Lib.

        mov     r0, 0           @ return 0;
        add     sp, sp, locals  @ deallocate local var
        ldr     fp, [sp, 0]     @ restore caller fp
        ldr     lr, [sp, 4]     @       lr
        add     sp, sp, 8       @   and sp
        bx      lr              @ return

promptAddr:
        .word    prompt
displayAddr:
        .word    display
