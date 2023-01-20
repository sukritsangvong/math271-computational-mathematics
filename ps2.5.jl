using JuMP, GLPK

# Preparing an optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
@variable(m, x1)
@variable(m, x2)
@variable(m, s1)
@variable(m, s2)
@variable(m, s3)

# Setting the objective
@objective(m, Max, 2x1 + 3s1)

# Adding constraints
@constraint(m, constraint1, s2 + s3 <= 5)
@constraint(m, constraint2, x2 - 10 <= s1)
@constraint(m, constraint3, -x2 + 10 <= s1)
@constraint(m, constraint4, x1 + 2 <= s2)
@constraint(m, constraint5, -x1 - 2 <= s2)
@constraint(m, constraint6, x2 <= s3)
@constraint(m, constraint7, -x2 <= s3)

# Solving the optimization problem
JuMP.optimize!(m)

# Printing the prepared optimization model
print(solution_summary(m))
print(m)

# Print the information about the optimum.
println("Objective value: ", objective_value(m))
println("Optimal solutions:")
println("x1 = ", value(x1))
println("x2 = ", value(x2))
println("s1 = ", value(s1))
println("s2 = ", value(s2))
println("s3 = ", value(s3))