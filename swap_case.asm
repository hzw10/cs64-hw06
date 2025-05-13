# swap_case.asm program
# For CMPSC 64
#
# Data Area
.data
    buffer:         .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:  .asciiz "Output:\n"
    convention:     .asciiz "Convention Check\n"
    newline:        .asciiz "\n"

.text

#
# DO NOT MODIFY THE MAIN PROGRAM 
#       OR ANY OF THE CODE BELOW, WITH 1 EXCEPTION!!!
# YOU SHOULD ONLY MODIFY THE SwapCase FUNCTION 
#       AT THE BOTTOM OF THIS CODE
#
main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    li $s1, 0
    li $s2, 0
    li $s3, 0
    li $s4, 0
    li $s5, 0
    li $s6, 0
    li $s7, 0

    move $a0, $s0
    jal SwapCase

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $zero, -1
    addi    $t1, $zero, -1
    addi    $t2, $zero, -1
    addi    $t3, $zero, -1
    addi    $t4, $zero, -1
    addi    $t5, $zero, -1
    addi    $t6, $zero, -1
    addi    $t7, $zero, -1
    ori     $v0, $zero, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    li $v0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

# YOU CAN ONLY MODIFY THIS FILE FROM THIS POINT ONWARDS:
SwapCase:
    #TODO: write your code here, $a0 stores the address of the string
    
    addi $sp, $sp, -28
    sw $s0, 0($sp) 
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $s5, 20($sp)
    sw $ra, 24($sp)

    li $s1, 65
    li $s2, 90
    li $s3, 97
    li $s4, 122
    move $s5 $a0
    
    loop:
    lb $s0, 0($s5)
    beq $s0, $zero, return

    blt $s0, $s1, nxtChar
    ble $s0, $s2, toLower

    bgt $s0, $s4, nxtChar
    bge $s0, $s3, toUpper

    nxtChar:
    addi $s5, $s5, 1
    j loop

    toUpper:
    li $v0, 11
    lb $a0, 0($s5) 
    syscall
    li $a0, 10
    syscall

    addi $s0, $s0, -32
    sb $s0, 0($s5)

    lb $a0, 0($s5)
    syscall
    li $a0, 10
    syscall
    jal ConventionCheck
    j nxtChar

    toLower:
    li $v0, 11
    lb $a0, 0($s5)
    syscall
    li $a0, 10
    syscall

    addi $s0, $s0, 32
    sb $s0, 0($s5)

    lb $a0, 0($s5)
    syscall
    li $a0, 10
    syscall
    jal ConventionCheck
    j nxtChar

    return:
    lw $s0, 0($sp) 
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $s4, 16($sp)
    lw $s5, 20($sp)
    lw $ra, 24($sp)
    addi $sp, $sp, 28
    # Do not remove the "jr $ra" line below!!!
    # It should be the last line in your function code!
    jr $ra
