/*
    This code was written to support the book, "ARM Assembly for Embedded Applications",
    by Daniel W. Lewis. Permission is granted to freely share this software provided
    that this notice is not removed. This software is intended to be used with a run-time
    library adapted by the author from the STM Cube Library for the 32F429IDISCOVERY 
    board and available for download from http://www.engr.scu.edu/~dlewis/book3.
*/

// void CopyCell(uint32_t *dst, uint32_t *src) ;        // R0 = dst, R1 = src

            .syntax     unified
            .cpu        cortex-m4
            .text

            .global     CopyCell
            .thumb_func
            .align
CopyCell:	PUSH {R4, LR}
			LDR R2,=0 //row
rowtop:		LDR R3,=0 //col
			CMP R2,60 // check R2 >= 60
			BHS done // go to done if it is
coltop:		CMP R3,60 // compare col R3 >= 60
			BHS coldone // go to coldone if it is
			LDR R4, [R1,R3,LSL 2] // dst[col] = src[col]   //LDR r4, r1, #4
			STR R4, [R0,R3,LSL 2]
			ADD R3,R3,1 // increment R3 
			B coltop // go back to coltop
coldone:	ADD R0,R0,960 // Increment R0 by 4 bytes
			ADD R1,R1,960 // Same with R1
			ADD R2,R2,1 // Add row by 1
			B rowtop // go back to rowtop
done:		POP {R4, PC} // done
            // Your code here !






// void FillCell(uint32_t *dst, uint32_t color) ;       // R0 = dst, R1 = color

            .global     FillCell
            .thumb_func
            .align 
FillCell:	LDR R2,=0
rowtop2:	LDR R3,=0
			CMP R2,60
			BHS done2
coltop2:	CMP R3,60
			BHS coldone2
			STR R1, [R0,R3,LSL 2]
			ADD R3,R3,1
			B coltop2
coldone2:	ADD R0,R0,960
			ADD R2,R2,1
			B rowtop2
done2:		
			
            // Your code here !

            .end















