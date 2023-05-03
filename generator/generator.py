import os
import sys

# check if input file exists
if not os.path.isfile(sys.argv[1]):
    print(f"{sys.argv[1]} does not exist!")
    exit()

# read input file
with open(sys.argv[1], 'r', encoding='utf-8') as f:
    input_text = f.read()

# create output file
with open('output.txt', 'w', encoding='utf-8') as f:
    while f.tell() < 35*1024*1024:
        f.write(input_text)
