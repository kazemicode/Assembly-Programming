@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
output: .asciz "The number was: %d \n"
message: .asciz "Nth Fibonacci term where overflow occurs: %d\n"



@ Program code
.text
.align 2
.global fibonacci
.type fibonacci, %function

fibonacci:

push {fp, lr}
add fp, sp, #4 @ user input from main representing nth position

@ call loop

loop:
@ add the two regs with fib numbers
adds r5, r4, r5 @ set carry flag
bvs done
sub r4, r5, r4
add r6, r6, #1
b loop

done:
mov r1, r6
ldr r0, =message
bl printf

mov r1, r4
ldr r0, =output
bl printf
sub sp, fp, #4
pop {fp, pc}
