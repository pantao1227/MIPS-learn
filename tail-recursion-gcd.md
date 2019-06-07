# Tail Recursion Case Study

This is a C program to figure out the great common divisor of to number

```C
int GCD(int ,int y)
{   
   if(y == 0) 
     return x;
   else
     return GCD(y, x % y);
}
```

It can find out that this function return itself, that is to say, in each cycle just the parameters are changed. we just need to update the parameters and determine when to exit. This is the tail recursion.

The corresponding asm code is:

```mipsasm
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
```

Run it in Mars and got `$v0 = 9`.