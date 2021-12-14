using Documenter
using DocumenterMarkdown
using SimpleFWA

makedocs(
    sitename = "SimpleFWA",
    format = Markdown(),
    modules = [SimpleFWA]
)

deploydocs(
    repo = "git@github.com:hondoRandale/SimpleFWA.jl.git"
)
