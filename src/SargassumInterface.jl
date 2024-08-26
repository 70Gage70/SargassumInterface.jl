module SargassumInterface

using Pluto

"""
    run(; force_retry::Bool = false, args...)

Start the interface to `SargassumBOMB`. 

### Optional Arguments

- `force_retry`: If true, notebook will be redownloaded.
- `args`: Passed directly to `Pluto.run()`
"""
function run(; force_retry::Bool = false, args...)
    f = joinpath(@__DIR__, "..", "interface", "BOMBinterface-editable.jl")
    DL_LINK = "https://raw.githubusercontent.com/70Gage70/SargassumInterface.jl/master/src/BOMBinterface.jl"
    (!isfile(f) || force_retry) && download(DL_LINK, f)

    defaults = (
        notebook = f,
    )

    Pluto.run(; merge(defaults, args)...)
    return nothing 
end

# function __init__()
#     @info "Use `SargassumInterface.run()` to start the interface."
# end

import PrecompileTools

PrecompileTools.@compile_workload begin
    f = joinpath(@__DIR__, "..", "interface", "BOMBinterface-editable.jl")
    rm(f, force = true)
end

end # module SargassumInterface
