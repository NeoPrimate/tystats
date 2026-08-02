# tystats

scipy.stats-style probability distributions for [Typst](https://typst.app),
backed by the [`statrs`](https://crates.io/crates/statrs) Rust crate compiled to
WebAssembly.

## Installation

Once published to Typst Universe:

```typst
#import "@preview/tystats:0.1.0": norm, binom
```

## Usage

```typst
#import "@preview/tystats:0.1.0": norm, binom, gamma, t, poisson

#norm.cdf(1.96)                       // 0.9750021048529024
#norm.pdf(0)                          // 0.3989422804014327
#norm.sd()                            // 1.0
#norm.median(mean: 5.0, std_dev: 2.0) // 5.0
#norm.rvs(size: 3, seed: 42)          // (0.0447, -0.2456, -0.7462)

#binom.pmf(5, 10, 0.5)                // 0.24609375
#gamma.mean(2.0)                      // 2.0
#t.cdf(2.0, 10)                       // 0.9633060849999875
#poisson.pmf(3, 4.0)                  // 0.19536681481316454
```

## Distributions

### Continuous

| Distribution | Constructor params (defaults) |
|---|---|
| `norm` | `mean: 0.0, std_dev: 1.0` |
| `expon` | `rate: 1.0` |
| `uniform` | `min: 0.0, max: 1.0` |
| `lognorm` | `mu: 0.0, sigma: 1.0` |
| `gamma` | `shape, rate: 1.0` |
| `beta` | `shape_a, shape_b` |
| `chi2` | `freedom` |
| `t` | `freedom, location: 0.0, scale: 1.0` |

Methods: `pdf(x, ...)`, `cdf(x, ...)`, `sf(x, ...)`, `mean(...)`, `var(...)`,
`sd(...)`, `median(...)`, `rvs(size: 1, seed: 0, ...)`.

### Discrete

| Distribution | Constructor params |
|---|---|
| `poisson` | `lambda` |
| `binom` | `n, p` |
| `geom` | `p` |
| `bernoulli` | `p` |

Methods: same as continuous, but `pmf(x, ...)` instead of `pdf`.

## Parameter names

Distribution parameter names follow `statrs`, not scipy. For example, `norm`
uses `mean`/`std_dev` (not `loc`/`scale`), and `gamma` uses `shape`/`rate`
(not `a`/`scale`). The distribution and method names themselves follow scipy
conventions.

## Random sampling

`rvs` requires an explicit `seed` (defaults to `0`). The underlying RNG is
`ChaCha20`, so the same seed always produces the same sequence — ideal for
reproducible documents. There is no access to system entropy from inside
Typst's WASM sandbox.

```typst
#norm.rvs(size: 5, seed: 0)        // deterministic
#norm.rvs(size: 5, seed: 1)        // a different deterministic sequence
```

## Local testing via symlink

To use a checked-out copy of this repo as if it were an installed package
(handy when iterating on the package itself or testing changes before
release), symlink the repo into Typst's local-packages directory. Typst
resolves `@local/<name>:<version>` to
`{data-dir}/typst/packages/local/<name>/<version>`. The data directory is
platform-specific:

- macOS: `~/Library/Application Support`
- Linux: `$XDG_DATA_HOME` or `~/.local/share`
- Windows: `%APPDATA%`

### macOS / Linux

```sh
# Adjust the source path to wherever you cloned the repo.
# Adjust 0.1.0 to match the `version` field in typst.toml.
PKG_DIR="$HOME/Library/Application Support/typst/packages/local/tystats"   # macOS
# PKG_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/typst/packages/local/tystats"  # Linux

mkdir -p "$PKG_DIR"
ln -s "$(pwd)" "$PKG_DIR/0.1.0"
```

Then from any document:

```typst
#import "@local/tystats:0.1.0": norm, binom
```

Edits to files in the cloned repo are picked up immediately on the next
`typst compile` — no reinstall step. When you bump `version` in
`typst.toml`, also rename the symlink (or create a new one alongside) so
the directory name matches.

### Windows (PowerShell, run as administrator)

```powershell
$pkg = "$env:APPDATA\typst\packages\local\tystats"
New-Item -ItemType Directory -Force -Path $pkg | Out-Null
New-Item -ItemType SymbolicLink -Path "$pkg\0.1.0" -Target (Get-Location)
```

### Removing the symlink

When you're done testing locally — or before installing the real package
from Universe — remove the symlink so Typst falls back to the published
version:

```sh
# macOS
rm "$HOME/Library/Application Support/typst/packages/local/tystats/0.1.0"

# Linux
rm "${XDG_DATA_HOME:-$HOME/.local/share}/typst/packages/local/tystats/0.1.0"
```

```powershell
# Windows
Remove-Item "$env:APPDATA\typst\packages\local\tystats\0.1.0"
```

Use plain `rm` (not `rm -rf`) — the target is a symlink, not a directory
tree, so a regular `rm` removes only the link and leaves your cloned repo
untouched. If the `tystats` parent directory is now empty, you can
`rmdir` it as well, but leaving it is harmless.

## Building from source

The Rust source for the WASM plugin lives in `src/lib.rs`. To rebuild:

```sh
./build.sh
```

This runs `cargo build --release --target wasm32-unknown-unknown` and copies
the resulting `tystats.wasm` into the package root. Requires the
`wasm32-unknown-unknown` Rust target.

## License

MIT — see [LICENSE](LICENSE).
