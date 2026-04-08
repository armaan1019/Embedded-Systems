/*
    This code was written to support the book, "ARM Assembly for Embedded Applications",
    by Daniel W. Lewis. Permission is granted to freely share this software provided
    that this notice is not removed. This software is intended to be used with a run-time
    library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY 
    board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/
        .syntax     unified
        .cpu        cortex-m4
        .text

// uint32_t Mul32X10(uint32_t multiplicand) ;

        .global     Mul32X10
        .thumb_func
        .align
Mul32X10: ADD R0, R0, R0, LSL 2
		  LSL R0, R0, 1
		  BX LR // R0 = multiplicand

        //ur code here

// uint32_t Mul64X10(uint32_t multiplicand) ;

        .global     Mul64X10
        .thumb_func
        .align
Mul64X10: PUSH {R4, R5, LR}
		  LSL R3, R1, 3 //R3 = R1*8
		  LSR R2, R0, 29 // R2 = R0 >> 29
		  ORR R3, R2, R3 //R3 = R2 | R3
		  LSL R2, R0, 3 //R2 = R0*8
		  
		  LSL R5, R1, 1 //R5 = R1*2
		  LSR R4, R0, 31 //R4 = R0 >> 31
		  ORR R5, R4, R5 //R5 = R4 | R5
		  LSL R4, R0, 1 //R4 = R0 * 2
		  
		  ADDS R0, R2, R4 // R0 = R2 + R4
		  ADC R1, R3, R5 // R1 = R3 + R5 (factor carry in)
		  POP {R4, R5, PC}
		  // R1.R0 = multiplicand

        //ur code here

// uint32_t Div32X10(uint32_t dividend) ;

        .global     Div32X10
        .thumb_func
        .align
Div32X10: LDR R1,=3435973837
		  UMULL R2, R1, R1, R0
		  LSRS R0, R1, 3
		  BX LR // R0 = dividend

        //ur code here

        .end


