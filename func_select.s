// 208649186 Coral Kuta

    .section .rodata
    .align 8                        # Align address to multiple of 8

case5060_str :    .string "first pstring length: %d, second pstring length: %d\n"

case52_str:       .string "old char: %c, new char: %c, first string: %s, second string: %s\n"

case53_str:       .string "length: %d, string: %s\n"

case54_str:       .string "length: %d, string: %s\n"

case55_result:    .string "compare result: %d\n"

default:          .string "invalid option!\n"

format_d:         .string "%d"
format_c:         .string " %c"
format_s:         .string "%s"

    
.jump_table:
    .quad .case5060              # Case 50
    .quad .default	             # Case 51
    .quad .case52                # Case 52
    .quad .case53                # Case 53
    .quad .case54                # Case 54
    .quad .case55                # Case 55
    .quad .default	             # Case 56
    .quad .default	             # Case 57
    .quad .default	             # Case 58
    .quad .default	             # Case 59
    .quad .case5060              # Case 60
        

    .text
    .globl run_func
    .extern pstrlen,replaceChar, pstrijcpy, swapCase, pstrijcmp
        
        
    /* Remember %rdi = option
                %rsi = address of p1
                %rdx = address of p2 .*/ 
run_func:
    # Set up the jump table access
    subq    $50, %rdi	             # Switch case starts from 50, we want to start the addresses from 0 
    cmpq    $10 ,%rdi               # Compare option to 10 (switch case goes from 50 to 60, so it's from 0 to 10)
    ja      .default                # if >, goto default case
    jmp     *.jump_table (,%rdi,8)  # go to jump_table[option]
    
    
    
.case5060:
    movq    %rsi, %rdi              # Prepare pstrlen's first argument - p1.
    call    pstrlen
    movq    %rax, %r11              # Move pstrlen's result to a caller saved register. %r11 = len1.
    
    movq    %rdx, %rdi              # Prepare pstrlen's first argument - p2.
    call    pstrlen
    movq    %rax, %r10              # Move pstrlen's result to a caller saved register. %r10 = len2.
    
    
    movq    $case5060_str, %rdi     # Pass %rdi the first argument for printf
    movq    %r11, %rsi              # Move len1 to %rsi as the second argument for printf.     
    movq    %r10, %rdx              # Move len2 to %rdx as the third argument for printf.       
    movq    $0, %rax                # Clear %rax
    call    printf

    ret
    
    
    /* Remember %rdi = option
                %rsi = address of p1
                %rdx = address of p2 .*/ 
.case52:
    # Push new stack frame  
	pushq   %rbp					# Save %rbp - the old frame pointer
    movq    %rsp, %rbp
    pushq	%r12					# Saving %r12 and %r13 (callee saved)
    pushq	%r13
    subq    $16, %rsp
    
    movq	%rsi, %r12				# copy &p1 to %r12
    movq	%rdx, %r13				# copy &p2 to %r13
	
	
    movq    $format_c, %rdi         # Store the type of the argument we want to read
    leaq    -16(%rbp), %rsi         # Allocating 8 bytes for old char from -16 to -8.
    movq    $0, %rax                # Clear %rax before calling scanf
    call    scanf
        
    movq    $format_c, %rdi         # %rdi is caller saved and we call scanf, so we update the type of the argument again
    leaq    -8(%rbp), %rsi          # Allocating 8 bytes for new char from -8 to -0.
    movq    $0, %rax                # Clear %rax before calling scanf
    call    scanf
    
    # Call replaceChar
    movq    %r12, %rdi              # &p1 the first argument
    movzbq  -16(%rbp), %rsi         # Second argument, old char
    movzbq  -8(%rbp), %rdx          # Third argument, new char
    call    replaceChar
    movq    %rax, %r12              # Getting replaceChar's return value (replaced p1) back to %r12.
    
    movq    %r13, %rdi              # &p2 the first argument
    movzbq  -16(%rbp), %rsi         # %rsi is caller saved so we need to pass it again as a second argument, old char
    movzbq  -8(%rbp), %rdx          # %rdx is also caller saved so we pass it again as the third argument, new char
    call    replaceChar
    movq    %rax, %r13              # Getting replaceChar's return value (replaced p2) back to %r13.
    
    # Printing
    movq    $case52_str, %rdi       # printf first argument      
    movzbq  -16(%rbp), %rsi         # old char - second argument
    movzbq  -8(%rbp), %rdx          # new char - third argument
    inc		%r12					# don't print len
    inc		%r13					# don't print len
    movq    %r12, %rcx              # New p1 - fourth argument
    movq    %r13, %r8               # New p2 - fifth argument
    movq    $0, %rax                # Clear %rax before calling printf
    call    printf
    
	# Pop stack frame  
    addq    $16, %rsp
    popq    %r13
    popq    %r12
    popq	%rbp
    ret
    
   
.case53:
    # Push new stack frame 
    pushq   %rbp                    # Saving %rbp
    movq    %rsp, %rbp
    pushq   %r12                    # Saving %r12 and %r13 (callee saved)
    pushq   %r13  
    subq    $16, %rsp               # Allocating 16 bytes on the stack for i and j
    movq    %rsi, %r12              # Copying &p1 to %r12
    movq    %rdx, %r13              # Copying &p2 to %r13
    
    movq    $format_d, %rdi         # Store the type of the argument we want to read
    leaq    -16(%rbp), %rsi         # Allocating 8 bytes for i (start) from -16 to -8.
    movq    $0, %rax                # Clear %rax before calling scanf
    call    scanf
    
    movq    $format_d, %rdi         # %rdi is caller saved and we call scanf, so we update the type of the argument again
    leaq    -8(%rbp), %rsi          # Allocating 8 bytes for j (end) from -8 to -0.
    movq    $0, %rax                # Clear %rax before calling scanf
    call    scanf


    # Call pstrijcpy
    movq    %r12, %rdi
    movq    %r13, %rsi
    movzbq  -16(%rbp), %rdx
    movzbq  -8(%rbp), %rcx
    call    pstrijcpy
    movq    %rax, %r12              # Move the result of pstrijcpy to %r12
    
        
    # Printing dst
    movq    $case53_str, %rdi       # printf first argument - what to print
    movzbq  (%r12), %rsi            # printf second argument - p1 lenght  
    inc		%r12					# don't print len         
    movq    %r12, %rdx              # printf third argument - p1
    movq    $0, %rax                # Clear %rax before calling printf
    call    printf
    
    
    # Printing src
    movq    $case53_str, %rdi       # printf first argument - what to print
    movzbq  (%r13), %rsi            # printf second argument - p2 lenght   
    inc		%r13					# don't print len        
    movq    %r13, %rdx              # printf third argument - p2
    movq    $0, %rax                # Clear %rax before calling printf
    call    printf
    
    # Pop stack frame  
    addq    $16, %rsp
    popq    %r13
    popq    %r12
    popq	%rbp
    ret



.case54:
    # Push new stack frame 
    pushq   %rbp                    # Saving %rbp
    movq    %rsp, %rbp
    pushq   %r12                    # Saving %r12 and %r13 (callee saved)
    pushq   %r13  
    subq    $16, %rsp               # Allocating 16 bytes on the stack for oldchar and newchar
    movq    %rsi, %r12              # Copying p1 to %r12
    movq    %rdx, %r13              # Copying p2 to %r13

    
    # Call swapCase
    movq    %r12, %rdi              # &p1 the argument of swapCase
    call    swapCase
    movq    %rax, %r12              # Getting the return value (swapped p1) back to %r12.
    
    movq    %r13, %rdi              # &p2 the argument of swapCase
    call    swapCase
    movq    %rax, %r13              # Getting the return value (swapped p2) back to %r13.
    
    # Print p1:
    movq    $case54_str, %rdi       # printf first argument - what to print
    movzbq  (%r12), %rsi            # printf second argument - p1 lenght 
    inc		%r12  					# don't print len
    movq    %r12, %rdx              # printf third argument - p1 
    movq    $0, %rax                # Clear %rax before calling printf
    call    printf            
    
    # Print p2:
    movq    $case54_str, %rdi       # printf first argument - what to print
    movzbq  (%r13), %rsi            # printf second argument - p2 lenght 
    inc		%r13					# don't print len
    movq    %r13, %rdx              # printf third argument - p2
    movq    $0, %rax                # Clear %rax before calling printf
    call    printf            
    
    # Pop stack frame  
    addq    $16, %rsp
    popq    %r13
    popq    %r12
    popq	%rbp
    ret
    

    
.case55:
	# Push new stack frame 
    pushq   %rbp                    # Saving %rbp
    movq    %rsp, %rbp
    pushq   %r12                    # Saving %r12 and %r13 (callee saved)
    pushq   %r13  
    subq    $16, %rsp               # Allocating 16 bytes on the stack for i and j
    movq    %rsi, %r12              # Copying p1 to %r12
    movq    %rdx, %r13              # Copying p2 to %r13
    
    movq    $format_d, %rdi         # Store the type of the argument we want to read
    leaq    -16(%rbp), %rsi         # Allocating 8 bytes for i (start) from -16 to -8.
    movq    $0, %rax                # Clear %rax before calling scanf
    call    scanf
    
    movq    $format_d, %rdi         # %rdi is caller saved and we call scanf, so we update the type of the argument again
    leaq    -8(%rbp), %rsi          # Allocating 8 bytes for j (end) from -8 to -0.
    movq    $0, %rax                # Clear %rax before calling scanf
    call    scanf
    
    # Call ‫‪pstrijcmp
    movq    %r12, %rdi              # &p1 is the first argument
    movq    %r13, %rsi              # &p2 is the second argument
    movzbq  -16(%rbp), %rdx         # i is the third argument
    movzbq  -8(%rbp), %rcx          # j is the fourth argument
    call    pstrijcmp
    
        
    # Printing dst
    movq    $case55_result, %rdi    # printf first argument
    movq    %rax, %rsi              # printf second argument (the result is in %rax as the return value of pstrijcmp)
    movq    $0, %rax                # Clear %rax before calling printf
    call    printf
    
    # Pop stack frame  
    addq    $16, %rsp
    popq    %r13
    popq    %r12
    popq	%rbp
    ret


.default:
    movq    $default, %rdi          # Print "invalid option"
    movq    $0, %rax                # Clear %rax before calling printf
    call    printf 
    
.done:
    ret
