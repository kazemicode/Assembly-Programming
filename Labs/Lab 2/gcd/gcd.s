@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
output: .asciz "%d"
nline: .asciz "\n"


@ Program code
.text
.align 2
.global gcd
.type gcd, %function

gcd:

push {fp, lr}
add fp, sp, #4

@ r4 has first positive integer (a)
@ r5 has second positive integer (b)
@ r6 will act as temp for swapping (c)
@ r7 will hold remainder (r)

mov r7, #99 @ r = 99 init to arbitrary number != 0
cmp r4, r5 @ if r4 < r5, swap
bls swap

loop:
cmp r7, #0
beq done
udiv r6, r4, r5 @ temp = a/b
mul r6, r6, r5 @ temp = temp * b
sub r7, r4, r6 @ r = a - temp (remainder)
b loop


swap:
mov r6, r4 @ c = a
mov r4, r5 @ a = b
mov r5, r6 @ b = c


done:
mov r1, r4
ldr r0, =output
bl printf
ldr r0, =nline
bl printf
sub sp, fp, #4
pop {fp, pc}
