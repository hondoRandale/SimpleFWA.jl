using Documenter
using SimpleFWA

makedocs(
    sitename = "SimpleFWA",
    modules = [SimpleFWA]
)

deploydocs(
    repo = "git@github.com:hondoRandale/SimpleFWA.jl.git"
)
