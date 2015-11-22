NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

#Sample the data
sample <- NEI[sample(nrow(NEI), size=200, replace=F), ]

#Subset state
state <- subset(NEI, fips=='24510')
#Get total emissions
total_emissions <- tapply(state$Emissions, state$year, sum)
#Get years
years <- unique(state$year)

#Make plot
png(filename = "Plot2.png")
barplot(total_emissions, years,  main='Total PM2.5 Emissions From Baltimore City, Maryland', ylab='Emissions of PM2.5 (Tons)', xlab='Year')
dev.off()