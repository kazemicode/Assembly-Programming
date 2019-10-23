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
.global reverse
.type reverse, %function

reverse:

push {fp, lr}
add fp, sp, #4

@ r4 has input value n to be reversed
@ r10 has mod value to extract each digit
@ r1 will have reversed value
@ if number is 1234 we want 4321
mov r10, #10
mov r1, #0

cmp r4, #0 @ if n > 0 then loop
bgt loop
ldr r0, =output
bl printf
sub sp, fp, #4
pop {fp, pc}


loop:
mul r1, r1, r10
udiv r7, r4, r10 @ 1234 / 10 = 123
mul r8, r4, r10 @ amount to subtract to get remainder 1230
sub r6, r4, r8 @ 1234 - 1230 = 4
add r1, r1, r6
