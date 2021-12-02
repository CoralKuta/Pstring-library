// 208649186 Coral Kuta

    .data
    .section .rodata
format_d:       .string "%d"
format_s:       .string "%s"
format_0:       .word   0
invalid_s:      .string "invalid input!\n"

	
.text
.globl pstrlen,replaceChar, pstrijcpy, swapCase, pstrijcmp


/* WE DONT PUSH RBP AND MOV RBP TO RSP BECAUSE WE DONT HAVE LOCAL VARIABLES */

    .type pstrlen @function
pstrlen:
    # %rdi has the address of the pstring.
    movq    $0, %rax
    movb    (%rdi), %al
    ret
  
   .type replaceChar @function
replaceChar:
    /* %rdi = address of p
       %rsi = old char
       %rdx = new char .*/ 
       
    movq    %rdi, %rax          # %rax has the result
    incq    %rdi                # The pstring starts with it's len, so we increment our pointer by one byte.
    movq    $0, %r10            # move "\0" to %r10
    cmpb    %r10b, (%rdi)       # compare p[0] to "\0"
    je      .rc_done            # if p[0] = "\0" we go to "done" and not execute the loop. This is the Guarded Do logic.
    
    # if we didn't go to "done", p[0] != "\0", we enter the loop   
.rc_loop:
    cmpb    (%rdi), %sil        # compare p[i] to "old char"
    jne     .rc_move_pointer    # if p[0] != "old char" we don't replace nothing, we just move the pointer.
    
    # if p[i] == "old char" we replace "old char" with "new char"
    movb    %dl, (%rdi)         # Insert new char to the string and "fall" to "move pointer".
    
    
.rc_move_pointer:
    incq    %rdi                # Add 1 (byte) to the address of p (that is in %rdi) to move to the next char of the string.
    movq    $0, %r10            # move "\0" to %r10
    cmpb    %r10b, (%rdi)       # if p[0] != "\0" we go to "loop" and execute again.
    jne     .rc_loop

    # if we didn't go back to "loop", p[0] == "\0", we "fall" to "done". 
.rc_done:
    rep; ret                    # Remember %rax has the address of the pstring



   .type pstrijcpy @function
pstrijcpy:
    /* %rdi = address of dst
       %rsi = address of src
       %rdx = i 
       %rcx = j.*/ 
       
    movq    %rdi, %r14          # Copying dst to a callee register in case we got invalid inputs and we need to return it with no changes.
    
    cmpb    $0, %dl             # compare i to 0
    jl      .cp_invalid         # if i<0, we jump to "invalid"
    cmpb    %dl, %cl            # compare i to j
    jl      .cp_invalid         # if j<i, we jump to "invalid"
    cmpb    (%rdi), %cl         # compare dst_len to j
    jae     .cp_invalid         # if j>=dst_len, we jump to "invalid"
    cmpb    (%rsi), %cl         # compare src_len to j
    jae     .cp_invalid         # if j>=src_len, we jump to "invalid"

    /* All valid arguments */

    leaq    (%r14, %rdx, 1), %r14  # go to dst[i]
    leaq    (%rsi, %rdx, 1), %rsi  # go to src[i]
    
    inc		%rcx
    inc		%rdx
    
.cp_loop:
    cmpq    %rcx, %rdx          # compare i to j.
    ja      .cp_done            # if i > j we are done copying and we exit the loop
    
    inc    %r14                 # increase the address of dst in 1 byte - point the next letter
    inc    %rsi                 # increase the address of src in 1 byte - point the next letter
    
    movzbq  (%rsi), %r11        # copy src[i] to %r11
    movb	%r11b, (%r14)       # copy src[i] to dst
    
    inc    %rdx                 # i++
    jmp     .cp_loop 
     
    
.cp_invalid:
    movq    $invalid_s, %rdi    # Pass %rdi the argument for printf
    movq    $0, %rax            # Clear %rax
    call    printf
    movq    %r14, %rax          # Move original dst to %rax
    ret    
    
.cp_done:
    movq    %rdi, %rax          # Move new dst to %rax
    ret
    
        

   .type swapCase @function
swapCase:
    # %rdi = address of p
    pushq   %r12                # Saving %r12 (callee saved)

    movq    %rdi, %r10          # Copying the address of p
    
    movq    $0, %r11            # clear %r11
    movb    (%rdi), %r11b       # %rdi still has the address of p, we save it's length to %r11
    
    inc     %r11                # length++ (for the first iteration)
.sc_loop:
    dec     %r11                # length-- 
    cmp     $0, %r11            # compare 0 to length
    jle     .sc_done            # if len <= 0, we finished and we quit the loop

    inc     %r10                # increase the address of p in 1 byte - point the next letter
    
    cmpb    $65, (%r10)         # compare p[i] to 65
    jl      .sc_loop            # if p[i] < 65, the char is not upper or lower case, we move to the next iteration
    cmpb    $90, (%r10)         # p[i] >= 65. now compare p[i] to 90
    jle     .sc_upper_to_lower  # 65 <= p[i] <= 90. change upper case to lower case
    
    cmpb    $97, (%r10)         # compare p[i] to 97     
    jl      .sc_loop            # char is not upper case. if p[i] < 97, the char is also not lower case, we move to the next iteration
    cmpb    $122, (%r10)        # p[i] >= 97. now compare p[i] to 122
    jle     .sc_lower_to_upper  # 97 <= p[i] <= 122. change lowe case to upper case
    
    jmp     .sc_loop            # if p[i] > 122, the char is not upper or lower case, we move to the next iteration

.sc_upper_to_lower:
    movq    $0, %r12            # clear %r12
    movb    (%r10), %r12b       # copy p[i] to %r12
    addq    $32, %r12           # adding 32 to p[i] in order to make it lower case
    movb    %r12b, (%r10)       # copy the new p[i] back to it's place in p.
    jmp     .sc_loop 

.sc_lower_to_upper:
    movq    $0, %r12            # clear %r12
    movb    (%r10), %r12b       # copy p[i] to %r12
    subq    $32, %r12           # subtracting 32 to p[i] in order to make it upper case
    movb    %r12b, (%r10)       # copy the new p[i] back to it's place in p.  
    jmp     .sc_loop 
            
.sc_done:
    movq    %rdi, %rax   
    popq    %r12                # restoring %r12       
    ret



.type pstrijcmp @function
pstrijcmp:
    /* %rdi = address of dst
       %rsi = address of src
       %rdx = i 
       %rcx = j.*/    
          
    
    cmpb    $0, %dl             # compare i to 0
    jl      .cm_invalid         # if i<0, we jump to "invalid"
    cmpb    %dl, %cl            # compare i to j
    jl      .cm_invalid         # if j<i, we jump to "invalid"
    cmpb    (%rdi), %cl         # compare dst_len to j
    jae     .cm_invalid         # if j>=dst_len, we jump to "invalid"
    cmpb    (%rsi), %cl         # compare src_len to j
    jae     .cm_invalid         # if j>=src_len, we jump to "invalid"

    /* All valid arguments */
    
    leaq    (%rdi, %rdx, 1), %rdi  # go to dst[i-1]
    leaq    (%rsi, %rdx, 1), %rsi  # go to src[i-1]
    
    movq    $0, %r10            # register to save the dst[i]. initialize to 0
    movq    $0, %r11            # register to save the src[i]. initialize to 0

.cm_loop:
    cmpq    %rcx, %rdx          # compare i to j.
    ja      .cm_equal           # if i > j we are done comparing and we exit the loop - dst[i:j] and src[i:j] are equal !
    
    inc     %rdi                # increase the address of dst in 1 byte - point the next letter
    inc     %rsi                # increase the address of src in 1 byte - point the next letter
    
    movzbq	(%rdi), %r10		# move dst[i] to %r10 (and delete dst[i-1])
    movzbq	(%rsi), %r11		# move src[i] to %r11 (and delete src[i-1])

    cmp		%r11, %r10			# compare dst[i] to src[i]  (dst-src)
    jg		.cm_dst				# dst > src
    jl		.cm_src				# src > dst

	# dst[i] = src[i], we continue to the next index    
    inc     %rdx                # i++
    jmp     .cm_loop    


.cm_dst:
	movq    $1, %rax			# return 1, dst > src
	ret

.cm_src:
	movq    $-1, %rax			# return -1, src > dst
	ret

.cm_equal:
    movq    $0, %rax            # return 0
    ret


.cm_invalid:
    movq    $invalid_s, %rdi    # Pass %rdi the argument for printf
    movq    $0, %rax            # Clear %rax
    call    printf
    movq    $-2, %rax
    ret
    
  
    

