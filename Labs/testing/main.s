@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
prompt: .asciz "Enter a 5 digit zip code: "
input: .asciz "%d"

@ Program code
.text
.align 2
.global main
.type main, %function


@ r4 has the zip code value
@ r7 has the current digit to convert to barcode
@ r10 has mod value to extract each digit
@ r1 will have the barcode equivalent of the current digit
@ r5 will be our limit for iterating on 5 digits
@ r3 will be our counter variable to keep track of iterations


main:

push {fp, lr}
add fp, sp, #4
@ print prompt for user
mov r10, lr
ldr r0, =prompt
bl printf

@ call scanf to read user input
sub sp, sp, #4
ldr r0, =input
mov r1, sp
bl scanf @ sp contain the input

@ inp stored in r4
ldr r4, [sp]

ldr r10, =#10000  @ used for mod10 for isolating digits


@ cmp r3, r5    @ check if we've iterated 5 times
@ beq done      @ if yes, we're done

@ MOD10 to isolate digits
udiv r7, r4, r10  @ 95823 / 10000 = 9
mul r8, r7, r10 @ amount to subtract to get remainder 5823 ( 9 * 1000 = 9000)
sub r6, r4, r8  @ 95823 - 90000 = 5823

@ sub r3, r3, #1  @ increment counter variable

bl bar          @ convert current digit to barcode equivalent




sub sp, fp, #4
pop {fp, pc}
