@ reverseArray.s
@ Gets 10 integers from user then prints in reverse order.


@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constants for assembler
        .equ    nElements,10    @ number of elements in array
        .equ    intArray,-52    @ array beginning
        .equ    locals,40       @ space for local vars

@ Constant program data
        .section .rodata
        .align  2
prompt:
        .asciz        "Enter an integer:\n"
display:
        .asciz        "In reverse order:\n"

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
        sub     sp, sp, locals  @ for the array

        add     r4, fp, intArray  @ address of array beginning
        mov     r5, 0           @ index = 0;
fillLoop:
        cmp     r5, nElements   @ all filled?
        bge     allFull         @ yes
        ldr     r0, promptAddr  @ no, prompt user
        bl      writeStr
        bl      getDecInt       @ get integer
        lsl     r1, r5, 2       @ offset is 4 * index
        str     r0, [r4, r1]    @ at index-th element
        add     r5, r5, 1       @ index++;
        b       fillLoop
allFull:
        ldr     r0, displayAddr @ nice message
        bl      writeStr

        add     r4, fp, intArray  @ address of array beginning
        mov     r5, 9           @ index = 9;
printLoop:
        lsl     r1, r5, 2       @ no, offset is 4 * index
        ldr     r0, [r4, r1]    @ at index-th element
        bl      putDecInt       @ print integer
        bl      newLine
        subs    r5, r5, 1       @ index--;
        bge     printLoop
allDone:
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
