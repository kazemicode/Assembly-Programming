.cpu cortex-a53
.fpu neon-fp-armv8

.data
message_cs: .asciz "Starting check sunk \n"

.text
.align 2
.global check_sunk
.type check_sunk, %function

check_sunk:

push {fp, lr}
add fp, sp, #4

push {r1, r0}

ldr r0, =message_cs
bl printf
pop {r0, r1}

@ r0 contains the augmented ship ID
@ r1 contains the number of hits
@ if augmented shipID == 15 && number_of_hits == 5, return 1 else return 0
@ if augmented shipID == 14 && number_of_hits == 4, return 1 else return 0
@ if augmented shipID == 13 or 12 && number_of_hits == 3, return 1 else return 0
@ if augmented shipID == 11 && number_of_hits == 2, return 1 else return 0

cmp r0, #12
ble ch_else  @ check if augmented ship ID == 12.
sub r2, r0, #10  @ if it is not 12, subtract 10 from the augmented ID
b ch_done

ch_else:
sub r2, r0, #9   @ if it is 12, subtract 9

ch_done:

mov r0, #0  @ initialize return value to 0 to indicate not sunk
cmp r1, r2
bne ch_done_done
mov r0, #1  @ if r1 == r2, then we sank the ship

ch_done_done:

sub sp, fp, #4
pop {fp, pc}
