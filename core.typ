#let _plugin = plugin("tystats.wasm")

#let _eval(req) = cbor(_plugin.eval(cbor.encode(req)))

#let scalar(method, dist, x, params) = {
  _eval((m: method, d: dist, x: float(x), p: params.map(float)))
}

#let moment(method, dist, params) = {
  _eval((m: method, d: dist, p: params.map(float)))
}

#let rvs(dist, size, seed, params) = {
  _eval((m: "rvs", d: dist, n: int(size), seed: int(seed), p: params.map(float)))
}
