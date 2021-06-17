#1 script for collect number of n causal snps (estimated)
OUTPUTFILE="path/to/this_output"
echo -e "Variant\tN_Causal" > ${OUTPUTFILE}

for locus in all_locus
do
NCAUSAL=`cat ${logfile_in_this_locus} | grep "Post-expected # of causal SNPs" | awk '{print $8}'`
echo -e "${locus}\t${NCAUSAL}" >> ${OUTPUTFILE}
done

#2 Pre and Post-Pr(# of causal SNPs is k)
OUTPUTFILE="path/to/this_output"
for locus in all_locus
do
for i in `seq 1 5` # because max causal n was set to 5
do
Pre=`cat ${logfile_in_this_locus} | grep "${i} -> " | awk '{print $3}' | head -n1`
Post=`cat ${logfile_in_this_locus} | grep "${i} -> " | awk '{print $3}' | tail -n1`
echo -e "${locus}\t${i}\t${Pre}\t${Post}" >> ${OUTPUTFILE}
done
done
