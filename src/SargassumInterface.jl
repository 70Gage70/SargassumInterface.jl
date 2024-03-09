module SargassumInterface

using Pluto

function run()
    Pluto.run(notebook = joinpath(@__DIR__, "..", "interface", "BOMBinterface-editable.jl"))
    return nothing 
end

function __init__()
    rm(joinpath(@__DIR__, "..", "interface", "BOMBinterface-editable.jl"), force = true)

    cp(
        joinpath(@__DIR__, "..", "interface", "BOMBinterface.jl"), 
        joinpath(@__DIR__, "..", "interface", "BOMBinterface-editable.jl"))
    @info "Use `SargassumInterface.run()` to start the interface."
end

end # module SargassumInterface
