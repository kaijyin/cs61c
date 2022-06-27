.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:
    # Error checks
    li t0 1
    blt a1 t0 argbad1
    blt a2 t0 argbad1
    blt a4 t0 argbad2
    blt a5 t0 argbad2
    beq a1 a5 next
    beq a2 a4 next
    jal argbad3
next:
    # Prologue
    addi sp sp -48
    sw s11 44(sp)
    sw s10 40(sp)
    sw s9 36(sp)
    sw s8 32(sp)
    sw s7 28(sp)
    sw s6 24(sp)
    sw s5 20(sp)
    sw s4 16(sp)
    sw s3 12(sp)
    sw s2 8(sp)
    sw s1 4(sp)
    sw s0 0(sp)

    mv s0 a0
    mv s1 a3
    mv s2 a1
    mv s3 a2 
    mv s4 a6

    li t0 4 
    mul s5 t0 s2
    mul s6 t0 s3

    mul t1 s2 s3
    mul t1 t1 t0
    add s11 t1 s4
    
    mv s7 s0
loop1:
    mv s10 s1
    mv t5 s2
loop2:
    mv t0 s10
    mv s8 s7
    li t1 0 
    li t2 0 
    
loop3:
    lw t3 0(s8)
    lw t4 0(t0)

    mul t4 t3 t4
    add t1 t1 t4
   
    addi s8 s8 4
    add t0 t0 s5

    addi t2 t2 1
    blt t2 s3 loop3

loop3_end:
    sw  t1 0(s4)
    addi s4 s4 4 
    addi s10 s10 4
    addi t5 t5 -1
    blt x0 t5 loop2 
loop2_end:
    add s7 s7 s6
    blt s4 s11 loop1
loop1_end: 
    


    # Epilogue
    lw s11 44(sp)
    lw s10 40(sp)
    lw s9 36(sp)
    lw s8 32(sp)
    lw s7 28(sp)
    lw s6 24(sp)
    lw s5 20(sp)
    lw s4 16(sp)
    lw s3 12(sp)
    lw s2 8(sp)
    lw s1 4(sp)
    lw s0 0(sp)
    addi sp sp 48
    ret

argbad1:
    li a1 2
    jal exit2
argbad2:
    li a1 3
    jal exit2
argbad3:
    li a1 4
    jal exit2