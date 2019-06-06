# 汇编语言递归实例分析

2019年6月5日

> 下面是一个计算阶乘的递归过程

``` c
int fact (int n)
{
    if (n < 1) return (1);
    else return (n* fact(n - 1));
}
```

> 对应的 `MIPS` 汇编代码

``` mipsasm
fact:
    #作为被调用者（callee），负责保护 $ra 和 $s<>
    #作为调用者（caller），负责保护参数寄存器 $a<>
    addi    $sp, $sp, -8
    sw      $ra, 4($sp)
    sw      $a0, 0($sp)

    slti    $t0, $a0, 1
    beq     $t0, $zero, L1

    addi    $v0, $zero, 1
    #出栈，没有修改内容，所以仅仅移动指针
    addi    $sp, $sp, 8
    jr      $ra

L1:
    addi    $a0, $a0, -1
    jal     fact
    lw      $a0, 0($sp)
    lw      $ra, 4($sp)
    addi    $sp, $sp, 8
    mul     $v0, $a0, $v0
    jr      $ra
```

> 执行过程分析

在 `MARS 4.5` 中，设定 `$a0=3` ，从运行结果来看：

``` mipsasm
lw      $a0, 0($sp)
```

分配的地址是 `0x004002c`，`$ra` 初始值为 `0x00000000`

内存状态：

addr | value | 备注 |
:-: | :-: | :-: |
0x7fffefc0 | 0x00000000 | × |
0x7fffefc4 | 0x00000000 | × |
0x7fffefc8 | 0x00000000 | × |
0x7fffefcc | 0x00000000 | × |
0x7fffefd0 | 0x00000000 | × |
0x7fffefd4 | 0x00000000 | × |
0x7fffefd8 | 0x00000000 | × |
0x7fffefdc | 0x00000000 | 最后一个 `$a0` 的值，虽然是 `0`，但是堆栈指针已经修改，不影响后面的乘法运算 |
0x7fffefe0 | 0x0040002c | `lw      $a0, 0($sp)` 所在地址 |
0x7fffefe4 | 0x00000001 | `$a0-1-1` |
0x7fffefe8 | 0x0040002c | `lw      $a0, 0($sp)` 所在地址 |
0x7fffefec | 0x00000002 | `$a0-1` |
0x7fffeff0 | 0x0040002c | `lw      $a0, 0($sp)` 所在地址 |
0x7fffeff4 | 0x00000003 | 初始 `$a0` |
0x7fffeffc | 0x00000000 | 初始 `$ra` |

根据上述分析，这段程序就是把每一步的参数和函数（地址）展开到内存里。
