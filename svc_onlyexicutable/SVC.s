		AREA mycode,CODE,READONLY
		EXPORT start
		EXPORT SVC_Handler
		EXPORT  HardFault_Handler      
		ENTRY
start 	PROC
		
		MOV R0,#3
		MSR CONTROL,R0   ;reseting and changing the driver in un-priviliged mode before svc call
		LDR R5,=0X20000000    ; assigning valid memory address
		MOV R13,R5 ;giving valid address to SP
		
		SVC #0X01	;drive privilidge mode with psp
		
SUB1		;performig subtration of 64 bit data when SVC02 Called
		MOV32 R6,#0X44444444
		MOV32 R7,#0X22222222
	
		MOV32 R8,#0X55555555
		MOV32 R9,#0X33333333
	 
		ADDS R6,R7		;making 64 data by addition two 32 bit stored data and stroring result in R6
		ADDS R8,R9		;making 64 data by addition two 32 bit stored data and storing result in R8
		SUBS R6,R8     ;subtracting 64 bit data and storing result in R6
		
		BX LR
		ENDP
		



SVC_Handler	PROC
			;performing addition of 64bit when SVC01 Called
			MOV32 R1,#0x12345678      ;32bit     
			MOV32 R2,#0X11111111	   ;32bit
		
			MOV32 R3,#0x22222222     ;32bit          
			MOV32 R4,#0X33333333	 ;32bit
		
			ADDS R1,R2    ;r1 become 64bit ,addition result when r1 of 32bit and r2 of 32 bit adding                 
			ADDS R3,R4    ;r3 become 64bit ,addition result when r4 of 32bit and r3 of 32 bit adding                  
			ADDS R1,R3    ;64 bit addition ,when svcx01 called and stroring in r1 register  
			
			SVC #0X02  ; going to SUB1 label to subtract two 64 bit data
			
			BX LR
		    ENDP
				
HardFault_Handler PROC
                
                BL SUB1 
			    END
	