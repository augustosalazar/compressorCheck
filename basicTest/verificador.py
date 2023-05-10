import sys

def compare_files(file1_path, file2_path):
    """Compares the contents of the two files."""
    with open(file1_path, 'rb') as file1, open(file2_path, 'rb') as file2:
        while True:
            chunk1 = file1.read(1024)
            chunk2 = file2.read(1024)
            if chunk1 != chunk2:
                return False
            if not chunk1:
                return True

if __name__ == '__main__':
    file1_path = sys.argv[1]
    file2_path = sys.argv[2]
    if compare_files(file1_path, file2_path):
        print('ok')
    else:
        print('nok')