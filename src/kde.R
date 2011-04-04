library('ProjectTemplate')
load.project()

ggplot(claims, aes(x = AgreedPayment)) + geom_density()

ggplot(claims, aes(x = AgreedPayment, fill = District)) + geom_density() + facet_grid(District ~ .)

ggplot(claims, aes(x = AgreedPayment, fill = Province)) + geom_density() + facet_grid(Province ~ .)

ggplot(subset(claims, AgreedPayment < 10000), aes(x = AgreedPayment)) + geom_density()
