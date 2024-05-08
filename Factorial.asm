# By Cayden Ronning
# Calculates the factorial value of the given integer.
# (a factorial is the product of all positive integers 
# less than or equal to a given positive integer)

			.text
# Ask for a number
restart:
			
			la		   $a0, question # Load address of question string
			li		   $v0, 4		 # syscall 4 prints a string
			syscall
			
    		addi       $a0, $0, 10   # ASCII code 10 is a line feed
    		li         $v0, 11       # syscall 11 prints character in $a0
    		syscall

# Read in the number

    		li         $v0, 5        # syscall 5 reads in an integer
    		syscall
    		
    		move	   $t0, $v0		 # Store result in $t0 (prints at the end)
    		move	   $t1, $v0		 # Store result in $t1 (subtracted in loop)
    		move	   $t2, $v0		 # Store result in $t1 (result of mult, starts at given)

# Check for invalid input

			blez 	   $t0, invalid	 # If input is less than or equal to 0...
			b		   valid		 # Otherwise, continue as normal
			
invalid:

			# Print error message
			la		   $a0, pInvalid # Load address of pInvalid string
			li		   $v0, 4		 # syscall 4 prints a string
			syscall
			
    		addi       $a0, $0, 10   # ASCII code 10 is a line feed
    		li         $v0, 11       # syscall 11 prints character in $a0
    		syscall
    		syscall

    		b		   restart		 # Ask for a number again
    		
valid:

# Calculate factorial value
multLoop:
			
			# Increment down by one; if 0 reached, end loop
			add		   $t1, $t1, -1
			beq 	   $t1, 0, exitLoop
			
			mult	   $t2, $t1		 # Multiply current total by next number
			mflo	   $t2

			b		   multLoop
			
exitLoop:

			# Print starting number
			move	   $a0, $t0
			li		   $v0, 1		 # syscall 1 prints an integer
			syscall

			# Print "! = "
			la		   $a0, print	 # Load address of print string
			li		   $v0, 4		 # syscall 4 prints a string
			syscall
			
			# Print result
			move	   $a0, $t2
			li		   $v0, 1		 # syscall 1 prints an integer
			syscall
			
    		li         $v0, 10        # syscall 10 terminates program execution
    		syscall
		
# Stores text for printing
			.data
question:	.asciiz "Please provide a positive integer to find the factorial:"
print:		.asciiz "! = "
pInvalid:	.asciiz "Not a positive integer!"