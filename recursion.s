# this program uses the third approach to re-implement project 2 i.e processing the user input in a subprogram and using registers only for parameters and return values.
.data
user_input: .space 11000
input_value_empty: .asciiz "Input is empty."
input_value_invalid: .asciiz "Invalid base-27 number."
input_too_long: .asciiz "Input is too long."

.text
main:
li $v0, 8                                   #  syscall code to get user input
la $a0, user_input                          #  loading byte space into address
li $a1, 11000                               #  allocating byte space for input string