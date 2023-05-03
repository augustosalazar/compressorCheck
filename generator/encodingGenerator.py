import os
import random
import string

# list of encodings to use
encodings = ['utf-8', 'ascii', 'iso-8859-1', 'utf-16']

# function to generate random text
def generate_text(size):
    return ''.join(random.choices(string.ascii_lowercase + ' ', k=size))

# generate text files
for i in range(5):
    # generate random text
    text = generate_text(5*1024*1024)

    # choose random encoding
    encoding = random.choice(encodings)

    # create output file
    filename = f"output_{i}.txt"
    with open(filename, 'w', encoding=encoding) as f:
        f.write(text)

    # print file info
    print(f"Created {filename} ({encoding} encoding) with {os.path.getsize(filename)} bytes")
