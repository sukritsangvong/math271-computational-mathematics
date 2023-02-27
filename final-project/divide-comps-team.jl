using JuMP, GLPK

# # Download packages to read csv file
# using Pkg
# Pkg.add("DataFrames")
# Pkg.add("CSV")
# Pkg.add("DataStructures")
using DataFrames, CSV, DataStructures

# Preparing an optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
x = CSV.read(joinpath(@__DIR__, "clean_comps_data.csv"), DataFrames.DataFrame, missingstring="",)
N = size(x)[1] # Number of students
M = size(x)[2] # Number of projects

# Set ks to be Binary
@variable(m, k[1:N, 1:M], Bin)
@variable(m, max_dissatisfaction)

# Setting the objective
@objective(m, Min, max_dissatisfaction)

# Adding constraints
for i in 1:N
    for j in 1:M
        @constraint(m, max_dissatisfaction >= k[i, j] * x[i, j])
    end
end
for j in 1:M-1
    # Constrains number of students per group
    @constraint(m, sum(k[i, j] for i in 1:N) <= 4)
end
for i in 1:N
    # Constrains each student to have a project
    @constraint(m, sum(k[i, j] for j in 1:M) == 1)
end

# Solving the optimization problem
JuMP.optimize!(m)

# Printing the prepared optimization model
print(solution_summary(m))
print(m)

# Print the information about the optimum.
println("Objective value: ", objective_value(m))
println("Optimal solutions:")
for j in 1:M
    print("Project ", j, " Group Member(s): ")
    for i in 1:N
        if value(k[i, j]) == 1
            print(i, " ")
        end
    end
    println()
end