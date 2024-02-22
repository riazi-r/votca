start=`date +%s`

pairs=`pwd`

for i in pairs
#1-1 4-4 1-3 1-4 3-3 
do
  destination=$pairs
  #first=$(awk '/ATOM/{print NR}' $source1/step3_input.pdb)
  first=$(awk '/ATOM/ { print NR; exit}' $destination/step3_input_no_ter.pdb)
  last=$(awk '$0~"ATOM"{n=NR}END{print n}' $destination/step3_input_no_ter.pdb)
  i=1
  #j=1
  echo > tmp.pdb
  
  #awk -v a="$first" -v id="$i" 'NR==a {$10=id ; print ; next} ' $destination/step3_input_no_ter.pdb >> tmp.pdb  #disrupts original formatting ,culmns,etc.
  #awk -v a="$first" -v id="$i" 'NR==a { for(j = 1; j <= NF; j++) { if ( j == 10 )print id;else print $j } }' $destination/step3_input_no_ter.pdb #mess with formatting too
  line=$(awk -v "a=$first" 'NR==a {print $0}' ./step3_input_no_ter.pdb)
  sed -e "s/\<\w\+/\t $i/17" <<< "$line" >> tmp.pdb
  #sed -e "'$first'i s/\<\w\+/\t $i/17" $destination/step3_input_no_ter.pdb >> tmp.pdb
  
  ((first++))
  
  for (( line=$first; line<=$last; line+=1 ))
  do
   
   resid=$(awk -v "a=$line" 'NR==a {print $5}' $destination/step3_input_no_ter.pdb)
   previous_line=$(($line-1))
   previous_resid=$(awk -v "a=$previous_line" 'NR==a {print $5}' $destination/step3_input_no_ter.pdb)
   if [[ "$resid" != "$previous_resid" ]]
   then
    ((i++))
   fi
   #resname=$(awk -v "a=$line" 'NR==a {print $4}' $source1/step3_input.pdb)
   #atom=$(awk -v "a=$line" 'NR==a {print $3}' $source1/step3_input.pdb)
   #awk '{ $0 = "'$resid'':''$resname'':''$atom' " } {print}' bead.txt > temp.txt && mv temp.txt bead.txt
   #echo -n "$resid:$resname:$atom " >> bead.txt
   #awk -v a="$line" -v id="$i" 'NR==a {$10=id ; print; next }' $destination/step3_input_no_ter.pdb >> tmp.pdb #disrupts original formatting ,culmns,etc.
	str=$(awk -v "a=$line" 'NR==a {print $0}' ./step3_input_no_ter.pdb)
    sed -e "s/\<\w\+/\t $i/17" <<< "$str" >> tmp.pdb
  done
	 
#sed -e "s/.\{160\}/&\n/g" < bead.xml

done

end=`date +%s`
echo Execution time was `expr $end - $start` seconds.

awk -v r="$replace" '{ for(i = 1; i <= NF; i++) { if ( i == 4 )print r;else print $i } }'