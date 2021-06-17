#5 script for running annovar
OUTPUT="path/to/output_5"
echo "##fileformat=VCFv4.2" > ${OUTPUT}.vcf
echo -e "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tNA00001" >> ${OUTPUT}.vcf

# assuming that "path/to/output_4" has a format of ${CHR}:${POS}:${REF}:${ALT}
cat "path/to/output_4" | awk -F[:] '{printf("%d\t%d\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",$1,$2,$0,$3,$4,".",".",".","GT","0/1")}' | sort -k1,1n -k2,2n >> ${OUTPUT}.vcf

/path/to/annovar/convert2annovar.pl -format vcf4 -allsample -withfreq ${OUTPUT}.vcf --outfile result/ann/${OUTPUT}.avinput

/path/to/annovar/table_annovar.pl result/ann/${OUTPUT}.avinput /path/to/annovar/humandb/ -buildver hg19 --out ${ANNOVAR_OUTPUT} --protocol avsnp150,refGene,ccdsGene,dbnsfp30a --nastring . --operation f,g,g,f
