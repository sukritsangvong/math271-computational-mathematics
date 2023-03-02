# How to Run:

Download the csv file of the form. 
(The first colum is assumed to be the Major, and the rest is the number of project. Empty field will be replaced with "15".)

Change the name of `csv_file_name` in `clean_csv.py` to match the name of the csv file.

Run `python3 clean_csv.py` to get clean_comps_data.csv.

Run `julia divide-comps-team.jl`

# To Run with Flags:

### Dataset format
(see example in `flags_students.csv` and `flags_projects.csv`)

flags_students.csv:
```
column i:   flag i
row j:      student j
cell[i,j]:  binary where 1 represents true and 0 represents false
```

flags_projects.csv:
```
column i:   project max(1, i//2)'s constraint (odd col is min constraint and even col is max constraint)
row j:      flag j
cell[i,j]:  "" means no constraint
            integer means a constraint of either max or min of people with flag j allowed for the project
            each project will have 2 columns, one for min and one for max; therefore flags_projects will 
                  have double the amount of columns compsdata.csv has
```

 

### Prepare dataset

If don't already have dataset for `flags_students.csv` and `flags_projects.csv`, can run `python3 write_flags_csv.py` to generate mock csv datasets.


### Run code

Trigger flag calculation by setting `RUN_WITH_FLAGS` to `true` in `divide-comps-team.jl` then follow the instructions (How to Run) above.


### Output from Running with Flag Calculation
```
Objective value: 5.0
Optimal solutions:
Project 1 Group Member(s): 54 61 63 65 
Project 2 Group Member(s): 47 51 57 58 
Project 3 Group Member(s): 45 50 59 62 
Project 4 Group Member(s): 19 43 46 48 
Project 5 Group Member(s): 6 14 24 
Project 6 Group Member(s): 10 20 39 42 
Project 7 Group Member(s): 9 16 34 36 
Project 8 Group Member(s): 7 12 30 38 
Project 9 Group Member(s): 22 25 27 28 
Project 10 Group Member(s): 2 17 32 35 
Project 11 Group Member(s): 8 13 41 44 
Project 12 Group Member(s): 4 18 33 40 
Project 13 Group Member(s): 5 21 
Project 14 Group Member(s): 1 3 11 15 23 26 29 31 37 49 52 53 55 56 60 64 
```
