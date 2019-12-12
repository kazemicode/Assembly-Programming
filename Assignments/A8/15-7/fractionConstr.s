
@ fractionConstr.s
@ Construct a fraction object
@ Calling sequence:
@        r0 <- address of fraction variable
@        bl  fractionConstr
@ Returns 0


@ Define my Raspberry Pi
.cpu    cortex-a53
.fpu    neon-fp-armv8
.syntax unified         @ modern syntax

@ Constants for assembler
.include "fractionObject.s"  @ fraction object defs.

@ The code
.text
.align  2
.global fractionConstr
.type   fractionConstr, %function
fractionConstr:
sub     sp, sp, 8       @ space for fp, lr
str     fp, [sp, 0]     @ save fp
str     lr, [sp, 4]     @   and lr
add     fp, sp, 4       @ set our frame pointer

mov     r1, 1           @ reasonable numerator
str     r1, [r0, num]

mov     r1, 2           @ reasonable denominator
str     r1, [r0, den]

mov     r0, 0           @ return 0;
ldr     fp, [sp, 0]     @ restore caller fp
ldr     lr, [sp, 4]     @       lr
add     sp, sp, 8       @   and sp
bx      lr              @ return
