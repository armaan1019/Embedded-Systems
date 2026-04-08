				.syntax         unified
				.cpu            cortex-m4
				.text
				// int32_t Return32Bits(void)
				.global         Return32Bits
				.thumb_func
				.align
Return32Bits:	// Implement me
				// Implement me
				// Implement me
				LDR R0,=10 // Loads 10 into R0				
				BX LR // Returns

				// int64_t Return64Bits(void) ;
				.global         Return64Bits
				.thumb_func
				.align
Return64Bits:	// Implement me
				// Implement me
				// Implement me
				LDR R0,=-10 // Loads -10 into R0
				LDR R1,=-1 // Loads -1 into R1
				BX LR

				// uint8_t Add8Bits(uint8_t x, uint8_t y)
				.global         Add8Bits
				.thumb_func
				.align
Add8Bits:		// Implement me
				// Implement me
				// Implement me
				ADD R0, R0, R1 // Will add x and y and put it in R0
				UXTB R0, R0 // Converts R0 to 8 bits 
				BX LR

				// uint32_t FactSum32(uint32_t x, uint32_t y)
				.global         FactSum32
				.thumb_func
				.align
FactSum32:		// Implement me
				// Implement me
				// Implement me
				PUSH {R4, LR} // Push R4 to save its value
				ADD R0, R0, R1 // Add x and y
				BL Factorial // Call the factorial function on x+y
				POP {R4, PC} // Pop R4 off the stack

				// uint32_t XPlusGCD(uint32_t x, uint32_t y, uint32_t z)
				.global         XPlusGCD
				.thumb_func
				.align
XPlusGCD:		// Implement me
				// Implement me
				// Implement me
				PUSH {R4, LR} // Save previous R4 value on stack
				MOV R4, R0 // Move x value into R4
				MOV R0, R1 // Store y val in R0
				MOV R1, R2 // Store z value into R1
				BL gcd // Call gcd function on y, z
				ADD R0, R0, R4 // Adds x and the gcd of y and z
				POP {R4, PC} // Pops R4 off the stack
				.end
