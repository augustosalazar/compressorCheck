from mpi4py import MPI
import sys

comm = MPI.COMM_WORLD
size = comm.Get_size()
rank = comm.Get_rank()

if rank == 0:
    for i in range(size):
	    comm.send(i, dest=i)

data = comm.recv(source=0)
#print (rank , " received "  , data)
data = data * data
comm.send(data, dest=0)

if rank == 0:
    for i in range(size):
        x = comm.recv(source=MPI.ANY_SOURCE)
        print(x)
