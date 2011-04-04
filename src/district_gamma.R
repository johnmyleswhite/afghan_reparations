library('ProjectTemplate')
load.project()

# Estimate a gamma distribution that produced the scores data.
jags <- jags.model(file.path('jags', 'district_hierarchical_gamma.bug'),
                   data = list('payment' = claims$AgreedPayment,
                               'district' = as.numeric(claims$District),
                               'N' = nrow(claims),
                               'K' = max(as.numeric(claims$District))),
                   n.chains = 4,
                   n.adapt = 1000)

mcmc.samples <- coda.samples(jags,
                             c('shape', 'rate'),
                             1000)

mcmc.save(mcmc.samples,
          filename = file.path('graphs', 'district_hierarchical_gamma'))

credible.intervals <- mcmc.summarize(mcmc.samples)

p <- ggplot(credible.intervals[1:4,],
            aes(x = reorder(Parameter, Mean),
                y = Mean,
                color = Parameter)) +
  geom_point() +
  geom_pointrange(aes(ymin = LowerBound95, ymax = UpperBound95)) +
  coord_flip() +
  ylab('') +
  opts(title = 'Estimated score distribution for player...') +
  xlab('') +
  scale_color_discrete(legend = FALSE)
ggsave(filename = file.path('graphs', 'district_parameters_1.png'), plot = p)

p <- ggplot(credible.intervals[5:8,],
            aes(x = reorder(Parameter, Mean),
                y = Mean,
                color = Parameter)) +
  geom_point() +
  geom_pointrange(aes(ymin = LowerBound95, ymax = UpperBound95)) +
  coord_flip() +
  ylab('') +
  opts(title = 'Estimated score distribution for player...') +
  xlab('') +
  scale_color_discrete(legend = FALSE)
ggsave(filename = file.path('graphs', 'district_parameters_2.png'), plot = p)

# Get means and standard deviations. Just look at means with uncertainty included.
# Put meaningful labels on graphs.

for (i in 1:4)
{
  as.array(mcmc.samples)[,'shape[1]',] * (1 / as.array(mcmc.samples)[,'rate[1]',])
  sqrt(as.array(mcmc.samples)[,'shape[1]',] * (1 / as.array(mcmc.samples)[,'rate[1]',]) ^ 2)
}
