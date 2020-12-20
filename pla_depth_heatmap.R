library(RColorBrewer)
library(pheatmap)


pdf("70S_pla-depth_pPCP-depth.rm699.order.pdf",height=10,width=4);

x=read.table("70S_pla-depth_pPCP-depth.rm699.order.v2.xls",header=TRUE,check.names=F);
d=data.matrix(x);

cc = colorRampPalette(rev(brewer.pal(n = 10, 
     name = "RdYlBu")))

pheatmap(d, color=cc(130), cluster_rows = FALSE, display_numbers = TRUE,treeheight_row=0, angle_col = "45", treeheight_col=0, cluster_cols = FALSE, fontsize_row=10,fontsize_col=10,number_format = "%.1f", number_color = "grey30", fontsize_number = 6,)

dev.off()

