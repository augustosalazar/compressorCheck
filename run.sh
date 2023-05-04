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
    sizeBiblia="$(wc -c <${fileName})"
    sizeCompressed="$(wc -c <comprimido.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimido-elmejorprofesor.txt)"
    echo "Original size ${sizeBiblia} compressed ${sizeCompressed} decompressed ${sizedDecompressed}" >> g$2.txt
    diffOriginal=`expr $sizeBiblia - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    rate=`expr $temp / $sizeBiblia`
    echo "compression rate ${rate}%" >> g$2.txt
    echo "Sized diff between original and decompressed ${diffOriginal}"  >> g$2.txt
    rm -f $fileName
done

cp -f g$2.txt ../
cd ..