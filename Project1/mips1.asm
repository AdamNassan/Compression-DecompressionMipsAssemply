#Jehad Hamayel 1200348
#Adam Nassan 1202076

################# D ata segment #####################
.data
fileDict: .asciiz "dictionary.txt" # name of file to read from
FirstQu: .asciiz "Does the dictionary.txt file exist? If the answer is yes, enter 1, and if the answer is no, enter 0 \n"
yesAnser: .asciiz "Enter the dicPath of dictionary.txt Please\n"
ErrorOutOfMemory: .asciiz "The maximum number of special cricketers has been reached \n"
DicPath: .asciiz "C:\\Users\\hp\\Desktop\\Mars\\Project1\\dictionary.txt"
dicPath: .space 1024
dicFile: .space 65535
beCompPath: .space 1024
beCompFile: .space 65535

quotient: .asciiz ""  # define a string to store the quotient
remainder: .asciiz ""

sprint1: .asciiz "\nThe uncompressed file size = Number of characters x 16 (size of the Unicode)\n= "
sprint12: .asciiz "The compressed file size = Number of binary codes x 16 (code size)\n= "
sprint13: .asciiz "File Compression Ratio = uncompressed file size / compressed file size\n= "
sprint2:  .asciiz " x "
sprint3:  .asciiz " = "
sprint4:  .asciiz " bits "
sprint5:  .asciiz " bytes \n"
sprint6:  .asciiz ","

code: .space 4

compPath:  .asciiz "C:\\Users\\hp\\Desktop\\Mars\\Project1\\compressed.txt"
compFile: .space 65535

deCompPath: .asciiz "C:\\Users\\hp\\Desktop\\Mars\\Project1\\uncompressed.txt"
deCompFile: .space 65535

timp1: .space 1024
timp2: .space 1024
newDictionaryFile: .asciiz "C:\\Users\\hp\\Desktop\\Mars\\Project1\\dictionary.txt"
statment0: .asciiz "\nDo you want to compress or decompress a specific file? \n"
statment1: .asciiz "c: Compress File\n"
statment2: .asciiz "d: Decompress File\n"
statment3: .asciiz "q: quit the program\n"
statment4: .asciiz "Choose one of the options: "
statment5: .asciiz "Enter the path of the file to be compressed:\n"
newLine: .asciiz "\n\n"
option1: .byte 'c'   # first option
option2: .byte 'd'   # second option
option3: .byte 'q'   # thirs option
test: .asciiz "\nTest\n"
ErrorMessage1: .asciiz "\nPlease choose on of the options\n"
ErrorMessage2: .asciiz "\nPlease choose just 1 or 0 \n"
################# Code segment #####################
.text
.globl main
main: # main program entry
	li $v0, 4          
  	la $a0, FirstQu       
   	syscall
	li $v0, 5         
   	syscall
   	li $t1, 1
   	beq $v0, $t1, yes
   	li $t1, 0
   	beq $v0, $t1, no
   	j Error2	
yes:

	li $v0, 4          
  	la $a0, yesAnser       
   	syscall
   	
   	li $v0, 8
   	la $a0,dicPath
   	li $a1, 1024
   	syscall
   	
      	
  	 la    $s0, dicPath    # $s0 contains base address of str
 	 add    $s2, $0, $0    # $s2 = 0
         addi    $s3, $0, '\n'    # $s3 = '\n'
loop:
         lb    $s1, 0($s0)    # load character into $s0
         beq    $s1, $s3, end    # Break if byte is newline
         addi    $s2, $s2, 1    # increment counter
         addi    $s0, $s0, 1    # increment str address
         j    loop
end:
         sb    $0, 0($s0)    #replace newline with 0 
          	
      	li $v0, 13
   	la $a0, dicPath
   	li $a1, 0
   	syscall
   	move $s0, $v0
   	
   	li $v0, 14
   	move $a0, $s0
   	la $a1,dicFile
   	li $a2, 65536
   	syscall
   	 li $v0 4
   	 la $a0,dicFile
   	 syscall 
   	 
   	 li $v0, 16
   	 move $a0,$s0
   	 syscall  
 	 			
	j menuLoop
			
no:

         # creating new file for dictionary.txt
	li $v0, 13          # system call code for "open"
  	la $a0, newDictionaryFile    # load the filename into $a0
 	li $a1, 1        # O_WRONLY (0x01)
 	syscall             # call the system to open the file

	move $s0, $v0     # save the file descriptor in $s0
	
	# Close the file
	li $v0, 16        # system call code for "close"
	move $a0, $s0     # load the file descriptor into $a0
	syscall           # call the system to close the file
	

	
menuLoop:
	li $v0, 4          
  	la $a0, statment0       
   	syscall	
   	
	li $v0, 4          
  	la $a0, statment1       
   	syscall
   	
	li $v0, 4          
  	la $a0, statment2       
   	syscall
   	
	li $v0, 4          
  	la $a0, statment3       
   	syscall
   	
  	li $v0, 4          
  	la $a0, statment4       
   	syscall
   	
	li $v0, 12         # system call number for reading a character
   	syscall
   	
        move $t0, $v0
 	li $v0, 4          
  	la $a0, newLine       
   	syscall
   	lb $t1, option1
   	beq $t0, $t1, compress
   	lb $t1, option2
   	beq $t0, $t1, deCompress
   	lb $t1, option3
   	beq $t0, $t1, exit
   	j Error1
   	
compress: 
 	li $v0, 4          
  	la $a0, statment5       
   	syscall	
   	
   	li $v0, 8
   	la $a0,beCompPath
   	li $a1, 1024
   	syscall
   	
      	
  	 la    $s0, beCompPath    # $s0 contains base address of str
 	 add    $s2, $0, $0    # $s2 = 0
         addi    $s3, $0, '\n'    # $s3 = '\n'
loop2:
         lb    $s1, 0($s0)    # load character into $s0
         beq    $s1, $s3, end2    # Break if byte is newline
         addi    $s2, $s2, 1    # increment counter
         addi    $s0, $s0, 1    # increment str address
         j    loop2
end2:
         sb    $0, 0($s0)    #replace newline with 0 
          	
      	li $v0, 13
   	la $a0, beCompPath
   	li $a1, 0
   	syscall
   	move $s0, $v0
   	
   	li $v0, 14
   	move $a0, $s0
   	la $a1,beCompFile
   	li $a2, 65536
   	syscall
   	 li $v0 4
   	 la $a0,beCompFile
   	 syscall 
   	 
   	 li $v0, 16
   	 move $a0,$s0
   	 syscall 
   	 la $t8, compFile 
   	 li $s4,0 # flag 
   	 li $s6,0 # flag
   	 la $t0,beCompFile # base address for the file that we want to compress it 
 
   	 la $t4,timp1 #taking the address of the timp memory to compare it with dictionary to compress it
   	 
loop3:    #Starting comparing
#note : make the spichal character valid in the first of the file that we want to compress
	 lb $t2,0($t0)#taking the first character
	 beq $t2,' ',special 
	 beq $t2,',',special	 
	 beq $t2,'.',special
	 beq $t2,'\r',newline # because the new line stors \r\n
	 beq $t2,'\0',stop
	 li $s6,1 #string 
	 sb $t2,0($t4)
	 addi $t0, $t0, 1 
	 addi $t4, $t4, 1
	 j loop3
stop:
	beq $s6,1,special
	j finishComp 	 	   	 
special:
	beq $s6,0,compChar
	li $t1,'\0'
        sb $t1,0($t4)
        li $s6,0
        j compare
        
newline: 
	la $t4,timp1
	li $t2,0x5C # means \
	sb $t2,0($t4)
	li $t2,0x6E# means \n
	addi $t4, $t4, 1
	sb $t2,0($t4)
	addi $t0, $t0, 2 
	addi $t4, $t4, 1
	li $t1,'\0'
	sb $t1,0($t4)
	j compare
compChar: 
	la $t4,timp1
	lb $t2,0($t0)
	sb $t2,0($t4)
	addi $t0, $t0, 1 
	addi $t4, $t4, 1
	li $t1,'\0'
	sb $t1,0($t4)
	j compare
	
storeNewDic:
	la $t2,code
	addi $t2,$t2,3 #0x
	li $s2,4
	move $s3,$s7
	
loopStore:
	andi $t1,$s3,0x0000000f
	beq $t1,0x00000000,zero
	beq $t1,0x00000001,one
	beq $t1,0x00000002,two
	beq $t1,0x00000003,three
	beq $t1,0x00000004,four
	beq $t1,0x00000005,five
	beq $t1,0x00000006,six
	beq $t1,0x00000007,Seven
	beq $t1,0x00000008,eight
	beq $t1,0x00000009,nine
	beq $t1,0x0000000a,A
	beq $t1,0x0000000b,B
	beq $t1,0x0000000c,C
	beq $t1,0x0000000d,D
	beq $t1,0x0000000e,E
	beq $t1,0x0000000f,F
contee: srl $s3,$s3,4
        sb $t5,0($t2)
	subi $t2,$t2,1
	subi $s2,$s2,1
	beq $s2,$zero,dict

	j loopStore
zero:	li $t5,0x30
	j contee
one: 	li $t5,0x31
	j contee
two:	li $t5,0x32
	j contee
three:  li $t5,0x33
	j contee
four:	li $t5,0x34
	j contee
five:	li $t5,0x35
	j contee
six:	li $t5,0x36
	j contee
Seven:	li $t5,0x37
	j contee
eight:	li $t5,0x38
	j contee
nine:	li $t5,0x39
	j contee
A:	li $t5,0x61
	j contee
B:	li $t5,0x62
	j contee
C:	li $t5,0x63
	j contee
D:	li $t5,0x64
	j contee
E:	li $t5,0x65
	j contee
F:	li $t5,0x66
	j contee
				
dict: 
      la $t9,code
      li $t5,4
loopDic:
      lb $t1,0($t9)   
      sb $t1,0($t3)
      addi $t3,$t3,1
      addi $t9,$t9,1
      subi $t5,$t5,1
      beq $t5,$zero,complet
      j loopDic

complet: li $t1,0x20 #Space 
	 sb $t1,0($t3)
         addi $t3,$t3,1
         la $t9,timp1
loopNew: 
         lb $t1,0($t9)
         beq $t1,$zero,endloop
         sb $t1,0($t3)
         addi $t3,$t3,1
         addi $t9,$t9,1
	 j loopNew
endloop: li $t1,'\r'
         sb $t1,0($t3)
         addi $t3,$t3,1
         li $t1,'\n'
         sb $t1,0($t3)
         addi $t3,$t3,1
	 j equal		
compare: 
	
	la $t3,dicFile
	li $s7,0
	la $t9,code
	
	lb $s1,0($t3)
	beq $s1,'\0',storeNewDic
	li $t2,4
loopCode:
	lb $t1,0($t3)
	sb $t1,0($t9)	
 	subi,$t2,$t2,1
 	addi $t3, $t3, 1
 	addi $t9, $t9, 1
 	beq $t2,0,cont
 	j loopCode
 	
 	
cont: 	addi $t3, $t3, 1#0000 we\r\n
	la $t5,timp2
 	lb $t2,0($t3)
loopComp:
	sb $t2,0($t5)
	addi $t3, $t3, 1 
	addi $t5, $t5, 1
	lb $t2,0($t3)
	beq $t2,'\r',ToCommp
	j loopComp
ToCommp: addi $t3, $t3, 2
	 li $t1,'\0'
	 sb $t1,0($t5)
	 j CompareStraing

CompareStraing:
	#Load the addresses of the strings into $a0 and $a1
	la $a0, timp1 #we\0
	la $a1, timp2 #we\0
	
loopStr:
	lb $t6, ($a0)
 	lb $t7, ($a1)
 	  #Compare the characters
  	bne $t6, $t7, not_equal

 	 #Check if the end of the string has been reached
  	beq $t6, $zero, equal
  	addi $a0, $a0, 1
 	addi $a1, $a1, 1
 	j loopStr
 	
not_equal: la $t5,timp2
	addi $s7,$s7,1
	la $t9,code
	li $t6,4
	#li $t6,0x31313131 
	#lw ,$t7,4($)
	#beq $t6,$t7,ErrorOut
	lb $t7,0($t3)
	beq $t7,'\0',storeNewDic
loopCode2:
	lb $t7,0($t3)
	sb $t7,0($t9)	
 	subi,$t6,$t6,1
 	addi $t3, $t3, 1
 	addi $t9, $t9, 1
 	beq $t6,0,cont2
 	j loopCode2
 	
cont2:	   addi $t3, $t3, 1
	   
	   lb $t2,0($t3)

	   
	   j loopComp
equal:
	la $t9,code 
	lb $t1,0($t9)
	sb $t1,0($t8)
	addi $t8, $t8, 1
	addi $t9, $t9, 1
	lb $t1,0($t9)
	sb $t1,0($t8)
	addi $t8, $t8, 1
	addi $t9, $t9, 1
	lb $t1,0($t9)
	sb $t1,0($t8)
	addi $t8, $t8, 1
	addi $t9, $t9, 1
	lb $t1,0($t9)
	sb $t1,0($t8)
	addi $t8, $t8, 1
	addi $t9, $t9, 1
	li $t1,'\r'
	sb $t1,0($t8)
	addi $t8, $t8, 1
	addi $t9, $t9, 1
	li $t1,'\n'
	sb $t1,0($t8)
	addi $t8, $t8, 1
	la $t4,timp1
	j loop3 # to check the spetial character

   	 
    	 
finishComp: 
	 la $t0,beCompFile
	 li $s0,0 #wee\0
loopUnCompressed:
	lb $t2,0($t0)
	addi $t0,$t0,1
	beq $t2,'\0', next
	beq $t2,'\r',skip
	addi $s0,$s0,1
skip:	j loopUnCompressed
next:
	move $s6,$s0
	li $s1,16
	mul $s2,$s0,$s1
	 li $v0 4
   	 la $a0,sprint1
   	 syscall
	move $a0,$s0
	 li $v0 1
   	 syscall
   	 
   	 li $v0 4
   	 la $a0,sprint2
   	 syscall
   	 
   	  move $a0,$s1
   	 li $v0 1
   	 syscall
   	 
   	 li $v0 4
   	 la $a0,sprint3
   	 syscall
   	 
   	 li $v0, 1       
	move $a0,$s2  
	syscall
	
	li $v0 4
   	 la $a0,sprint4
   	 syscall
   	 
   	 li $v0 4
   	 la $a0,sprint3
   	 syscall
   	 move $s3,$s2
   	 li $t3,0  
loopByt: blt $s3,8,printByte
	 subi $s3,$s3,8
	 addi $t3,$t3,1
	  j loopByt 	 
printByte:  
	move $a0,$t3
   	li $v0 1
   	syscall 
   	li $v0 4
   	 la $a0,sprint5
   	 syscall
 #sprint12
#sprint2:  .asciiz " x "
#sprint3:  .asciiz " = "
#sprint4:  .asciiz " bits "
#sprint5:  .asciiz " bytes "
#sprint6:  .asciiz ","
	 la $t1, compFile 
	 li $s0,0
loopCompressed:
	lb $t2,0($t1)
	addi $t1,$t1,1
	beq $t2,'\0', next2
	beq $t2,'\r',addone
	beq $t2,'\n',skip2
skip2:	j loopCompressed
addone:addi $s0,$s0,1
	j loopCompressed
next2:
  	li $s1,16
   
  	mul $s3,$s0,$s1
  	 li $v0 4
   	 la $a0,sprint12
   	 syscall
	move $a0,$s0
	 li $v0 1
   	 syscall
   	 
   	 li $v0 4
   	 la $a0,sprint2
   	 syscall
   	 
   	  move $a0,$s1
   	 li $v0 1
   	 syscall
   	 
   	 li $v0 4
   	 la $a0,sprint3
   	 syscall
   	 
   	 move $a0,$s3
   	 li $v0 1
   	 syscall
   	 
   	 li $v0 4
   	 la $a0,sprint4
   	 syscall
   	 
   	 li $v0 4
   	 la $a0,sprint3
   	 syscall
   	 
   	 move $s1,$s3
   	 li $t3,0  
loopByt2: blt $s1,8,printByte2
	 subi $s1,$s1,8
	 addi $t3,$t3,1
	  j loopByt2 	 
printByte2:  
	move $a0,$t3
   	li $v0 1
   	syscall 
   	li $v0 4
   	 la $a0,sprint5
   	 syscall
   	 
   	 div $s6,$s0
   	 mflo $t0          # Move quotient from $LO to $t0
   	 mfhi $t1        # Move remainder from $HI to $t1
   	  
	
  	  # Print floating-point result
  	 move $a0,$t0
         li $v0, 1       # Load the system call number for printing a float (2)
         syscall         # Trigger the system call to print the float         
	
   	 move $a0,$t1
   	li $v0, 1       # Load the system call number for printing a float (2)
  	  syscall         # Trigger the system call to print the remainder
  	  
  	  li $v0, 13
   	la $a0, compPath
   	li $a1, 1
   	syscall
   	move $s0, $v0
   	
   	li $v0, 15
   	move $a0, $s0
   	la $a1,compFile
   	li $a2, 65536
   	syscall 
   	 
   	 li $v0, 16
   	 move $a0,$s0
   	 syscall 
   	 
   	 li $v0, 13
   	la $a0, DicPath
   	li $a1, 1
   	syscall
   	move $s0, $v0
   	
   	li $v0, 15
   	move $a0, $s0
   	la $a1,dicFile
   	li $a2, 65536
   	syscall 
   	 
   	 li $v0, 16
   	 move $a0,$s0
   	 syscall 
    	 j menuLoop
    	 
ErrorOut: li $v0, 4          
  	  la $a0, ErrorOutOfMemory       
          syscall
   	  j exit    	 
deCompress:  	      
	
	
	
Error1: 
	li $v0, 4          
  	la $a0, ErrorMessage1       
   	syscall
   		
	j menuLoop	
Error2: 
	li $v0, 4          
  	la $a0, ErrorMessage2       
   	syscall	
   	j main
   	
	j menuLoop
exit:	li $v0, 10 # Exit program
	syscall
