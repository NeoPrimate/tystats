#import "../core.typ"

#let pdf(x, dfn, dfd) = core.scalar("pdf", "f", x, (dfn, dfd))
#let cdf(x, dfn, dfd) = core.scalar("cdf", "f", x, (dfn, dfd))
#let sf(x, dfn, dfd)  = core.scalar("sf",  "f", x, (dfn, dfd))
#let ppf(p, dfn, dfd) = core.scalar("ppf", "f", p, (dfn, dfd))
#let mean(dfn, dfd)   = core.moment("mean",   "f", (dfn, dfd))
#let var(dfn, dfd)    = core.moment("var",    "f", (dfn, dfd))
#let sd(dfn, dfd)     = core.moment("sd",     "f", (dfn, dfd))
#let median(dfn, dfd) = core.moment("median", "f", (dfn, dfd))
#let rvs(dfn, dfd, size: 1, seed: 0) = core.rvs("f", size, seed, (dfn, dfd))
