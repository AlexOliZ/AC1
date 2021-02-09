	.data
str1:	.asciiz "id: "
str2:	.asciiz "first_name: "
str3:	.asciiz "last_name: "
str4:	.asciiz "grade: "
	.eqv read_str,8
	.eqv read_int,5
	.eqv read_float,6
	.eqv print_str,4
	.eqv print_int,1
	.eqv print_float,2
	.eqv S_FIRST,18
	.eqv S_LAST,15
	.eqv MAX_STUDENTS,4
	.align 2
student:
	.byte 0 	# id 1º byte
	.space 3 	# align ...
	.asciiz "" 	# first_name 4º byte até 22º byte
	.space 2
	.asciiz ""	# last_name 24º byte até 39º byte
	.space 1
	.float 0.0	
# espaço total 1+3+18+2+15+1+4 = 44
arr_student: .space 176
	.text 
	.globl main
	
read_data:
	# recebe como arg o address para adicionar 
	la $t0,student	
	la $t1,$a0
for:
	# ---- read id ----
	la $a0,str1
	li $v0,print_str
	syscall
	li $v0,read_int
	syscall
	# guardar o id
	sb $v0,0($t1)
	addi $t1,$t1,4
	
	# --- read first_name ---
	la $a0,str2
	li $v0,print_str
	syscall
	li $a0,S_FIRST
	li $v0,read_str
	syscall
	# guardar o first_name
for_first:
	bge $t1,22,end_first
	sb $v0,0($t1)
	addi $v0,$v0,1
	addi $t1,$t1,1
	j for_first
end_first:
	addi $t1,$t1,2
	# --- saved first_name ---
	
	# --- read last_name
	la $a0,str3
	li $v0,print_str
	syscall
	li $a0,S_LAST
	li $v0,read_str
	syscall 
	# guardar o last_name
for_last:
	bge $t1,39,end_last
	sb $v0,0($t1)
	addi $v0,$v0,1
	addi $t1,$t1,1
	j for_last
end_last:
	addi $t1,$t1,1
	# --- saved last_name ---
	
	# --- read grade ---
	la $a0,str4
	li $v0,print_str
	syscall
	li $v0,read_float
	syscall
	# guardar a grade
	s.s $f12,0($t1)
	
	# próximo student
	# addi $t0,44 # se usar offset em vez de incrementar o ponteiro ...
	j for
endfor:	
	
	jr $ra
	
max:
	
	
	jr $ra
	
print_student:
	
	
	jr $ra
	
main:
	
	
	jr $ra
#	Estrutura
# id         ->  4 bytes	
# first_name ->	18 bytes
# last_name  -> 15 bytes
# float	     ->  4 bytes 
# total      ->  31 bytes

Allocator.Student:
	# ID
	li $a0,$a0
	# INICIAR FIRST_NAME
	lw $a1,0($a1)
	# INICIAR LAST_NAME
	
	# INICIAR GRADE
	li $v0,9
	syscall
	jr $ra
	
	
