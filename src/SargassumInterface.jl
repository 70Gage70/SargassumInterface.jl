module SargassumInterface

using Pluto

function run()
    bomb_int = joinpath(@__DIR__, "..", "interface", "BOMBinterface.jl")
    bomb_edit = joinpath(pwd(), "BOMBinterface-editable.jl")
    rm(bomb_edit, force = true)
    cp(bomb_int, bomb_edit)

    Pluto.run(notebook = bomb_edit)
    return nothing 
end

function __init__()
    @info "Use `SargassumInterface.run()` to start the interface."
end

end # module SargassumInterface
