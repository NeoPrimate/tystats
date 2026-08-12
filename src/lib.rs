use rand::SeedableRng;
use rand_chacha::ChaCha20Rng;
use serde::{Deserialize, Serialize};
use statrs::distribution::{
    Bernoulli, Beta, Binomial, ChiSquared, Continuous, ContinuousCDF, Discrete, DiscreteCDF, Exp,
    FisherSnedecor, Gamma, Geometric, LogNormal, Normal, Poisson, StudentsT, Uniform,
};
use statrs::statistics::Distribution as Moments;
use wasm_minimal_protocol::*;

initiate_protocol!();

getrandom::register_custom_getrandom!(stub_getrandom);
fn stub_getrandom(_buf: &mut [u8]) -> Result<(), getrandom::Error> {
    Err(getrandom::Error::UNSUPPORTED)
}

#[derive(Deserialize)]
struct Req {
    m: String,
    d: String,
    #[serde(default)]
    x: f64,
    #[serde(default)]
    n: u64,
    #[serde(default)]
    seed: u64,
    p: Vec<f64>,
}

#[derive(Serialize)]
#[serde(untagged)]
enum Res {
    Scalar(f64),
    Vector(Vec<f64>),
}

fn param(req: &Req, i: usize) -> Result<f64, String> {
    req.p
        .get(i)
        .copied()
        .ok_or_else(|| format!("dist '{}' missing param[{}]", req.d, i))
}

fn cont<D>(d: D, req: &Req) -> Result<Res, String>
where
    D: Continuous<f64, f64>
        + ContinuousCDF<f64, f64>
        + Moments<f64>
        + rand::distributions::Distribution<f64>,
{
    Ok(match req.m.as_str() {
        "pdf" => Res::Scalar(d.pdf(req.x)),
        "cdf" => Res::Scalar(d.cdf(req.x)),
        "sf" => Res::Scalar(d.sf(req.x)),
        "ppf" => Res::Scalar(d.inverse_cdf(req.x)),
        "mean" => Res::Scalar(d.mean().unwrap_or(f64::NAN)),
        "var" => Res::Scalar(d.variance().unwrap_or(f64::NAN)),
        "sd" => Res::Scalar(d.std_dev().unwrap_or(f64::NAN)),
        "median" => Res::Scalar(d.inverse_cdf(0.5)),
        "rvs" => {
            let mut rng = ChaCha20Rng::seed_from_u64(req.seed);
            let v: Vec<f64> = (0..req.n).map(|_| d.sample(&mut rng)).collect();
            Res::Vector(v)
        }
        m => return Err(format!("method '{m}' not supported for continuous distributions")),
    })
}

fn disc<D>(d: D, req: &Req) -> Result<Res, String>
where
    D: Discrete<u64, f64>
        + DiscreteCDF<u64, f64>
        + Moments<f64>
        + rand::distributions::Distribution<f64>,
{
    Ok(match req.m.as_str() {
        "pmf" => Res::Scalar(d.pmf(req.x as u64)),
        "cdf" => Res::Scalar(d.cdf(req.x as u64)),
        "sf" => Res::Scalar(d.sf(req.x as u64)),
        "ppf" => Res::Scalar(d.inverse_cdf(req.x) as f64),
        "mean" => Res::Scalar(d.mean().unwrap_or(f64::NAN)),
        "var" => Res::Scalar(d.variance().unwrap_or(f64::NAN)),
        "sd" => Res::Scalar(d.std_dev().unwrap_or(f64::NAN)),
        "median" => Res::Scalar(d.inverse_cdf(0.5) as f64),
        "rvs" => {
            let mut rng = ChaCha20Rng::seed_from_u64(req.seed);
            let v: Vec<f64> = (0..req.n).map(|_| d.sample(&mut rng)).collect();
            Res::Vector(v)
        }
        m => return Err(format!("method '{m}' not supported for discrete distributions")),
    })
}

fn build_err<E: core::fmt::Display>(e: E) -> String {
    e.to_string()
}

fn dispatch(req: &Req) -> Result<Res, String> {
    match req.d.as_str() {
        "norm" => cont(
            Normal::new(param(req, 0)?, param(req, 1)?).map_err(build_err)?,
            req,
        ),
        "expon" => cont(Exp::new(param(req, 0)?).map_err(build_err)?, req),
        "uniform" => cont(
            Uniform::new(param(req, 0)?, param(req, 1)?).map_err(build_err)?,
            req,
        ),
        "lognorm" => cont(
            LogNormal::new(param(req, 0)?, param(req, 1)?).map_err(build_err)?,
            req,
        ),
        "gamma" => cont(
            Gamma::new(param(req, 0)?, param(req, 1)?).map_err(build_err)?,
            req,
        ),
        "beta" => cont(
            Beta::new(param(req, 0)?, param(req, 1)?).map_err(build_err)?,
            req,
        ),
        "chi2" => cont(ChiSquared::new(param(req, 0)?).map_err(build_err)?, req),
        "f" => cont(
            FisherSnedecor::new(param(req, 0)?, param(req, 1)?).map_err(build_err)?,
            req,
        ),
        "t" => cont(
            StudentsT::new(param(req, 0)?, param(req, 1)?, param(req, 2)?)
                .map_err(build_err)?,
            req,
        ),
        "poisson" => disc(Poisson::new(param(req, 0)?).map_err(build_err)?, req),
        "binom" => disc(
            Binomial::new(param(req, 0)?, param(req, 1)? as u64).map_err(build_err)?,
            req,
        ),
        "geom" => disc(Geometric::new(param(req, 0)?).map_err(build_err)?, req),
        "bernoulli" => disc(Bernoulli::new(param(req, 0)?).map_err(build_err)?, req),
        d => Err(format!("unknown distribution: '{d}'")),
    }
}

#[wasm_func]
pub fn eval(buf: &[u8]) -> Result<Vec<u8>, String> {
    let req: Req = ciborium::from_reader(buf).map_err(|e| format!("decode: {e}"))?;
    let res = dispatch(&req)?;
    let mut out = Vec::new();
    ciborium::into_writer(&res, &mut out).map_err(|e| format!("encode: {e}"))?;
    Ok(out)
}
