#!/bin/bash

URL="https://raw.githubusercontent.com/datasets/s-and-p-500-companies/refs/heads/main/data/constituents.csv"

curl -s "$URL" | python3 -c '
import csv, sys

reader = csv.DictReader(sys.stdin)
rows = []

for row in reader:
    rows.append((
        row.get("Security", "").strip(),
        row.get("Headquarters Location", "").strip(),
        row.get("Founded", "").strip()
    ))

def year(value):
    try:
        return int(value)
    except (ValueError, TypeError):
        return 9999

for company, location, founded in sorted(rows, key=lambda x: year(x[2])):
    print(f"{company}\t{location}\t{founded}")
'
