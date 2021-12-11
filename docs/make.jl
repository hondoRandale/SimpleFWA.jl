using Documenter
using SimpleFWA

makedocs(
    sitename = "SimpleFWA",
    format = Documenter.HTML(),
    modules = [SimpleFWA]
)

deploydocs(
    repo = "git@github.com:hondoRandale/SimpleFWA.jl.git"
)
