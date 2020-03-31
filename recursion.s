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