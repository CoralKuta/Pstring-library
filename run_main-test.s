	.file	"run_main-test.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"first pstring length:%d, second pstring length:%d\n"
.LC1:
	.string	" %c"
	.align 8
.LC2:
	.string	"old char:%c, new char:%c, first string:%s, second string:%s\n"
.LC3:
	.string	"%d"
.LC4:
	.string	"length: %d,string: %s\n"
.LC5:
	.string	"compare result: %d\n"
.LC6:
	.string	"invalid option!"
	.text
	.globl	run_func
	.type	run_func, @function
run_func:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$72, %rsp
	.cfi_offset 3, -24
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movl	-52(%rbp), %eax
	subl	$50, %eax
	cmpl	$10, %eax
	ja	.L2
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L4(%rip), %rax
	movl	(%rdx,%rax), %eax
	cltq
	leaq	.L4(%rip), %rdx
	addq	%rdx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L4:
	.long	.L3-.L4
	.long	.L2-.L4
	.long	.L8-.L4
	.long	.L7-.L4
	.long	.L6-.L4
	.long	.L5-.L4
	.long	.L2-.L4
	.long	.L2-.L4
	.long	.L2-.L4
	.long	.L2-.L4
	.long	.L3-.L4
	.text
.L3:
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	pstrlen@PLT
	movsbl	%al, %eax
	movl	%eax, -32(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	pstrlen@PLT
	movsbl	%al, %eax
	movl	%eax, -28(%rbp)
	movl	-28(%rbp), %edx
	movl	-32(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L9
.L8:
	leaq	-44(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	-40(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movzbl	-40(%rbp), %eax
	movsbl	%al, %edx
	movzbl	-44(%rbp), %eax
	movsbl	%al, %ecx
	movq	-64(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	replaceChar@PLT
	movzbl	-40(%rbp), %eax
	movsbl	%al, %edx
	movzbl	-44(%rbp), %eax
	movsbl	%al, %ecx
	movq	-72(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	replaceChar@PLT
	movq	-72(%rbp), %rax
	leaq	1(%rax), %rsi
	movq	-64(%rbp), %rax
	leaq	1(%rax), %rcx
	movzbl	-40(%rbp), %eax
	movsbl	%al, %edx
	movzbl	-44(%rbp), %eax
	movsbl	%al, %eax
	movq	%rsi, %r8
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L9
.L7:
	leaq	-44(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	-40(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-40(%rbp), %eax
	movsbl	%al, %ecx
	movl	-44(%rbp), %eax
	movsbl	%al, %edx
	movq	-72(%rbp), %rsi
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	pstrijcpy@PLT
	movq	-64(%rbp), %rax
	leaq	1(%rax), %rbx
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	pstrlen@PLT
	movsbl	%al, %eax
	movq	%rbx, %rdx
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-72(%rbp), %rax
	leaq	1(%rax), %rbx
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	pstrlen@PLT
	movsbl	%al, %eax
	movq	%rbx, %rdx
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L9
.L6:
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	swapCase@PLT
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	swapCase@PLT
	movq	-64(%rbp), %rax
	leaq	1(%rax), %rbx
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	pstrlen@PLT
	movsbl	%al, %eax
	movq	%rbx, %rdx
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-72(%rbp), %rax
	leaq	1(%rax), %rbx
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	pstrlen@PLT
	movsbl	%al, %eax
	movq	%rbx, %rdx
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L9
.L5:
	leaq	-44(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	-40(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-40(%rbp), %eax
	movsbl	%al, %ecx
	movl	-44(%rbp), %eax
	movsbl	%al, %edx
	movq	-72(%rbp), %rsi
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	pstrijcmp@PLT
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L9
.L2:
	leaq	.LC6(%rip), %rdi
	call	puts@PLT
.L9:
	nop
	movq	-24(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L10
	call	__stack_chk_fail@PLT
.L10:
	addq	$72, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	run_func, .-run_func
	.section	.rodata
.LC7:
	.string	"%s"
	.text
	.globl	run_main
	.type	run_main, @function
run_main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$544, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-540(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	-528(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rsi
	leaq	.LC7(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-540(%rbp), %eax
	movb	%al, -528(%rbp)
	leaq	-536(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	-272(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rsi
	leaq	.LC7(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-536(%rbp), %eax
	movb	%al, -272(%rbp)
	leaq	-532(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-532(%rbp), %eax
	leaq	-272(%rbp), %rdx
	leaq	-528(%rbp), %rcx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	run_func
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L12
	call	__stack_chk_fail@PLT
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	run_main, .-run_main
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
