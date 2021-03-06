    .text

main:
    bgez  $a0 fib_entry

fib_entry:
    addiu $sp $sp -28   # we need room for $ra, n, ret, n1, n2, f1, f2
    sw $ra, 24($sp)     # store $ra since not leaf function
    sw $a0, 20($sp)     # store n

    lw $t0, 20($sp)     # load n
    #ble $t0 1 fib_small

    slt $t2, $t0, 1
    bne $t2, $t3, fib_small

    lw $t0, 20($sp)     # load n
    addi $t0 $t0 -1     # n - 1
    sw $t0, 12($sp)     # store as n1

    lw $a0, 12($sp)     # pass n1 as argument
    jal fib_entry
    sw $v0 4($sp)       # store into f1

    lw $t0, 20($sp)     # load n
    addi $t0 $t0 -2     # n - 2
    sw $t0, 8($sp)      # store as n2

    lw $a0, 8($sp)      # pass n2 as argument
    jal fib_entry
    sw $v0 ($sp)        # store into f2

    lw $t0 4($sp)       # f1
    lw $t1 ($sp)        # f2
    addu $t0 $t0 $t1    # f1 + f2
    sw $t0 16($sp)      # store into ret

    

fib_small:
    lw $t0, 20($sp)     # load n
    sw $t0 16($sp)      # store into ret

fib_done:
    lw $v0 16($sp)      # load return value
    lw $ra 24($sp)      # restore $ra
    addiu $sp $sp 28    # restore stack
    jr $ra              # return