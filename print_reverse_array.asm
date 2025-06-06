# print_array.asm program
# For CMPSC 64
#
# Don't forget to:
#   make all arguments to any function go in $a0, $a1
#   make all returned values from functions go in $v0

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout:  .asciiz "The contents of the array are:\n"

.text
printArr:
	sll $t0, $a1, 2     
	add $t0, $t0, $a0
	addi $t0, $t0, -4      # t0 points to last item
	
	move $t1, $a0      # t1 points to first item
	
	loop:
    blt $t0, $t1, return      # enter loop if t0 points to valid item
	
	li $v0, 1
	lw $a0, 0($t0)
	syscall      # print item
	
	li $v0, 11
	li $a0, 10
	syscall      # print newline
	
	addi $t0, $t0, -4      # t0 points to previous item
	j loop

	return:
	jr $ra

main:  # DO NOT MODIFY THE MAIN SECTION
	li $v0, 4
	la $a0, cout
	syscall

	la $a0, array
	li $a1, 10

	jal printArr

	li $v0, 10
	syscall
	