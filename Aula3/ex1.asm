# Mapa de registos:
# $t0 – soma
# $t1 – value
# $t2 - i
 .data
	str1: .asciiz "Introduza um numero: "
	str2: .asciiz "Valor ignorado"
	str3: .asciiz "A soma dos positivos e: "
	.eqv print_string,4
 	.eqv read_int,5
 	.text
 	.globl main
main: 
	li $t0,0 # soma = 0;
 	li $t1,0 # i = 0;
 	
for: bge $t1,5,endfor # while(i < 5) {
	
	la $a0,str1
	ori $v0,$0,print_string
 	syscall # print_string("...");
 	
 	ori $v0,$0,read_int # value=read_int();
 	syscall
 	or $t2,$0,$v0	#t2 = value
	ble $t2,$0,else # if(value > 0)
	add $t0,$t0,$t2 # soma += value;
 	
 	j endif #
 	
else: 	#(...)# else
 	# print_string("...");
 	la $a0,str2
 	ori $v0,$0,print_string
 	syscall
endif: 
	addi $t1,$t1,1 # i++;
 	j for # }
	
endfor:
 	
 	# print_string("...");
 	la $a0,str3
 	ori $v0,$0,print_string
 	syscall
 	
 	# print_int10(soma);
 	or $a0,$0,$t0
 	ori $v0,$0,1
 	syscall
 jr $ra