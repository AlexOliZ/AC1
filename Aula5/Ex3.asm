# Mapa de registos
#i: $t0
#valor: $t1
#lista: $t2
# houve_troca: $t4
# i: $t5
# lista: $t6
# lista + i: $t7
 	.data
 	.eqv FALSE,0
 	.eqv TRUE,1
 	.eqv SIZE,10
 	.eqv SIZE_M,9
 	.eqv print_int10,1
 	.eqv print_string,4
 	.eqv read_int10,5

str1:	.asciiz	"\nIntroduza um número: "
	.align 2
str2:	.asciiz "\nConteúdo do array:\n"
	.align 2
str3: 	.asciiz "; "
	.align 2
	
lista:  .space 40	
 	.align 2
 	.text
 	.globl main
main: 	# código para leitura de valores
w1:	beq $t0,SIZE_M,endw1
	li $v0,print_string
	la $a0,str1
	syscall
	li $v0,read_int10
	#move $a0,$t1
	syscall
	la $t2,lista
	sll $t2,$t0,2 #
 	addu $t2,$t1,$t2 # $t2 = &lista[i]
	sw $v0,0($t2)
	addi $t0,$t0,1
 	j w1
endw1:	
 	la $t6,lista #
 		
do: # do {
 	li $t4,FALSE # houve_troca = FALSE;
 	li $t5,0 # i = 0;
w2: 	bge $t5,SIZE_M,endw2 # while(i < SIZE-1){
if: 	sll $t7,$t5,2 # $t7 = i * 4
 	addu $t7,$t7,$t6 # $t7 = &lista[i]
 	lw $t8,0($t7) # $t8 = lista[i]
 	lw $t9,4($t7) # $t9 = lista[i+1]
 	ble $t8,$t9,endif # if(lista[i] > lista[i+1]){
 	sw $t8,4($t7) # lista[i+1] = $t8
 	sw $t9,0($t7) # lista[i] = $t9
 	li $t4,TRUE #
 	# }
	endif: addi $t5,$t5,1 # i++;
 	j w2 # }
 endw2:
 	beq $t4,TRUE,do # } while(houve_troca == TRUE);
	li $v0,print_string
	la $a0,str2
	syscall
	
	la $t0, lista		# p = lista (posição em memória do início do array)		
				# $t2 = lista + size; (posição em memória do fim do array)
	li $t2, SIZE		# $t2 = size	
	sll $t2, $t2, 2		# $t2 = size * 4 (each word uses 4 positions in memory)
	addu $t2, $t2, $t0	# $t2 = $t2 + $t0 == size * 4 + list
	
w3: 	bge $t0,$t2,endw3# codigo de impressao do
 	lw $t1,0($t0) # $t1 = *p;
 	li $v0,print_int10
 	move $a0,$t1
 	syscall
 	
 	li $v0, print_string	# 	print_string("; ");
	la $a0, str3
	syscall			

	sll $t0,$t0,2	# 	$t0++ = p++;

 	
 	j w3
 endw3:
 	# conteudo do array
 jr $ra # termina o programa 
