.data 
input: .asciiz "The x number="
line: .asciiz "\n"
null: .asciiz "a is null\n"
msga: .asciiz "The a number="
msgb: .asciiz "The b number="
.text
.globl main
main:
	li $v0, 4
	la $a0, input
	syscall
	li $v0, 5
	syscall
	add $t1,$zero,$v0
	add $s1,$zero,$t1 #a=x
	add $s2,$zero,$t1 #b=x
	beq $t1,1,one #if(x==1)
	beq $t1,2,two #if(x==2)
	beq $t1,3,three #if(x==3)
	add $t2,$zero,2 #i=2
	add $t6,$zero,2
	#else
whilea:	sub $s1,$s1,1	#while(--a) #3
	add $t2,$zero,2
trya:	add $t3,$zero,$s1 #x=a #x=3
	add $t5,$zero,$t2	#y=i #y=2
diva:	sub $t3,$t3,$t5		#x=x-y #x=x-2
	slt $t4,$t3,$zero	#�p�Gt3<���ơA����t4��1�A�_�h��0
	beq $t4,1,Inca	#���㰣
	beq $t3,$zero,whilea	#�i�H�Q�㰣(���O���)
	j diva
	slt $t4,$t2,$s1	#�p�Gi<a,����t4��1,�_�h��0
Inca:	addi $t2,$t2,1	#i++
	beq $t2,$s1,Pa	#�p�Gi==a�A����N�L�Xa
	j trya
	j whilea
	#print
Pa:	li $v0,4
	la $a0,msga
	syscall
	add $a0,$zero,$s1
	li $v0,1
	syscall
	li $v0,4
	la $a0,line
	syscall
whileb:	addi $s2,$s2,1	#while(++b) #3
	add $t6,$zero,2
tryb:	add $t3,$zero,$s2 #x=a #x=3
	add $t5,$zero,$t6	#y=i #y=2
divb:	sub $t3,$t3,$t5		#x=x-y #x=x-2
	slt $t4,$t3,$zero	#�p�Gt3<0�A����t4��1�A�_�h��0
	beq $t4,1,Incb	#���㰣
	beq $t3,$zero,whileb	#�i�H�Q�㰣(���O���)
	j divb
	slt $t4,$t6,$s2	#�p�Gi<a,����t4��1,�_�h��0
Incb:	addi $t6,$t6,1	#i++
	beq $t6,$s2,Pb	#�p�Gi==a�A����N�L�Xa
	j tryb
	j whileb	
Pb:	li $v0,4
	la $a0,msgb
	syscall
	add $a0,$zero,$s2
	li $v0,1
	syscall
	li $v0,10
	syscall
one:	li $v0,4
	la $a0,null
	syscall
	add $s2,$zero,2
	li $v0,4
	la $a0,msgb
	syscall 
	add $a0,$zero,$s2
	li $v0,1
	syscall
two:	li $v0,4
	la $a0,null
	syscall
	add $s2,$zero,3
	li $v0,4
	la $a0,msgb
	syscall
	li $v0,1
	add $a0,$zero,$s2
	syscall
three:	li $v0,4
	la $a0,msga
	syscall
	add $s1,$zero,2
	li $v0,1
	add $a0,$zero,$s1
	syscall
	li $v0,4
	la $a0,line
	syscall
	li $v0,4
	la $a0,msgb
	syscall
	add $s2,$zero,5
	li $v0,1
	add $a0,$zero,$s2
	syscall
