.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================
dot:

    # Prologue
    li t1 1
    blt a2 t1 argvalid1
    blt a3 t1 argvalid12
    blt a4 t1 argvalid12
    li t1 4
    li t0 0
    mul a3 a3 t1
    mul a4 a4 t1
    li t2 0
loop:
    lw t3 0(a0)
    lw t4 0(a1)
    mul t3 t3 t4
    add t2 t2 t3
    add a0 a0 a3
    add a1 a1 a4
    addi t0 t0 1
    blt t0 a2 loop
loop_end:
    mv a0 t2

    # Epilogue

    
    ret

argvalid1:
    li a1 5
    call exit2
argvalid12:
    li a1 6
    call exit2