### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 66e144d6-dcbb-11ee-26f3-b36ae4be3693
begin
    import Pkg
    Pkg.activate(@__DIR__)
	Pkg.add("PlutoUI")
	Pkg.add("SargassumBOMB")
	Pkg.add("SargassumFromAFAI")
	Pkg.add("WGLMakie")
	Pkg.add("Dates")
end

# ╔═╡ 32bd8970-a2f8-478b-ab48-4fbd1bcf735b
begin
	using SargassumBOMB
	using SargassumFromAFAI
	using WGLMakie
	using Dates
	using PlutoUI
	@info "Loaded dependencies."
end

# ╔═╡ 5aaaa4b6-cf8f-4a6c-8ae7-c6aeb3745dae
md"""
# Front Matter
"""

# ╔═╡ 174f180c-642c-46e4-976b-89ad6f99c962
begin
	@info "Maximizing notebook width."
	html"""
	<style>
		main {
			margin: 0 auto;
			max-width: 2000px;
	    	padding-left: max(160px, 10%);
	    	padding-right: max(160px, 10%);
		}
	</style>
	"""
end

# ╔═╡ c3eddd51-43c4-42f4-800a-ae9945df1e86
md"""
# Interface
"""

# ╔═╡ 71f616dd-c637-4039-85d4-04bc5fdd8662
md"""
## Initial Conditions
"""

# ╔═╡ 618ddac0-4a20-4146-8abd-761a97a451a6
md"""
### Time span
"""

# ╔═╡ 09d66d39-007b-4b0f-90bb-d3d36b85396c
begin
	@bind tspan_data PlutoUI.combine() do Child
		md"""
		Start date (yyyy-mm-dd): $(Child(TextField(default = "2018-01-01")))
		
		End date (yyyy-mm-dd): $(Child(TextField(default = "2018-01-02")))
		"""
	end
end

# ╔═╡ 7dd77f5a-fdeb-4811-94c5-8066cf1bda3e
md"""
### Rectangular clump positions
"""

# ╔═╡ ed4f082b-237c-4b08-b3b9-2f1846b0ecfb
begin
	@bind corners PlutoUI.combine() do Child
		md"""
		Lon min (°): $(Child(TextField(default = "-55.0")))
		Lon max (°): $(Child(TextField(default = "-50.0")))
		Lat min (°): $(Child(TextField(default = "5.0")))
		Lat max (°): $(Child(TextField(default = "10.0")))
		"""
	end
end

# ╔═╡ ba5a8ecc-14d6-4175-aa47-a9dc740e9dc0
begin
	@bind n_clumps_xy PlutoUI.combine() do Child
		md"""
		N clumps x: $(Child(TextField(default = "5")))
		N clumps y: $(Child(TextField(default = "5")))
		"""
	end
end

# ╔═╡ c2b42438-72c0-48a5-8a50-4d9bbbb77841
md"""
## Clump Parameters
"""

# ╔═╡ 063d5ec4-b8b7-44bd-af6b-50731140f397
begin
	@bind clump_parameters PlutoUI.combine() do Child
		md"""
		δ [unitless]: $(Child(TextField(default = "1.25")))
		
		a [km]: $(Child(TextField(default = "1.0e-4")))
		
		Stokes drift coefficient [unitless]: $(Child(TextField(default = "0.0")))

		α [unitless]: $(Child(TextField(default = ""))) Force? (apply this α regardless of δ, a) $(Child(CheckBox(default = false)))

		τ [d]: $(Child(TextField(default = ""))) Force? (apply this τ regardless of δ, a) $(Child(CheckBox(default = false)))

		"""
	end
end

# ╔═╡ f3a4587e-5f83-4a34-be92-088156b1aead
md"""
## Spring Parameters
"""

# ╔═╡ 3021ee5c-86c0-4e0e-8e71-7c4120e5daab
begin
	@bind spring_parameters PlutoUI.combine() do Child
		md"""
		Type: $(Child(Select(["BOMB", "Hooke"], default = "BOMB")))
		
		k: $(Child(TextField(default = "1.00")))
		"""
	end
end

# ╔═╡ 9ea221d8-66c4-464d-b568-14da81d54834
md"""
### Info

The natural length of the spring is chosen dynamically based on initial conditions.

- "BOMB": $k(x) = k (1 + \exp((x - 2L)/0.2))^{-1}$ where $L$ is the natural length of the spring.

- "Hooke": $k(x) = k$
"""

# ╔═╡ dabd0dc5-da02-48db-a8d8-732b65d905bc
md"""
## Connections
"""

# ╔═╡ 4bc0ef76-4312-4d42-b5ac-c2b7312d98b4
begin
	@bind connections_parameters PlutoUI.combine() do Child
		md"""
		Type: $(Child(Select(["Full", "None", "Radius", "Nearest"], default = "Nearest")))
		
		Parameter: $(Child(TextField(default = "2")))
		"""
	end
end

# ╔═╡ 3d056344-77cf-4979-85e1-82a21ccf5a5e
md"""
### Info

- "Full": every clump is connected to every other clump and "parameter" has no effect.
- "None": no clumps are connected and "parameter" has no effect.
- "Radius": each clump is connected to each clump within a radius of `parameter * L`
- "Nearest": each clump is connected to its `parameter` nearest neighbors
"""

# ╔═╡ 9d9a3510-9101-4094-af0b-3b8a7af0276a
md"""
## Growth Death
"""

# ╔═╡ 5926d7fa-643b-4efc-b917-d1fd66da6a92
md"""
### Info

- "Immortal": clumps do not grow or die by biological effets. No parameters have any effect if this is selected.
- "Brooks": clumps grow and die according to the Brooks model.
  - μ max: Sargassum maximum growth rate.
  - m: Sargassum mortality rate.
  - k(N): Sargassum nitrogen (N) uptake half saturation.
  - clumps minimum: the number of clumps will not die below this value
  - clumps maximum: the number of clumps will not grow above this value (default twice the number of initial clumps)
"""

# ╔═╡ a170a7ae-d035-4a43-a658-0045334b4120
md"""
## Land
"""

# ╔═╡ 98c30e75-9461-4c76-813f-dbf6c7907068
begin
	@bind land_parameters PlutoUI.combine() do Child
		md"""
		Type: $(Child(Select(["Land", "NoLand"], default = "Land")))
		"""
	end
end

# ╔═╡ ad6620f6-6182-467e-a0b2-7b653b165e63
md"""
### Info

- "Land": clumps die when reaching land
- "NoLand": clumps do not die when reaching land
"""

# ╔═╡ f0590b8f-42a0-435d-a4fa-5f9cf206235a
md"""
# Plotting
"""

# ╔═╡ b72056b0-e8e6-4b56-a391-777e5734f016
md"""
### When this box is checked, you are in edit mode. This allows you to set parameters without updating the plot automatically. When the box is unchecked, you see any updates you've made, and any further updates will be computed automatically as they change.
Edit mode: $(@bind edit_mode CheckBox(default = true))
"""

# ╔═╡ c2eef4f9-d933-4e22-9853-7dd57330761e
md"""
## Plot (zoomable/pannable)
"""

# ╔═╡ d512eee1-890c-40ce-ab0e-54d1004ad5d2
# Spacer
md"""
\
\
\
\
\
\
\
\
\
\
"""

# ╔═╡ b42dfa74-5bce-4682-aa40-6e828ed08581
md"""
# Calculations (don't edit past here unless you know what you're doing 😀)
"""

# ╔═╡ 65b2ceb8-40d4-4f97-9541-36e0023c5d6b
md"""
## Initial Conditions
"""

# ╔═╡ 0b703706-bea8-442d-9acc-3c15fa9bbf0b
md"""
### Rectangle
"""

# ╔═╡ 2c38594d-7d78-49d8-9597-0b723f56e76f
begin
	local t1, t2 = tspan_data .|> x -> DateTime(x, "yyyy-mm-dd") .|> datetime2time
	local tspan = (t1, t2)
	local cor = corners .|> x -> parse(Float64, x)
	local n_c_xy = n_clumps_xy .|> x -> parse(Int64, x)
	local x_range = range(cor[1], cor[2], length = n_c_xy[1])
	local y_range = range(cor[3], cor[4], length = n_c_xy[2])
	ics = InitialConditions(tspan, x_range, y_range, to_xy = true)
end

# ╔═╡ 49dbb6b4-8ee9-4477-9870-9783a0a86850
begin
	local n_max = string(Integer(2*ics.ics[1]))
	@bind gd_parameters PlutoUI.combine() do Child
		md"""
		Type: $(Child(Select(["Immortal", "Brooks"], default = "Immortal")))

		μ max [1/d]: $(Child(TextField(default = "0.1")))
		m [1/d]: $(Child(TextField(default = "0.05")))
		k(N) [mmol N/m^3]: $(Child(TextField(default = "0.012")))
		
		clumps minimum: $(Child(TextField(default = "0")))
		clumps maximum: $(Child(TextField(default = n_max)))
		"""
	end
end

# ╔═╡ 536953f0-580f-4461-a9e5-2a27131e7b92
md"""
### AFAI Distribution
"""

# ╔═╡ 63f15c7e-91e0-4153-baf1-aa1dd25c13b6
# TODO
# ics = InitialConditions(tspan, dist_initial, [initial_time[3]], n_levels, "levels")

# ╔═╡ 8ba55d2d-53fa-4206-872c-0470e76fcf6b
md"""
## Clump Parameters
"""

# ╔═╡ 8c14a852-3bd4-4dda-b812-6c1378d676d5
begin
	local δ, a, σ, α, force_α, τ, force_τ = clump_parameters
	δ, a, σ = (δ, a, σ) .|> x -> parse(Float64, x)
	clumps = ClumpParameters(δ = δ, a = a, σ = σ)

	if force_α && α != ""
		α = parse(Float64, α)
		clumps = ClumpParameters(α, clumps.τ, clumps.R, clumps.f, clumps.σ)
	end

	if force_τ && τ != ""
		τ = parse(Float64, τ)
		clumps = ClumpParameters(clumps.α, τ, clumps.R, clumps.f, clumps.σ)
	end

	clumps
end

# ╔═╡ 943f8d1a-335a-4321-8d2b-b29e5ca5845c
md"""
## Springs
"""

# ╔═╡ 4430e3f8-ee7d-46ab-a98a-573db7815670
begin
	local spring_type, amplitude = spring_parameters
	local amplitude = parse(Float64, amplitude)

	if spring_type == "BOMB"
		springs = BOMBSpring(amplitude, ΔL(ics))
	elseif spring_type == "Constant"
		springs = HookeSpring(amplitude, ΔL(ics))
	end
end

# ╔═╡ cac6046f-0d45-4f1a-b062-b8cc53044807
md"""
## Connections
"""

# ╔═╡ 7f4daf85-2b36-4450-bf48-a4d77b4d4af3
begin
	local conn_type, param = connections_parameters

	if conn_type == "None"
		connections = ConnectionsNone()
	elseif conn_type == "Full"
		connections = ConnectionsFull()
	elseif conn_type == "Nearest"
		local param = parse(Int64, param)
		connections = ConnectionsNearest(param)
	elseif conn_type == "Radius"
		local param = parse(Int64, param)*ΔL(ics)
		connections = ConnectionsRadius(param)
	end
end

# ╔═╡ 8e250f3e-e5b9-4c76-9eac-39a4a60ded57
md"""
## Growth and Death
"""

# ╔═╡ dc6651a1-4c47-4cd7-a831-f37812e8a8e6
begin
	local gd_type, μ_max, m, K_N, c_min, c_max = gd_parameters
	if gd_type == "Immortal"
        gd_model = ImmortalModel()
	elseif gd_type == "Brooks"
		local μ_max, m, K_N = (μ_max, m, K_N) .|> x -> parse(Float64, x)
		local c_min, c_max = (c_min, c_max) .|> x -> parse(Int64, x)
        local bmp = BrooksModelParameters(
			TEMPERATURE_ITP.x, 
			NUTRIENTS_ITP.x, 
            clumps_limits = (c_min, c_max), # the number of clumps can at most double
            μ_max = μ_max,
            m = m,
            k_N = k_N)
        gd_model = BrooksModel(params = bmp)
    end
	gd_model
end

# ╔═╡ 7aea397d-a1b3-4e2d-a265-3b528762415c
md"""
## Land
"""

# ╔═╡ 4568d0b9-e6a2-4653-abc5-44e229cc3ded
begin
	if land_parameters[1] == "Land"
		land = Land()
	elseif land_parameters[1] == "NoLand"
		land = NoLand()
	end
	land
end

# ╔═╡ fb9970b9-25a9-4235-a01c-5f4b6b2b2580
md"""
# Integration
"""

# ╔═╡ 4c0ac1c0-13a8-4492-aaa1-2e071572da74
begin
	if !edit_mode
		rp = RaftParameters(
	        ics = ics,
	        clumps = clumps,
	        springs = springs,
	        connections = connections,
	        gd_model = gd_model,
	        land = land
	    )
	
	    sol = simulate(rp, showprogress = false)
	end
end

# ╔═╡ e25ab537-8be8-46e1-9b8c-e9c1f8a4dc30
begin
	if edit_mode
		"You are in edit mode, uncheck the box to see the plot."
	else
		fig = Figure(size = (800, 400), figure_padding = (10, 40, 10, 10))
		ax = geo_axis(fig[1, 1], limits = (-100, -40, 0, 40), title = "", labelscale = 0.5)
		trajectory!(ax, sol)
		land!(ax)
		fig
	end
end

# ╔═╡ Cell order:
# ╟─5aaaa4b6-cf8f-4a6c-8ae7-c6aeb3745dae
# ╟─174f180c-642c-46e4-976b-89ad6f99c962
# ╠═66e144d6-dcbb-11ee-26f3-b36ae4be3693
# ╠═32bd8970-a2f8-478b-ab48-4fbd1bcf735b
# ╟─c3eddd51-43c4-42f4-800a-ae9945df1e86
# ╟─71f616dd-c637-4039-85d4-04bc5fdd8662
# ╟─618ddac0-4a20-4146-8abd-761a97a451a6
# ╟─09d66d39-007b-4b0f-90bb-d3d36b85396c
# ╟─7dd77f5a-fdeb-4811-94c5-8066cf1bda3e
# ╟─ed4f082b-237c-4b08-b3b9-2f1846b0ecfb
# ╟─ba5a8ecc-14d6-4175-aa47-a9dc740e9dc0
# ╟─c2b42438-72c0-48a5-8a50-4d9bbbb77841
# ╟─063d5ec4-b8b7-44bd-af6b-50731140f397
# ╟─f3a4587e-5f83-4a34-be92-088156b1aead
# ╟─3021ee5c-86c0-4e0e-8e71-7c4120e5daab
# ╟─9ea221d8-66c4-464d-b568-14da81d54834
# ╟─dabd0dc5-da02-48db-a8d8-732b65d905bc
# ╟─4bc0ef76-4312-4d42-b5ac-c2b7312d98b4
# ╟─3d056344-77cf-4979-85e1-82a21ccf5a5e
# ╟─9d9a3510-9101-4094-af0b-3b8a7af0276a
# ╟─49dbb6b4-8ee9-4477-9870-9783a0a86850
# ╟─5926d7fa-643b-4efc-b917-d1fd66da6a92
# ╟─a170a7ae-d035-4a43-a658-0045334b4120
# ╟─98c30e75-9461-4c76-813f-dbf6c7907068
# ╟─ad6620f6-6182-467e-a0b2-7b653b165e63
# ╟─f0590b8f-42a0-435d-a4fa-5f9cf206235a
# ╟─b72056b0-e8e6-4b56-a391-777e5734f016
# ╟─c2eef4f9-d933-4e22-9853-7dd57330761e
# ╟─e25ab537-8be8-46e1-9b8c-e9c1f8a4dc30
# ╟─d512eee1-890c-40ce-ab0e-54d1004ad5d2
# ╟─b42dfa74-5bce-4682-aa40-6e828ed08581
# ╟─65b2ceb8-40d4-4f97-9541-36e0023c5d6b
# ╟─0b703706-bea8-442d-9acc-3c15fa9bbf0b
# ╟─2c38594d-7d78-49d8-9597-0b723f56e76f
# ╟─536953f0-580f-4461-a9e5-2a27131e7b92
# ╠═63f15c7e-91e0-4153-baf1-aa1dd25c13b6
# ╟─8ba55d2d-53fa-4206-872c-0470e76fcf6b
# ╟─8c14a852-3bd4-4dda-b812-6c1378d676d5
# ╟─943f8d1a-335a-4321-8d2b-b29e5ca5845c
# ╟─4430e3f8-ee7d-46ab-a98a-573db7815670
# ╟─cac6046f-0d45-4f1a-b062-b8cc53044807
# ╟─7f4daf85-2b36-4450-bf48-a4d77b4d4af3
# ╟─8e250f3e-e5b9-4c76-9eac-39a4a60ded57
# ╟─dc6651a1-4c47-4cd7-a831-f37812e8a8e6
# ╟─7aea397d-a1b3-4e2d-a265-3b528762415c
# ╟─4568d0b9-e6a2-4653-abc5-44e229cc3ded
# ╟─fb9970b9-25a9-4235-a01c-5f4b6b2b2580
# ╟─4c0ac1c0-13a8-4492-aaa1-2e071572da74
