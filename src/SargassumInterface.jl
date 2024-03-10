module SargassumInterface

using Pluto, Scratch

# interface_cache = ""

function run()
    f = download("https://raw.githubusercontent.com/70Gage70/SargassumInterface.jl/master/src/BOMBinterface.jl")
    Pluto.run(notebook = f)
    return nothing 
end

function __init__()
    # global interface_cache = @get_scratch!("interface_cache")
    # bomb_int = joinpath(@__DIR__, "BOMBinterface.jl")
    # bomb_edit = joinpath(interface_cache, "BOMBinterface-editable.jl")
    # rm(bomb_edit, force = true)
    # cp(bomb_int, bomb_edit)
    @info "Use `SargassumInterface.run()` to start the interface."
end

end # module SargassumInterface
