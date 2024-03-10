module SargassumInterface

using Pluto, Scratch

interface_cache = ""

function run()
    bomb_edit = joinpath(interface_cache, "BOMBinterface-editable.jl")

    Pluto.run(notebook = bomb_edit)
    return nothing 
end

function __init__()
    global interface_cache = @get_scratch!("interface_cache")
    bomb_int = joinpath(@__DIR__, "BOMBinterface.jl")
    bomb_edit = joinpath(interface_cache, "BOMBinterface-editable.jl")
    rm(bomb_edit, force = true)
    cp(bomb_int, bomb_edit)
    @info "Use `SargassumInterface.run()` to start the interface."
end

end # module SargassumInterface
