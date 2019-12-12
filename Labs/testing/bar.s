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
@ r6 has the current digit to convert to barcode
@ r10 has mod value to extract each digit
@ r1 will have the barcode equivalent of the current digit
@ r5 will be our limit for iterating on 5 digits
@ r3 will be our counter variable to keep track of iterations


cmp r6, 0
ldreq r0, =zero

cmp r6, 1
ldreq r0, =one

cmp r6, 2
ldreq r0, =two

cmp r6, 3
ldreq r0, =three

cmp r6, 4
ldreq r0, =four

cmp r6, 5
ldreq r0, =five

cmp r6, 6
ldreq r0, =six

cmp r6, 7
ldreq r0, =seven

cmp r6, 8
ldreq r0, =eight

cmp r6, 9
ldreq r0, =nine


bl printf
sub sp, fp, #4
pop {fp, pc}
