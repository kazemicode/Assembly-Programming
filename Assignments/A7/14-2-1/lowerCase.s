@ lowerCase.s
@ Prompts user to enter alphabetic characters, converts
@ all uppercase to lowercase and shows the result.

@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constant for assembler
        .equ    nBytes,50  @ amount of memory for string
@ Constant program data
        .section .rodata
        .align  2
prompt:
        .asciz        "Enter some alphabetic characters: "

@ The program
        .text
        .align  2
        .global main
        .type   main, %function
main:
        sub     sp, sp, 16      @ space for saving regs
                                @ (keeping 8-byte sp align)
        str     r4, [sp, 4]     @ save r4
        str     fp, [sp, 8]     @      fp
        str     lr, [sp, 12]    @      lr
        add     fp, sp, 12      @ set our frame pointer

        mov     r0, nBytes      @ get memory from heap
        bl      malloc
        mov     r4, r0          @ pointer to new memory

        ldr     r0, promptAddr  @ prompt user
        bl      writeStr

        mov     r0, r4          @ get user input
        mov     r1, nBytes      @ limit input size
        bl      readLn

	mov	r0, r4		@ convert to lowercase
	bl	toLower

        mov     r0, r4          @ echo user input
        bl      writeStr

        mov     r0, r4          @ free heap memory
        bl      free

        mov     r0, 0           @ return 0;
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @ restore sp
        bx      lr              @ return

promptAddr:
        .word    prompt
