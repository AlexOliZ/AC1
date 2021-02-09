	.data
	.text
	.globl main
	
main:
	
	li $t0,0x0f0f	# $t0 = bin
	
	# BIN TO GRAY
	
	srl $t1,$t0,1	# bin << 1
	xor $t1,$t0,$t1	# bin ^ (bin << 1)
	
	# GRAY TO BIN
	
	li $t3,0x0f0f
	sll $t1,$t3,4
	xor $t0,$t1,$t3
	sll $t1,,$t0,2
	xor $t0,$t1,$t0
	sll $t1,$t0,1
	xor $t0,$t1,$t0
	or $t2,$t1,$0

	jr $ra
	