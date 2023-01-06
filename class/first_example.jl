using JuMP, GLPK

# Preparing an optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
@variable(m, x1 >= 0)
@variable(m, x2 >= 0)

# Setting the objective
@objective(m, Max, x1 + x2)

# Adding constraints
@constraint(m, constraint1, -x1+x2 <= 1)
@constraint(m, constraint2,  x1 + 6x2 <= 15)
@constraint(m, constraint3,  4x1 - x2 <= 10)

# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Print the information about the optimum.
println("Objective value: ", objective_value(m))
println("Optimal solutions:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))
