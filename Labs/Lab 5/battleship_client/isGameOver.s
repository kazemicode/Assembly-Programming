.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global isGameOver
.type isGameOver, %function

@ guessboard - 0=no move; 1=miss; 2=hit; 3=sunk

isGameOver:

push {fp, lr}
add fp, sp, #4

mov r4, r0

mov r1, #0  @ i = r1

mov r5, #0  @ count number of hits/sunk

isGameOver_loop:

cmp r1, #99  @ looping through 100 elements of the guessboard
bgt done_isGameOver_loop

lsl r2, r1, #2  @ r2 = 4*i
mov r3, #-1     
mul r2, r2, r3  @ r2 = -r2

ldr r2, [r4, r2] @ r2 = *(r4 + r2)

cmp r2, #1
ble hitmiss_else @ if element in guessboard is 1 or less, don't count

add r5, r5, #1

hitmiss_else:

add r1, r1, #1  @ i = i + 1 to move up the memory location in guessboard

b isGameOver_loop

done_isGameOver_loop:

mov r0, #0  @ initialize return to 0 to indicate game not over
cmp r5, #17
blt end_isGameOver

mov r0, #1  @ if r5 == 17, r0 = 1

end_isGameOver:  @ at this point, r0 = 0 or r0 = 1 depending on r5

sub sp, fp, #4
pop {fp, pc}
