# Mapa de registos
# n: $a0 -> $s0
# b: $a1 -> $s1
# s: $a2 -> $s2
# p: $s3
# digit: $t0
# Sub-rotina interm�dia
.globl main

itoa: 	addiu $sp,$sp,-16 # reserva espa�o na stack
 	sw $ra,0($sp) # guarda registos $sx e $ra
 	sw $s0,4($sp)
 	sw $s1,8($sp)
 	sw $s2,12($sp)
 	move $s0,$a0 #n
 	move $s1,$a1 #b
 	move $s2,$a2 #s
 	move $s3,$a2 #p
do: # do {
 	rem $a0,$s0,$s1
 	div $s0,$s0,$s1
 	jal toasscii
 	sb $v0,0($s3)
 	bgt $s0,0,do # } while(n > 0);
 	sb $0,0($s3) # *p = 0;
 	jal strrev # strrev( s );
 	move $v0,$s2 # return s;
 	lw $s0,... # rep�e registos $sx e $ra
 	(...)
 	addiu $sp,... # liberta espa�o na stack
 	jr $ra # 

toasscii:


	jr $ra


main:




	jr $ra
 	
 	
 	
 	
 	
 	
 	
 	