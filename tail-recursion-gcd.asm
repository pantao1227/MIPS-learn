main:
	addi $a0,$zero, 27
	addi $a1,$zero, 18
gcd:
	beq $a1, $zero, gcd_exit
	div $a0, $a1
	add $a0, $a1, $zero
	mfhi $a1
	j gcd
	
gcd_exit:
	add $v0, $a0, $zero
	#jr $ra