#3 script for define most likely n causal
variants <- c("locus_1","locus_2",...) # a list of all locus name used as ${locus}
dat<-read.table("path/to/output_2",header=T,sep="\t")
RES<-NULL
for(variant in variants){
tmp<-dat[dat$Variant==variant,]
if(nrow(tmp)>0){
ncausal<-tmp[which.max(tmp$PostProb),]$N_Causal
ncausalpost<-max(tmp$PostProb)
out<-c(variant,ncausal,ncausalpost)
RES<-rbind(RES,out)
}
}
colnames(RES)<-c("Variant","Mostly_N_Causal","PostProb")
write.table(RES,"path/to/output_3",quote=F,row=F,sep="\t")

#4 script to output config variants at most likely n causal
dat<-read.table("path/to/output_3",header=T)
RES<-NULL
for(i in c(1:nrow(dat))){
variant<-as.character(dat$Variant)[i]
ncausal<-dat$Mostly_N_Causal[i]
cred<-read.table(paste0("path/to/FINEMAP.cred",ncausal),header=T)
cred<-cred[1,]
takeout<-paste0("cred",1:ncausal)
credset<-cred[takeout]
for(j in 1:ncol(credset)){
out<-c(variant,j,as.character(credset[1,j]))
RES<-rbind(RES,out)
}
}
colnames(RES)<-c("LeadVariant","Mostly_N_Causal","CredVariant")
write.table(RES,"path/to/output_4",quote=F,row=F,sep="\t")