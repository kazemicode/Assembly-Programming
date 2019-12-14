.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global update_guessboard
.type update_guessboard, %function

update_guessboard:

@ r0 - address of the guess board
@ r1 - row
@ r2 - column
@ r3 - hit/miss flag

push {fp, lr}
add fp, sp, #4

push {r0, r1, r2, r3}

ldr r0, [sp, #8]
ldr r1, [sp, #4]
bl mapij

@ r0 contains the byte offset from the address of the guess board

ldr r1, [sp, #12]  @ load the address of the guess board into r1

ldr r3, [sp]  @ r3 contains the hit/miss flag

cmp r3, #0  @ check if flag indicates miss
bne updateguess_else1
mov r2, #3
str r2, [r1, r0]  @ r1[r][c] = 3
b end_update_guessboard

updateguess_else1:
cmp r3, #1  @ check if flag indicates hit
bne updateguess_else2
mov r2, #1
str r2, [r1, r0]  @ r1[r][c] = 1
b end_update_guessboard

updateguess_else2:
cmp r3, #2 @ check if flag indicates sunk
bne end_update_guessboard
mov r2, #2
str r2, [r1, r0]  @ r1[r][c] = 2

end_update_guessboard:

pop {r0, r1, r2, r3}

sub sp, fp, #4
pop {fp, pc}
