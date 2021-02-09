	.data
	.text
	.globl main
fun1:
	# k -> $t0
	# *a ->$a0
	# N -> $a1
	# *b ->$a2
	# $f2 valor de a*
	# $f4 valor de b*
	# $f6 const compare
	# $f8 const 2 para dividir
	# p -> $t1

	li $t0,0
	li $2,2
	li $1,1
	
	mtc1 $2,$f8
	mtc1 $0,$f6
	cvt.d.w $f8,$f8
	cvt.d.w $f6,$f6
	
	addu $t2,$a1,$a0
	or $t1,$a0,$0
	
for:
	bge $t1,$t2,end 
	l.d $f2,0($t1)
	
if:	
	div.d $f10,$f2,$f8 
	c.eq.d $f10,$f6 
	bc1t else 
	s.d $f2,0($a2)
	addiu $a2,$a2,8
	j endif 
else:
	addiu $t0,$t0,1
endif:
	addiu $t1,$t1,1
	j for
end:
	
	sub $v0,$a1,$t0
	jr $ra
main:
	jr $ra
