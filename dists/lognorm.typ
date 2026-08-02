#import "../core.typ"

#let pdf(x, mu: 0.0, sigma: 1.0) = core.scalar("pdf", "lognorm", x, (mu, sigma))
#let cdf(x, mu: 0.0, sigma: 1.0) = core.scalar("cdf", "lognorm", x, (mu, sigma))
#let sf(x, mu: 0.0, sigma: 1.0)  = core.scalar("sf",  "lognorm", x, (mu, sigma))
#let ppf(p, mu: 0.0, sigma: 1.0) = core.scalar("ppf", "lognorm", p, (mu, sigma))
#let mean(mu: 0.0, sigma: 1.0)   = core.moment("mean",   "lognorm", (mu, sigma))
#let var(mu: 0.0, sigma: 1.0)    = core.moment("var",    "lognorm", (mu, sigma))
#let sd(mu: 0.0, sigma: 1.0)     = core.moment("sd",     "lognorm", (mu, sigma))
#let median(mu: 0.0, sigma: 1.0) = core.moment("median", "lognorm", (mu, sigma))
#let rvs(size: 1, seed: 0, mu: 0.0, sigma: 1.0) = core.rvs("lognorm", size, seed, (mu, sigma))
