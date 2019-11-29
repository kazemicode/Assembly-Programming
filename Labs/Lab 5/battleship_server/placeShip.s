.cpu cortex-a53
.fpu neon-fp-armv8

.data
fname: .asciz "p1.txt"
shipprompt: .asciz "%d %d %d"
fr: .asciz "r"

.text
.align 2
.global placeShips
.type placeShips, %function

placeShips:

push {fp, lr}
add fp, sp, #4

mov r4, r0 @ r4 = address of first array
ldr r0, =fname
ldr r1, =fr
bl fopen  @ r0 = fopen(r0, r1) = fopen("p1.txt","r");

mov r5, r0  @ r5 = r0 = file pointer

mov r6, #0

place_loop:

cmp r6, #17  @ if r6 < 17 (17 lines in "p1.txt")
bge done_place_loop

@ be careful of input buffer

@ call fscanf(file point, "%d %d %d", sp-4, sp-8, sp-16)

mov r0, r5  @ r0 = file pointer stored in r5
ldr r1, =shipprompt

sub sp, sp, #4  
mov r2, sp   @ gets shipID
sub sp, sp, #4
mov r3, sp   @ gets ship row

sub r9, sp, #8
push {r9}    @ gets ship column

@ r9 contains the address on the stack where the 5th
@ argument will be written to
@ This is necessary because the function arguments only 
@ use r0-r3 to store the first 4 arguments
@ The 5th and higher argument need to be on the stack

bl fscanf  
@ call fscanf(r0, r1, r2, r3, sp)

sub r0, sp, #4  @ r0 = column
ldr r0, [r0]

add r1, sp, #4  @ r1 = row
ldr r1, [r1]

add r2, sp, #8  @ r2 = shipID
ldr r2, [r2]

@ Map row, column to location on the array stack
mov r3, #10  @ r3 = 10
mul r3, r3, r1  @ r3 = 10*row
add r3, r3, r0  @ r3 = 10*row + column

@ calculate the byte offset
lsl r3, r3, #2  @ r3 = 4 * (10*row +column)

sub r3, r4, r3  @ starting address of array - bytes offset

str r2, [r3]  @ array[row][col] = r2 = shipID

add sp, sp, #12  @ moves stack point back
add r6, r6, #1  @ i = i + 1

b place_loop

done_place_loop:

mov r0, r5  @ r0 = file pointer
bl fclose  @ fclose(r4)

sub sp, fp, #4
pop {fp, pc}
