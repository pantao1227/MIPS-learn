main:
	addi $a0, $zero, 3
fact:
	# As callee, to save $ra and $s<>, as caller, to save parameter register $a<>
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)
	sw	$a0, 0($sp)

	slti	$t0, $a0, 1
	beq	$t0, $zero, L1	# if $t0 == $zero then L1 ("L" for a leaf procedure)

	addi	$v0, $zero, 1
	# pop 2 items, nothing changed, so just adjust stack pointer
	addi	$sp, $sp, 8
	jr	$ra

L1:
	addi	$a0, $a0, -1
	jal	fact
	lw	$a0, 0($sp)
	lw	$ra, 4($sp)
	addi	$sp, $sp, 8
	mul	$v0, $a0, $v0
	jr	$ra
    
