.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global mapij
.type mapij, %function

mapij:

push {fp, lr}
add fp, sp, #4

mov r2, #10  @ r2 = 10
mul r2, r2, r0  @ r2 = 10*i  (r0 = i)
add r2, r2, r1  @ r2 = 10*i + j  (r1 = j)

lsl r2, r2, #2   @ r2 = r2*4  computes bytes offset

mov r1, #-1   @ flips the sign of r2
mul r0, r2, r1

sub sp, fp, #4
pop {fp, pc}