module SargassumInterface

using Pluto

function run()
    Pluto.run(notebook = joinpath(@__DIR__, "..", "interface", "BOMBinterface.jl"))
    return nothing 
end

function __init__()
    @info "Use `SargassumInterface.run()` to start the interface."
end

end # module SargassumInterface
