#Firstly try to accomplish 8 queens problem
#No malloc system, do not input number larger than 8
#By haldak 2016.5.4

.data
Site:
	.space 32					#allocate 8*4 consecutive bytes
__string: 
	.asciiz "Eight Queen problems, entering the number of queens:"

.text		
	la $s7, Site					#global Site[]
main:		
	li $v0, 4					#print string
	la $a0, __string
	syscall
		
	li $v0, 5					#read integer, scanf the number of queens
	syscall		
	addi $s6, $v0, 0				#QUEENS = cin
	
	li $a0, 0					#n = 0
	li $v0, 0					#iCount = 0
		
	jal Queen
	
	addi $a0, $v0, 0				#$a0 = iCount[return]
	li $v0, 1					#print integer m($1)
	syscall
		
	li $v0, 10					#exit
	syscall
		
Queen:		
	li $s0, 1					#int i = 1
	beq $a0, $s6, branch1				#n == QUEENS
	j loop1
	branch1:		
		addi $v0, $v0, 1			#iCount += 1
		j exit					#return			
	loop1:	
		slt $t1, $s6, $s0			#$ti = (QUEENS < i) ? 1 : 0	
		bnez $t1, exit				#i > QUEENS, exit
		mul $t7, $a0, 4				#n * 4
		addu $t2, $s7, $t7			#Site + n
		sw $s0, 0($t2)				#Site[n] = i
		li $t3, 0				#j = 0
		j loop2
	loop2:
		slt $t4, $t3, $a0		#$t4 = (j < n) ? 1 : 0
		beqz $t4, branch3		#j >= n, return1
		mul $t7, $t3, 4			#j * 4
		addu $t5, $s7, $t7		#Site + j
		lw $s5, 0($t5)			#$s5 = Site[j]
		beq $s5, $s0, branch2		#if Site[j] == Site[n]
		sub $t6, $s5, $s0		#Site[j] - Site[n]
		abs $t6, $t6			#abs $t6
		subu $t7, $a0, $t3		#n-j
		beq $t6, $t7, branch2		#if abs == n-j
		addi $t3, $t3, 1		#j++
		j loop2
	branch2:
		addi $s0, $s0, 1		#i++
		j loop1
	branch3:
		#Save in stack
		addi $sp, $sp, -12
		sw $ra, 8($sp)			#Save $ra
		sw $a0, 4($sp)			#Save n
		sw $s0, 0($sp)			#Save i
		addi $a0, $a0, 1		#n++
		jal Queen
			
		#Recover from Stack
		lw $s0, 0($sp)			#Get i
		lw $a0, 4($sp)			#Get n
		lw $ra, 8($sp)			#Get $ra
		addi $sp, $sp, 12	
		j branch2				
	exit:
		jr $ra					#Queen's return
		
