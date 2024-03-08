module SargassumInterface

function __init__()
    Pluto.run(notebook = joinpath(@__DIR__, "BOMBinterface.jl"))
end

end # module SargassumInterface
