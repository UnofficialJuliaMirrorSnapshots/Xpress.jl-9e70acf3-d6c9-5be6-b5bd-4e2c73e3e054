using Documenter, Xpress

makedocs(
    format = :html,
    sitename = "Xpress",
    pages = [
        "Introduction" => "index.md"
    ]
)

deploydocs(
    repo   = "github.com/JuliaOpt/Xpress.jl.git",
    target = "build",
    osname = "linux",
    julia  = "0.6",
    deps   = nothing,
    make   = nothing
)
