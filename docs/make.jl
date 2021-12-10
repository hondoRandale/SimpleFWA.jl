 
using Documenter, SimpleFWA

makedocs(
  sitename = "SimpleFWA",
  format   = Documenter.HTML(),
  modules  = [SimpleFWA]
)

deploydocs(
  repo = "github.com/hondoRandale/SimpleFWA.jl.git"
)
