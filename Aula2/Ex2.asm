	.data
 	.text
	.globl main
main: 	li $t0,0x12345678
	sll $t1,$t0,1 	# Shift left logical
	srl $t2,$t0,1 	# Shift right logical
	sra $t3,$t0,1 	# Shift right arithmetic 
 	
 	sll $t1,$t0,4 	# Shift left logical
	srl $t2,$t0,4 	# Shift right logical
	sra $t3,$t0,4 	# Shift right arithmetic 
	
	sll $t1,$t0,16 	# Shift left logical
	srl $t2,$t0,16	# Shift right logical
	sra $t3,$t0,16	# Shift right arithmetic 
 	
 	#Passar para de BIN para GRAY
 	srl $t1,$t0,1
 	xor $t1,$t1,$t0
 	
 	#GRAY to BIN
 	or $t4,$0,$t0
 	srl $t4,$t0,4
 	xor $t4,$t4,$t0
 	srl $t4,$t0,2
 	xor $t4,$t4,$t0
 	srl $t4,$t0,1
 	xor $t4,$t4,$t0
 	or $t5,$0,$t4
 	
 	
 	jr $ra 			# fim do programa

