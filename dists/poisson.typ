#import "../core.typ"

#let pmf(x, lambda) = core.scalar("pmf", "poisson", x, (lambda,))
#let cdf(x, lambda) = core.scalar("cdf", "poisson", x, (lambda,))
#let sf(x, lambda)  = core.scalar("sf",  "poisson", x, (lambda,))
#let ppf(p, lambda) = core.scalar("ppf", "poisson", p, (lambda,))
#let mean(lambda)   = core.moment("mean",   "poisson", (lambda,))
#let var(lambda)    = core.moment("var",    "poisson", (lambda,))
#let sd(lambda)     = core.moment("sd",     "poisson", (lambda,))
#let median(lambda) = core.moment("median", "poisson", (lambda,))
#let rvs(lambda, size: 1, seed: 0) = core.rvs("poisson", size, seed, (lambda,))
