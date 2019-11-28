	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14	sdk_version 10, 14
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	leaq	L_.str(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	leaq	L_.str.1(%rip), %rdi
	leaq	-24(%rbp), %rsi
	leaq	-20(%rbp), %rdx
	xorl	%eax, %eax
	callq	_scanf
	movl	-24(%rbp), %esi
	movl	-20(%rbp), %edx
	leaq	L_.str.2(%rip), %rdi
	xorl	%eax, %eax
	callq	_printf
	movl	-24(%rbp), %ebx
	incl	%ebx
	movl	-20(%rbp), %ecx
	cmpl	%ecx, %ebx
	jge	LBB0_8
## %bb.1:
	leaq	L_.str.3(%rip), %r14
	.p2align	4, 0x90
LBB0_2:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB0_5 Depth 2
	cmpl	$4, %ebx
	jl	LBB0_6
## %bb.3:                               ##   in Loop: Header=BB0_2 Depth=1
	movl	%ebx, %esi
	shrl	$31, %esi
	addl	%ebx, %esi
	sarl	%esi
	movl	$1, %edi
	.p2align	4, 0x90
LBB0_5:                                 ##   Parent Loop BB0_2 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	incl	%edi
	movl	%ebx, %eax
	cltd
	idivl	%edi
	testl	%edx, %edx
	je	LBB0_7
## %bb.4:                               ##   in Loop: Header=BB0_5 Depth=2
	cmpl	%esi, %edi
	jl	LBB0_5
LBB0_6:                                 ##   in Loop: Header=BB0_2 Depth=1
	xorl	%eax, %eax
	movq	%r14, %rdi
	movl	%ebx, %esi
	callq	_printf
	movl	-20(%rbp), %ecx
LBB0_7:                                 ##   in Loop: Header=BB0_2 Depth=1
	incl	%ebx
	cmpl	%ecx, %ebx
	jl	LBB0_2
LBB0_8:
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_checkPrimeNumber       ## -- Begin function checkPrimeNumber
	.p2align	4, 0x90
_checkPrimeNumber:                      ## @checkPrimeNumber
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$1, %eax
	cmpl	$4, %edi
	jl	LBB1_6
## %bb.1:
	movl	%edi, %ecx
	movl	%edi, %esi
	shrl	$31, %esi
	addl	%edi, %esi
	sarl	%esi
	movl	$1, %edi
	.p2align	4, 0x90
LBB1_2:                                 ## =>This Inner Loop Header: Depth=1
	incl	%edi
	movl	%ecx, %eax
	cltd
	idivl	%edi
	testl	%edx, %edx
	je	LBB1_5
## %bb.3:                               ##   in Loop: Header=BB1_2 Depth=1
	cmpl	%esi, %edi
	jl	LBB1_2
## %bb.4:
	movl	$1, %eax
	popq	%rbp
	retq
LBB1_5:
	xorl	%eax, %eax
LBB1_6:
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Enter two positive integers: "

L_.str.1:                               ## @.str.1
	.asciz	"%d %d"

L_.str.2:                               ## @.str.2
	.asciz	"Prime numbers between %d and %d are: "

L_.str.3:                               ## @.str.3
	.asciz	"%d "


.subsections_via_symbols
