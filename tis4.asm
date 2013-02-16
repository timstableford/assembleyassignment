;Timothy Stableford (tis4)
	.ORIG	x3000
ROTATE	ADD	R1,R1,0		;Here we check if input is valid
	BRn	FAIL		;Fail if times to rotate is less than 0
	BRz	SUC		;Succeed if 0 because result is input
	ADD	R6,R1,-15	;If its greater than 15 this will be positive
	BRp	FAIL
START	LEA 	R2,MSB		;Load the mask starting address into R2
	LD	R3,COUNTER	;Set R3 (counter) as 15
	AND	R4,R4,#0	;Set R4 (output) as 0
	LD	R5,LSB		;Set R5 (mask holder) to LSB
	AND	R6,R6,#0	;Set the temp as 0
	AND	R6,R0,R5	;Check if the LSB is set
	BRz	LOOP		;If it's not go to loop
	LD	R4,MSB		;If it is, set the MSB to high
LOOP	LDR	R5,R2,#0	;Load the mask
	ADD	R2,R2,1		;Increment the mask address pointer
	AND	R6,R0,R5	;Check if the bit the mask its referring to is high
	BRz	NOTSET		;If the previous bit mask was not true then continue/do nothing
	;Now we're going to OR that into our output (R4) with the inputs R5 (mask) and R4 (output)
	LDR	R5,R2,#0	;Update the loaded mask with the one to the right
	NOT	R5,R5		;NOT both the inputs (making an OR gate)
	NOT	R4,R4
	AND	R4,R4,R5
	NOT	R4,R4		;NOT the output to get the result of the OR
NOTSET	ADD	R3,R3,-1	;Decrement the counter
	BRp	LOOP		;If it's greater than 0 then loop again;
	ADD	R0,R4,0		;Copy our output into R0
	ADD	R1,R1,-1	;Decrement times to rotate counter
	BRp	START		;Rotate right again if the counters greater than 0
SUC	LD	R1,SUCCESS	;Set as 1 if here, because we suceeded
	JSR	DONE
FAIL	LD	R1,FAILURE	;Set as failure
DONE	RET
SUCCESS	.FILL	1
FAILURE	.FILL	-1
COUNTER .FILL	x000F
MSB	.FILL	x8000
	.FILL	x4000
	.FILL	x2000
	.FILL	x1000
	.FILL	x0800
	.FILL	x0400
	.FILL	x0200
	.FILL	x0100
	.FILL	x0080
	.FILL	x0040
	.FILL	x0020
	.FILL	x0010
	.FILL	x0008
	.FILL	x0004
	.FILL	x0002
LSB	.FILL	x0001
	.END
