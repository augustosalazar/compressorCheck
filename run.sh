#starting from root dir after the pull
# the first parameter is the directory name
# second parameters is group id
#!/bin/bash

declare -a fileList=("text1.txt" "text2.txt" "text3.txt" "text4.txt" "text5.txt")

for fileName in ${fileList[@]}; do
   cp -f $fileName $1
done

a1=$1
a2=$2
outputFileName=g${a2}_${a1}.txt

cd $1
rm -rf  ${outputFileName}
for fileName in ${fileList[@]}; do
    echo $fileName
    echo $fileName >> ${outputFileName}
    rm -f comprimido.elmejorprofesor
    rm -f descomprimido-elmejorprofesor.txt
    python3 compresor.py ${fileName} >>  ${outputFileName}
    python3 descompresor.py comprimido.elmejorprofesor >>  ${outputFileName}
    python3 verificador.py ${fileName} descomprimido-elmejorprofesor.txt >>  ${outputFileName}
    sizeBiblia="$(wc -c <${fileName})"
    sizeCompressed="$(wc -c <comprimido.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimido-elmejorprofesor.txt)"
    echo "Original size ${sizeBiblia} compressed ${sizeCompressed} decompressed ${sizedDecompressed}" >>  ${outputFileName}
    diffOriginal=`expr $sizeBiblia - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    rate=`expr $temp / $sizeBiblia`
    echo "compression rate ${rate}%" >>  ${outputFileName}
    echo "Sized diff between original and decompressed ${diffOriginal}"  >>  ${outputFileName}
    rm -f $fileName
done

rm -f comprimido.elmejorprofesor
rm -f descomprimido-elmejorprofesor.txt
cp -f  ${outputFileName} ../
rm -rf  ${outputFileName}
cd ..