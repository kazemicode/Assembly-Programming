@ Define my Raspberry pi
.cpu cortex-a53
.fpu neon-fp-armv8
.syntax unified
.data
zero:   .asciz "||:::"
one:    .asciz ":::||"
two:    .asciz "::|:|"
three:  .asciz "::||:"
four:   .asciz ":|::|"
five:   .asciz ":|:|:"
six:    .asciz ":||::"
seven:  .asciz "|:::|"
eight:  .asciz "|::|:"
nine:   .asciz "|:|::"


@ Program code
.text
.align 2
.global bar
.type bar, %function

bar:

push {fp, lr}
add fp, sp, #4


@ r4 has the zip code value
@ r7 has the current digit to convert to barcode
@ r8 amount to subtract from original zip to get remaining digits
@ r10 has mod value to extract each digit
@ r1 will have the barcode equivalent of the current digit
@ r2 has divisor 10 to change mod amount

cmp r7, 0
ldreq r0, =zero

cmp r7, 1
ldreq r0, =one

cmp r7, 2
ldreq r0, =two

cmp r7, 3
ldreq r0, =three

cmp r7, 4
ldreq r0, =four

cmp r7, 5
ldreq r0, =five

cmp r7, 6
ldreq r0, =six

cmp r7, 7
ldreq r0, =seven

cmp r7, 8
ldreq r0, =eight

cmp r7, 9
ldreq r0, =nine


bl printf
sub sp, fp, #4
pop {fp, pc}
