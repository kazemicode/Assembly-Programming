@ structPass.s
@ Allocates two structs and gets values for user for
@ each struct, then displays the values.


@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants for assembler
        .include "theTagStruct.s"  @ theTag struct defs.
        .equ    y,-36           @ y struct
        .equ    x,-24           @ x struct
        .equ    locals,24       @ space for the structs

@ Constant program data
        .section .rodata
        .align  2
displayX:
        .asciz        "x fields:\n"
displayY:
        .asciz        "y fields:\n"

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
        sub     sp, sp, locals  @ for the structs

@ fill the x struct
        add     r0, fp, x       @ address of x struct
        bl      getStruct

@ fill the y struct
        add     r0, fp, y       @ address of y struct
        bl      getStruct

@ display x struct
        ldr     r0, displayXaddr
        bl      writeStr
        add     r0, fp, x         @ address of x struct
        bl      putStruct
        bl      newLine

@ display y struct
        ldr     r0, displayYaddr
        bl      writeStr
        add     r0, fp, y         @ address of y struct
        bl      putStruct
        bl      newLine

        mov     r0, 0           @ return 0;
        add     sp, sp, locals  @ deallocate local var
        ldr     r4, [sp, 4]     @ restore r4
        ldr     fp, [sp, 8]     @         fp
        ldr     lr, [sp, 12]    @         lr
        add     sp, sp, 16      @         sp
        bx      lr              @ return

        .align  2
@ addresses of messages
displayXaddr:
        .word   displayX
displayYaddr:
        .word   displayY
