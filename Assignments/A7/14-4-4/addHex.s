@ addHex.s
@ Prompts user for two hex numbers and adds them


@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constant for assembler
        .equ    maxChars,9      @ max input chars
        .equ    inString1,-24   @ for 1st input string
        .equ    inString2,-36   @ for 2nd input string
        .equ    outString,-52   @ for output string
        .equ    locals,40       @ space for local vars

@ Constant program data
        .section .rodata
        .align  2
prompt:
        .asciz        "Enter up to 32-bit hex number: "
display:
        .asciz        "Their sum is: "

@ The program
        .text
        .align  2
        .global main
        .type   main, %function
main:
        sub     sp, sp, 16      @ space for saving regs
        str     r4, [sp, 0]     @ save r4
        str     r5, [sp, 4]     @      r5
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer
        sub     sp, sp, locals  @ for local vars

        ldr     r0, promptAddr  @ prompt user
        bl      writeStr

        add     r0, fp, inString1  @ 1st input
        mov     r1, maxChars    @ limit input size
        bl      readLn
        add     r0, fp, inString1  @ user input
        bl      hexToInt        @ convert it
        mov     r4, r0          @ 1st int

        ldr     r0, promptAddr  @ prompt for 2nd
        bl      writeStr

        add     r0, fp, inString2  @ 2nd input
        mov     r1, maxChars    @ limit input size
        bl      readLn
        add     r0, fp, inString2  @ user input
        bl      hexToInt        @ convert it
        mov     r5, r0          @ 2nd int

        add     r1, r4, r5      @ add the two ints
        add     r0, fp, outString  @ place for result
        bl      intToHex        @ convert to hex string

        ldr     r0, displayAddr @ show user result
        bl      writeStr

        add     r0, fp, outString
        bl      writeStr

        bl      newLine         @ looks nicer

        mov     r0, 0           @ return 0;
        add     sp, sp, locals  @ deallocate local var
        ldr     r4, [sp, 0]     @ restore r4
        ldr     r5, [sp, 4]     @      r5
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @ restore sp
        bx      lr              @ return

promptAddr:
        .word    prompt
displayAddr:
        .word    display
