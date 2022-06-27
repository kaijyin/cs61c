.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
relu:
    # Prologue
    li t0 1
    bge a1 t0 loop_start
    li a1 8
    call exit2
loop_start:
    li t0 4
    mul t1 a1 t0
    add t1 t1 a0
    
loop_continue:
     lw t0 0(a0) 
     blt x0 t0 next
     sw x0 0(a0) 
next:
     addi a0 a0 4
     blt a0 t1 loop_continue
loop_end:
    # Epilogue
	ret