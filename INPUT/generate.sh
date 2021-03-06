#!/bin/bash

LC_NUMERIC=C
start_path=$PWD

echo "Tworze strukture katalogow..."
mkdir data

Temp=1400.0
#stech=1.0
cv=0.0092


x=25
y=25
z=25
unit_cell=2

edytuj()
{
#    myfile="u"$1"u"$2
    #utworz katalog symulacji
#    mkdir $myfile
    #skopij zawartosc katalogu tamplate do kat. symulacji
#    cp ../template/* ./$myfile
    #wejdz do katalogu symulacji
#    cd $myfile
    #edytuj plik chem.in
    sed -e 's/potencjaly/'$chem1' '$chem2'/' chem.in > temp.in
    cat temp.in > chem.in
    rm temp.in
    #edytuj plik conf.in


    sed -i 's/VAC/'$4'/' conf.in
    if [ "$3" -gt 0 ]; then
	sed -i 's/ATOMS/'$3' 2 1/' conf.in
    elif [ "$3" -lt 0 ]; then
	A=` awk -v st=$3 'BEGIN{printf "%d", -st}'`
	sed -i 's/ATOMS/'$A' 1 2/' conf.in
    elif [ "$3" -eq 0 ]; then
	sed -i 's/ATOMS/'$3' 1 1/' conf.in
    fi
    sed -e 's/TEMPERATURA/'$1'/' conf.in > temp.in
    cat temp.in > conf.in
    rm temp.in
    sed -e 's/STECH/'$2'/' conf.in > temp.in
    cat temp.in > conf.in
    rm temp.in

    #edytuj plik uruchomieniowy
    sed 's/^#SBATCH -J name/#SBATCH -J T'$1'S'$2'/' run_sim > tmp
    cat tmp > run_sim
    
    rm tmp
    #wroc do katalogu uruchomieniowego
    cd ..

}



SIZE=` echo "$x * $y * $z * $unit_cell" | bc`
echo "Rozmiar ukladu: " $SIZE

while read u1 s1 u2 s2 stech x x x; do
    
    chem1=$u1
    chem2=$u2
#    Temp=${Temp%.*}
    stech=`awk -v st=$stech 'BEGIN{st=st*100;st=int(st+.5);st=st/100; printf "%1.3f", st}'`
    VAC=` echo "$SIZE * $cv " | bc`
    VAC=` awk -v st=$VAC 'BEGIN{st=st*1;st=int(st+.5);st=st/1; printf "%d", st}'`
    VA=`echo "$VAC / 2" | bc`
    SIZEA=`echo "$SIZE / 2" | bc`
    ATOMSA=`echo "$SIZEA - $VA" |bc`

    ATOMS=`echo "$SIZE - $VAC" |bc`
    A=`echo "$ATOMS * $stech" | bc`
    B=`echo "$ATOMS * (1.0 - $stech) " | bc`
    A=` awk -v st=$A 'BEGIN{st=st*1;st=int(st+.5);st=st/1; printf "%.0f", st}'`
    B=` awk -v st=$B 'BEGIN{st=st*1;st=int(st+.5);st=st/1; printf "%.0f", st}'`

    
    DEL_A=` echo "$A - $ATOMSA" | bc`
    DEL_A=` awk -v st=$DEL_A 'BEGIN{st=st*1; (st>=0)? st=int(st+.5) : st=int(st-.5);st=st/1; printf "%.0f", st}'`
    DEL_B=` echo "$B - $ATOMSA" | bc`
    DEL_B=` awk -v st=$DEL_B 'BEGIN{st=st*1; (st>=0)? st=int(st+.5) : st=int(st-.5);st=st/1; printf "%.0f", st}'`

    CZ_A=` echo "$ATOMSA + $DEL_A" | bc`
    CZ_B=` echo "$ATOMSA - $DEL_A" | bc`

    ILORAZ=`echo "$CZ_A / ( $CZ_A + $CZ_B )" | bc -l`
    SUM=`echo "$CZ_A + $CZ_B + $VA +$VA" | bc `
    ILORAZ=` awk -v st=$ILORAZ 'BEGIN{st=st*100;st=int(st+.5);st=st/100; printf "%1.3f", st}'`

    
    echo $stech $SIZE $VAC $ATOMS $A $B "<|>" $SIZEA $VA $ATOMSA  "|=>" $DEL_A $DEL_B "||" $CZ_A $CZ_B $VA $VA $SUM $ILORAZ

    sim_dir=$start_path/data/S$stech
    script_path=$start_path/scripts
    template_path=$start_path/template

    if ! [ -d $sim_dir ]; then mkdir $sim_dir; fi;
    cp $template_path/* $sim_dir
#    cp $start_path/S$stech/*.xyz $sim_dir/start.in

    cd $sim_dir
    edytuj $Temp $stech $DEL_A $VA
    cd ..
done < *.input

#uruchom symulacje
#cd $start_path
#./run T$Tem
