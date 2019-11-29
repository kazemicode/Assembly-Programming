.cpu cortex-a53
.fpu neon-fp-armv8

.data
rowPrompt: .asciz "Enter the row: "
colPrompt: .asciz "Enter the col: "
inpprompt1: .asciz "%d"
ret2:      .asciz "\n"

.text
.align 2
.global makeMove
.type makeMove, %function

makeMove:

push {fp, lr}
add fp, sp, #4

mov r4, r0  @ r4 contains address of row
mov r5, r1  @ r5 contains address of col

@ Get the row from the user
ldr r0, =rowPrompt
bl printf
ldr r0, =inpprompt1
mov r1, r4
bl scanf  @ scanf("%d", r4)

@ Get the column from the user
ldr r0, =colPrompt
bl printf
ldr r0, =inpprompt1
mov r1, r5
bl scanf  @ scanf("%d", r5)

sub sp, fp, #4
pop {fp, pc}
