First pull the repository of the student

To run the secuential test:

bash run.sh <directory name of the repository of the student> <groupid>

For example, in case that group # 2 has a repository called LZW_Compressor:

bash run.sh LZW_Compressor 2

To run the paralel test:

bash runp.sh <directory name of the repository of the student> <groupid>

For example, in case that group # 2 has a repository called LZW_Compressor:

bash runp.sh LZW_Compressor 2   

To execute using docker:   
docker run --rm -it --name mpicont -v "$(pwd)":/app --workdir=/app augustosalazar/un_mpi_image:v4 bash runp.sh basicTest 0   

To run a simple MPI file from docker   
docker run --rm -it --name mpicont -v "$(pwd)":/app --workdir=/app augustosalazar/un_mpi_image:v4 mpirun -n 3 -oversubscribe --allow-run-as-root python3 mpi_test.py

To install MPI:   
sudo apt-get update -y   
sudo apt-get install -y libopenmpi-dev python3-dev python3-pip   
python3 -m pip install mpi4py


rm -f comprimido.ec2
rm -f comprimidop.ec2
rm -f descomprimido-ec2.txt
rm -f descomprimidop-ec2.txt

Simple verify 202430    
python3 compresor.py text1.txt   
python3 descompresor.py comprimido.ec2   
python3 verificador.py text1.txt descomprimido-ec2.txt   
docker run --rm -it --name mpicont -v "$(pwd)":/app --workdir=/app augustosalazar/un_mpi_image:v4 mpirun -n 3 -oversubscribe --allow-run-as-root python3 /app/descompresorp.py /app/comprimido.ec2   
python3 verificador.py text1.txt descomprimidop-ec2.txt
