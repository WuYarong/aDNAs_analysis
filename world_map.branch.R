library(ggplot2)
library(RColorBrewer)

library(sp)

library(maptools)
library(maps)
library(scatterpie)


pdf("wordld_map.aDNA.3clade.pdf", width=10, height=3.5)
mydata<-read.table("map.3clade.xls",header=TRUE)
mydata<-mydata[which(mydata[,4]>0),]
visit.x<-mydata$long
visit.y<-mydata$lat
mp<-NULL
mapworld<-borders("world",colour = "gray50",fill="white",lwd=0.1) #绘制基本地图
mp<-ggplot()+mapworld+ylim(-60,90)

mp+
geom_point(data=mydata,aes(x=long,y=lat,colour="red"),size=0.2)+
scale_fill_brewer(palette="Blues") +
scale_size_area(max_size=8)+
theme(
panel.grid=element_blank(),
panel.background=element_blank(),
axis.text=element_blank(),
axis.ticks=element_blank(),
axis.title=element_blank(),
legend.position='right'
) + 
geom_scatterpie_legend(4, x=90, y=-20) 


mydata<-read.table("map.3clade.xls",header=TRUE)
mydata<-mydata[which(mydata[,5]>0),]
visit.x<-mydata$long
visit.y<-mydata$lat
mp<-NULL
mapworld<-borders("world",colour = "gray50",fill="white",lwd=0.1)
mp<-ggplot()+mapworld+ylim(-60,90)


mp+
geom_point(data=mydata,aes(x=long,y=lat,colour="red"),size=0.2)+
scale_fill_brewer(palette="Blues") +
scale_size_area(max_size=8)+
theme(
panel.grid=element_blank(),
panel.background=element_blank(),
axis.text=element_blank(),
axis.ticks=element_blank(),
axis.title=element_blank(),
legend.position='right'
) + 
geom_scatterpie_legend(4, x=90, y=-20)



mydata<-read.table("map.3clade.xls",header=TRUE)
mydata<-mydata[which(mydata[,6]>0),]
visit.x<-mydata$long
visit.y<-mydata$lat
mp<-NULL
mapworld<-borders("world",colour = "gray50",fill="white",lwd=0.1)
mp<-ggplot()+mapworld+ylim(-60,90)

mp+
geom_point(data=mydata,aes(x=long,y=lat,colour="red"),size=0.2)+
scale_fill_brewer(palette="Blues") +
scale_size_area(max_size=8)+
theme(
panel.grid=element_blank(),
panel.background=element_blank(),
axis.text=element_blank(),
axis.ticks=element_blank(),
axis.title=element_blank(),
legend.position='right'
) + 
geom_scatterpie_legend(3, x=90, y=-20)

dev.off()
