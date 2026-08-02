#import "../core.typ"

#let pdf(x, mean: 0.0, std_dev: 1.0) = core.scalar("pdf", "norm", x, (mean, std_dev))
#let cdf(x, mean: 0.0, std_dev: 1.0) = core.scalar("cdf", "norm", x, (mean, std_dev))
#let sf(x, mean: 0.0, std_dev: 1.0)  = core.scalar("sf",  "norm", x, (mean, std_dev))
#let ppf(p, mean: 0.0, std_dev: 1.0) = core.scalar("ppf", "norm", p, (mean, std_dev))
#let mean(mean: 0.0, std_dev: 1.0)   = core.moment("mean",   "norm", (mean, std_dev))
#let var(mean: 0.0, std_dev: 1.0)    = core.moment("var",    "norm", (mean, std_dev))
#let sd(mean: 0.0, std_dev: 1.0)     = core.moment("sd",     "norm", (mean, std_dev))
#let median(mean: 0.0, std_dev: 1.0) = core.moment("median", "norm", (mean, std_dev))
#let rvs(size: 1, seed: 0, mean: 0.0, std_dev: 1.0) = core.rvs("norm", size, seed, (mean, std_dev))
