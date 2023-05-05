#starting from root dir after the pull
# the first parameter is the directory name
# second parameters is group id
#!/bin/bash

declare -a fileList=("text1.txt" "text2.txt" "text3.txt" "text4.txt" "text5.txt")

for fileName in ${fileList[@]}; do
   cp -f $fileName $1
done

cd $1
rm -rf  g$2.txt
for fileName in ${fileList[@]}; do
    echo $fileName
    echo $fileName >> g$2.txt
    rm -f comprimido.elmejorprofesor
    rm -f descomprimido-elmejorprofesor.txt
    python3 compresor.py ${fileName} >> g$2.txt
    python3 descompresor.py  >> g$2.txt
    python3 verificador.py ${fileName} >> g$2.txt
    sizeOriginal="$(wc -c <${fileName})"
    sizeCompressed="$(wc -c <comprimido.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimido-elmejorprofesor.txt)"
    diffOriginal=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    rate=`expr $temp / $sizeOriginal`
    echo "Original size ${sizeOriginal} compressed ${sizeCompressed} decompressed ${sizedDecompressed}  rate ${rate}% diff ${diffOriginal}" >> g$2.txt

    rm -f comprimido.elmejorprofesor
    rm -f descomprimido-elmejorprofesor.txt
    mpirun -n 3 --allow-run-as-root –-oversubscribe python3 compresorp.py ${fileName} >> g$2.txt
    mpirun -n 3 --allow-run-as-root –-oversubscribe python3 descompresorp.py  >> g$2.txt
    python3 verificador.py ${fileName} >> g$2.txt
    sizeOriginal="$(wc -c <${fileName})"
    sizeCompressed="$(wc -c <comprimido.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimido-elmejorprofesor.txt)"
    diffOriginal=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    rate=`expr $temp / $sizeOriginal`
    echo "Original size ${sizeOriginal} compressed ${sizeCompressed} decompressed ${sizedDecompressed}  rate ${rate}% diff ${diffOriginal}" >> g$2.txt

    rm -f comprimido.elmejorprofesor
    rm -f descomprimido-elmejorprofesor.txt
    mpirun -n 5 --allow-run-as-root –-oversubscribe python3 compresorp.py ${fileName} >> g$2.txt
    mpirun -n 5 --allow-run-as-root –-oversubscribe python3 descompresorp.py  >> g$2.txt
    python3 verificador.py ${fileName} >> g$2.txt
    sizeOriginal="$(wc -c <${fileName})"
    sizeCompressed="$(wc -c <comprimido.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimido-elmejorprofesor.txt)"
    diffOriginal=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    rate=`expr $temp / $sizeOriginal`
    echo "Original size ${sizeOriginal} compressed ${sizeCompressed} decompressed ${sizedDecompressed}  rate ${rate}% diff ${diffOriginal}" >> g$2.txt

    rm -f comprimido.elmejorprofesor
    rm -f descomprimido-elmejorprofesor.txt
    mpirun -n 10 --allow-run-as-root –-oversubscribe python3 compresorp.py ${fileName} >> g$2.txt
    mpirun -n 10 --allow-run-as-root –-oversubscribe python3 descompresorp.py  >> g$2.txt
    python3 verificador.py ${fileName} >> g$2.txt
    sizeOriginal="$(wc -c <${fileName})"
    sizeCompressed="$(wc -c <comprimido.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimido-elmejorprofesor.txt)"
    diffOriginal=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    rate=`expr $temp / $sizeOriginal`
    echo "Original size ${sizeOriginal} compressed ${sizeCompressed} decompressed ${sizedDecompressed}  rate ${rate}% diff ${diffOriginal}" >> g$2.txt


    rm -f $fileName
done

cp -f g$2.txt ../
cd ..