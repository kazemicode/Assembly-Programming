@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
prompt1: .asciz "Enter first positive integer: "
prompt2: .asciz "Enter second positive integer: "
input: .asciz "%d"

@ Program code
.text
.align 2
.global main
.type main, %function

main:

push {fp, lr}
add fp, sp, #4
@ print prompt for user
mov r10, lr
ldr r0, =prompt1
bl printf

@ call scanf to read user input
sub sp, sp, #4
ldr r0, =input
mov r1, sp
bl scanf @ sp contain the input

@ inp stored in r4
ldr r4, [sp]

ldr r0, =prompt2
bl printf

@ call scanf to read user input
sub sp, sp, #4
ldr r0, =input
mov r1, sp
bl scanf @ sp contain the input
@ inp stored in r5
ldr r5, [sp]


bl gcd
sub sp, fp, #4
pop {fp, pc}
