// 208649186 Coral Kuta

  .section  .rodata
format_d:       .string "%d"
format_s:       .string "%s"

.text
.global run_main
.extern run_func
.type run_main, @function

run_main:
 
    # Initialization - push new stack frame 
    pushq   %rbp                   # Save %rbp - the old frame pointer
    movq    %rsp, %rbp             
    subq    $544, %rsp             # Allocate 544 bytes on the stack for the variables: size of pstring (256 bytes) * 2 
                                   # and 24 bytes for len1, len2 and opt, and for alignment reasons. %rsp in -544
                                  
    
    /* BODY  
    Setting the registers for scanf. %rdi has the type of the argument we want to read, and %rsi has the desired address
    to save what we read. We call scanf - it's a function. Thus we don't use caller saved registers because scanf can change
    their value. */
    
    /* The length of the first pstring.*/
    movq   $format_d, %rdi         # Store the type of the argument we want to read
    leaq   -544(%rbp), %rsi        # Store len1 in the stack from -544 to -536
    movq   $0, %rax                # Clear %rax before calling scanf
    call   scanf
    
    movq   -544(%rbp), %rax        
    movb   %al, -536(%rbp)         # Store the length of the first pstring in it's first char -536 to -535
    
    
    /* The first pstring.*/
    movq   $format_s, %rdi         # Store the type of the argument we want to read
    leaq   -535(%rbp), %rsi        # Store the first pstring in the stack from -535 to -280. One byte is saved for len1
    movq   $0, %rax                # Clear %rax before calling scanf
    call   scanf
    
    
     /* The length of the second pstring.*/
    movq   $format_d, %rdi         # Store the type of the argument we want to read
    leaq   -280(%rbp), %rsi        # Store len2 in the stack from -280 to -272
    movq   $0, %rax                # Clear %rax before calling scanf
    call   scanf
    
    movq   -280(%rbp), %rax        
    movb   %al, -272(%rbp)         # Store the length of the first pstring in it's first char
    
    
    /* The second pstring.*/
    movq   $format_s, %rdi         # Store the type of the argument we want to read
    leaq   -271(%rbp), %rsi        # Store the second psring in the stack from -271 to -16. One byte is saved for len2.
    movq   $0, %rax                # Clear %rax before calling scanf
    call   scanf
    
    
    /* The option. */
    movq   $format_d, %rdi         # Store the type of the argument we want to read
    leaq   -16(%rbp), %rsi         # Store opt in the stack from -16 to -8
    movq   $0, %rax                # Clear %rax before calling scanf
    call   scanf
    
    /* Moving data to arguments registers. */         
    movq    -16(%rbp), %rdi        # %rdi first argument. %rdi = opt
    leaq    -536(%rbp), %rsi       # %rsi second argument. %rsi = &p1
    leaq    -272(%rbp), %rdx       # %rdx third argument. %rdx = &p2
    call    run_func
    
.ter:
    # Termination - pop stack frame
    movq    $0, %rax			   # return 0
    addq    $544, %rsp
    movq    %rbp, %rsp
    popq    %rbp
    ret
    

