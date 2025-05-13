# conversion.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0, $a1, $a2
#   make all returned values from functions go in $v0

.text
conv:
    li $v0, 0      # reset return register
    li $t0, 0      # loop counter
    li $t2, 2

    loop:
    bge $t0, $a2, return      # enter loop if t0 < a2

    sub $v0, $v0, $a0      # v0 = v0 - a0
    sll $t1, $a1, 2
    add $v0, $v0, $t1      # v0 = v0 + 4*a1

    blt $a0, $t2, inc      # if (a0 >= 2) a1 = a1 - a0      
    sub $a1, $a1, $a0

    inc:
    addi $a0, $a0, 1
    addi $t0, $t0, 1
    j loop

    return:
    jr $ra

main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 5
    li $a1, 7
    li $a2, 7

    jal conv

    move $a0, $v0
    li $v0, 1
    syscall

    li $v0, 10
    syscall