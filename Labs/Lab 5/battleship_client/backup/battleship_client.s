.cpu cortex-a53
.fpu neon-fp-armv8

.data
message: .asciz "hello battleship"
message2: .asciz "HIT\n"
message3: .asciz "%d\n"

.text
.align 2
.global main
.type main, %function

main:

@ This is the client portion of the battleship code
@ The CLIENT is PLAYER 1

push {fp, lr}
add fp, sp, #4

mov r0, #202
lsl r0, r0, #2
sub sp, sp, r0

sub r0, fp, #16
str r0, [fp, #-8]
mov r0, #99
lsl r0, r0, #2
add r0, sp, r0  @ second array starts at sp + 4*99
str r0, [fp, #-12]

@ open network TCP/IP connection
bl startClient

push {r0}  @ push the serverID onto the stack

mov r6, r0

@++++++++++++++++++++++++++++++++++++++++++++++++
@ DEBUG CODE

@ allocate 2 bytes of memory to store packet
mov r0, #2
bl malloc
mov r8, r0  @ r8 contains the address to the packet
bl reset_packet

mov r0, r8
mov r1, #1
mov r2, #3

bl encode

add r0, r8, #1
mov r1, #1
mov r2, #9

bl encode

pop {r0}
push {r0}

mov r1, r8
mov r2, #2

bl write

@ print out the hit/miss flag and row

mov r0, #2
bl malloc
mov r7, r0

ldrb r0, [r8]
mov r1, r7
add r2, r7, #1

bl decode

ldr r0, =message3
ldrb r1, [r7]
bl printf
ldr r0, =message3
ldrb r1, [r7, #1]
bl printf

@printf out the gameover flag and col
ldrb r0, [r8, #1]
mov r1, r7
add r2, r7, #1


bl decode

ldr r0, =message3
ldrb r1, [r7]
bl printf
ldr r0, =message3
ldrb r1, [r7, #1]
bl printf


@++++++++++++++++++++++++++++++++++++++++++++++++

@ one for the server and one for the client

ldr r0, [fp, #-8]
bl init
ldr r0, [fp, #-12]
bl init

@ test the array by printing it out
@ldr r0, [fp, #-8]
@bl displayBoard

@ Place the ship using an input file
ldr r0, [fp, #-8]  @ address to the first array - battlespace
bl placeShips
ldr r0, [fp, #-8]
bl displayBoard

@ ======================================
@ check function check_move
mov r0, #2
mov r1, #1
ldr r2, [fp, #-8]
bl check_move

cmp r0, #1
bne no_hit

ldr r0, =message2
bl printf

no_hit:

@ ======================================

@ encoding/decoding packet to send moves will stored into a 
@ 2-D array of characters containing 16 bits
@ Encode hit/miss/sunk/noinfo into first 2 bits (highest bits)
@ Encode 0/1/2 (not over, player1 wins, player 2 wins) next 2 bits
@ Encode row into next 4 bits, column into next 4 bits

@ allocate 2 bytes of memory to store packet
mov r0, #2
bl malloc
mov r8, r0  @ r8 contains the address to the packet
bl reset_packet

@ allocate 2 bytes of memory to store the packet read from the server

mov r0, #2
bl malloc  @ dynamically allocate 2 bytes
push {r0}

mov r7, #3 @ r7 to indicate hit/miss 0-miss, 1-hit, 2-sunk, 3-N/A

gameover_loop:

ldr r0, [fp, #-12] @ r0 = address of the guess board
bl isGameOver @ returns 0=not, 1=game over

push {r0}  @ place the gameover flag onto the stack

cmp r0, #1

beq gameover

@ need to print battlespace and guessboard

sub sp, sp, #4
mov r0, sp
sub sp, sp, #4
mov r1, sp

bl makeMove

ldr r10, [sp]   @ r10 contains the column of the move
add sp, sp, #4
ldr r9, [sp]    @ r9 contains the row of the move
add sp, sp, #4

@ encode the hit/miss flag and row
mov r0, r8  @ move the address of the first packet element into r0
mov r1, r7  @ move the hit/miss flag into r1
mov r2, r9  @ move the row into r2

bl encode

@ encode the gameover flag and column
add r0, r8, #1  @ move the address of the second packet element into r0
pop {r1}   @ pops the gameover flag on the stack into r1
mov r2, r10  @ move the column into r2

bl encode 

@ Send the coded message to the Server
@ sendToServer

pop {r0, r7}  @ popping the server ID off the stack into r0
              @ r7 contains the address to where the received data will be stored
push {r0} @ immediately put the server ID back onto the stack
push {r7} @ immediately put the address to the received data onto the stack

mov r1, r8  @ move the address of the data data message into r1 (2 bytes)
mov r2, #2  @ specifies the number of bytes to send over to the server

bl write    @ call write to send the message over to the server


@ wait for a response back from the Sever
@ receiveFromServer

pop {r0}  @ popping the server ID off the stack again
push {r0} @ push server ID back onto the stack immediately
mov r1, r7  @ r7 contains the address to store data read from server
mov r2, #2  @ number of bytes to read

bl read

@ decode
@ ---------------------------

ldrb r0, [r7]  @ load the message byte from r7 into r0

sub sp, sp, #4  @ place the hit/miss flag onto the top of the stack
mov r1, sp
sub sp, sp, #4  @ place the row onto the top of the stack
mov r2, sp

bl decode  @ decode will write the flag and row onto the stack

@printf out the gameover flag and col
ldrb r0, [r7, #1]  @load the column message byte from r7+1 into r0
sub sp, sp, #4     @ store the gameover flag onto the stack
mov r1, sp
sub sp, sp, #4     @ store the column onto the stack
mov r2, sp

bl decode

@ At this point, the top four elements of the stack contains
@ column from the server
@ gameover flag from the server
@ row from the server
@ hit/miss flag from the server

@ Update the Guessboard

sub r0, fp, #12 @ gets the guessboard
mov r1, r9      @ r9 contains the row from client move
mov r2, r10     @ r10 contains the column from the client move
ldrb r3, [sp, #4]   @ loads the gameover flag from the stack without removing

cmp r3, #0
bne gameover

ldrb r3, [sp, #12]

bl update_guessboard

@ ---------------------------

@ checkMove: call check_move
@ check_move returns 0 = miss, 1 = hit, 2 = sunk

@ check if game is over
@ set the gameover flag
@ set the hit/miss flag

b gameover_loop


gameover:

cmp r3, #1
@ print player 1 wins
@ else
@ print player 2 wins

sub sp, fp, #4
pop {fp, pc}
