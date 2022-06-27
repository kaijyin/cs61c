.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================
argmax:

    # Prologue
    mv t0 a0
    li a0 0
    li t1 1
    lw t2 0(t0)
    addi t0 t0 4
    bge t1 a1 end
loop_continue:
    lw t3 0(t0)
    bge t2 t3 go
    mv t2 t3
    mv a0 t1
go:
    addi t0 t0 4
    addi t1 t1 1
    blt t1 a1 loop_continue
    # Epilogue
end:
    ret