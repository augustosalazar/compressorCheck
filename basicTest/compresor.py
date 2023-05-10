import sys
import time

def compress(input_path, output_path):
    try:
        with open(input_path, 'rb') as source:
            with open(output_path, 'wb') as destination:
                destination.write(source.read())
    except FileNotFoundError:
        print("One or both files not found.")

start_time = time.time()
input_file_path = sys.argv[1]
output_file_path = 'comprimido.elmejorprofesor'
compress(input_file_path, output_file_path)
end_time = time.time()
elapsed_time = end_time - start_time
print(elapsed_time)