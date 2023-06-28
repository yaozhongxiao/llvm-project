# llc build for object file

The following command can generate the ch3.cpu0.o which is the elf format files
```
llc -march=cpu0 -relocation-model=pic -filetype=obj ch3.bc -o ch3.cpu0.o
```

# llc build for asm file

The following command can generate the assembly text files ch3.cpu0.s
```
llc -march=cpu0 -relocation-model=pic -filetype=asm ch3.bc -o ch3.cpu0.s
```

```
	.text
	.section .mdebug.abiO32
	.previous
	.file	"ch3.cpp"
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
	.ent	main                            # @main
main:
	.frame	$fp,8,$lr
	.mask 	0x00001000,-4
	.set	noreorder
	.set	nomacro
# %bb.0:
	addiu	$sp, $sp, -8
	st	$fp, 4($sp)                     # 4-byte Folded Spill
	move	$fp, $sp
	addiu	$2, $zero, 0
	st	$2, 0($fp)
	move	$sp, $fp
	ld	$fp, 4($sp)                     # 4-byte Folded Reload
	addiu	$sp, $sp, 8
	ret	$lr
	.set	macro
	.set	reorder
	.end	main
$func_end0:
	.size	main, ($func_end0)-main
                                        # -- End function
	.ident	"Apple clang version 14.0.3 (clang-1403.0.22.14.1)"
	.section	".note.GNU-stack","",@progbits
```