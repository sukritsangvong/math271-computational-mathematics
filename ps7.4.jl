#  In this script we find the (mixed) Nash equilibrium
#  for any given M matrix

# load in packages
using JuMP, GLPK

###  SOLVING THE PRIMAL PROBLEM

# Preparing an optimization model
m = Model(GLPK.Optimizer)


# Declaring variables
# Note here that x0 is unconstrained in the problem.
M = [-2 3; 3 -4; -4 5] # Can be anything
x_strat_num = size(M)[1]
y_strat_num = size(M)[2]
@variable(m, x0)
@variable(m, x[1:x_strat_num] >= 0)

# Setting the objective
@objective(m, Max, x0)

# Adding constraints M'x - 1x0 >=0 and sum(x) == 1
@constraint(m, *(transpose(M), x) .>= *(x0, ones(y_strat_num)))
@constraint(m, sum(x) == 1)

# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Print the information about the optimum.
# We don't print x0 because it's just the value of the objective
println(" \n PRIMAL \n ")
println("Objective value: ", objective_value(m), "\n")
println("Optimal solution:")
for i in 1:x_strat_num
    println("x", i, " = ", value(x[i]))
end
println()

###  SOLVING THE DUAL PROBLEM

# Preparing an optimization model
md = Model(GLPK.Optimizer)


# Declaring variables
# Note y0 is unconstrained.
@variable(md, y0)
@variable(md, y[1:y_strat_num] >= 0)

# Setting the objective
@objective(md, Min, y0)

# Adding constraints My - 1y0 <= 0, sum(y) == 1
@constraint(md, *(M, y) .<= *(y0, ones(x_strat_num)))
@constraint(md, sum(y) == 1)

# Printing the prepared optimization model
print(md)

# Solving the optimization problem
JuMP.optimize!(md)

# Print the information about the optimum.
println(" \n DUAL \n ")
println("Objective value: ", objective_value(md), "\n")
println("Optimal solution:")
for i in 1:y_strat_num
    println("y", i, " = ", value(y[i]))
end
println()