import sys
import time
from mpi4py import MPI
comm = MPI.COMM_WORLD   
rank = comm.Get_rank() 

def decompress(input_path, output_path):
    try:
        with open(input_path, 'rb') as source:
            with open(output_path, 'wb') as destination:
                destination.write(source.read())
    except FileNotFoundError:
        print("One or both files not found.")

start_time = time.time()
input_file_path = sys.argv[1]
output_file_path = 'descomprimidop-ec2.txt'
decompress(input_file_path, output_file_path)
end_time = time.time()
elapsed_time = end_time - start_time
if (rank == 0):
    print(elapsed_time)