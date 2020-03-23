.data
	promptUser: .asciiz "Enter the value"
	theString: .space 1000
	#Error Messages
	INVALID_INPUT: .asciiz  "Invalid input"

.text
	main:
		#Taking user input as string
		li $v0, 8
		la $a0, theString
		syscall




	

	li $v0, 10
	syscall 