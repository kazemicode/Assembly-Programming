.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global init
.type init, %function

init:
push {fp, lr}
add fp, sp, #4

mov r4, r0

mov r5, #0  @ i = 0

sloop_init:

cmp r5, #100  @ compare i < 100
bge done_sloop_init

lsl r1, r5, #2  @ r1 = r5*4 = i*4
mov r0, #0  @ set r0 = 0 to store into array
mov r2, #-1 
mul r1, r1, r2  @ r1 = -1*r1

str r0, [r4, r1]  @ *(r4 - 4*r5) = 0

add r5, r5, #1  @ i = i + 1

b sloop_init

done_sloop_init:

sub sp, fp, #4
pop {fp, pc}
