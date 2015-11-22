library(ggplot2)

#Get data
NEI <- readRDS('./summarySCC_PM25.rds')
SCC <- readRDS('./Source_Classification_Code.rds')

#Subset for Baltimore
baltimore <- NEI[NEI$fips=="24510",]

#Get aggregate
aggregate_Baltimore <- aggregate(Emissions ~ year, baltimore,sum)

#Make plot
png(filename = "Plot3.png")

plot <- ggplot(baltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("Baltimore City PM"[2.5]*" Emissions by Source Type"))

print(plot)

dev.off()