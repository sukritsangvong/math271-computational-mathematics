import csv
import random

csv_file_name = "clean_comps_data.csv"
output_flags_project_name = "flags_projects.csv"
output_flags_student_name = "flags_students.csv"

NUM_FLAGS = 2
MAX_PER_GROUP = 4
WEIGHTS = [0.9, 0.025, 0.025, 0.025, 0.025]

with open(csv_file_name, "r") as f:
    reader = csv.reader(f)
    comps_csv_rows = list(reader)

num_students = len(comps_csv_rows) - 1
num_projects = len(comps_csv_rows[0])

with open(output_flags_project_name, "w", newline="") as f:
    writer = csv.writer(f)

    # write titles
    title_row = []
    for col in comps_csv_rows[0]:
        title_row.append(f"{col}_min")
        title_row.append(f"{col}_max")
    writer.writerow(title_row)

    # fill in max and min of a given flag per group via probability
    for flag in range(NUM_FLAGS):
        new_row = []
        for i in range(num_projects):
            # Not add constraints for independent comps
            if i == num_projects - 1:
                new_row.append("")
                new_row.append("")
                break

            random_number_min = random.choices(
                range(MAX_PER_GROUP + 1), weights=WEIGHTS
            )[0]
            random_number_max = random.choices(
                range(random_number_min, MAX_PER_GROUP + 1)
            )[0]

            if random_number_min == 0:
                new_row.append("")
            else:
                new_row.append(random_number_min)

            if random_number_max == 0:
                # Don't want max to have 0 that often
                new_row.append(random.choices([0, ""], weights=[0.01, 0.99])[0])
            else:
                new_row.append(random_number_max)

        writer.writerow(new_row)

with open(output_flags_student_name, "w", newline="") as f:
    writer = csv.writer(f)

    # write titles
    title_row = []
    for i in range(NUM_FLAGS):
        title_row.append(f"f{i+1}")
    writer.writerow(title_row)

    for i in range(num_students):
        new_row = []
        for i in range(NUM_FLAGS):
            new_row.append(random.choice([1, 0]))
        writer.writerow(new_row)
