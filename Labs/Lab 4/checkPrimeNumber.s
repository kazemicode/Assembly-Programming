@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
output: .asciz "%d "


@ Program code
.text
.align 2
.global checkPrimeNumber
.type checkPrimeNumber, %function

checkPrimeNumber:

push {fp, lr}
add fp, sp, #4

mov r7, 2       @ j = 2
mov r8, 1       @ flag = 1
udiv r9, r6, 2  @ n / 2

@ r4 has user input (n1)
@ r5 has user input (n2)
@ r6 has n (number between n1 and n2 inclusive)
@ r7 is j
@ r8 is flag


@ n will be in register set in main
@ j is a divisor used to determine if n is Prime
@ flag is set to 0 if not prime, 1 if prime (return value)

loop:
cmp r7, r9            @ is j <= n/2 ?
bgt done              @ No? Done, flag still 1
@ modulus             @ Yes? Check if divisible by j
udiv r9, r6, r7       @ x = n / j
mul r3, r9, r6        @ r3 = x * j
sub r2, r6, r3        @ n - (x * j)
cmp r2, 0             @ n%j == 0?
beq setflag           @ Yes? set flag to 0, indicating not prime
add r7, r7, 1         @ j++
b loop                @ No? Loop again after incrementing j

setflag:
mov r8, 0             @ flag = 0
b done

done:
sub sp, fp, #4
pop {fp, pc}
