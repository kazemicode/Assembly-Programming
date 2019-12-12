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
@ r6 has the current digit to convert to barcode
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

mov r10, #10  @ used for mod10 for isolating digits
mov r5, #4    @ loop limit to iterate through 5 digits
mov r3, #0    @ counter variable for loop



@loop:
cmp r3, r5    @ check if we've iterated 5 times
beq done      @ if yes, we're done

@ MOD10 to isolate digits
mul r1, r1, r10
udiv r7, r4, r10  @ 12345 / 10 = 1234
mul r8, r7, r10 @ amount to subtract to get remainder 12340
sub r6, r4, r8  @ 12345 - 12340 = 5

add r3, r3, #1  @ increment counter variable

bl bar          @ convert current digit to barcode equivalent

@b loop          @ check loop condition again

done:
sub sp, fp, #4
pop {fp, pc}
