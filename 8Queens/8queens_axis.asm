#8 Queens Problem_malloc_axis
#By haldak
#2016.5.5
#WARNING: It's meaningless when set N larger than 20, since the result goes too large to calculate.

.data
__string: .asciiz "Eight Queen problems, entering the number of N:"
Column: .space 80					#20 * word(4 bytes)
MainDiag: .space 160					#40 * word(4 bytes)
SubDiag: .space 160					#40 * word(4 bytes)

.text
la $s6 Column						#$s6 -> Column[0]
la $s5 MainDiag						#$s5 -> MainDiag[0]
la $s4 SubDiag						#$s4 -> SubDiag[0]
Main:
	li $v0, 4					#put string
	la $a0, __string	
	syscall
	
	li $v0, 5					#read integer
	syscall
	addi $s7, $v0, 0				#$s7 = N
	
	li $a0, 0					#n = 0
	li $v0, 0					#iCount = 0
	jal Queen
	
	addi $a0, $v0, 0				#print integer
	li $v0, 1
	syscall
	
	li $v0, 10					#exit
	syscall

Queen:
	li $s0, 0					#int i = 0
	#if(n == N)
	beq $a0, $s7, branch1				#if n == N
	j loop1
	
	branch1:
		addi $v0, $v0, 1			#iCount++
		j exit
		
	loop1:
		#if(i < N)
		slt $t0, $s0, $s7			#$t0 = (i < N) ? 1 : 0
		beqz $t0, exit				#if i > = N, exit
		
		#if(Column[i] == 0 && MainDiag[N - 1 - n + i] == 0 && SubDiag[n + i] == 0)
		mul $t0, $s0, 4				#shift i in 4
		addu $t1, $s6, $t0			#$t1 -> Column[i]
		lw $t7, 0($t1)				#$t7 = Column[i]
		
		addu $t2, $s7, $s0			#$t2 = i + N
		subu $t2, $t2, $a0			#$t2 = N + i - n
		subi $t2, $t2, 1			#$t2 = N - 1 - n + i
		mul $t2, $t2, 4				#shift in 4
		addu $t2, $t2, $s5			#$t2 -> MainDiag[N - 1 - n + i]	
		lw $t6, 0($t2)				#$t6 = MainDiag[N - 1 - n + i]
				
		addu $t3, $a0, $s0			#$t3 = n + i
		mul $t3, $t3, 4				#shift in 4
		addu $t3, $t3, $s4			#$t3 -> SubDiag[n + i]
		lw $t5, 0($t3)				#$t5 = SubDiag[n + i]
		
		bnez $t7, branch2			#Colunm[i] != 0, branch2
		bnez $t6, branch2			#MainDiag[N - 1 - n + i] != 0, branch2
		bnez $t5, branch2			#SubDiag[n + i] != 0, branch2
		
		#Update Col, Diag
		li $t0, 1				#$t0 = 1
		sw $t0, 0($t1)				#Colunm[i] = 1
		sw $t0, 0($t2)				#MainDiag[N - 1 - n + i] = 1
		sw $t0, 0($t3)				#SubDiag[n + i] = 1
		
		#Put elements into stack
		subi $sp, $sp, 12			
		sw $s0, 8($sp)				#save i
		sw $a0, 4($sp)				#save n
		sw $ra	0($sp)				#save iCount
		
		addi $a0, $a0, 1			#n++
		jal Queen
		
		#Get elements from stack
		lw $ra 0($sp)				#get iCount
		lw $a0 4($sp)				#get n
		lw $s0 8($sp)				#get i
		addi $sp, $sp, 12
		
		#Backdate Col, Diag
		mul $t0, $s0, 4				#shift i in 4
		addu $t1, $s6, $t0			#$t1 -> Column[i]
		
		addu $t2, $s7, $s0			#$t2 = i + N
		subu $t2, $t2, $a0			#$t2 = N + i - n
		subi $t2, $t2, 1			#$t2 = N - 1 - n + i
		mul $t2, $t2, 4				#shift in 4
		addu $t2, $t2, $s5			#$t2 -> MainDiag[N - 1 - n + i]	
				
		addu $t3, $a0, $s0			#$t3 = n + i
		mul $t3, $t3, 4				#shift in 4
		addu $t3, $t3, $s4			#$t3 -> SubDiag[n + i]
		
		sw $0, 0($t1)				#Colunm[i] = 0
		sw $0, 0($t2)				#MainDiag[N - 1 - n + i] = 0
		sw $0, 0($t3)				#SubDiag[n + i] = 0
		
		j branch2
		
	branch2:
		#i++
		addi $s0, $s0, 1			#i++
		j loop1
		
	exit:
		#return iCount
		jr $ra					#return iCount