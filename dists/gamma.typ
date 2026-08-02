#import "../core.typ"

#let pdf(x, shape, rate: 1.0) = core.scalar("pdf", "gamma", x, (shape, rate))
#let cdf(x, shape, rate: 1.0) = core.scalar("cdf", "gamma", x, (shape, rate))
#let sf(x, shape, rate: 1.0)  = core.scalar("sf",  "gamma", x, (shape, rate))
#let ppf(p, shape, rate: 1.0) = core.scalar("ppf", "gamma", p, (shape, rate))
#let mean(shape, rate: 1.0)   = core.moment("mean",   "gamma", (shape, rate))
#let var(shape, rate: 1.0)    = core.moment("var",    "gamma", (shape, rate))
#let sd(shape, rate: 1.0)     = core.moment("sd",     "gamma", (shape, rate))
#let median(shape, rate: 1.0) = core.moment("median", "gamma", (shape, rate))
#let rvs(shape, size: 1, seed: 0, rate: 1.0) = core.rvs("gamma", size, seed, (shape, rate))
