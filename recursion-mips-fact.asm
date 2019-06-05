main:
	addi $a0, $zero, 3
fact:
	#作为被调用者（callee），负责保护 $ra 和 $s<>，作为调用者（caller），负责保护参数寄存器 $a<>
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)
	sw	$a0, 0($sp)

	slti	$t0, $a0, 1
	beq	$t0, $zero, L1	# if $t0 == $zero then L1 ("L" for a leaf procedure)

	addi	$v0, $zero, 1
	#出栈，没有修改内容，所以仅仅移动指针
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
    
