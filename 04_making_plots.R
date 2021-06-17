# script for making plots

# histogram of estimated # causal variants
dat<-read.table("path/to/output_1",header = T,sep="\t")
hist(dat$N_Causal,breaks=100,xlab = "# estimaed causal variants",main="")

# Posterior Probs distribution boxplots
# Pre Probs
dat<-read.table("path/to/output_2",header = T,sep="\t")
dat$N_Causal<-as.factor(dat$N_Causal)

p <- ggplot(dat, aes(x=N_Causal, y=PostProb, fill = N_Causal)) + 
  geom_boxplot() + 
  geom_jitter(shape=16, position=position_jitter(0.2))
print(p)

# annotation pie chart
library(dplyr)
dat<-read.table("path/to/${ANNOVAR_OUTPUT}.hg19_multianno.txt",sep="\t",header=T)
summary <- dat %>% group_by(Func.refGene) %>% summarise(m=n())

pie <- ggplot(summary, aes(x="", y=m, fill=Func.refGene))+
  geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0) +
  scale_fill_brewer(palette="Set2")
print(pie)
