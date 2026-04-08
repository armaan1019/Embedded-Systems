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

// void PutNibble(void *nibbles, uint32_t index, uint32_t nibble) ;

        .global     PutNibble
        .thumb_func
        .align

PutNibble: PUSH {R4, LR}
		   ADD R4, R0, R1, LSR 1
		   LDRB R3, [R4]
		   AND R1, R1, 1
		   CMP R1, 1
		   IT EQ
		   LSLEQ R2, R2, 4
		   CMP R1, 1
		   ITTEE EQ
		   ANDEQ R3, R3, 0b00001111
		   ORREQ R3, R3, R2
		   ANDNE R3, R3, 0b11110000
		   ORRNE R3, R3, R2
		   STRB R3, [R4]
		   POP {R4, PC}


// uint32_t GetNibble(void *nibbles, uint32_t index) ;

        .global     GetNibble
        .thumb_func
        .align

GetNibble: LSR R3, R1, 1
		   LDR R2, [R0, R3]
		   AND R1, R1, 1
		   CMP R1, 1
		   IT EQ
		   LSREQ R2, R2, 4
		   AND R0, R2, 0b00001111
		   BX LR


        .end
