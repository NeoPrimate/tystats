#import "../core.typ"

#let pmf(x, p) = core.scalar("pmf", "geom", x, (p,))
#let cdf(x, p) = core.scalar("cdf", "geom", x, (p,))
#let sf(x, p)  = core.scalar("sf",  "geom", x, (p,))
#let ppf(q, p) = core.scalar("ppf", "geom", q, (p,))
#let mean(p)   = core.moment("mean",   "geom", (p,))
#let var(p)    = core.moment("var",    "geom", (p,))
#let sd(p)     = core.moment("sd",     "geom", (p,))
#let median(p) = core.moment("median", "geom", (p,))
#let rvs(p, size: 1, seed: 0) = core.rvs("geom", size, seed, (p,))
