	.file	"pstring.c"
	.text
	.globl	pstrlen
	.type	pstrlen, @function
pstrlen:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	pstrlen, .-pstrlen
	.globl	replaceChar
	.type	replaceChar, @function
replaceChar:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, %ecx
	movl	%edx, %eax
	movl	%ecx, %edx
	movb	%dl, -28(%rbp)
	movb	%al, -32(%rbp)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, -4(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L4
.L6:
	movq	-24(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	movzbl	1(%rdx,%rax), %eax
	cmpb	%al, -28(%rbp)
	jne	.L5
	movq	-24(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	movzbl	-32(%rbp), %ecx
	movb	%cl, 1(%rdx,%rax)
.L5:
	addl	$1, -8(%rbp)
.L4:
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jl	.L6
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	replaceChar, .-replaceChar
	.globl	pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%ecx, %eax
	movb	%dl, -20(%rbp)
	movb	%al, -24(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	pstrijcpy, .-pstrijcpy
	.globl	swapCase
	.type	swapCase, @function
swapCase:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	pstrlen
	movsbl	%al, %eax
	movl	%eax, -4(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L9
.L12:
	movq	-24(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	movzbl	1(%rdx,%rax), %eax
	cmpb	$64, %al
	jle	.L10
	movq	-24(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	movzbl	1(%rdx,%rax), %eax
	cmpb	$90, %al
	jg	.L10
	movq	-24(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	movzbl	1(%rdx,%rax), %eax
	addl	$32, %eax
	movl	%eax, %ecx
	movq	-24(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	movb	%cl, 1(%rdx,%rax)
	jmp	.L11
.L10:
	movq	-24(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	movzbl	1(%rdx,%rax), %eax
	cmpb	$96, %al
	jle	.L11
	movq	-24(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	movzbl	1(%rdx,%rax), %eax
	cmpb	$122, %al
	jg	.L11
	movq	-24(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	movzbl	1(%rdx,%rax), %eax
	subl	$32, %eax
	movl	%eax, %ecx
	movq	-24(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	movb	%cl, 1(%rdx,%rax)
.L11:
	addl	$1, -8(%rbp)
.L9:
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jl	.L12
	movq	-24(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	swapCase, .-swapCase
	.globl	pstrijcmp
	.type	pstrijcmp, @function
pstrijcmp:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	%ecx, %eax
	movb	%dl, -20(%rbp)
	movb	%al, -24(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	pstrijcmp, .-pstrijcmp
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
