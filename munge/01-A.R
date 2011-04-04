claims <- transform(claims, AgreedPayment = as.numeric(str_replace(as.character(claims$AgreedPayment), ',', '')))

# Drop extreme values.
claims <- subset(claims, AgreedPayment != 0)
claims <- subset(claims, AgreedPayment < 10000)

