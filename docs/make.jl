using Documenter
using SimpleFWA

makedocs(
    sitename = "SimpleFWA",
    modules = [SimpleFWA]
)

deploydocs(
    repo = "git@github.com:hondoRandale/SimpleFWA.jl.git",
)

deploydocs(
    repo   = "github.com/USER_NAME/PACKAGE_NAME.jl.git",
    deps   = Deps.pip("mkdocs", "pygments", "python-markdown-math"),
    make   = () -> run(`mkdocs build`)
    target = "site"
)
