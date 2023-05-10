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

    sizeOriginal="$(wc -c <${fileName})"

    #primero ejecutamos el secuencial
    rm -f comprimido.elmejorprofesor
    rm -f descomprimido-elmejorprofesor.txt
    ct=$(python3 compresor.py ${fileName})
    dt=$(python3 descompresor.py comprimido.elmejorprofesor)
    v=$(python3 verificador.py ${fileName} descomprimido-elmejorprofesor.txt)
    sizeCompressed="$(wc -c <comprimido.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimido-elmejorprofesor.txt)"
    diffOriginal=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    rate=`expr $temp / $sizeOriginal`

    #continuamos con el paralelo con 3 procesos
    rm -f comprimidop.elmejorprofesor
    rm -f descomprimidop-elmejorprofesor.txt
    ctp3=$(mpirun -n 3 -oversubscribe --allow-run-as-root  python3 compresorp.py ${fileName})
    dtp3=$(mpirun -n 3 -oversubscribe --allow-run-as-root  python3 descompresorp.py comprimidop.elmejorprofesor)
    vp=$(python3 verificador.py ${fileName} descomprimidop-elmejorprofesor.txt)
    sizeCompressed="$(wc -c <comprimidop.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimidop-elmejorprofesor.txt)"
    diffOriginalp3=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    ratep3=`expr $temp / $sizeOriginal`

    #ahora con el paralelo con 10 procesos
    rm -f comprimidop.elmejorprofesor
    rm -f descomprimidop-elmejorprofesor.txt
    ctp10=$(mpirun -n 10 -oversubscribe --allow-run-as-root python3 compresorp.py ${fileName})
    dtp10=$(mpirun -n 10 -oversubscribe --allow-run-as-root  python3 descompresorp.py comprimidop.elmejorprofesor)
    vp=$(python3 verificador.py ${fileName} descomprimidop-elmejorprofesor.txt)
    sizeCompressed="$(wc -c <comprimidop.elmejorprofesor)"
    sizedDecompressed="$(wc -c <descomprimidop-elmejorprofesor.txt)"
    diffOriginalp10=`expr $sizeOriginal - $sizedDecompressed`
    temp=`expr $sizeCompressed  \* 100`
    ratep10=`expr $temp / $sizeOriginal`

    #finalizamos verificando la compatibilidad entre versiones secuenciales y paralelas (con 4 procesos)
    rm -f comprimidop.elmejorprofesor
    rm -f descomprimidop-elmejorprofesor.txt
    ctp_sanity=$(mpirun -n 4 -oversubscribe --allow-run-as-root  python3 compresorp.py ${fileName})
    dt_sanity=$(python3 descompresor.py comprimidop.elmejorprofesor)
    dtp_sanity=$(mpirun -n 4 -oversubscribe --allow-run-as-root  python3 descompresorp.py comprimido.elmejorprofesor)
    vp_sanity=$(python3 verificador.py descomprimido-elmejorprofesor.txt descomprimidop-elmejorprofesor.txt)
    sizedDecompressed="$(wc -c <descomprimidop-elmejorprofesor.txt)"
    diffOriginal_sanity=`expr $sizeOriginal - $sizedDecompressed`
    echo "sanity check ${vp_sanity} ${diffOriginal_sanity}" >> g$2.txt


    rm -f comprimido.elmejorprofesor
    rm -f descomprimido-elmejorprofesor.txt
    rm -f comprimidop.elmejorprofesor
    rm -f descomprimidop-elmejorprofesor.txt

    echo "ct ${ct} ctp3 ${ctp3} ctp10 ${ctp10} rate ${rate} ratep3 ${ratep10} ratep3 ${ratep10} diff ${diffOriginal}" diffp3 ${diffOriginalp3}" diffp10 ${diffOriginalp10}">> g$2.txt

    rm -f $fileName
done

cp -f g$2.txt ../
cd ..