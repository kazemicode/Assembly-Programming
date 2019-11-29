.cpu cortex-a53
.fpu neon-fp-armv8

.data
vline: .asciz "|"
hline: .asciz "   -----------------------------------------"
ret:   .asciz "\n"
toplabel: .asciz "     0   1   2   3   4   5   6   7   8   9\n"
iiprompt: .asciz " %d "


.text
.align 2
.global displayBoard
.type displayBoard, %function

displayBoard:

push {fp, lr}
add fp, sp, #4

mov r4, r0

mov r5, #0  @ i = 0

ldr r0, =toplabel
bl printf 


dloopi_start:

cmp r5, #10
bge done_dloopi_start

mov r6, #0  @ j = 0;

ldr r0, =hline
bl printf  @ printf("---------------")
ldr r0, =ret
bl printf

ldr r0, =iiprompt
mov r1, r5
bl printf

dloopj_start:

cmp r6, #10
bge done_dloopj_start

ldr r0, =vline
bl printf

mov r0, r5
mov r1, r6
bl mapij  @ returns -4*(10*r5 + r6)

ldr r1, [r4, r0]
ldr r0, =iiprompt
bl printf

add r6, r6, #1  @ j = j + 1

b dloopj_start


done_dloopj_start:
ldr r0, =vline
bl printf
ldr r0, =ret
bl printf


add r5, r5, #1  @ i = i + 1

b dloopi_start

done_dloopi_start:

ldr r0, =hline
bl printf
ldr r0, =ret
bl printf

sub sp, fp, #4
pop {fp, pc}
