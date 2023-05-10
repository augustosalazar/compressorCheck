First pull the repository of the student

To run the secuential test:

bash run.sh <directory name of the repository of the student> <groupid>

For example, in case that group # 2 has a repository called LZW_Compressor:

bash run.sh LZW_Compressor 2

To run the paralel test:

bash runp.sh <directory name of the repository of the student> <groupid>

For example, in case that group # 2 has a repository called LZW_Compressor:

bash runp.sh LZW_Compressor 2


To install MPI:
sudo apt-get update -y
sudo apt-get install -y libopenmpi-dev python3-dev python3-pip
python3 -m pip install mpi4py