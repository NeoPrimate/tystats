#import "../core.typ"

#let pdf(x, rate: 1.0) = core.scalar("pdf", "expon", x, (rate,))
#let cdf(x, rate: 1.0) = core.scalar("cdf", "expon", x, (rate,))
#let sf(x, rate: 1.0)  = core.scalar("sf",  "expon", x, (rate,))
#let mean(rate: 1.0)   = core.moment("mean",   "expon", (rate,))
#let var(rate: 1.0)    = core.moment("var",    "expon", (rate,))
#let sd(rate: 1.0)     = core.moment("sd",     "expon", (rate,))
#let median(rate: 1.0) = core.moment("median", "expon", (rate,))
#let rvs(size: 1, seed: 0, rate: 1.0) = core.rvs("expon", size, seed, (rate,))
