.globl read_matrix
.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:

    # Prologue
   addi sp sp -20
   sw s0  0(sp)
   sw s1  4(sp)
   sw s2  8(sp)
   sw s3  12(sp)
   sw s4  16(sp)

   mv s1 a1
   mv s2 a2
 
   mv a1 a0
   li a2 5
   call fopen 
   blt a0 x0 fopenfail
   mv s3 a0
   mv a1 s1
   li a2 4
   call fread
   li t0 1
   blt a0 t0 freadfail

   mv a0 s3
   mv a1 s2
   li a2 4
   call fread
   li t0 1
   blt a0 t0 freadfail
   
   lw s1 0(s1)
   lw s2 0(s2)
   mul s1 s1 s2
   mv a0 s1 
   call malloc 
   li t0 1
   blt a0 t0 mallocfail
   mv s2 a0
   addi s1 s1 -1 
loop: 
    mv a0 s3
    mv a1 s2
    li a2 4
    call fread
    li t0 1
    blt a0 t0 freadfail

    addi s2 s2 4
    addi s1 s1 -1
    bge s1 x0 loop

    # Epilogue
   lw s0  0(sp)
   lw s1  4(sp)
   lw s2  8(sp)
   lw s3  12(sp)
   lw s4  16(sp)
   addi sp sp 20

    ret

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