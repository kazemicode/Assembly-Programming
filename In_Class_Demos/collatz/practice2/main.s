@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
prompt: .asciz "Enter a 4 digit number: "
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
ldr r0, =prompt
bl printf

@ call scanf to read user input
sub sp, sp, #4
ldr r0, =input
mov r1, sp
bl scanf @ sp contain the input

@ inp stored in r4
ldr r4, [sp]

bl reverse


sub sp, fp, #4
pop {fp, pc}
