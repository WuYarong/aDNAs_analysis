library("ggsignif")
library("ggplot2")

pdf('70S_pla-depth_pPCP-depth.pdf',width=10,height=6)
x<-read.table("pla_depth.2ndpandemic.xls",header=T)
test<-data.frame(ratio=as.numeric(x$ratio),clade=x$clade, stringsAsFactors = FALSE)
compaired <- list(c("01.black_death", "02.Alpine_clade"),c("01.black_death","03.central_Asia_clade"),c("02.Alpine_clade","03.central_Asia_clade"))
ggplot(test,aes(clade,ratio,fill=clade))+
	geom_boxplot(width=0.5)+
	theme(plot.title=element_text(size = 15),axis.text.x=element_text(size=10,angle=0),axis.text.y=element_text(size=10),axis.title.x=element_text(size = 15),axis.title.y=element_text(size = 15))+
	labs(x='clade', y= 'pla_depth/pPCP_depth(%)')+
	geom_signif(comparisons = compaired,step_increase = 0.1,map_signif_level = F,test = wilcox.test)

dev.off()
