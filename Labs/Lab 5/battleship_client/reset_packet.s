.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global reset_packet
.type reset_packet, %function

reset_packet:

@ this function resets all the bits in the packet 2-d array to 
@ all zeroes

push {fp, lr}
add fp, sp, #4

mov r4, r0  @ address of the 2-element character array

mov r1, #0
strb r1, [r4]  @ *(packet) = 0
strb r1, [r4, #1]  @ *(packet+1) = 0

sub sp, fp, #4
pop {fp, pc}