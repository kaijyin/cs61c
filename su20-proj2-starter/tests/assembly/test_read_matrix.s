.import ../../src/read_matrix.s
.import ../../src/utils.s

.data
file_path: .asciiz "inputs/test_read_matrix/test_input.bin"

.text
main:
    # Read matrix into memory
    la s0 file_path
    
    li a0 4
    call malloc
    li t0 1
    blt a0 t0 mallocfail
    mv s1 a0
    li a0 4
    call malloc
    li t0 1
    blt a0 t0 mallocfail
    mv s2 a0
    mv a0 s0
    mv a1 s1
    mv a2 s2
    call read_matrix
    # Print out elements of matrix
    lw a1 0(s1)
    lw a2 0(s2)    
    call print_int_array
    
    call exit

fopenfail:
    li a1 50
    call exit2
freadfail:
    li a1 51
    call exit2
fwritefail:
    li a2 52
    call exit2
mallocfail:
    li a1 48
    call exit2