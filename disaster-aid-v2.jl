using JuMP, GLPK

# Preparing an optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
# x1 -> shelter ; x2 -> food
@variable(m, x1 >= 0)
@variable(m, 0 <= x2 <= 5)

# Setting the objective
@objective(m, Min, 11x1 + 4x2)

# Adding constraints
@constraint(m, constraint1, x1 + x2 <= 6)
@constraint(m, constraint2, 7.5x1 + 5x2 <= 40)
# @constraint(m, constraint3, 5x1 + 8x2)

# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Print the information about the optimum.
println("Objective value: ", objective_value(m))
println("Optimal solutions:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))