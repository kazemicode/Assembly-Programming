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
@ r8 amount to subtract from original zip to get remaining digits
@ r10 has mod value to extract each digit
@ r1 will have the barcode equivalent of the current digit
@ r2 has divisor 10 to change mod amount

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
ldr r10, =#10000  @ used for mod for isolating digits
mov r2, #10

@loop:
@cmp r10, #1    @ check if we've iterated over all digits
@beq done       @ if yes, we're done

@ MOD to isolate digits
udiv  r7, r4, r10 @ 95823 / 10000 = 9
mul   r8, r7, r10 @ amount to subtract to get remainder 5823 ( 9 * 1000 = 9000)
sub   r4, r4, r8  @ 95823 - 90000 = 5823

udiv r10, r10, r2  @ move to next mod for next digit

bl bar          @ convert current digit to barcode equivalent
@b loop          @ check loop condition again


done:
sub sp, fp, #4
pop {fp, pc}
