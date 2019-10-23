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
.global fibonacci
.type fibonacci, %function

fibonacci:

push {fp, lr}
add fp, sp, #4 @ user input from main representing nth position

@ r4 has input value nth position of fibonacci sequence
@ r10 i counter variable for loop
@ r7 act as temp for swapping values
@ r8 ith value in sequence
@ r9 i + 1 th value in sequence
@ r1 will have return value (numeric value of nth position)

mov r10, #1 @ i = 1
mov r8, #1 @ a = 1
mov r9, #1 @ b = 1

loop:
cmp r10, r4 @ if i < n then loop
bge done
mov r7, r9 @ temp = b
add r9, r8, r9 @ b += a
mov r8, r7 @ a = temp
b loop

done:
mov r1, r8
ldr r0, =output
bl printf
ldr r0, =nline
bl printf
sub sp, fp, #4
pop {fp, pc}
