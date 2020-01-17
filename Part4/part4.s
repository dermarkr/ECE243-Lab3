/* Program that converts a binary number to decimal */
           .text               		// executable code follows
           .global _start
_start:
            MOV    	R4, #N
            MOV    	R5, #Digits  	// R5 points to the decimal digits storage location
			MOV    	R8, #Divisor 
			LDR    	R8, [R8]     	// Loading the divisor to a registor
			MUL	   	R9, R8, R8		// Creating Multiples of the Divisor
			MUL	   	R10, R8, R9
            LDR    	R4, [R4]     	// R4 holds N
            MOV    	R0, R4       	// parameter for DIVIDE goes in R0
            BL     	DIVIDE
			STRB   	R7, [R5, #3] 	// Thousands digit is now in R7
			STRB   	R6, [R5, #2] 	// Hundreds digit is now in R6
            STRB   	R1, [R5, #1] 	// Tens digit is now in R1
            STRB   	R0, [R5]     	// Ones digit is in R0
END:        B      	END

/* Subroutine to perform the integer division R0 / 10.
 * Returns: quotient in R1, and remainder in R0
*/
DIVIDE:   	MOV    	R2, #0			// Setting the quotients to zero
			MOV	   	R6, #0
			MOV    	R7, #0
DTHOU:		CMP    	R0, R10			// Checking if the value is greater than the Divisor to the fourth power 
            BLT    	DHUND			// Moving to the next function if Divisor is greater than the remaining value
            SUB    	R0, R10			// Subtracting the divisor from the remaining value
            ADD    	R7, #1			// incrementing Thousands value for each time through the full function
            B      	DTHOU			// going back to beginning of function 
DHUND:		CMP    	R0, R9			// Checking if the value is greater than the Divisor to the Third power
            BLT    	DTEN			// Moving to the next function if Divisor is greater than the remaining value
            SUB    	R0, R9			// Subtracting the divisor from the remaining value
            ADD    	R6, #1			// incrementing Hundreds value for each time through the full function
            B      	DHUND			// going back to beginning of function
DTEN:       CMP    	R0, R8			// Checking if the value is greater than the Divisor to the Second power
            BLT    	DIV_END			// Moving to the next function if Divisor is greater than the remaining value
            SUB    	R0, R8			// Subtracting the divisor from the remaining value
            ADD    	R2, #1			// incrementing Tens value for each time through the full function
            B      	DTEN			// going back to beginning of function
DIV_END:    MOV    	R1, R2       	// quotient in R1 (remainder in R0)
            MOV    	PC, LR

N:          .word  	9876         	// the decimal number to be converted
Digits:     .space 	4            	// storage space for the decimal digits
Divisor:	.word  	10		    	//Divisor Value

            .end
