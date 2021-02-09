#void main(void)
#{
# unsigned int value, bit, i;

 #print_string("Introduza um numero: ");
 #value = read_int();
 #print_string("\nO valor em binário e': ");
 #for(i=0; i < 32; i++)
 #{
 #bit = value & 0x80000000; // isola bit 31
 #if(bit != 0)
 #print_char('1');
 #else
 #print_char('0');
 #value = value << 1; // shift left de 1 bit
 #}
#}

# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i
	.data
	str1: .asciiz "Introduza um numero: "
	str2: .asciiz "valor em binário e: "
 	.eqv print_string,4
 	.eqv read_int,5
 	.eqv read_char,12
 	.eqv print_char,11    
 	.text 	
 	.globl main
main:   la $a0,str1
 	li $v0,print_string 		# (instrução virtual)
 	syscall 			# print_string(str1);
 	
 	ori $v0 ,$0,read_int		# value=read_int();
 	syscall
 	or $t0,$0,$v0
 	
 	la $a0,str2
 	li $v0 ,print_string		# print_string("...");
 	syscall
 	
 	li $t2,0 			# i = 0
	
for: bge $t2,32,endfor 			# while(i < 32) {
 		
 	andi $t1,$0,0x80000000 		# (instrução virtual)
 	bne $t1,$0,else 		# if(bit != 0)
 	
 	li $a0,'1'
 	li $v0 ,print_char
 	syscall 			# print_char('1');

else: 					# else
	li $a0,'0'
 	li $v0 ,print_char
 	syscall 				# print_char('0');
 					# value = value << 1;
 	addi $t1,$t1,1			# i++;
 	j for 				# }

endfor: 				#
 
 
 jr $ra 				# fim do programa 