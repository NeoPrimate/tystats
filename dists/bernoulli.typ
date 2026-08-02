#import "../core.typ"

#let pmf(x, p) = core.scalar("pmf", "bernoulli", x, (p,))
#let cdf(x, p) = core.scalar("cdf", "bernoulli", x, (p,))
#let sf(x, p)  = core.scalar("sf",  "bernoulli", x, (p,))
#let ppf(q, p) = core.scalar("ppf", "bernoulli", q, (p,))
#let mean(p)   = core.moment("mean",   "bernoulli", (p,))
#let var(p)    = core.moment("var",    "bernoulli", (p,))
#let sd(p)     = core.moment("sd",     "bernoulli", (p,))
#let median(p) = core.moment("median", "bernoulli", (p,))
#let rvs(p, size: 1, seed: 0) = core.rvs("bernoulli", size, seed, (p,))
