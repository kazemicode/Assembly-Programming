.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global collatz
.type collatz, %function

collatz:

mov r9, lr

ands r1, r0, #1

cmp r1, #1

beq odd

mov r2, r0, LSR #1
mov r0, r2

b donecollatz

odd:

mov r2, #3
mul r2, r2, r0
add r2, r2, #1
mov r0, r2

donecollatz:

mov lr, r9
bx lr

