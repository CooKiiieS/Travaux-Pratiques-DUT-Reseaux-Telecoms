#!/bin/bash



a=`sudo traceroute -nI google.fr | cut -d" " -f4 | sed "1d" | grep '*' -v`


declare -a t=()

b=0

for w in $a
do


t[$b]=$w

((b+=1))
done

((b-=1))

for x in `seq 0 0`
do
echo ${t[x+1]}
done


