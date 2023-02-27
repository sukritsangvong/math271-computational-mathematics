using JuMP, GLPK
using LinearAlgebra
using Pkg;

A = [1 0 0 -2 -9 1 9; 0 1 0 1/3 1 -1/3 -2; 0 0 1 2 3 -1 -12]
b = [0; 0; 2]
c = [0; 0; 0; 2; 3; -1; -12]
B = [1, 4, 6]

m, n = size(A)

# Check dimensions
if size(b) != (m,) || size(c) != (n,) || size(b) != (m,)
    println("Error: Wrong Dimension!")
    println("Size of A = ", size(A))
    println("Size of b = ", size(b), " should be mx1 ", (m,))
    println("Size of c = ", size(c), " should be nx1 ", (n,))
    println("Size of B = ", size(B), " should be mx1 ", (m,))
    exit()
end

# Check if B constitutes a basis
for i = 1:m
    if B[i] > n || B[i] <= 0
        println("Error: B can not be used to construct a basis (all values should be less than n).")
        println("B = ", B, " and n = ", n)
        exit()
    end
end

# Construct N
N = zeros(Int64, 0)
for i = 1:n
    if !(i in B)
        append!(N, i)
    end
end

# Functions for submatrices
function sub_matrix(matrix, B)
    return matrix[:, B]
end

function sub_matrix_row(matrix, B)
    return matrix[B, :]
end

A_B = sub_matrix(A, B)

if det(A_B) == 0
    println("Error: A_B is singular")
    exit()
end

A_B_inverse = inv(A_B)
A_N = sub_matrix(A, N)
c_B_transpose = transpose(sub_matrix_row(c, B))
c_N = sub_matrix_row(c, N)

println("A = ", A)
println("A_B = ", A_B)
println("A_B_inverse = ", A_B_inverse)
println("A_N = ", A_N)
println("c = ", c)
println("c_B_transpose = ", c_B_transpose)
println("c_N = ", c_N)
println()

p = *(A_B_inverse, b)
Q = *(-A_B_inverse, A_N)
z0 = *(*(c_B_transpose, A_B_inverse), b)
r = c_N - transpose(*(*(c_B_transpose, A_B_inverse), A_N))

println("p = ", p)
println("Q = ", Q)
println("z0 = ", z0)
println("r = ", r)