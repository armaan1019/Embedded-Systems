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

// int32_t MxPlusB(int32_t x, int32_t mtop, int32_t mbtm, int32_t b) ;

// #define ASR31(x) ((x < 0) ? -1 : 0)                          // Same as arithmetic shift right by 31 bits    
// rounding = ((((ASR31(dvnd*dvsr)) * dvsr) << 1) + dvsr) / 2 ; // rounding (where dvnd = x*mtop, dvsr = mbtm)
// quotient = (dvnd + rounding) / dvsr ;                        // quotient = (x*mtop + rounding) / mbtm

/* ------------------------------------------------------------------------------------------------------------------- */
// Note: The purpose of ASR31(dvnd*dvsr) is to produce a result that will be -1 if dvnd/dvsr is negative, else 0. 
// Multiplying by dvsr and shifting left once produces -2*dvsr if dvnd < 0, else 0. To this we add dvsr, which yields
// -dvsr if dvnd < 0, and +dvsr if dvnd >= 0. Finally, we divide by 2 to produce a rounding that has the sign of
// dvnd and magnitude |dvsr/2|. 
//
// The 2nd product (dvnd*dvsr) below may overflow if MUL is used, generating a positive result when it should be negative, 
// or vice-versa. The solution below avoids this problem by using the most-significant half of a 64-bit product that  
// cannot overflow. There are two alternatives: (1) Use SMMUL R0,R1,R2 (covered in Chapter 8) that computes only the 
// most-signficant half of a 64-bit product, or (2) use XOR R0,R1,R2 (covered in Chapter 7).
/* ------------------------------------------------------------------------------------------------------------------- */

        .global     MxPlusB
        .thumb_func

        .align
MxPlusB:	PUSH {R4-R12}
			MUL R4,R1,R0 // dvnd= x*mtop
			SMMUL R5,R4,R2 // dvnd * dvsr
			ASR R6,R5,31 // right shift 31 bits
			MUL R7,R6,R2 // multiply by dvsr
			LSL R8,R7,1 // left shift by 1
			ADD R9,R8,R2 // add by dvsr
			LDR R4,=2 //load constant into R4
			SDIV R10,R9,R4 // divide by 2, gives rounding
			MUL R11,R0,R1 // get dvnd again x*mtop
			ADD R12,R11,R10 // add rounding and dvnd
			SDIV R0,R12,R2 // divide by dvsr, gives quotient
			ADD R0,R0,R3 // add b
			POP {R4-R12} // Pop
			BX LR // return R0
		// your implementation here!

        .end

