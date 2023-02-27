import csv

csv_file_name = "compsdata.csv"
clean_csv_file_name = "clean_comps_data.csv"
val_to_replace_None = "15"

with open(csv_file_name, "r") as f:
    reader = csv.reader(f)
    rows = list(reader)

with open(clean_csv_file_name, "w", newline="") as f:
    writer = csv.writer(f)
    for row in rows:
        new_row = []
        for col in row[1:]:  # skips first column
            if col == "" or col is None:
                new_col = val_to_replace_None
            else:
                new_col = col
            new_row.append(new_col)
        writer.writerow(new_row)
