#import "tystats.typ": norm, expon, uniform, lognorm, gamma, beta, chi2, t
#import "tystats.typ": poisson, binom, geom, bernoulli

= TyStats

A Typst package that wraps `statrs`.

#table(
  columns: 2,
  inset: 1em,
  [Distribution], [Methods],
  [`norm`\ `expon`\ `uniform`\ `lognorm`\ `gamma`\ `beta`\ `chi2`\ `t`],
  [`pdf`\ `cdf`\ `sf`\ `rvs`\ `mean`\ `var`\ `sd`\ `median`],
  [`poisson`\ `binom`\ `geom`\ `bernoulli`],
  [`pmf`\ `cdf`\ `sf`\ `rvs`\ `mean`\ `var`\ `sd`\ `median`],
)

== Smoke checks

#let fmt(x) = if type(x) == array {
  "(" + x.map(v => str(calc.round(v, digits: 4))).join(", ") + ")"
} else {
  str(calc.round(x, digits: 6))
}

#table(
  columns: 2,
  inset: 0.6em,
  [Call], [Result],

  [`norm.cdf(1.96)`],                       fmt(norm.cdf(1.96)),
  [`norm.pdf(0)`],                          fmt(norm.pdf(0)),
  [`norm.sd()`],                            fmt(norm.sd()),
  [`norm.median(mean: 5.0)`],               fmt(norm.median(mean: 5.0)),
  [`norm.rvs(size: 3, seed: 42)`],          fmt(norm.rvs(size: 3, seed: 42)),

  [`expon.mean(rate: 2.0)`],                fmt(expon.mean(rate: 2.0)),
  [`expon.cdf(1.0)`],                       fmt(expon.cdf(1.0)),

  [`uniform.pdf(0.5)`],                     fmt(uniform.pdf(0.5)),
  [`uniform.var()`],                        fmt(uniform.var()),

  [`lognorm.median()`],                     fmt(lognorm.median()),
  [`lognorm.pdf(1.0)`],                     fmt(lognorm.pdf(1.0)),

  [`gamma.mean(2.0)`],                      fmt(gamma.mean(2.0)),
  [`gamma.pdf(1.0, 2.0)`],                  fmt(gamma.pdf(1.0, 2.0)),

  [`beta.mean(2.0, 5.0)`],                  fmt(beta.mean(2.0, 5.0)),
  [`beta.pdf(0.3, 2.0, 5.0)`],              fmt(beta.pdf(0.3, 2.0, 5.0)),

  [`chi2.mean(4)`],                         fmt(chi2.mean(4)),
  [`chi2.pdf(1.0, 4)`],                     fmt(chi2.pdf(1.0, 4)),

  [`t.pdf(0.0, 10)`],                       fmt(t.pdf(0.0, 10)),
  [`t.cdf(2.0, 10)`],                       fmt(t.cdf(2.0, 10)),

  [`poisson.pmf(3, 4.0)`],                  fmt(poisson.pmf(3, 4.0)),
  [`poisson.mean(4.0)`],                    fmt(poisson.mean(4.0)),

  [`binom.pmf(5, 10, 0.5)`],                fmt(binom.pmf(5, 10, 0.5)),
  [`binom.cdf(5, 10, 0.5)`],                fmt(binom.cdf(5, 10, 0.5)),
  [`binom.mean(10, 0.3)`],                  fmt(binom.mean(10, 0.3)),

  [`geom.pmf(3, 0.5)`],                     fmt(geom.pmf(3, 0.5)),
  [`geom.mean(0.5)`],                       fmt(geom.mean(0.5)),

  [`bernoulli.pmf(1, 0.3)`],                fmt(bernoulli.pmf(1, 0.3)),
  [`bernoulli.var(0.3)`],                   fmt(bernoulli.var(0.3)),
)
