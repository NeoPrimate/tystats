#import "../core.typ"

#let pmf(x, n, p) = core.scalar("pmf", "binom", x, (p, n))
#let cdf(x, n, p) = core.scalar("cdf", "binom", x, (p, n))
#let sf(x, n, p)  = core.scalar("sf",  "binom", x, (p, n))
#let mean(n, p)   = core.moment("mean",   "binom", (p, n))
#let var(n, p)    = core.moment("var",    "binom", (p, n))
#let sd(n, p)     = core.moment("sd",     "binom", (p, n))
#let median(n, p) = core.moment("median", "binom", (p, n))
#let rvs(n, p, size: 1, seed: 0) = core.rvs("binom", size, seed, (p, n))
