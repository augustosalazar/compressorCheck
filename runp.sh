#starting from root dir after the pull
# the first parameter is the directory name
# second parameters is group id
#!/bin/bash

declare -a fileList=("text1.txt" "text2.txt" "text3.txt" "text4.txt" "text5.txt")

for fileName in ${fileList[@]}; do
   cp -f $fileName $1
done

cd $1

a1=$1
a2=$2
outputFileName=g${a2}_${a1}.txt

rm -rf  ${outputFileName}
for fileName in ${fileList[@]}; do
    echo $fileName
    echo $fileName >>${outputFileName}

    sizeOriginal="$(wc -c <${fileName})"

    #primero ejecutamos el secuencial
    rm -f comprimido.ec2
    rm -f descomprimido-ec2.txt
    ct=$(python3 compresor.py ${fileName})
    dt=$(python3 descompresor.py comprimido.ec2)
    v=$(python3 verificador.py ${fileName} descomprimido-ec2.txt)
    sizeCompressed="$(wc -c <comprimido.ec2)"
    sizedDecompressed="$(wc -c <descomprimido-ec2.txt)"
    diffOriginal=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    rate=`expr $temp / $sizeOriginal`

    #continuamos con el paralelo con 3 procesos
    rm -f comprimidop.ec2
    rm -f descomprimidop-ec2.txt
    ctp3=$(mpirun -n 3 -oversubscribe --allow-run-as-root  python3 compresorp.py ${fileName})
    dtp3=$(mpirun -n 3 -oversubscribe --allow-run-as-root  python3 descompresorp.py comprimidop.ec2)
    vp=$(python3 verificador.py ${fileName} descomprimidop-ec2.txt)
    sizeCompressed="$(wc -c <comprimidop.ec2)"
    sizedDecompressed="$(wc -c <descomprimidop-ec2.txt)"
    diffOriginalp3=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    ratep3=`expr $temp / $sizeOriginal`

    #ahora con el paralelo con 10 procesos
    rm -f comprimidop.ec2
    rm -f descomprimidop-ec2.txt
    ctp10=$(mpirun -n 10 -oversubscribe --allow-run-as-root python3 compresorp.py ${fileName})
    dtp10=$(mpirun -n 10 -oversubscribe --allow-run-as-root  python3 descompresorp.py comprimidop.ec2)
    vp=$(python3 verificador.py ${fileName} descomprimidop-ec2.txt)
    sizeCompressed="$(wc -c <comprimidop.ec2)"
    sizedDecompressed="$(wc -c <descomprimidop-ec2.txt)"
    diffOriginalp10=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    ratep10=`expr $temp / $sizeOriginal`

    #finalizamos verificando la compatibilidad entre versiones secuenciales y paralelas (con 4 procesos)
    rm -f comprimidop.ec2
    rm -f descomprimidop-ec2.txt
    ctp_sanity=$(mpirun -n 4 -oversubscribe --allow-run-as-root  python3 compresorp.py ${fileName})
    dt_sanity=$(python3 descompresor.py comprimidop.ec2)
    dtp_sanity=$(mpirun -n 4 -oversubscribe --allow-run-as-root  python3 descompresorp.py comprimido.ec2)
    vp_sanity=$(python3 verificador.py descomprimido-ec2.txt descomprimidop-ec2.txt)
    sizedDecompressed="$(wc -c <descomprimidop-ec2.txt)"
    diffOriginal_sanity=`expr $sizeOriginal - $sizedDecompressed`
    echo "sanity check ${vp_sanity} ${diffOriginal_sanity}" >> ${outputFileName}


    rm -f comprimido.ec2
    rm -f descomprimido-ec2.txt
    rm -f comprimidop.ec2
    rm -f descomprimidop-ec2.txt

    echo "ct ${ct} ctp3 ${ctp3} ctp10 ${ctp10} rate ${rate} ratep3 ${ratep10} ratep3 ${ratep10} diff ${diffOriginal}" diffp3 ${diffOriginalp3}" diffp10 ${diffOriginalp10}">> ${outputFileName}

    rm -f $fileName
done

rm -f comprimido.ec2
rm -f descomprimido-ec2.txt
rm -f comprimidop.ec2
rm -f descomprimidop-ec2.txt
cp -f ${outputFileName} ../
rm -rf ${outputFileName}
cd ..