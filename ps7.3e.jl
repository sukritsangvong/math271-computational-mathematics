#  In this script we find the (mixed) Nash equilibrium
#  for the monkey vs rabbit rock/paper/scissors game.

# load in packages
using JuMP, GLPK

###  SOLVING THE PRIMAL PROBLEM

# Preparing an optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
M = [-2 3; 3 -4; -4 5]
ones = [1; 1]
@variable(m, x0)
@variable(m, x[1:3] >= 0)

# Setting the objective
@objective(m, Max, x0)

# Adding constraints 
@constraint(m, *(transpose(M), x) .>= *(x0, ones))
@constraint(m, sum(x) == 1)

# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Print the information about the optimum.
println("Objective value: ", objective_value(m), "\n")
println("Optimal solution:")
println("x1 = ", value(x[1]))
println("x2 = ", value(x[2]))
println("x3 = ", value(x[3]))
println(solution_summary(m))
println()


# @constraint(m, constraint1, -2x1 + 3x2 - x0 >= 0)
# @constraint(m, constraint2, 3x1 + -4x2 - x0 >= 0)
# @constraint(m, constraint3, -4x1 + 5x2 - x0 >= 0)
# @constraint(m, constraint4, x1 + x2 == 1)

# ###  SOLVING THE DUAL PROBLEM

# # Preparing an optimization model
# md = Model(GLPK.Optimizer)


# # Declaring variables
# # Note y0 is unconstrained.

# @variable(md, y0)
# @variable(md, y1 >= 0)
# @variable(md, y2 >= 0)

# # Setting the objective
# @objective(md, Min, y0)

# # Adding constraints My - 1y0 <= 0, sum(y) == 1
# @constraint(md, constraint1, -y2 - y0 <= 0)
# @constraint(md, constraint2, y1 - y0 <= 0)
# @constraint(md, constraint3, -y1 + y2 - y0 <= 0)
# @constraint(md, constraint4, y1 + y2 == 1)

# # Printing the prepared optimization model
# print(md)

# # Solving the optimization problem
# JuMP.optimize!(md)

# # Print the information about the optimum.
# println(" \n DUAL \n ")
# println("Objective value: ", objective_value(md), "\n")
# println("Optimal solution:")
# println("y1 = ", value(y1))
# println("y2 = ", value(y2), "\n")
