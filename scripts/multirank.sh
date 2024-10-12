#!/bin/bash

(
echo 'import matplotlib'
echo 'import matplotlib.pyplot as plt'

#for k in rnk*.txt
#do
#echo -n "# $k :"
#grep ':'  $k | sed 's/.*://g' | sed 's/ (.*//g' | egrep '[a-zA-Z0-9]' | sort | uniq | wc -l
#
#done

for ag in yes no
do
for num in 1 2 4 8 
do
echo  "num=$num"
echo  "numt=$( ls rnk* | wc -l )"
echo  "title=f'How many times in the {num} best ? out of {numt}'"
echo 'plt.clf()'
echo  "labels = []"
echo  "numbers = []"
echo "# $num best"
for a in RandomSearch AX AXP Cobyla PCABO SMAC3 NgIohTuned NGDSRW PymooBIPOP CMA PSO SQOPSO DE DiscreteLenglerOnePlusOne DiscreteOnePlusOne OnePlusOne DSproba MetaModel LognormalDiscreteOnePlusOne 
do
echo -n "# $a is in the $num best in this number of problems:"
number=$( 
for k in rnk*.txt
do
if [ $ag="yes" ]; then
    grep ':' $k | sed 's/.*://g' | sed 's/ (.*//g' | egrep '[a-zA-Z0-9]' | egrep -v ' NgIohTuned | NGDSRW | AX | AXP | LognormalDiscreteOnePlusOne | PCABO | PSO | PymooBIPOP | CMA ' | head -n $num | grep "^ $a$"
else
    grep ':' $k | sed 's/.*://g' | sed 's/ (.*//g' | egrep '[a-zA-Z0-9]' | head -n $num | grep "^ $a$"
fi
done | wc -l )
echo $number
if [ $ag="yes" ]; then
echo "labels += [\" $a \" + '(' + str( $number ) + ')' ];numbers += [ $number + .2 ]" | egrep -v ' NgIohTuned | NGDSRW | AX | AXP | PCABO | PSO | PymooBIPOP | CMA | LognormalDiscreteOnePlusOne '
else
echo "labels += [\" $a \" + '(' + str( $number ) + ')' ];numbers += [ $number + .2 ]"
fi
done
echo "plt.pie(numbers, labels=labels)"
echo "plt.title(title)"
if [ $ag="yes" ]; then
echo "plt.savefig(f'agpie{num}.png')"
else
echo "plt.savefig(f'pie{num}.png')"
fi
done
done
) > plotpie.py

python plotpie.py
#sed -i 's/label.* AX .*//g' plotpie.py
#sed -i 's/label.* PSO .*//g' plotpie.py
#sed -i 's/label.* PymooBIPOP .*//g' plotpie.py
#sed -i 's/label.* CMA .*//g' plotpie.py
#sed -i 's/pie{num}/agpie{num}/g' plotpie.py
#
#python plotpie.py