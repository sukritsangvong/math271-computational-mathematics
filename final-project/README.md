# How to Run:

Download the csv file of the form. 
(The first colum is assumed to be the Major, and the rest is the number of project. Empty field will be replaced with "15".)

Change the name of `csv_file_name` in `clean_csv.py` to match the name of the csv file.

Run `python3 clean_csv.py` to get clean_comps_data.csv.

Run `julia divide-comps-team.jl`
