library(ggplot2)

NEI <- readRDS('./summarySCC_PM25.rds')
SCC <- readRDS('./Source_Classification_Code.rds')

#Subset to Baltimore Vehicle Emissions
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]
baltimore_Vehicles_NEI <- vehicles_NEI[vehicles_NEI$fips=="24510",]

#Make Plot
png(filename = "Plot5.png")

ggp <- ggplot(baltimore_Vehicles_NEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("PM"[2.5]*" Emission")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions in Baltimore"))

print(ggp)

dev.off()