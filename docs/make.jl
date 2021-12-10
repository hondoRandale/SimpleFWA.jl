using Documenter
using SimpleFWA

makedocs(
    sitename = "SimpleFWA",
    format = Documenter.HTML(),
    modules = [SimpleFWA]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "https://github.com/hondoRandale/SimpleFWA.jl"
)
