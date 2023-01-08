using JuMP, GLPK

# Preparing an optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
@variable(m, a)
@variable(m, b)
@variable(m, e0)
@variable(m, e1)
@variable(m, e2)
@variable(m, e3)
@variable(m, e4)
@variable(m, e5)

# Setting the objective
@objective(m, Min, e0 + e1 + e2 + e3 + e4 + e5)

x0 = 120, y0 = 120, x1 = 11, y1 = 52
x2 = 33, y2 = 32, x3 = 68, y3 = 43
x4 = 80, y4 = 14, x5 = 108, y5 = 39

# Adding constraints
@constraint(m, constraint1, e1 >= (a * x1) + b - y1)
@constraint(m, constraint2, e1 >= -((a * x1) + b - y1))
@constraint(m, constraint3, e2 >= (a * x2) + b - y2)
@constraint(m, constraint4, e2 >= -((a * x2) + b - y2))
@constraint(m, constraint5, e3 >= (a * x3) + b - y3)
@constraint(m, constraint6, e3 >= -((a * x3) + b - y3))
@constraint(m, constraint7, e4 >= (a * x4) + b - y4)
@constraint(m, constraint8, e4 >= -((a * x4) + b - y4))
@constraint(m, constraint9, e5 >= (a * x5) + b - y5)
@constraint(m, constraint10, e5 >= -((a * x5) + b - y5))

@constraint(m, constraint11, e0 >= (a * x0) + b - y0)
@constraint(m, constraint12, e0 >= -((a * x0) + b - y0))


# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Print the information about the optimum.
println("Objective value: ", objective_value(m))
println("Optimal solutions:")
println("a = ", value(a))
println("b = ", value(b))

# function constraint_positive(e, x, y)
#     return e >= (a * x) + b - y
# end
# function constraint_negative(e, x, y)
#     return e >= -((a * x) + b - y)
# end
