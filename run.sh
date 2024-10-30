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
    rm -f comprimido.ec2
    rm -f descomprimido-ec2.txt
    python3 compresor.py ${fileName} >>  ${outputFileName}
    python3 descompresor.py comprimido.ec2 >>  ${outputFileName}
    python3 verificador.py ${fileName} descomprimido-ec2.txt >>  ${outputFileName}
    sizeBiblia="$(wc -c <${fileName})"
    sizeCompressed="$(wc -c <comprimido.ec2)"
    sizedDecompressed="$(wc -c <descomprimido-ec2.txt)"
    echo "Original size ${sizeBiblia} compressed ${sizeCompressed} decompressed ${sizedDecompressed}" >>  ${outputFileName}
    diffOriginal=`expr $sizeBiblia - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    rate=`expr $temp / $sizeBiblia`
    echo "compression rate ${rate}%" >>  ${outputFileName}
    echo "Sized diff between original and decompressed ${diffOriginal}"  >>  ${outputFileName}
    rm -f $fileName
done

rm -f comprimido.ec2
rm -f descomprimido-ec2.txt
cp -f  ${outputFileName} ../
rm -rf  ${outputFileName}
cd ..