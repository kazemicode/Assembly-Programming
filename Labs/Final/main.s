@ CSCI 212
@ Sara Kazemi

@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
prompt: .asciz "Enter a 5 digit zip code: "
input: .asciz "%d"
newLine: .asciz "\n"
framebar: .asciz "|"

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
@ r9 keep track of sum of all digits

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

@ print left framebar
ldr r0, =framebar
bl printf

loop:
mov r2, #10
cmp r10, #0    @ check if we've iterated over all digits
beq done       @ if yes, we're done

@ MOD to isolate digits
udiv  r7, r4, r10 @ 95823 / 10000 = 9
mul   r8, r7, r10 @ amount to subtract to get remainder 5823 ( 9 * 1000 = 9000)
sub   r4, r4, r8  @ 95823 - 90000 = 5823

add r9, r7, r9  @ sum together digits

udiv r10, r10, r2  @ move to next mod for next digit

bl bar          @ convert current digit to barcode equivalent
b loop          @ check loop condition again


done:
@ get check digit bar
mov r10, #10
udiv  r4, r9, r10 @ 19 / 10 = 1
mul   r8, r4, r10 @ amount to subtract to get remainder  ( 1 * 10 = 10)
sub   r9, r9, r8  @ 19 - 10 = 9 @ remainder
sub   r9, r10, r9 @ 10 - 9 = 1

mov r7, r9 @ for use with bar function
bl bar

@ print right framebar
ldr r0, =framebar
bl printf

@ print newline for neatness
ldr r0, =newLine
bl printf

sub sp, fp, #4
pop {fp, pc}
