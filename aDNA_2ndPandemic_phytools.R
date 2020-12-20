require(phytools);
library(evobiR);
library(RColorBrewer)

pdf('tree.v2.test-wyr.pdf',width=10,height=15)
cc = colorRampPalette(rev(brewer.pal(n = 10,
     name = "RdYlBu")))


tree=read.tree("RAxML_bipartitions.47S.final.raxml.reroot.newic.tree");
plot(tree,no.margin=TRUE,edge.width=3,cex=1);
nodelabels(text=1:tree$Nnode,node=1:tree$Nnode+Ntip(tree));

data=read.table("47S.country.txt",header=T);


loc=data$loc;
loc=as.vector(loc);
names(loc)=data$id;
loc=ReorderData(tree,loc);
require(phytools);


plotTree(tree,type="phylogram",fsize=1,ftype="i");
cols=setNames(cc(12),sort(unique(loc)));
tiplabels(pie=to.matrix(loc,sort(unique(loc))),piecol=cols,cex=0.3);


mtrees=make.simmap(tree,loc,model="ARD",nsim=100,Q="mcmc");
mtrees;
plot(summary(mtrees),colors=cols,ftype="i")
pd=describe.simmap(mtrees,plot=TRUE);

write.table(pd$count,file="est3.2.countout.info")
write.table(pd$ace,file="test3.2.aceout.info");
plot(pd,fsize=1,ftype="i",colors=cols);
add.simmap.legend(colors=cols,prompt=FALSE,fsize=0.8,vertical=FALSE);

add.simmap.legend(colors=cols,prompt=TRUE,fsize=0.8);


mt<-phytools:::make.transparent;
changes<-sapply(mtrees,markChanges,sapply(cols,mt,0.4))
sink("changes.info");
print(changes);
sink();
