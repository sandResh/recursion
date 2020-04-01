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
		beq $s7, 1, invalidChar          # If character is not space, check whether a non space character is encountered already, if yes($s7=1) add one to the length($t1)
		add $t0, $t0, 1				# Before going back to convert increment character in the string, because character is decremented at the beginning of 								convert
		j convert 					# jump to convert
	
	checkSpaceLen:
		beq $s7, 0, length
		add $t1, $t1, 1
		j length

	checkEmpty:
		beq $t1, 0, empty
		li $s7, 0 		# Reset $s7 to 0 before converting
		j convert

	# Convert valid characters to decimal and increments the result, return error if invalid character is found
	convertChar:
		blt $t2, 48, invalidChar      	# If char is less than 48, invalid char
		blt $t2, 58, convertNum  	# If char is between 48 and 57, char is a number

		blt $t2, 65, invalidChar
		blt $t2, 85, convertUpper
		blt $t2, 97, invalidChar
		blt $t2, 117, convertLower

		j invalidChar

	convertNum:
		addi $t5, $t2, -48				# Get the value of number character
		j compute

	convertUpper:
		addi $t5, $t2, -55
		j compute

	convertLower:
		addi $t5, $t2, -87
		j compute

	compute:
		mult $t5, $t4 					# Multilpy the value with power
		mflo $t5					# Move result of multiplication to $t5
		add $s0, $s0, $t5 				# Increment the decimal value by result of multiplication
		mult $t4, $s1					# Multiply the power by 30
		mflo $t4
		j convert 					# Jump back to convert

	