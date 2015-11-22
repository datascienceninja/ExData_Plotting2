library(ggplot2)

#Get data
NEI <- readRDS('./summarySCC_PM25.rds')
SCC <- readRDS('./Source_Classification_Code.rds')

# Subset coal combustion related NEI data
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
combined <- (combustion & coal)
combustion_SCC <- SCC[combined,]$SCC
combustion_NEI <- NEI[NEI$SCC %in% combustion_SCC,]

#Make Plot
png(filename = "Plot4.png")

ggp <- ggplot(combustion_NEI,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emissions")) + 
  labs(title=expression("PM"[2.5]*" Combined Coal Combustion Source Emissions"))

print(ggp)

dev.off()