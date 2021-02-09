	.data
str1:	.asciiz "id: "
str2:	.asciiz "first_name: "
str3:	.asciiz "last_name: "
str4:	.asciiz "grade: "
str5:	.asciiz "MAX: "
	.eqv read_str,8
	.eqv read_int,5
	.eqv read_float,6
	.eqv print_str,4
	.eqv print_int,1
	.eqv print_char,11
	.eqv print_float,2
	.eqv S_FIRST,18
	.eqv S_LAST,15
	.eqv MAX_STUDENTS,2
	.align 2
#student:
#	.space 4 	# id 1 word
#	.space 18
#	#.asciiz "" 	# first_name 4º byte até 22º byte
#	.space 2
#	.space 15
#	#.asciiz ""	# last_name 24º byte até 39º byte
#	.space 1
#	.float 0.0	
# espaço total 1+3+18+2+15+1+4 = 44
arr_student: .space 176
	.text 
	.globl main
	
read_data:
	move $t1,$a0	# address na class
	move $t2,$a1	# len(student_array)
	li $t0,0	# student_array[i]
for_class:
	bge $t0,$t2,end_forC
	
	# ---- read id ----
	la $a0,str1
	li $v0,print_str
	syscall
	li $v0,read_int
	syscall
	sw $v0,0($t1)
	#addi $t1,$t1,4
	
	# --- read first_name ---
	la $a0,str2
	li $v0,print_str
	syscall
	addi $a0,$t1,4
	li $a1,S_FIRST
	li $v0,read_str
	syscall
	#addi $t1,$t1,20
	
	# --- read last_name
	la $a0,str3
	li $v0,print_str
	syscall
	addi $a0,$t1,24
	li $a1,S_LAST
	li $v0,read_str
	syscall 
	#addi $t1,$t1,16
	
	# --- read grade ---
	la $a0,str4
	li $v0,print_str
	syscall
	li $v0,read_float
	syscall
	# guardar a grade
	mov.s $f12,$f0
	s.s $f12,40($t1)
	#addi $t1,$t1,4
	
	# próximo student
	addi $t0,$t0,1
	
	# guardar o first_name
#	move $t4,$t1	# ponteiro da string (na class)
#for_first:
#	lb $t3,0($v0)	# $t0 = char[i]
#	sb $t3,0($t4)	# guardar char na string do first_name
#	beq $t3,'\0',end_first
#	addi $v0,$v0,1	# i++
#	addi $t4,$t4,1	# next_address
#	j for_first
#end_first:
	
	# guardar o last_name
#	move $t4,$t1	# address da string
#for_last:	
#	lb $t3,0($v0)	# char[i]
#	sb $t3,0($t4)	# guardar char[i] na string do last_name
#	beq $t3,'\0',end_last
#	addi $v0,$v0,1	# i++
#	addi $t4,$t4,1	# next_address da class
#	j for_first
#end_last:
	addi $t1,$t1,44
	j for_class
end_forC:	
	jr $ra
	
print_student:	# print 1 objeto student
	# address do student
	move $t0,$a0
	
	lw $a0,0($t0)
	li $v0,print_int
	syscall
	# offset -> 4 
	move $t3,$t0
	
	li $a0,'\n'
	li $v0 print_char
	syscall
	
	#addi $t0,$a0,24
	addi $a0,$t0,4
	li $v0,print_str
	syscall
	li $a0,'\n'
	li $v0 print_char
	syscall
	
	addi $a0,$t0,24
	li $v0,print_str
	syscall
	li $a0,'\n'
	li $v0 print_char
	syscall
	
#for_f:	
#	lb $a0,4($t3)
#	beq $a0,'\0',end_f
#	li $v0,print_char
#	syscall
#	addi $t3,$t3,1
#	j for_f
#end_f:
	# offset -> 24
	
#for_l:	
#	lb $a0,24($t3)
#	beq $a0,'\0',end_l
#	li $v0,print_char
#	syscall
#	addi $t3,$t3,1
#	j for_l
#end_l:
	
	l.s $f12,40($t0)
	li $v0,print_float
	syscall
	li $a0,'\n'
	li $v0 print_char
	syscall
	
	jr $ra
	
max_grade:
	# iniciar o comparador e maximo
	li $t0,0
	mtc1 $t0,$f12
	cvt.s.w $f12,$f12 
	
for_max:
	bge $t0,$a1,end_max
	l.s $f1,40($a0)
if:
	c.le.s $f1,$f12
	bc1t endif
	mov.s $f12,$f1
	cvt.s.w $f12,$f12	
endif:
	addi $t0,$t0,1
	addi $a0,$a0,44
	j for_max
end_max:

	li $v0,print_float
	syscall
	jr $ra
	
main:
	subu $sp,$sp,-8
	sw $ra,0($sp)
	sw $ra,4($sp)
	
	la $a0,arr_student
	li $a1,MAX_STUDENTS
	jal read_data
	
	la $a0,arr_student
	li $a1,MAX_STUDENTS
	jal max_grade
	
	la $a0,str4
	li $v0,print_str
	syscall	
	li $v0,print_float
	syscall
	li $a0,'\n'
	li $v0 print_char
	syscall
	
	lw $ra,4($sp)
	addiu $sp,$sp,4
	
	la $t0,arr_student
	li $t1,0
for:
	bge $t1,MAX_STUDENTS,end_for
	move $a0,$t0
	jal print_student
	addi $t0,$t0,44
	addi $t1 ,$t1,1
	j for
end_for:
	
	lw $ra,0($sp)
	addiu $sp,$sp,4
	jr $ra
