.cpu cortex-a53
.fpu neon-fp-armv8

.data
message: .asciz "hello battleship"
message2: .asciz "HIT\n"
message4: .asciz "GUESS BOARD\n"
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
bl startServer

push {r0}  @ push the serverID onto the stack

mov r6, r0

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

@ allocate 2 bytes of memmory to store the received packet
mov r0, #2
bl malloc
bl reset_packet
push {r0}  @ store the received packet memory address ono the stack

mov r7, #3 @ r7 to indicate hit/miss 0-miss, 1-hit, 2-sunk, 3-N/A

gameover_loop:

ldr r0, [fp, #-12] @ r0 = address of the guess board
bl isGameOver @ returns 0=not, 1=game over

@push {r0}  @ place the gameover flag onto the stack

cmp r0, #1

beq gameover

@ wait for a response from the Client
@ receiveFromClient

@ decode

@ checkMove: call check_move
@ check_move returns 3 = miss, 1 = hit, 2 = sunk

@ Receive the move data from the client

ldr r0, [sp, #8]  @ loads the client ID into r0
mov r1, r8  @ contains the address of the received message
mov r2, #2  @ the number of bytes to read

bl read

@ Decode the message and perform the guessboard update
@ Exactly the same way we did it in the client code

@ decode
@ ---------------------------

pop {r7}  @ pops the read message memory address into r7
push {r7}  @ puts the address right back

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

@ Check hit/miss flag to see if equals 3

ldrb r3, [sp, #12]  @ load the hit/miss flag into r3

cmp r3, #3
beq noupdate

@ Update the Guessboard

sub r0, fp, #12 @ gets the guessboard
mov r1, r9      @ r9 contains the row from client move
mov r2, r10     @ r10 contains the column from the client move
ldrb r3, [sp, #4]   @ loads the gameover flag from the stack without removing

cmp r3, #0
bne gameover

ldrb r3, [sp, #-12]

bl update_guessboard

@ display guess board
ldr r0, =message4
bl printf
ldr r0, [fp, #-12]
bl displayBoard

@ ---------------------------

noupdate:

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

@ Send the coded message to the Client
@ sendToClient

ldr r0, [sp, #4]  @ popping the server ID off the stack into r0
              @ r7 contains the address to where the received data will be stored
@push {r0} @ immediately put the server ID back onto the stack

mov r1, r8  @ move the address of the data data message into r1 (2 bytes)
mov r2, #2  @ specifies the number of bytes to send over to the server

bl write    @ call write to send the message over to the server

@ check if game is over
@ set the gameover flag
@ set the hit/miss flag

b gameover_loop


gameover:


sub sp, fp, #4
pop {fp, pc}
