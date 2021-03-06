#install.packages(c("ggplot2","maps"))
require(ggplot2)
require(maps)
require(grid)

clusters<-read.table("data/clusters.out",col.names=c("lat","lon","cluster","type"))

clusters<-subset(clusters,type ==1)            
shapelist<-c(19)
shapetypes<-c("1")
sizelist<-c(1.5)
colourlist<-c("colour_1","colour_2","colour_3")
clusters$shape<-shapetypes[clusters$type]
clusters$size<-sizelist[clusters$type]
clusters$colour<-colourlist[clusters$cluster+1]



#Get world map info
world_map <- map_data("world")

 
# create a blank ggplot theme
theme_opts <- list(theme(panel.grid.minor = element_blank(),
                        panel.grid.major = element_blank(),
                        panel.background = element_blank(),
                        plot.margin = unit(c(0,0,0,0),"mm"),
                        panel.border = element_blank(),
                        axis.line = element_blank(),
                        axis.text.x = element_blank(),
                        axis.text.y = element_blank(),
                        axis.ticks = element_blank(),
                        axis.title.x = element_blank(),
                        axis.title.y = element_blank(),
                        plot.title = element_text(size=22)))
                        
#Creat a base plot
p <- ggplot() + coord_fixed(ylim=c(-60,80),xlim=c(-170,180)) +theme_opts
#Add map to base plot


base_world <- p + geom_polygon(data=world_map,
                aes(x=long, y=lat,group=group),alpha=I(0.1))

world <- base_world + scale_size_continuous(range = c(1.5,4))+
                            geom_point(data=clusters,
                                size=1.5,
                                            aes(x=lon,
                                                y=lat,
                                                shape= shape,
                                                size=c(0.1),
                                                colour=colour,
                                                order=shape),
                                         alpha=I(1.0)) 
                                         
world <- world +scale_colour_manual(values=c("#55AA55","#000000","#AAAAFF"))
world <- world +scale_shape_manual(values=shapelist,labels=c("user"))
world <- world + guides(colour="none",size="none", shape=
    guide_legend(title="node type",
    override.aes = list(colour=c("black"), size=sizelist,
    shape=shapelist)))
         
             

#pdf("out.pdf")
#print(map_with_jitter)
ggsave("graphs/cluster_plot_1.pdf",width=6.0,height=2.05)
#dev.off()
