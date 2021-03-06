source ("scripts/readDataFiles.R")
require(ggplot2)
require(grid)
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 5) {
    cat("Requires stay_on  nearest potato no_users outputfile")
}
filename1<- args[1]
filename2<-args[2]
filename3<-args[3]
nousers<- as.numeric(args[4])
outfilename<- args[5]

stay<-read_servers_file(filename1)
nearest<-read_servers_file(filename2)
potato<-read_servers_file(filename3)

wid<-0.1
dodge<-c(-wid/3,0,wid/3.0)
stay$type<-"d"
nearest$type<-"e"
potato$type<-"f"
stay$dodge2<- -wid
nearest$dodge2<- 0
potato$dodge2<- wid
combined<-rbind(stay,nearest,potato)

col1<-"#990000"
col2<-"#00CC00"
col3<-"#0000FF"
allcols<-c(col1,col2,col3)
linetypes<-c("dashed","solid","dotted")
shapetypes<-c(16,17,15)


minx<-min(stay$noservers-wid*2)
maxx<-max(stay$noservers+wid*2)

theme_opts<- theme_bw()


breaks<-as.numeric(levels(factor(stay$noservers)))
g<-ggplot(combined,aes(x=noservers)) + theme_opts +
    scale_x_continuous(limits=c(minx-wid,maxx+wid),breaks=breaks)+
        scale_colour_manual(name="combined",breaks=c("d","e","f"),
        values=allcols, labels=c("stay_on","nearest","potato"),
        guide = guide_legend(title = element_blank())) +
    scale_shape_manual(name="combined",breaks=c("d","e","f"),
        values=shapetypes, labels=c("stay_on","nearest","potato")) +    
    scale_linetype_manual(breaks=c("a","b"),
        values=linetypes, labels=c("managed","total")) +
    expand_limits(y=0) +
    geom_errorbar(aes(x=noservers+dodge[1]+dodge2,ymin=mandel-2*mandelsd, ymax=mandel+2*mandelsd, colour=type), width=wid) +
    geom_line(aes(x=noservers+dodge[1]+dodge2,y=mandel,colour=type,linetype="a"))+
    geom_point(aes(x=noservers+dodge[1]+dodge2,y=mandel,colour=type,shape=type),size=2.5) + 
    geom_errorbar(aes(x=noservers+dodge[2]+dodge2,ymin=totdel-2*totdelsd, ymax=totdel+2*totdelsd, colour=type), width=wid) +
    geom_line(aes(x=noservers+dodge[2]+dodge2,y=totdel,colour=type,linetype="b")) +
    geom_point(aes(x=noservers+dodge[2]+dodge2,y=totdel,colour=type,shape=type),size=2.5) +
    guides(linetype= 
        guide_legend(title=element_blank())) +
    guides(shape= 
        guide_legend(title=element_blank())) +
    xlab("Number of cloud hosts/session") +
    ylab("Mean delay (secs)")
ggsave(outfilename,width=6.0,height=2.5)
