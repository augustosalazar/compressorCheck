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
    ct=$(python3 compresor.py ${fileName})
    dt=$(python3 descompresor.py)
    v=$(python3 verificador.py ${fileName})
    sizeOriginal="$(wc -c <${fileName})"
    sizeCompressed="$(wc -c <comprimido.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimido-elmejorprofesor.txt)"
    diffOriginal=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    rate=`expr $temp / $sizeOriginal`
    
    rm -f comprimido.elmejorprofesor
    rm -f descomprimido-elmejorprofesor.txt
    ctp3=$(mpirun -n 3 --allow-run-as-root –-oversubscribe python3 compresorp.py ${fileName})
    dtp3=$(mpirun -n 3 --allow-run-as-root –-oversubscribe python3 descompresorp.py)
    vp=$(python3 verificador.py ${fileName})
    sizeOriginal="$(wc -c <${fileName})"
    sizeCompressed="$(wc -c <comprimido.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimido-elmejorprofesor.txt)"
    diffOriginalp3=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    ratep3=`expr $temp / $sizeOriginal`

    rm -f comprimido.elmejorprofesor
    rm -f descomprimido-elmejorprofesor.txt
    ctp10=$(mpirun -n 10 --allow-run-as-root –-oversubscribe python3 compresorp.py ${fileName})
    dtp10=$(mpirun -n 10 --allow-run-as-root –-oversubscribe python3 descompresorp.py)
    vp=$(python3 verificador.py ${fileName})
    sizeOriginal="$(wc -c <${fileName})"
    sizeCompressed="$(wc -c <comprimido.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimido-elmejorprofesor.txt)"
    diffOriginalp10=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    ratep10=`expr $temp / $sizeOriginal`
    
    echo "ct ${ct} ctp3 ${ctp3} ctp10 ${ctp10} rate ${rate} ratep3 ${ratep10} ratep3 ${ratep10} diff ${diffOriginal}" diffp3 ${diffOriginalp3}" diffp10 ${diffOriginalp10}">> g$2.txt

    rm -f $fileName
done

cp -f g$2.txt ../
cd ..