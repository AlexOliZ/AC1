	.data
	.eqv SIZE,5
lista:	.space 20
str:	.asciiz "\n Introduza um nunmero: "
	.align 2	#alinha de 2^2 elementos
	.eqv read_int,5
	.eqv print_string,4
	.text
	.globl main
	
	#	Mapa De Registos
	# i -> $t0
	# &lista -> $t1
	# *lista -> $t2
	# tmp -> $t3
	
main:
	li $t0,0
	la $t1,lista
while:
	bge $t0,SIZE,endw
	
	# print String
	li $v0,print_string 
	la $a0,str
	syscall
	
	# read_int
	li $v0,read_int
	syscall
	
	#ler elemento
	sll $t4,$t0,2
	addu $t2,$t1,$t4
	sw $v0,0($t2)
	
	# index
	addi $t0,$t0,1
	
	j while
endw:
	


	jr $ra