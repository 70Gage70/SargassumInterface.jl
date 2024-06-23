module SargassumInterface

using Pluto

"""
    run(; force_retry::Bool = false)

Start the interface to `SargassumBOMB`. If `force_retry == true`, the notebook will be redownloaded.
"""
function run(; force_retry::Bool = false)
    f = joinpath(@__DIR__, "..", "interface", "BOMBinterface-editable.jl")
    DL_LINK = "https://raw.githubusercontent.com/70Gage70/SargassumInterface.jl/master/src/BOMBinterface.jl"
    (!isfile(f) || force_retry) && download(DL_LINK, f)
    Pluto.run(notebook = f)
    return nothing 
end

function __init__()
    @info "Use `SargassumInterface.run()` to start the interface."
end

import PrecompileTools

PrecompileTools.@compile_workload begin
    f = joinpath(@__DIR__, "..", "interface", "BOMBinterface-editable.jl")
    rm(f, force = true)
end

end # module SargassumInterface
