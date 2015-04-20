#     F i n d  T u m b l i n g G e o r g e  i n  a  C r o w d
#
# 
# This routine finds an exact match of George's face which may be
# rotated in a crowd of tumbling (rotated) faces.
#
# <10/6/2013>                               <Jason Mar>

.data
Array:  .alloc	1024

.text

FindGeorge:	addi	$1, $0, Array		# point to array base
		swi	570			# generate tumbling crowd

		addi	$4, $0, 128		# $4 stores counter
		addi 	$5, $0, 1		# $5 stores white color 1
		addi 	$6, $0, 2		# $6 stores red color 2
		addi 	$7, $0, 3		# $7 stores blue color 3
		addi 	$8, $0, 5		# $8 stores yellow color 5
		addi 	$9, $0, 7		# $9 stores green color 7
		addi 	$10, $0, 8		# $10 stores black color 8
	
Beginning:	lb 	$11, Array($4)		# $11 loads byte from array		
		bne	$11, $5, NotWhite	# branches if not white
		
		addi 	$12, $4, -3		# holds next comparison location
		lb 	$11, Array($12)		# loads byte three to the left
		beq	$11, $8, Rot90		# assumes rotate 90
		
		addi 	$12, $4, 3		# holds next comparison location
		lb 	$11, Array($12)		# loads byte three to the right
		beq 	$11, $8, Rot270		# assumes rotate 270

		addi	$12, $4, 192		# holds next comparison location
		lb	$11, Array($12)		# loads byte 192 down from index
		bne	$11, $8, UpsideDown	# branches to check if face is upside down
		
		addi 	$12, $4, 576		# holds next comparison location
		lb 	$11, Array($12)		# loads byte 576 down from index
		bne	$11, $7, NotWhite	# branches if shirt is not blue
		
		addi 	$12, $4, -64		# holds next comparison location
		lb 	$11, Array($12)		# loads byte 64 up from index
		bne	$11, $6, NotWhite	# branches if hat is not red
		
		addi 	$14, $0, 0		# counter for green eye limit
		addi 	$13, $4, 124		# creates a new counter from index
CheckUpEye:	lb	$11, Array($13)		# loads byte to check for which index eye is at
		addi	$14, $14, 1		# increments green eye limit
		slti	$15, $14, 6		# if counter <6 
		beq	$15, $0, NotWhite	# branches when eye is not found >5 tries
		bne 	$11, $9, Reloop		# loops if eye is not found
	
		addi 	$12, $13, 64		# holds next comparison location	
		lb 	$11, Array($12)		# loads byte 64 down from index
		bne	$11, $8, NotWhite	# branches if yellow is not beneath eye
	
		addi	$12, $13, 128		# holds next comparison location
		lb	$11, Array($12)		# loads byte 128 down from index
		bne	$11, $10, NotWhite	# branches if smile is not black
		
		addi	$12, $13, -254		# gets top of hat location
		addi	$15, $13, 450		# gets middle of shirt location
		j 	Exit
		

UpsideDown:	addi 	$12, $4, -192		# holds next comparison location
		lb 	$11, Array($12)		# loads byte 192 up from index
		bne	$11, $8, NotWhite	# branches if face isnt yellow
			
		addi	$12, $4, -576		# holds next comparison location
		lb	$11, Array($12)		# loads byte 576 up from index
		bne	$11, $7, NotWhite	# branches if shirt isnt blue
	
		addi 	$12, $4, 64		# holds next comparison location
		lb 	$11, Array($12)		# loads byte 64 down from index
		bne	$11, $6, NotWhite	# branches if hat is not red
		
		addi 	$14, $0, 0		# counter for green eye limit
		addi 	$13, $4, -124		# creates a new counter from index
CheckUpEye2:	lb	$11, Array($13)		# loads byte to check for which index eye is at
		addi	$14, $14, 1		# increments green eye limit
		slti	$15, $14, 6		# if counter <6 
		beq	$15, $0, NotWhite	# branches when eye is not found >5 tries
		bne 	$11, $9, Reloop2	# loops if eye is not found
	
		addi 	$12, $13, -64		# holds next comparison location	
		lb 	$11, Array($12)		# loads byte 64 down from index
		bne	$11, $8, NotWhite	# branches if yellow is not beneath eye
	
		addi	$12, $13, -128		# holds next comparison location
		lb	$11, Array($12)		# loads byte 128 down from index
		bne	$11, $10, NotWhite	# branches if smile is not black
		
		addi	$12, $13, 254		# gets top of hat location
		addi	$15, $13, -450		# gets middle of shirt location
		j 	Exit


Rot90:		addi	$12, $4, -9		# holds next comparison location
		lb	$11, Array($12)		# loads byte 9 left 
		bne 	$11, $7, NotWhite	# branches if shirt isnt blue
		
		addi	$12, $4, 1		# holds next comparison location
		lb	$11, Array($12)		# loads byte 1 right 
		bne 	$11, $6, NotWhite	# branches if hat isnt red
		
		addi 	$14, $0, 0		# counter for green eye limit
		addi 	$13, $4, -258		# holds next comparison location
CheckUpEye3:	lb	$11, Array($13)		# loads byte 4 up and 2 left 
		addi	$14, $14, 1		# increments green eye limit
		slti	$15, $14, 6		# if counter <6
		beq	$15, $0, NotWhite	# branches when eye is not found >5 
		bne	$11, $9, Reloop3	# loops if eye is not found
		
		addi 	$12, $13, -1		# holds next comparison location
		lb	$11, Array($12)		# loads byte 1 left 
		bne	$11, $8, NotWhite	# branches if yellow isnt next to eye
		
		addi 	$12, $13, -2		# holds next comparison location
		lb	$11, Array($12)		# loads byte 2 left 
		bne	$11, $10, NotWhite	# branches if smile isnt black
		
		addi	$12, $13, 132		# gets top of hat location
		addi	$15, $13, 121		# gets middle of shirt location
		j 	Exit


Rot270:		addi	$12, $4, 9		# holds next comparison location
		lb	$11, Array($12)		# loads byte 9 right
		bne 	$11, $7, NotWhite	# branches if shirt isnt blue
		
		addi	$12, $4, -1		# holds next comparison location
		lb	$11, Array($12)		# loads byte 1 left 
		bne 	$11, $6, NotWhite	# branches if hat isnt red
		
		addi 	$14, $0, 0		# counter for green eye limit
		addi 	$13, $4, 258		# holds next comparison location
CheckUpEye4:	lb	$11, Array($13)		# loads byte 4 down and 2 right 
		addi	$14, $14, 1		# increments green eye limit
		slti	$15, $14, 6		# if counter <6 
		beq	$15, $0, NotWhite	# branches when eye is not found >5		
		bne	$11, $9, Reloop4	# loops if eye is not found
		
		addi 	$12, $13, 1		# holds next comparison location
		lb	$11, Array($12)		# loads byte 1 right 
		bne	$11, $8, NotWhite	# branches if yellow isnt next to eye
		
		addi 	$12, $13, 2		# holds next comparison location
		lb	$11, Array($12)		# loads byte 2 right
		bne	$11, $10, NotWhite	# branches if smile isnt black
		
		addi	$12, $13, -132		# gets top of hat location
		addi	$15, $13, -121		# gets middle of shirt location
		j 	Exit

Reloop4: 	addi	$13, $13, -64		# increments by -64 for rotated 270 face
		j 	CheckUpEye4

Reloop3:	addi	$13, $13, 64		# increments by 64 for rotated 90 face
		j 	CheckUpEye3
	
Reloop2: 	addi 	$13, $13, -1		# increments by -1 for rotated 180 face
		j 	CheckUpEye2

Reloop:		addi 	$13, $13, 1		# increments by 1 for rotated 0 face
		j 	CheckUpEye

NotWhite:	addi	$4, $4, 5		# skips 5 pixels 
		j 	Beginning		

Exit:		sll	$2, $12, 16		# shifts left		
		add	$2, $2, $15		# combines two answers and submits
		swi 	571	
		jr 	$31
