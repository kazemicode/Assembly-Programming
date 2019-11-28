@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
output: .asciz "Factorial of %d is: %d \n"
omsg: .asciz "Overflow occurred. \n"


@ Program code
.text
.align 2
.global factorial
.type factorial, %function

factorial:

push {fp, lr}
add fp, sp, #4

@ r4 has user input (n)
@ r5 will be final value
@ r6 untouched user input

mov r6, r4
mov r5, r4
b loop

loop:
cmp r4, #1
beq done              @ factorial successfully computed
sub r4, r4, #1
umull r5, r0, r5, r4  @ r0 holds flag value
cmp r0, #0            @ overflow occurred
bne overflow
b loop


done:
mov r1, r6
mov r2, r5
ldr r0, =output
bl printf
sub sp, fp, #4
pop {fp, pc}

overflow:
ldr r0, =omsg
bl printf
sub sp, fp, #4
pop {fp, pc}
