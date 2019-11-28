@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified

@ Program code
.text
.align 2
.global main
.type main, %function

main:

push {fp, lr}
add fp, sp, #4
@ r4 1st fib number
mov r4, #1
@ r5 2nd fib number
mov r5, #1
@ r6 loop counter
mov r6, #2


bl fibonacci


sub sp, fp, #4
pop {fp, pc}
