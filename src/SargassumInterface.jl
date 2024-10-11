module SargassumInterface

using Scratch
_INTERFACE_SCRATCH = Ref{String}()

using Pluto

export interface

"""
    interface(; reset = false, args...)

Start the interface. 

### Optional Arguments

- `reset`: If true, the interface will be "factory reset" to its default state. This should only be required if the \
interface code itself has been modified. That is, changing parameters using sliders etc. does not require a reset.
- `args`: Passed directly to `Pluto.run()`. 
"""
function interface(; reset::Bool = false, args...)
    nb = joinpath(_INTERFACE_SCRATCH.x, "interface.jl")
    if reset
        rm(nb, force = true)
        Pluto.readwrite(joinpath(@__DIR__, "interface.jl"), nb)
    end

    defaults = (
        notebook = nb,
    )

    Pluto.run(; merge(defaults, args)...)
    return nothing 
end

function __init__()
    _INTERFACE_SCRATCH.x = @get_scratch!("_INTERFACE_SCRATCH")

    nb = joinpath(_INTERFACE_SCRATCH.x, "interface.jl")

    if !isfile(nb)
        Pluto.readwrite(joinpath(@__DIR__, "interface.jl"), nb)
    end
end

end # module SargassumInterface
