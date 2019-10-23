.cpu cortex-a53
.fpu neon-fp-armv8

.data
inpprompt: .asciz "Enter nth number: "
inp: .asciz "%d"
out: .asciz "Result = %d"
ret: .asciz "\n"

.text
.align 2
.global main
.type main, %function

main:

mov r10, lr

ldr r0, =inpprompt
bl printf
ldr r0, =inp
sub sp, sp, #4
mov r1, sp
bl scanf

ldr r4, [sp]
ldr r0, =ret
bl printf

mov r5, #27
mov r6, #1

loop:

cmp r6, r4
bge doneloop

mov r0, r5
bl collatz
mov r5, r0

ldr r0, =out
mov r1, r5
bl printf

ldr r0, =ret
bl printf

add r6, r6, #1
b loop

doneloop:

add sp, sp, #4
mov lr, r10
bx lr
