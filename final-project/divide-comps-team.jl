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

RUN_WITH_FLAGS = true
if RUN_WITH_FLAGS
    student_flags = CSV.read(joinpath(@__DIR__, "flags_students.csv"), DataFrames.DataFrame,)
    project_flags_constraints = CSV.read(joinpath(@__DIR__, "flags_projects.csv"), DataFrames.DataFrame, missingstrings="",)
    num_flags = size(student_flags)[2]

    # Checking dimensions for the flag files
    if size(student_flags)[1] != N
        println("Error: flags_students.csv's number of rows does not match with clean_comps_data.csv's")
        println("Number of rows for clean_comps_data: ", N)
        println("Number of rows for flags_students: ", size(student_flags)[1])
        exit()
    end

    if size(project_flags_constraints)[2] != M * 2
        println("Error: flags_projects.csv's number of columns does not match with clean_comps_data.csv's")
        println("Number of columns for clean_comps_data: ", M)
        println("Number of columns for flags_projects: ", size(project_flags_constraints)[2])
        exit()
    end

    if size(student_flags)[2] != size(project_flags_constraints)[1]
        println("Error: Numbers of flags in flags_projects.csv and clean_comps_data.csv do not match.")
        println("Number of columns for flags_students: ", size(student_flags)[2])
        println("Number of rows for flags_projects: ", size(project_flags_constraints)[1])
        exit()
    end
end

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

if RUN_WITH_FLAGS
    for project_constraint_index in 1:M*2
        for flag_index in 1:num_flags
            current_constraint = project_flags_constraints[flag_index, project_constraint_index]

            # skips projects with no constraints
            if ismissing(current_constraint)
                continue
            end

            current_project_index = max(1, div(project_constraint_index, 2)) # floor-division

            if project_constraint_index % 2 == 0
                # Max constraint
                @constraint(m, sum(k[i, current_project_index] * student_flags[i, flag_index] for i in 1:N) <= current_constraint)
            else
                # Min constraint
                @constraint(m, sum(k[i, current_project_index] * student_flags[i, flag_index] for i in 1:N) >= current_constraint)
            end

        end
    end
end

# Solving the optimization problem
JuMP.optimize!(m)

# Printing the prepared optimization model
print(m)
print(solution_summary(m))

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