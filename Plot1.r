#Get data
NEI <- readRDS('./summarySCC_PM25.rds')
SCC <- readRDS('./Source_Classification_Code.rds')

#Sample the data
sample <- NEI[sample(nrow(NEI), size=200, replace=F), ]

#Get sum for each year
total_emissions <- tapply(NEI$Emissions, NEI$year, sum)
#Get years
years <- unique(NEI$year)

#Create plot
png(filename = "Plot1.png")
barplot(total_emissions, years, main=expression('Total Emission of PM'[2.5]), xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()
