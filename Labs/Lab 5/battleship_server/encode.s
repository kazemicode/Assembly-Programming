.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global encode
.type encode, %function

encode:

push {fp, lr}
add fp, sp, #4

@ r0 = address of the 8-bit packet location to write to
@ r1 = flag (hit/miss or gameover)
@ r2 = row or columh

@ we are going to encode the flag and the row/column into
@ register r3

mov r3, #0  @ initialize r3 to all 0's

lsl r1, r1, #6  @ shifts the flag 6 bits to the the left
                @ placing the flag into bits 7-8 of r3
orr r3, r3, r1  @ puts shifted flag into r3

orr r3, r3, r2  @ puts the row/column inot bits 1-6 of r3
                @ assume the size of row/column is less than 6 bits

strb r3, [r0]   @ store the coded message into the packet memory location

sub sp, fp, #4
pop {fp, pc}
