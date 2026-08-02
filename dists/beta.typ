#import "../core.typ"

#let pdf(x, shape_a, shape_b) = core.scalar("pdf", "beta", x, (shape_a, shape_b))
#let cdf(x, shape_a, shape_b) = core.scalar("cdf", "beta", x, (shape_a, shape_b))
#let sf(x, shape_a, shape_b)  = core.scalar("sf",  "beta", x, (shape_a, shape_b))
#let ppf(p, shape_a, shape_b) = core.scalar("ppf", "beta", p, (shape_a, shape_b))
#let mean(shape_a, shape_b)   = core.moment("mean",   "beta", (shape_a, shape_b))
#let var(shape_a, shape_b)    = core.moment("var",    "beta", (shape_a, shape_b))
#let sd(shape_a, shape_b)     = core.moment("sd",     "beta", (shape_a, shape_b))
#let median(shape_a, shape_b) = core.moment("median", "beta", (shape_a, shape_b))
#let rvs(shape_a, shape_b, size: 1, seed: 0) = core.rvs("beta", size, seed, (shape_a, shape_b))
