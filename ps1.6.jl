using JuMP, GLPK

# Preparing an optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
@variable(m, x1 >= 0)
@variable(m, x2 >= 0)
@variable(m, x3 >= 0)
@variable(m, x4 >= 0)

# Setting the objective
@objective(m, Min, 0.8x1 + 0.2x2 + 0.4x3 + x4)

# Adding constraints
@constraint(m, constraint1, 16x1 + 8x2 + 6x3 + 12x4 <= 90)
@constraint(m, constraint2, 3x1 + 11x2 <= 40)
@constraint(m, constraint3, 7x1 + 8x2 + 12x3 + 26x4 >= 160)
@constraint(m, constraint4, 2x1 + 9x3 <= 25)
@constraint(m, constraint5, x1 >= 1)

# Solving the optimization problem
JuMP.optimize!(m)

# Printing the prepared optimization model
print(m)

# Print the information about the optimum.
println("Objective value: ", objective_value(m))
println("Optimal solutions:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))
println("x3 = ", value(x3))
println("x4 = ", value(x4))

println("")
println("protein = ", 7value(x1) + 8value(x2) + 12value(x3) + 26value(x4))
println("fat = ", 16value(x1) + 8value(x2) + 6value(x3) + 12value(x4))
println("fiber = ", 2value(x1) + 0value(x2) + 9value(x3) + 0value(x4))
println("sugar = ", 3value(x1) + 11value(x2) + 0value(x3) + 0value(x4))

# 7x1 + 8x2 + 12x3 + 26x4 
# 2x1 + 9x3 