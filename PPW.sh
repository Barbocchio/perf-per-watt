#!/bin/bash
echo 0 > /sys/class/backlight/intel_backlight/brightness
file="/etc/tlp.conf"

cd ~/PPW

sleep 1

rm timelog5.csv
rm timelog10.csv
rm timelog15.csv
rm timelog20.csv
rm timelog25.csv
rm timelog30.csv
rm timelog35.csv
rm timelog40.csv
rm timelog45.csv
rm timelog50.csv
rm timelog55.csv
rm timelog60.csv
rm timelog65.csv
rm timelog70.csv
rm timelog75.csv
rm timelog80.csv
rm timelog85.csv
rm timelog90.csv
rm timelog95.csv
rm timelog100.csv
rm points.csv

for percentage in {5..100..5}
do
    riga=$(grep -n "CPU_MAX_PERF_ON_AC=" ${file} | cut -d ':' -f 1)
    nuova_riga="CPU_MAX_PERF_ON_AC=${percentage}"
    sed -i "${riga}s/.*/${nuova_riga}/" ${file}

    riga=$(grep -n "CPU_MAX_PERF_ON_BAT=" ${file} | cut -d ':' -f 1)
    nuova_riga="CPU_MAX_PERF_ON_BAT=${percentage}"
    sed -i "${riga}s/.*/${nuova_riga}/" ${file}

    riga=$(grep -n "CPU_MIN_PERF_ON_AC=" ${file} | cut -d ':' -f 1)
    nuova_riga="CPU_MIN_PERF_ON_AC=${percentage}"
    sed -i "${riga}s/.*/${nuova_riga}/" ${file}

    riga=$(grep -n "CPU_MIN_PERF_ON_BAT=" ${file} | cut -d ':' -f 1)
    nuova_riga="CPU_MIN_PERF_ON_BAT=${percentage}"
    sed -i "${riga}s/.*/${nuova_riga}/" ${file}

    sudo tlp ac
    VAR1="timelog"
    VAR2=$((percentage))
    VAR3=".csv"

    file_mat="$VAR1$VAR2$VAR3"
    sleep 2

    sysbench --threads=64 --time=11 cpu run | grep "events per second" >> "points.csv" &
    sleep 1

    for VARIABLE in {1..10..1}
    do
        VAR1=$( echo $(( $(cat /sys/class/power_supply/BAT0/current_now)* $(cat /sys/class/power_supply/BAT0/voltage_now) / 1000000 )) )
        POW=$((VAR1 + POW))
        POWW=$(echo "scale=3 ; $VAR1/1000000" | bc)
        echo $POWW >> $file_mat
        sleep 1
    done
    sleep 1

done

echo 48000 > /sys/class/backlight/intel_backlight/brightness

echo "scale=3 ; $POW / (1000000 * 100)" | bc
riga=$(grep -n "CPU_MAX_PERF_ON_AC=" ${file} | cut -d ':' -f 1)
nuova_riga="CPU_MAX_PERF_ON_AC=100"
sed -i "${riga}s/.*/${nuova_riga}/" ${file}


riga=$(grep -n "CPU_MAX_PERF_ON_BAT=" ${file} | cut -d ':' -f 1)
nuova_riga="CPU_MAX_PERF_ON_BAT=50"
sed -i "${riga}s/.*/${nuova_riga}/" ${file}


riga=$(grep -n "CPU_MIN_PERF_ON_AC=" ${file} | cut -d ':' -f 1)
nuova_riga="CPU_MIN_PERF_ON_AC=0"
sed -i "${riga}s/.*/${nuova_riga}/" ${file}


riga=$(grep -n "CPU_MIN_PERF_ON_BAT=" ${file} | cut -d ':' -f 1)
nuova_riga="CPU_MIN_PERF_ON_BAT=0"
sed -i "${riga}s/.*/${nuova_riga}/" ${file}

sudo tlp start
