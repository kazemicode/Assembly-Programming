@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
prompt1: .asciz "Enter first integer: "
prompt2: .asciz "Enter second integer: "
input: .asciz "%d"
output: .asciz "The prime numbers between %d and %d are: \n"

@ Program code
.text
.align 2
.global main
.type main, %function

@ r4 has user input (n1)
@ r5 has user input (n2)
@ r6 is i (param n used in checkPromptNumber)
@ r7 is j
@ r8 is flag

main:

push {fp, lr}
add fp, sp, #4
mov r10, lr

@ print prompt for user
ldr r0, =prompt1
bl printf

@ call scanf to read user input
sub sp, sp, #4
ldr r0, =input
mov r1, sp
bl scanf @ sp contain the input
@ inp stored in r4
ldr r4, [sp]

@ print prompt for user
ldr r0, =prompt2
bl printf

@ call scanf to read user input
sub sp, sp, #4
ldr r0, =input
mov r1, sp
bl scanf @ sp contain the input
@ inp stored in r5
ldr r5, [sp]


@printf("Prime number between %d and %d are: ", n1, n2)
mov r1, r4 @ n1
mov r2, r5 @ n2
ldr r0, =output
bl printf

add r6, r4, 1 @ i = n1 + 1

loop:
cmp r6, r5    @ i < n2?
bge done      @ No? Done.
bl checkPrimeNumber @ Yes? Branch to checkPrimeNumber
@ check flag
mov r0, 1     @ STDOUT
mov r6, r1    @ move current n (i) to r1 to print if prime
cmp r8, 1     @ Is flag set?
beq pflag     @ Yes? print the value
add r6, r6, 1 @ i++
b loop        @ loop again

pflag:
bl printf

done:
sub sp, fp, #4
pop {fp, pc}
