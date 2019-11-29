.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global decode
.type decode, %function

decode:

push {fp, lr}
add fp, sp, #4

@ r0 contains the coded message
@ r1 contains the address to the flag
@ r2 contains the address to the row/column

@ extract bits 1-6 in r0 and store it into memory location pointed
@ to by r2 - this is the row/column
@ To extract bits 1-6, we first create a MASK containing six ones
@ stored the mask into r3

mov r3, #0x3F  @ 0x3F = 111111

and r3, r3, r0  @ extract bits 1-6 and store into r3 = row/col

strb r3, [r2]   @ store the row/col in r3 to memory address pointed
                @ to by r2 = row/column

@ shift r0 6 bits to the right to get the flag

mov r3, #0x3   @ 0x3 = 11

lsr r0, r0, #6  @ shifts the coded message 6 bits to the right
                @ to put the flag bits into bits 1-2

and r3, r3, r0  @ extract bits 1-2 in r0 into r3

strb r3, [r1]   @ store the flag bits in r3 into memory addressed
                @ pointed to by r1 = flag

sub sp, fp, #4
pop {fp, pc}
