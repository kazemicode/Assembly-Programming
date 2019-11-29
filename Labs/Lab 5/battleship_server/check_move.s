.cpu cortex-a53
.fpu neon-fp-armv8

.data
message_cm: .asciz "Starting check move\n"

.text
.align 2
.global check_move
.type check_move, %function

check_move:

push {fp, lr}
add fp, sp, #4

mov r9, r0  @ store the row into r9
mov r10, r1  @ store the col into r1
mov r4, r2  @ address of battlespace

ldr r0, =message_cm
bl printf  @ printing out "starting check move"

mov r0, r9
mov r1, r10
bl mapij  @ mapping the row, column into a byte offset on stack

mov r2, r0  @ store the byte offset into r2

ldr r3, [r4, r2]  @ r3 = battlespace[r9][r10]

mov r0, #0  @ initialize r0 to indicate a MISS

cmp r3, #0

beq done_check_move

add r3, r3, #10  @ if it is a HIT, then add 10 to the ship ID
		 @ in battlespace - call this the augmented ship ID

str r3, [r4, r2] @ store the new ship ID value back into battlespace

@ start checking the row
mov r0, #0  @ initialize number of hits to 0
push {r0}   @ store the number of hits on top of the stack

mov r5, #0  @ initialize the loop counter variable

row_loop:

cmp r5, #10
bge done_row_loop

mov r0, r9  @ move row into r0
mov r1, r5  @ move current column in r5 to r1
bl mapij    @ calculate the bytes offset at (r0, r5)

ldr r1, [r4, r0]  @ r1 = battlespace[r9][r5]

cmp r1, r3  @ check to see if the value at battlespace[r9][r5] == aug ship ID

bne else_row_loop

pop {r0}  @ get the number of hits off the stack
add r0, r0, #1  @ increment number of hits by 1
push {r0}  @ store the new number of hits back onto the stack

else_row_loop:

add r5, r5, #1  @ increment the column counter by 1

b row_loop


done_row_loop:  @ done going through the row r9

mov r0, r3  @ store the augmented ship ID into r0
pop {r1}    @ pop the number of hits from the stack into r1

bl check_sunk  @ check_sunk(aug_ship_ID, num_hits)
	       @ returns 0 = not sunk; returns 1 = sumk
mov r1, r0     @ r0 contains sunk/not sunk - move into r1 temporarily
mov r0, #2     @ initialize r0 to indicate sunk

cmp r1, #1     @ check if sunk
beq done_check_move

@ if not sunk then we check the column next
@ copy and paste the check row code here
@ --------------------------------------------------

mov r0, #0  @ initialize number of hits to 0
push {r0}   @ store the number of hits on top of the stack

mov r5, #0  @ initialize the loop counter variable: for (r5=0; r5 < 10; r5++)

col_loop:

cmp r5, #10
bge done_col_loop

mov r0, r5  @ move current row into r0
mov r1, r10  @ move column in r10 to r1
bl mapij    @ calculate the bytes offset at (r0, r5)

ldr r1, [r4, r0]  @ r1 = battlespace[r5][r10]

            @ r3 contains the value of the augmented ship ID
cmp r1, r3  @ check to see if the value at battlespace[r5][r10] == aug ship ID

bne else_col_loop

pop {r0}  @ get the number of hits off the stack
add r0, r0, #1  @ increment number of hits by 1
push {r0}  @ store the new number of hits back onto the stack

else_col_loop:

add r5, r5, #1  @ increment the column counter by 1

b col_loop


done_col_loop:  @ done going through the column r10

mov r0, r3  @ store the augmented ship ID into r0
pop {r1}    @ pop the number of hits from the stack into r1

bl check_sunk  @ check_sunk(aug_ship_ID, num_hits)
	       @ returns 0 = not sunk; returns 1 = sumk
mov r1, r0     @ r0 contains sunk/not sunk - move into r1 temporarily
mov r0, #2     @ initialize r0 to indicate sunk

cmp r1, #1     @ check if sunk
beq done_check_move

@ if we get to this line, then ship was hit but not sunk
mov r0, #1  @ r0 = 1 to indicate hit but not sunk

@ --------------------------------------------------

done_check_move:

@ at this point, r0 will contain the value 0, 1, 2, or 3
@ 0 = miss; 1 = hit; 2 = sunk; 3 = no info

sub sp, fp, #4
pop {fp, pc}
