#import "../core.typ"

#let pdf(x, freedom, location: 0.0, scale: 1.0) = core.scalar("pdf", "t", x, (location, scale, freedom))
#let cdf(x, freedom, location: 0.0, scale: 1.0) = core.scalar("cdf", "t", x, (location, scale, freedom))
#let sf(x, freedom, location: 0.0, scale: 1.0)  = core.scalar("sf",  "t", x, (location, scale, freedom))
#let ppf(p, freedom, location: 0.0, scale: 1.0) = core.scalar("ppf", "t", p, (location, scale, freedom))
#let mean(freedom, location: 0.0, scale: 1.0)   = core.moment("mean",   "t", (location, scale, freedom))
#let var(freedom, location: 0.0, scale: 1.0)    = core.moment("var",    "t", (location, scale, freedom))
#let sd(freedom, location: 0.0, scale: 1.0)     = core.moment("sd",     "t", (location, scale, freedom))
#let median(freedom, location: 0.0, scale: 1.0) = core.moment("median", "t", (location, scale, freedom))
#let rvs(freedom, size: 1, seed: 0, location: 0.0, scale: 1.0) = core.rvs("t", size, seed, (location, scale, freedom))
