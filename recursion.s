.data
	promptUser: .asciiz "Enter the value"
	theString: .space 100
	#Error Messages
	INVALID_INPUT: .asciiz  "Invalid input"

.text
	main:
		#Taking user input as string
		li $v0, 8
		la $a0, theString
		syscall

	la $a0, theString
    jal helperFunction



	

	li $v0, 10
	syscall 

helperFunction:
		move $t0, $a0
		li $s0, 0				#Initializing registers to store value of decimal
		li $s7, 0				# Flag to help check space in the middle of string($s0 is 1 after first non space character is encountered, otherwise 0)
		li $t4, 1				# Initializing power to be multiplied
		li $s1, 30				# Base
	li $t1, 0   # Counter, at the end $t1 will have number of characters(non space) in the string

	length:
		lb $t2, 0($t0)
		beq $t2, 10, checkEmpty     # If \n is encountered move to converting part
		addi $t0, $t0, 1
		beq $t2, 32, checkSpaceLen    # If current character is space move to beginning of the loop without incrementing the counter
		li $s7, 1		     # Whenever nonspace character is encountered set $s7 to 1
		addi $t1, $t1, 1
		bgt $t1, 20, tooLong
		j length

	

	convert:
		beq $t1, 0, printDecimal
		addi $t0, $t0, -1     # Move one character backward in the string
		lb $t2, 0($t0)
		beq $t2, 32, checkSpace   # If character is space go to checkSpace to check whether the space is at middle of string or not
		li $s7, 1			# Whenever nonspace character is encountered set $s7 to 1
		addi $t1, $t1, -1		# Decrement $t1 by 1
		j convertChar

	

	# Ignore the spaces at the end of theString, if space found in the middle print error message
	checkSpace:
		addi $t0, $t0, -1         # Go to one character backward in the string
		lb $t2, 0($t0)
		addi $t1, $t1, -1
		beq $t2, 32, checkSpace   # If character ahead is also space, go to checkSpace
		