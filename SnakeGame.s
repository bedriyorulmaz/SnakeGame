initial_sp:	.word	0x201FFFFC
reset_vector: .word _main

_main:		
			movs	r2, #20               //initialize row counter 			
			movs	r3, #60	              //initialize column counter		
			movs    r6, #0
			movs    r7, #0
			b		s5	
			
			//S harfi sağdan sola-1
s5:			
			ldr     r1, initial_renk		  //base color (fully opaque turquois in ARGB format)
			ldr     r0, initial_lcd
										
			movs	r2, #20				  //initialize row counter			
			sub     r3, r3, #1            //decrement the column counter		
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, #25                //check if we have reached the end of current column
			beq     s2_t						
nc_5:		add     r2, r2, #2           //increment the row counter
			cmp     r2, #25              //check if we have reached the end of the screen
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     nc_5
			b 		s5														
			
.balign 4
initial_lcd: .word 0x40010000
initial_renk: .word 0xffff880f	
		
	//sağdan sola-2	
s1:			//ldr     r0,=0x40010000
			movs	r2, #80				  //initialize row counter			 
			sub     r3, r3, #1            //decrement the column counter		
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, #25                //check if we have reached the end of current column
			beq     n1_p				 
nc_1:		add     r2, r2, #2            //increment the row counter
			cmp     r2, #85               //check if we have reached the end of the row satır
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     nc_1
			b 		s1									 	
	
	//yukardan aşağı-1		
s2:			//movs 	r2,#20				  //initialize row counter			 
			movs	r3,#25	              //initialize column counter		 
			add 	r2,r2,#2
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #54
			beq		s3					 	

nc_2:		add     r3, r3, #1            //increment the column counter
			cmp     r3, #31               //check if we have reached the end of the screen
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     nc_2
			b 		s2									 

	//soldan sağa
s3:			movs	r2, #50				  //initialize row counter			 
			add     r3, r3, #1            //decrement the column counter		
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, #60                //check if we have reached the end of current column
			beq     s4						 
nc_3:		add     r2, r2, #2            //increment the row counter
			cmp     r2, #55               //check if we have reached the end of the row satır
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     nc_3
			b 		s3									 		

	//yukardan aşağı-2		
s4:			//movs 	r2,#20				  //initialize row counter			 
			movs	r3,#54	              //initialize column counter		 
			add 	r2,r2,#2
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r1, [r0, #0xC]         
			cmp     r2, #88
			//ldr     r0, =0x40010000
			beq		s1					 	

nc_4:		add     r3, r3, #1            //increment the column counter
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, #60               //check if we have reached the end of the screen
			blt     nc_4
			b 		s4									 

	
	//N harfi yukardan aşağı-1
n1_p:		movs 	r2,#32				  //initialize row counter			 	
					
n1:			movs	r3,#86	              //initialize column counter		 
			add 	r2,r2,#2
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #86
			beq		n2_p_t					 	

nnc_1:		add     r3, r3, #1            //increment the column counter
			cmp     r3, #90               //check if we have reached the end of the screen
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     nnc_1
			b 		n1									 


s2_t:		b	s2	



	//A harfi çapraz-2
a2_p:		movs 	r2,#32 				  //initialize row counter			 
			movs	r4,#144					//Last column point 
			movs	r5,#148					//counter to calculate round
			//movs	r3,#164	              //initialize column counter		 

a2:			
			sub		r4,r4,#1			  //in each steps, we decrease our last column number    	
			sub		r5,r5,#1				//in each steps, we decrease our first column number to shift left  
			movs	r3,r5					// first column point is set zero
			sub		r3,r3,#1 			   	
			add 	r2,r2,#4			   
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #85
			bgt		a22_p					 	

anc_2:		
			sub     r3,r3,#1             //increment the column counter	sutün	sağdan sola
			cmp     r4, r3	              //check if we have reached the end of the screen
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     anc_2
			b 		a2										 
	
		
	//A harfi çapraz-22
a22_p:		movs 	r2,#34 				  //initialize row counter			 
			movs	r4,#144					//Last column point 
			movs	r5,#148					//counter to calculate round
			//movs	r3,#164	              //initialize column counter		 

a22:			
			sub		r4,r4,#1			  //in each steps, we decrease our last column number    	
			sub		r5,r5,#1				//in each steps, we decrease our first column number to shift left  
			movs	r3,r5					// first column point is set zero
			sub		r3,r3,#1 			   	
			add 	r2,r2,#4			   
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #85
			bgt		a3_p					 	

anc_22:		
			sub     r3,r3,#1             //increment the column counter	sutün	sağdan sola
			cmp     r4, r3	              //check if we have reached the end of the screen
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     anc_22
			b 		a22		 							
		
n3_p_t:		b		n3_p

	//N harfi çapraz
n2_p:		movs 	r2,#32				  //initialize row counter			 
			movs 	r4,#90					//Last column point 
			movs	r5,#84					//counter to calculate round
			movs	r3,#84	              //initialize column counter		 

n2:			
			add		r4,r4,#1			   //in each steps, we increase our last column number  to shift right	
			add		r5,r5,#1				// counter to shift right 
			movs	r3,r5					// first column point is set zero
			add		r3,r3,#1 			   	
			add 	r2,r2,#2			   
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #86
			bgt		n3_p_t					 	

nnc_2:		
			add     r3,r3,#1             //increment the column counter	 
			cmp     r3, r4	              //check if we have reached the end of the screen
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     nnc_2
			b 		n2									 

	

	//A harfisoldan sağa
a3_p:		movs 	r3, #136

a3:			movs	r2, #60				  //initialize row counter			 
			add     r3, r3, #2            //decrement the column counter		
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, #154                //check if we have reached the end of current column
			beq     k1_p						 
anc_3:		add     r2, r2, #1            //increment the row counter
			cmp     r2, #58               //check if we have reached the end of the row satır
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     anc_3
			b 		a3									 		

a2_p_t:		b		a2_p	

	//K harfi yukardan aşağı	
	
k1_p:		movs 	r2,#32				  //initialize row counter			 	
					
k1:			movs	r3,#178	              //initialize column counter		 
			add 	r2,r2,#2
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #86
			beq		k2_p					 	

knc_1:		add     r3, r3, #1            //increment the column counter
			cmp     r3, #182               //check if we have reached the end of the screen
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     knc_1
			b 		k1									 


n2_p_t:		b		n2_p
	//A harfi çapraz-1
a1_p:		movs 	r2,#32				  //initialize row counter			 
			movs	r4,#148					//Last column point 
			movs	r5,#144					//counter to calculate round
			//ldr 	r4,=#110					//Last column point 
			//ldr		r5,=#164					//counter to calculate round
			movs	r3,#160	              //initialize column counter		 

a1:			
			add		r4,r4,#1			   //in each steps, we increase our last column number  to shift right	
			add		r5,r5,#1				// counter to shift right 
			movs	r3,r5					// first column point is set zero
			add		r3,r3,#1 			   	
			add 	r2,r2,#4			   
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #85
			bgt		a12_p					 	

anc_1:		
			add     r3,r3,#1             //increment the column counter	 
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, r4	              //check if we have reached the end of the screen
			blt     anc_1
			b 		a1									 
	
	//
a12_p:		movs 	r2,#34 					  //initialize row counter			 
			movs	r4,#148					//Last column point 
			movs	r5,#144					//counter to calculate round
			//ldr 	r4,=#110					//Last column point 
			//ldr		r5,=#164					//counter to calculate round
			movs	r3,#160	              //initialize column counter		 

a12:			
			add		r4,r4,#1			   //in each steps, we increase our last column number  to shift right	
			add		r5,r5,#1				// counter to shift right 
			movs	r3,r5					// first column point is set zero
			add		r3,r3,#1 			   	
			add 	r2,r2,#4			   
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #85
			bgt		a2_p_t					 	

anc_12:		
			add     r3,r3,#1             //increment the column counter	 
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, r4	              //check if we have reached the end of the screen
			blt     anc_12
			b 		a12						



	//N harfi yukardan aşağı-2	
n3_p:		movs 	r2,#32				  //initialize row counter			 	
					
n3:			movs	r3,#112	              //initialize column counter		 
			add 	r2,r2,#2
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #86
			beq		a1_p_t	 	

nnc_3:		add     r3, r3, #1            //increment the column counter
			cmp     r3, #116               //check if we have reached the end of the screen
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     nnc_3
			b 		n3  								 
		
	//K harfi çapraz yukardan aşağı-1
k2_p:		movs 	r2,#32				  //initialize row counter			 
			movs	r4,#191					//Last column point 
			movs	r5,#197					//counter to calculate round
			//movs	r3,#164	              //initialize column counter		 

k2:			
			sub		r4,r4,#1			  //in each steps, we decrease our last column number    	
			sub		r5,r5,#1				//in each steps, we decrease our first column number to shift left  
			movs	r3,r5					// first column point is set zero
			sub		r3,r3,#1 			   	
			add 	r2,r2,#2			   
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #59
			bgt		k3_p					 	

knc_2:		
			sub     r3,r3,#1             //increment the column counter	sutün	sağdan sola
			cmp     r4, r3	              //check if we have reached the end of the screen
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     knc_2
			b 		k2									 
		
	//K harfi alttali aşağı-2
k3_p:		movs 	r2,#57			  //initialize row counter			 
			movs	r4,#183					//Last column point 
			movs	r5,#178					//counter to calculate round
		//	movs	r3,#195	              //initialize column counter		 

k3:			
			add		r4,r4,#1			   //in each steps, we increase our last column number  to shift right	
			add		r5,r5,#1				// counter to shift right 
			movs	r3,r5					// first column point is set zero
			add		r3,r3,#1 			   	
			add 	r2,r2,#2			   
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #86
			bgt		e1_p					 	

knc_3:		
			add     r3,r3,#1             //increment the column counter	 
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, r4	              //check if we have reached the end of the screen
			blt     knc_3
			b 		k3									 
	
a1_p_t: 	b		a1_p


	//E düz çizgi
e1_p:		movs 	r2,#32				  //initialize row counter			 	
					
e1:			movs	r3,#210	              //initialize column counter		 
			add 	r2,r2,#2
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r2, #88
			beq		e2_p					 	

enc_1:		add     r3, r3, #1            //increment the column counter
			cmp     r3, #214               //check if we have reached the end of the screen
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     enc_1
			b 		e1									 


	// E harfi yatay çizgi 1
e2_p:		movs 	r3, #214			// start of column 
			movs 	r4, #238
			
e2:			movs	r2, #34				  //initialize row counter			 
			add     r3, r3, #1            //decrement the column counter		
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, r4                //check if we have reached the end of current column
			beq     e3_p						 
enc_2:		add     r2, r2, #2            //increment the row counter
			cmp     r2, #36               //check if we have reached the end of the row satır
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     enc_2
			b 		e2									 		
	
	// E harfi yatay çizgi 2
e3_p:		movs 	r3, #214			//sutün başlangıç
			movs 	r4, #238
			
e3:			movs	r2, #58				  //initialize row counter			 
			add     r3, r3, #1            //decrement the column counter		
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, r4                //check if we have reached the end of current column
			beq     e4_p						 
enc_3:		add     r2, r2, #2            //increment the row counter
			cmp     r2, #60               //check if we have reached the end of the row satır
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     enc_3
			b 		e3									 		
		
	
	// E harfi yatay çizgi 3

e4_p:		movs 	r3, #214			// start of column 
			movs 	r4, #238
			
e4:			movs	r2, #84				  //initialize row counter			 
			add     r3, r3, #1            //decrement the column counter		
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			cmp     r3, r4                //check if we have reached the end of current column
			beq     acilis						 
enc_4:		add     r2, r2, #2            //increment the row counter
			cmp     r2, #86               //check if we have reached the end of the row satır
			str     r2, [r0]		       
			str     r3, [r0, #0x4]         
			str     r1, [r0, #0x8]         
			str     r0, [r0, #0xC]         
			blt     enc_4
			b 		e4									 		
			
	
acilis:		str     r1, [r0, #0x10]        //clean the screen
			ldr     r0, =0x40010000  //to contine press "a" 
			ldr		r5, [r0, #0x20]		
			ldr    	r2, =0x80000000       //a
			eor     r5, r5, r2
			cmp     r5, #0
			beq     start
			b		s5





start:		ldr     r2, =0x20000000  // This step, we initialize all ram to play snake game
			ldr		r4,	=0xffff0000
			str		r4,[r2]
			ldrh	r4, =0x0000
			ldr     r2, =0x20000006
			strh	r4,[r2] 		// initialize direction information //r4=0x0000 is meant that snake has direction to +x
			ldrh    r4, =0x0000 	
			add     r2,r2,#0		//0x0010 //#############4
			strh	r4,[r2]			// initialize direction information
			add		r2,r2,#2
			ldrh    r4, =0x0006 	//initialize lenght of snake
			strh 	r4,[r2]
			add		r2,r2,#2
			//0x0020 konum bilgilerini inialize ettik
			ldrh    r6, =0x1308    //location of head  r6[15:8]=x,r6[7:0]=y
			strh    r6, [r2]    				
			ldrh    r5, =0x1208		//location of head-1  r6[15:8]=x,r6[7:0]=y
			strh    r5, [r2,#2]
			ldrh    r5, =0x1108		//location of head-2  r6[15:8]=x,r6[7:0]=y	
			strh    r5, [r2,#4]
			ldrh    r5, =0x1008		//location of head-3  r6[15:8]=x,r6[7:0]=y	
			strh    r5, [r2,#6]
			ldrh    r5, =0x0f08		//location of head-4  r6[15:8]=x,r6[7:0]=y
			strh    r5, [r2,#8]
			ldrh    r5, =0x0e08		//location of head-5  r6[15:8]=x,r6[7:0]=y	
			strh    r5, [r2,#10]
			ldr		r7,=0x20000004
			ldrh	r5,=0x2020		//food  location
			strh    r5, [r7]
			
			

			
		
			
get_key: 	movs 	r5,#100
			ldr     r0, =0x40010000   //  lcd address
			ldr		r5, [r0, #0x20]	//read keyboard status register
			movs    r2, #0x20        //up
			eor     r5, r5, r2			
			cmp     r5, #0
			beq     y_neg_key
			ldr		r5, [r0, #0x20]	 	  //read keyboard status register
			movs    r2, #0x04       //left
			eor     r5, r5, r2
			cmp     r5, #0
			beq     x_neg_key	
			ldr		r5, [r0, #0x20]	   //read keyboard status register
			movs    r2, #0x10        //right
			eor     r5, r5, r2
			cmp     r5, #0
			beq     x_pos_key
			ldr		r5, [r0, #0x20]	//read keyboard status register
			movs    r2, #0x08        //down
			eor     r5, r5, r2
			cmp     r5, #0
			beq     y_pos_key
			ldr		r5, [r0, #0x20]	  //read keyboard status register
			movs    r2, #0x02        //space
			eor     r5, r5, r2
			cmp     r5, #0
			beq     pause
			b       new_dir			// if the player doesnt push any key, code jump directly new dir
			
pause:		ldr		r1,=0xff00ff00		// the player can out while pushing any key
			str		r1, [r0, #0xC]     	// ekranı yeniledik
			ldr		r5, [r0, #0x20]	
			movs    r2, #0x020        //up
			eor     r5, r5, r2
			cmp     r5, #0
			beq     get_key
			ldr		r5, [r0, #0x20]	
			movs    r2, #0x04       //left
			eor     r5, r5, r2
			cmp     r5, #0
			beq     get_key
			ldr		r5, [r0, #0x20]	
			movs    r2, #0x10        //right
			eor     r5, r5, r2
			cmp     r5, #0
			beq     get_key
			ldr		r5, [r0, #0x20]	
			movs    r2, #0x08        //down
			eor     r5, r5, r2
			cmp     r5, #0
			beq     get_key
			ldr		r5, [r0, #0x20]	
			movs    r2, #0x02        //space
			eor     r5, r5, r2
			cmp     r5, #0
			beq     get_key			
			b		pause
			
x_neg_key:  ldr		r5,=0x20000006     //direction address left=10 is meant 2
			ldrh	r2,[r5]			  // check current direction 
			cmp		r2,#0			 //if current direction and next direction are 
			beq		new_dir			//oposite each other, then we keep current direction
			ldrh 	r1,=0x0002		// otherwise we set new direction
			strh 	r1,[r5]      		   	
			b 		new_dir
			 
x_pos_key:  ldr		r5,=0x20000006       //direction address right=00 is meant 0 
			ldrh	r2,[r5]				
			cmp		r2,#2
			beq		new_dir
			ldrh 	r1,=0x0000
			strh 	r1,[r5]  
			b       new_dir
		
y_pos_key:  ldr		r5,=0x20000006    //direction address down=01 is meant 1
			ldrh	r2,[r5]
			cmp		r2,#3
			beq		new_dir
	        ldrh 	r1,=0x0001
			strh 	r1,[r5] 
			b    	new_dir

			
y_neg_key:  ldr		r5,=0x20000006    //direction address up=11  is meant 3
			ldrh	r2,[r5]
			cmp		r2,#1
			beq		new_dir
			ldrh 	r1,=0x0003
			strh 	r1,[r5]
			b    	new_dir
			
			
new_dir: 	ldr		r5,=0x20000006   //according to direction  the code goes suitable branch 
			ldrh 	r1,[r5] 		//r1=current direction
			cmp 	r1,#0
			beq 	x_pos
			cmp 	r1,#1
			beq 	y_pos
			cmp 	r1,#2
			beq 	x_neg
			cmp 	r1,#3
			beq 	y_neg
			b   	chck_food
			
x_neg:  	ldr 	r5,=0x2000000a	//direction address left=10 according to direction, we create new location.
			ldrh    r1,[r5]    		// getting head location information r1[15:8]=x, r1[7:0]=y
			lsr		r1,r1,#8		// we shift r1 in order to extract x value of head
			cmp     r1,#0			
			beq     col_320			// if current x of head is 0, then we sent col_320 branch to set 320 piksel value
			ldrh    r1,[r5]
			movs	r2,#1			//
			lsl     r2, r2, #8		// we decrease 1 on x value of head in order to change location
			sub     r1,r1,r2        //r1 has new head location information    
			b   	chck_food		

col_320:	ldrh    r1,[r5]
			movs    r2, #79
			lsl     r2, r2, #8 
			add     r1,r1,r2		// we adds 79 value to x value of head 
			b   	chck_food



x_pos:  	ldr 	r5,=0x2000000a	//direction address right=00 according to direction, we create new location.
			ldrh    r1,[r5]    		// getting head location information r1[15:8]=x, r1[7:0]=y
			lsr		r1,r1,#8		// we shift r1 in order to extract x value of head
			cmp     r1,#79			
			beq     zero_col		// if current x of head is 79(means 320), then we sent zero_col branch to set 0 piksel value
			ldr 	r5,=0x2000000a
			ldrh    r1,[r5]
			movs	r2,#1
			lsl     r2, r2, #8		// we increase 1 on x value of head in order to change location
			add     r1, r1,r2    	//r1 has new head location information   
			b   	chck_food

zero_col:   ldr		r5,=0x2000000a
			ldrh    r1,[r5]
			ldrh	r2,=0x00ff
			and		r1,r1,r2     // we set 0 value to x value of he
			b   	chck_food
			
			
y_pos:  	ldr 	r5,=0x2000000a	//direction address down=01 according to direction, we create new location.        
			ldrh    r1,[r5]    		// getting head location information r1[15:8]=x, r1[7:0]=y
			ldrh	r2,=0x00ff		// for y location information we should mask operation
			and		r1,r1,r2       
			cmp     r1,#59			
			beq     y_pos_zero 		// if current y of head is 59(means 240), then we sent y_pos_zero branch to set 0 piksel value
			ldrh    r1,[r5]			// we increase 1 on y value of head in order to change location
			add		r1,r1,#1		//r1 has new head location information  
			b   	chck_food
		
y_pos_zero:	ldrh    r4,=0xff00
			ldrh    r1,[r5] 
			and     r1,r1,r4	// we set 0 value to y value of he
			b   	chck_food
		
y_neg  :	ldr 	r5,=0x2000000a	//direction address up=11 according to direction, we create new location.     
			ldrh    r1,[r5]    		// getting head location information r1[15:8]=x, r1[7:0]=y
			ldrh	r2,=0x00ff		// for y location information we should mask operation
			and		r1,r1,r2		
			cmp     r1,#0
			beq     ini_row			// if current y of head is 0, then we sent ini_row branch to set 0 piksel value
			ldrh    r1,[r5]    		
			sub     r1, r1,#1
			b   	chck_food

ini_row: 	ldrh    r1,[r5] 
			add		r1,r1,#59  // we set 0 value to y value of he
			b   	chck_food
			
chck_food:	ldr		r7,=0x20000004
			ldrh	r5,[r7]
			cmp		r5,r1		//check food and new head whether same place or not
			bne		new_snake	 
			
			ldr		r7,=0x20000008
			ldrh	r5,[r7]
			add		r5,r5,#1 //lenght +1 if they are same place  we increase lenght 
			strh	r5,[r7]
			ldr		r7,=0x20000004 // to create new food place
			ldrh	r5,[r7]
			ldrh	r7,=0x00ff 
			and		r7,r7,r5	//r7 has y location of food
			ldrh	r6,=0xff00
			and		r6,r6,r5	//r6 has x location of food
			lsl		r6,r6,#8
			add		r6,r6,#31	// increase current x of  food place
			add		r7,r7,#23	// increase current y of  food place
mod_80_r:	cmp		r6,#79     
			bhi		mod_80       //  sending mod_80 to take mod 80
mod_60_r:	cmp		r7,#59		
			bhi		mod_60     //  sending mod_60 to take mod 60
			ldr     r0,=0x40010000      //lcd ekran address değerinin registerdakik address değeri
			lsl		r7,r7,#2
			lsl		r6,r6,#2
			str     r7, [r0]        	  
			str		r6, [r0, #0x4]      
			ldr		r4, [r0, #0xC] 		//we read color point to check new food place and snake same place or not
			ldr     r2, =0x20000000
			ldr     r3,	[r2]
	
			cmp		r4,r3
			beq		upd_food			//if new food place and snake are same place, we sent  upd_food to change new food place
			lsr		r7,r7,#2			
			lsr		r6,r6,#2
			ldrh	r5,=0xffff
			and		r5,r5,r7
			lsl		r6,r6,#8
			orr		r5,r5,r6
			ldr		r7,=0x20000004
			strh	r5,[r7]				// otherwise we save new food place to ram
			b		new_snake

mod_80:		sub		r6,r6,#79   
			b 		mod_80_r	

mod_60:		sub		r7,r7,#59
			b 		mod_60_r			
			
upd_food:	add		r6,r6,#4		
			add		r7,r7,#3
			b		mod_80_r
			
			
new_snake: 	movs	r4,#0				// to move all snake we should change each heads address with their new address
			ldr		r5,=0x2000000a		//head add
			ldr		r3,=0x20000008		// lenght address
			ldrh	r0,[r3]				//lenght value
			ldrh	r7,[r3]				//lenght value
			sub		r7,r7,#1
			sub		r0,r0,#2			//lenght-2
			lsl		r0,r0,#1			//lenght*2
			add		r5,r5,r0			//head add +2*lenght	
br_point:	ldrh	r3,[r5]
			strh	r3,[r5,#2]			// we store value head n on ram address of head n-1 
			sub		r5,r5,#2		
			add		r4,r4,#1
			cmp		r4,r7				// until all heads is completed, the code is going to change value
			blt		br_point
			ldrh	r3,[r5]
			strh	r1,[r5,#2]
					

			movs	r5,#0
			ldr		r7,=0x20002600 		// variable address of ram
			strh	r5,[r7]
			ldr     r7, =0x20000000		
			ldr     r1,	[r7]
			ldr		r0,=0x40010000
			str		r1, [r0, #0x10]		// we store new head value to ram head address
			b		check_game_over
			
check_game_over:	movs	r4,#0    // we check head location and each quene locations by one to one.
			ldr		r7,=0x20000008
			ldrh    r3, [r7]		//lenght 
			ldr		r7,=0x2000000a	
			ldrh    r1, [r7]		//head 
br_point_2:	add		r7,r7,#2
			ldrh    r2, [r7]
			cmp		r2,r1
			beq		gameover_tmp  //if they are same place game is over
			add		r4,r4,#1
			cmp		r4,r3
			blt		br_point_2 
			b		br_point_3
			
			

gameover_tmp:	b		gameover

br_point_3:	ldr     r7, =0x20000000  // we begin to paint all snake according locations all snake
			ldr     r1,[r7]
			ldr		r7,=0x2000000a
			ldrh    r6, [r7]
pik_dol:	ldrh    r4,=0x00ff  // y konumu masklemek için
			and     r4,r4,r6	      //r4 de y konum bilgisi mevcut	r4=B
			lsl     r4, r4, #2        //r4 4 ile çarptım bu şekilde doldurulması gereken piksel sayısını hesapladık
			ldr     r2,=0x400100000      //lcd ekran address değerinin registerdakik address değeri
			ldrh    r5,=0xff00	// x konumu masklemek için 
			and     r5,r5,r6		//r5 de x konum bilgisinin 2**8 ile çarpılmış hali mevcut
			lsr     r5, r5, #6      //r5 de hem başa kaydırım hem de 4 ile çarptık   r5=A
			






			movs 	r2,#0                      // y değerimiz
for_y:	  	str     r4, [r0]        	 //satır sayımızı güncelleştirdik  
			movs 	r3,#0                      // x değerimiz sıfırladık
			ldr     r5,=0x0000ff00	// x konumu masklemek için 
			and     r5,r5,r6		//r5 de x konum bilgisinin 2**8 ile çarpılmış hali mevcut
			lsr     r5, r5, #6         	//r5 de hem başa kaydırım hem de 4 ile çarptık   r5=A
for_x:		str		r5, [r0, #0x4]                   //sütün sayımızı güncelleştirdik
			str     r1, [r0, #0x8]	  	// mevcut satır ve sutun sayımızıı yeşil renk ile boyadık
			add     r5,r5,#1            // x değerimiz artırdık
			add 	r3,r3,#1
			cmp 	r3,#4
			blt   	for_x
			add     r4,r4,#1
			add 	r2,r2,#1
			cmp 	r2,#4
			blt    	for_y
			ldr		r7,=0x20000008
			ldrh	r3,[r7]   //uzunluk bilgisi
			lsl		r3,r3,#1
			ldr		r7,=0x20002600
			ldrh	r5,[r7]		// i değişkeni
			add		r5,r5,#2
			strh	r5,[r7]		// i değişkeni updated
			ldr		r7,=0x2000000a
			add		r7,r7,r5
			ldr     r6, [r7] 
			cmp		r5,r3
			beq		pik_dol_f
			

			b       pik_dol
			
			
			
			
pik_dol_f:	ldr		r7,=0x20000004 // we paint food 
			ldrh    r6, [r7]
			
			ldrh    r4,=0x00ff  // y konumu masklemek için
			and     r4,r4,r6	      //r4 de y konum bilgisi mevcut	r4=B
			lsl     r4, r4, #2        //r4 4 ile çarptım bu şekilde doldurulması gereken piksel sayısını hesapladık
			ldr     r0,=0x40010000      //lcd ekran address değerinin registerdakik address değeri
			ldrh    r5,=0xff00	// x konumu masklemek için 
			and     r5,r5,r6		//r5 de x konum bilgisinin 2**8 ile çarpılmış hali mevcut
			lsr     r5, r5, #6      //r5 de hem başa kaydırım hem de 4 ile çarptık   r5=A
			movs 	r2,#0                      // y değerimiz
for_y_f:	str     r4, [r0]        	 //satır sayımızı güncelleştirdik  
			movs 	r3,#0                      // x değerimiz sıfırladık
			ldr     r5,=0x0000ff00	// x konumu masklemek için 
			and     r5,r5,r6		//r5 de x konum bilgisinin 2**8 ile çarpılmış hali mevcut
			lsr     r5, r5, #6         	//r5 de hem başa kaydırım hem de 4 ile çarptık   r5=A
for_x_f:	str		r5, [r0, #0x4]                   //sütün sayımızı güncelleştirdik
			str     r1, [r0, #0x8]	  	// mevcut satır ve sutun sayımızıı yeşil renk ile boyadık
			add     r5,r5,#1            // x değerimiz artırdık

			add 	r3,r3,#1
			cmp 	r3,#4
			blt   	for_x_f
			add     r4,r4,#1
			add 	r2,r2,#1
			cmp 	r2,#4
			blt    	for_y_f
			str		r1, [r0, #0xC]     	// ekranı yeniledik
			
			
get_key_tmp:
		movs	r4,#0
timein:	movs    r3,#0		// we added a time place to move slowly our snake otherwise the player can not play our snake game
timein1:	add     r3, r3, #1
			cmp     r3, #240		
			blt     timein1
			movs    r3,#0
timein2:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein2
			movs    r3,#0
timein3:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein3
			movs    r3,#0
timein4:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein4
			movs    r3,#0
timein5:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein5
			movs    r3,#0
timein6:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein6
			movs    r3,#0
timein7:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein7
			movs    r3,#0
timein8:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein8
timein9:	add     r3, r3, #1
			cmp     r3, #240		
			blt     timein9
			movs    r3,#0
timein10:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein10
			movs    r3,#0
timein11:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein11
			movs    r3,#0
timein12:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein12
			movs    r3,#0
timein13:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein13
			movs    r3,#0
timein14:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein14
			movs    r3,#0
timein15:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein15
			movs    r3,#0
timein16:	add     r3, r3, #1
			cmp     r3, #240
			blt    timein16
			movs    r3,#0
timein1a:	add     r3, r3, #1
			cmp     r3, #240
            blt     timein1a

			movs    r3,#0
timein2a:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein2a
			movs    r3,#0
timein3a:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein3a
			movs    r3,#0
timein4a:	add     r3, r3, #1
			cmp     r3, #240
            blt     timein4a
			movs    r3,#0
timein5a:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein5a
			movs    r3,#0
timein6a:	add     r3, r3, #1
			cmp     r3, #240
            blt     timein6a
			movs    r3,#0
timein7a:	add     r3, r3, #1
			cmp     r3, #240
            blt     timein7a
			movs    r3,#0
timein8a:	add     r3, r3, #1
			cmp     r3, #240
            blt     timein8a
			movs    r3,#0
timein9a:	add     r3, r3, #1
			cmp     r3, #240
            blt     timein9a
			movs    r3,#0
timein10a:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein10a
			movs    r3,#0
timein11a:	add     r3, r3, #1
			cmp     r3, #240
            blt    timein11a
			movs    r3,#0
timein12a:	add     r3, r3, #1
			cmp     r3, #240
            blt     timein12a
			movs    r3,#0
timein13a:	add     r3, r3, #1
			cmp     r3, #240
			blt    timein13a
			movs    r3,#0
timein14a:	add     r3, r3, #1
			cmp     r3, #240
            blt     timein14a
			movs    r3,#0
timein15a:	add     r3, r3, #1
			cmp     r3, #240
            blt     timein15a
			movs    r3,#0
timein16a:	add     r3, r3, #1
			cmp     r3, #240
			blt     timein16a
			add		r4,r4,#1
			ldr		r6,=0x20000008
			ldrh	r7,[r6]
			movs	r5,#60
			sub		r5,r5,r7
			cmp		r4,r5  				// speed control  according to lenght we increase our snake speed
			blt		timein_tmp			// check time is ready or not
			ldr     r2, =0x20000000
			ldr     r3,	[r2]
			add		r3,r3,#100   	// each time, we change our snake and food  color, then we store it 
			ldr		r7,=0xffffff00 // if color is bigger white we change its with read color 
			cmp		r3,r7
			bgt		clr_in
clr_inr:str		r3,[r2]		
		str		r1, [r0, #0xC] 	
		b		get_key	
		
timein_tmp: b timein


clr_in:	ldr		r3,=0xffff0000  
		b 		clr_inr

gameover:b		gameover1   // gameover place
gameover1:b		gameover		
		
	