library(ggplot2)

NEI <- readRDS('./summarySCC_PM25.rds')
SCC <- readRDS('./Source_Classification_Code.rds')

#Subset the data to vehicle emissions
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data by each city's fip and add city name.
Baltimore_vehicles_NEI <- vehicles_NEI[vehicles_NEI$fips=="24510",]
Baltimore_vehicles_NEI$city <- "Baltimore City"

LA_vehicles_NEI <- vehicles_NEI[vehicles_NEI$fips=="06037",]
LA_vehicles_NEI$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
Combined_NEI <- rbind(Baltimore_vehicles_NEI,LA_vehicles_NEI)

#Make Plot
png(filename = "Plot6.png")

ggp <- ggplot(Combined_NEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("PM"[2.5]*" Emissions KTons")) + 
  labs(title=expression("Vehicle Emissions PM"[2.5]*" in Baltimore & LA"))

print(ggp)

dev.off()