#import "../core.typ"

#let pdf(x, freedom) = core.scalar("pdf", "chi2", x, (freedom,))
#let cdf(x, freedom) = core.scalar("cdf", "chi2", x, (freedom,))
#let sf(x, freedom)  = core.scalar("sf",  "chi2", x, (freedom,))
#let ppf(p, freedom) = core.scalar("ppf", "chi2", p, (freedom,))
#let mean(freedom)   = core.moment("mean",   "chi2", (freedom,))
#let var(freedom)    = core.moment("var",    "chi2", (freedom,))
#let sd(freedom)     = core.moment("sd",     "chi2", (freedom,))
#let median(freedom) = core.moment("median", "chi2", (freedom,))
#let rvs(freedom, size: 1, seed: 0) = core.rvs("chi2", size, seed, (freedom,))
