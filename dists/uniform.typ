#import "../core.typ"

#let pdf(x, min: 0.0, max: 1.0) = core.scalar("pdf", "uniform", x, (min, max))
#let cdf(x, min: 0.0, max: 1.0) = core.scalar("cdf", "uniform", x, (min, max))
#let sf(x, min: 0.0, max: 1.0)  = core.scalar("sf",  "uniform", x, (min, max))
#let mean(min: 0.0, max: 1.0)   = core.moment("mean",   "uniform", (min, max))
#let var(min: 0.0, max: 1.0)    = core.moment("var",    "uniform", (min, max))
#let sd(min: 0.0, max: 1.0)     = core.moment("sd",     "uniform", (min, max))
#let median(min: 0.0, max: 1.0) = core.moment("median", "uniform", (min, max))
#let rvs(size: 1, seed: 0, min: 0.0, max: 1.0) = core.rvs("uniform", size, seed, (min, max))
