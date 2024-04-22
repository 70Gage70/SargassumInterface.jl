### A Pluto.jl notebook ###
# v0.19.41

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

# ╔═╡ 589f251d-a2df-4879-9933-4deb95a8003a
begin
    import Pkg
    Pkg.activate(joinpath(@__DIR__, ".."))
	Pkg.instantiate()
end

# ╔═╡ d1565b62-ce6e-4e07-a041-f15e4fcc118b
begin
	using SargassumBOMB
	using SargassumFromAFAI
	using SargassumColors
	using GLMakie
	using Dates
	using PlutoUI, HypertextLiteral
	@info "Loaded dependencies."
end

# ╔═╡ 7573642c-d0c4-4f44-bd21-c0c7cd0abf2a


# ╔═╡ c3eddd51-43c4-42f4-800a-ae9945df1e86
md"""
---
---
"""

# ╔═╡ 81769b34-5373-43fe-88ef-82bb3a714ff6
md"""
---
"""

# ╔═╡ 3770ede8-77e4-47e3-bb70-6fd4d486d0b7
md"""
---
"""

# ╔═╡ e0d8925d-cc12-4a72-a383-93f07cb3d495
md"""
---
"""

# ╔═╡ 9b647b4f-233f-4795-8760-7472eeea422d
md"""
---
"""

# ╔═╡ df24d7ca-2143-481d-80fe-b8f31f0a3bb8
md"""
---
"""

# ╔═╡ 66c7f34f-378d-4a37-a112-5032c4cf07a4
md"""
---
---
"""

# ╔═╡ 4fddac82-52f3-464f-874f-056e8f165ba0
# Spacer
md"""
\
\
\
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

# ╔═╡ f6b36bcc-5162-4d84-a1a2-9cb3ff0e8ac1
md"""
# Interface Engine
"""

# ╔═╡ ea2ec22b-69ab-40d6-b8ea-704e4e6c3de8
md"""
!!! danger "Danger Zone!"
	\
	\
	**Don't edit anything after this point unless you know what you're doing!** 😀
	\
	\
	\
"""

# ╔═╡ 10a16ae5-044a-47e2-8964-13b334f5d0a8
md"""
## Front Matter
"""

# ╔═╡ 1b874c8c-08dd-4064-9afc-d62b2e900921
begin
	@info "Setting notebook width."
	html"""
	<style>
		main {
			margin: 0 auto;
			max-width: 2000px;
	    	padding-left: 31%;
	    	padding-right: 20%;
		}
	</style>
	"""
end

# ╔═╡ 8638b7a5-1ee0-47d2-aa6b-54cc9ab996ff
begin

@info "Hiding header"

html"""
<style>
    header {
		display:none
    }
</style>
"""
end

# ╔═╡ 7ca9e647-d06e-4815-b30b-eb1a4e5f1577
md"""
## Simulation
"""

# ╔═╡ 65b2ceb8-40d4-4f97-9541-36e0023c5d6b
md"""
### Initial Conditions
"""

# ╔═╡ 8ba55d2d-53fa-4206-872c-0470e76fcf6b
md"""
### Clump Parameters
"""

# ╔═╡ 943f8d1a-335a-4321-8d2b-b29e5ca5845c
md"""
### Springs
"""

# ╔═╡ cac6046f-0d45-4f1a-b062-b8cc53044807
md"""
### Connections
"""

# ╔═╡ 8e250f3e-e5b9-4c76-9eac-39a4a60ded57
md"""
### Growth and Death
"""

# ╔═╡ 7aea397d-a1b3-4e2d-a265-3b528762415c
md"""
### Land
"""

# ╔═╡ fb9970b9-25a9-4235-a01c-5f4b6b2b2580
md"""
### Integration
"""

# ╔═╡ 7d0b8d87-d783-467b-8240-deaa2e88963d
md"""
## Display
"""

# ╔═╡ 58d3a9da-c4df-4ec3-953e-1946495945bc
begin
	@info "Defining inspected plot options."
	
	local ui_inspect_plot(Child) = md"""
		Plot type: $(Child(Select(["Trajectories", "Heat Map"], default = "Trajectories"))) \
		Lon min: $(Child(TextField(4, default = "-100"))) Lon max: $(Child(TextField(4, default = "-40"))) \
		Lat min: $(Child(TextField(4, default = "0"))) Lat max: $(Child(TextField(4, default = "40")))
		\
		\
		"""
	global plot_window = @bind plot_params confirm(PlutoUI.combine() do Child
		ui_inspect_plot(Child)
	end,
	label = "APPLY")

	nothing
end

# ╔═╡ c29585d8-885c-4b5a-b530-9d34ec8daeb2
md"""
### Sargassum Distribution
"""

# ╔═╡ 154d4bd2-85c9-41dd-a68e-1f9028c55500
md"""
## Exporting
"""

# ╔═╡ e90936ec-f215-4a03-bd75-da2df6308ed0
md"""
## Utilities
"""

# ╔═╡ 67c5ed03-7e1b-4c4d-8fa1-837848a37924
ad(text, kind) = Markdown.MD(Markdown.Admonition(kind, "", [text]))

# ╔═╡ b503b1ff-18b5-46b9-9809-88b54240a762
begin
	local blurb = md"""
	This is the interface to the [SargassumBOMB.jl](https://github.com/70Gage70/SargassumBOMB.jl) package and companion packages.

	All of the integration parameters are set in this column. Scroll down to see them all, and click the `HELP` boxes for further explanation. At the bottom, there is a section for warnings. If things aren't working, check there.

	The main integration plot is displayed on the upper left of the screen. When parameters are changed, the plot is hidden. When you are done changing parameters, click `Run simulation` to recompute the plot.

	After a plot is created, a new button will appear labeled `Inspect/export`. This will open up a much larger view of the plot along with some further parameters to edit and an interface for exporting your simulation data.

	At the bottom left of the screen, the AFAI-derived satellite data can be viewed by checking `Show satellite data` and setting the desired date and plot parameters. Currently, only select months from 2017 and 2018 are available.
	"""

	local blurb2 = md"""
	# SargassumBOMB Interface
	$(details("Click me for tutorial!", blurb))
	"""
	
	ad(blurb2, "tip")
end

# ╔═╡ 8f0df9e4-3cc9-4265-9727-14bd7cf4497f
begin
	local blurb = md"""
	These settings control the initial locations of clumps.

	The time span sets the initial and final times through which the integration is performed. Then, one of two types of initial position distributions can be chosen.
	
	- `"Rectangle"`: Clumps are initialized in a rectangle inside the defined latitude/longitude box with `N clumps x` in the x direction and `N clumps y` in the y direction.
	
	- `"AFAI"`: Clumps are initialized according to the Sargassum distribution at the indicated date and week. `Levels` is related to the total number of clumps; the higher it is, the closer the initialized distribution is to the actual distribution.
	"""
	ad(
		md""" 
		## Initial Conditions 
		$(details("HELP", blurb))""", 
	"tip")
end

# ╔═╡ ebc20b02-83d5-4b94-ae76-16a1bd619312
begin
	local ui_tspan(Child) = md"""
		### Integration time span
		Start date (yyyy-mm-dd): $(Child(TextField(default = "2018-04-07"))) \
		End date (yyyy-mm-dd): $(Child(TextField(default = "2018-04-14")))
		"""
	@bind tspan_data PlutoUI.combine() do Child
		ad(ui_tspan(Child), "info")
	end
end

# ╔═╡ 62907762-cad8-483f-9dd1-5907c43b49ab
begin
		
	local blurb = md"""
		### Initial conditions type: $(@bind ics_type Select(["Rectangle", "AFAI"], default = "AFAI"))
		"""
	ad(blurb, "info")

end

# ╔═╡ ed4f082b-237c-4b08-b3b9-2f1846b0ecfb
begin
	if ics_type == "Rectangle"
		
	local ui_rect(Child) = md"""
		### Rectangular distribution parameters
		Lon min ( ° ): $(Child(TextField(default = "-55.0")))
		Lon max ( ° ): $(Child(TextField(default = "-50.0"))) \
		Lat min ( ° ): $(Child(TextField(default = "5.0")))
		Lat max ( ° ): $(Child(TextField(default = "10.0"))) \
		N clumps x: $(Child(TextField(default = "5")))
		N clumps y: $(Child(TextField(default = "5")))
		"""
	@bind rect_params PlutoUI.combine() do Child
		ad(ui_rect(Child), "info")
	end
		
	end # if
end

# ╔═╡ c75d9b70-d3bb-41fe-84bf-53c0ab41f406
begin
	if ics_type == "AFAI"

	local ui_afai(Child) = md"""
		### AFAI-based initial distribution parameters
		Date (yyyy-mm): $(Child(TextField(default = "2018-04"))) \
		Week: $(Child(Select(["1", "2", "3", "4"], default = "1"))) \
		Levels: $(Child(TextField(default = "10")))
		"""
	@bind afai_params PlutoUI.combine() do Child
		ad(ui_afai(Child), "info")
	end
		
	end # if
end

# ╔═╡ 2c38594d-7d78-49d8-9597-0b723f56e76f
begin
	if ics_type == "Rectangle"
		local t1, t2 = tspan_data .|> x -> DateTime(x, "yyyy-mm-dd") .|> datetime2time
		local tspan = (t1, t2)
		local cor = rect_params[1:4] .|> x -> parse(Float64, x)
		local n_c_xy = rect_params[5:6] .|> x -> parse(Int64, x)
		local x_range = range(cor[1], cor[2], length = n_c_xy[1])
		local y_range = range(cor[3], cor[4], length = n_c_xy[2])
		ics = InitialConditions(tspan, x_range, y_range, to_xy = true)
	elseif ics_type == "AFAI"
		local t1, t2 = tspan_data .|> x -> DateTime(x, "yyyy-mm-dd") .|> datetime2time
		local tspan = (t1, t2)
		local date, week, levels = afai_params
		local date = DateTime(date, "yyyy-mm") |> yearmonth
		local week = parse(Int64, week)
		local levels = parse(Int64, levels)
		local dist = SargassumFromAFAI.DIST_1718[date]
		ics = InitialConditions(tspan, dist, [week], levels, "levels")
	end
end

# ╔═╡ a644a9ff-9cf2-4121-a764-ea2e3cbb76d9
try
	ad(md"""**Total clumps: $(n_clumps(ics.ics))**""", "info")
catch
	ad(md"""**Total clumps: ERROR**""", "info")
end

# ╔═╡ 75898dc7-beec-4c4d-8580-79ec1df8cc42
begin
	local blurb = md"""
	These settings control the physics parameters for each clump.
	
	- ``\delta``: The buoyancy of the clump, where $\delta \geq 1$.
	- ``a``: The radius of the (assumed spherical) clump.
	- ``\sigma``: The prefactor multiplying the Stokes drift.
	- ``\alpha``: The "leeway" parameter. Depends on ``\delta`` in general, select the `"Force"` checkbox to ignore this dependence.
	- ``\tau``: The inertial response time. Depends on ``\delta`` and ``a`` in general, select the `"Force"` checkbox to ignore this dependence.
	"""
	ad(
		md""" 
		## Clump Parameters
		$(details("HELP", blurb))""", 
	"tip")
end

# ╔═╡ 489fe878-3ac1-4e18-a185-7d4f1f6679d0
begin
	local ui_clump(Child) = md"""
		``\delta`` [``\cdot``]: $(Child(TextField(default = "1.25"))) \
		``a`` [``\text{km}``]: $(Child(TextField(default = "1.0e-4"))) \
		``\sigma`` [``\cdot``]: $(Child(TextField(default = "0.0"))) \
		``\alpha`` [``\cdot``]: $(Child(TextField(default = ""))) Force? (apply this ``\alpha`` regardless of ``\delta``) $(Child(CheckBox(default = false))) \
		``\tau`` [``\text{d}``]: $(Child(TextField(default = ""))) Force? (apply this ``\tau`` regardless of ``\delta`` and  ``a``) $(Child(CheckBox(default = false))) \
		"""
	@bind clump_parameters PlutoUI.combine() do Child
		ad(ui_clump(Child), "info")
	end
end

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

# ╔═╡ 6bda3ba9-fbba-4ce5-8a23-0c606845b31a
begin
	local blurb = md"""
	These settings control the physics parameters for the springs connecting paris of clumps.

	The natural length of the spring is chosen dynamically based on initial conditions.
	
	- `"BOMB"`: Has a stiffness function ``k(x) = k (1 + \exp((x - 2L)/0.2))^{-1}`` where ``L`` is the natural length of the spring.
	- `"Hooke"`: Has a stiffness function ``k(x) = k``.
	"""
	ad(
		md""" 
		## Spring Parameters
		$(details("HELP", blurb))""", 
	"tip")
end

# ╔═╡ 7d5f16a6-9ce9-45c0-9483-24f44a23bd45
begin
	local ui_springs(Child) = md"""
		Type: $(Child(Select(["BOMB", "Hooke"], default = "BOMB"))) \
		``k`` [``\text{d}^{-2}``]: $(Child(TextField(default = "1.00")))
		"""
	@bind spring_parameters PlutoUI.combine() do Child
		ad(ui_springs(Child), "info")
	end
end

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

# ╔═╡ c60bb5f5-82b7-484c-b56b-ded74a1e651f
begin
	local blurb = md"""
	These settings control the logic that determines how clumps are connected by springs.

	- `"Full"`: every clump is connected to every other clump.
	- `"None"`: no clumps are connected.
	- `"Radius"`: each clump is connected to each clump within a radius of `Radius multiple` multipled by the natural length of the spring.
	- `"Nearest"`: each clump is connected to a number of its nearest neighbors.
	"""
	ad(
		md""" 
		## Connections
		$(details("HELP", blurb))""", 
	"tip")
end

# ╔═╡ e1fd0825-6b16-4fb6-9358-4252b1bd77e9
begin
		
	local blurb = md"""
		### Connections Type: $(@bind conn_type Select(["Full", "None", "Radius", "Nearest"], default = "Nearest"))
		"""
	ad(blurb, "info")

end

# ╔═╡ 3b123c70-d3b9-4b3d-8c38-f4d3457f079d
begin
	if conn_type == "Nearest"
		
		local ui_conn_nearest(Child) = md"""
			Number of neighbors: $(Child(TextField(default = "2")))
			"""
		@bind conn_params PlutoUI.combine() do Child
			ad(ui_conn_nearest(Child), "info")
		end

	elseif conn_type == "Radius"

		local ui_conn_radius(Child) = md"""
			Radius multiple: $(Child(TextField(default = "2.0")))
			"""
		@bind conn_params PlutoUI.combine() do Child
			ad(ui_conn_radius(Child), "info")
		end

	else 
		conn_params = (nothing,)
		nothing
	end # if
end

# ╔═╡ 7f4daf85-2b36-4450-bf48-a4d77b4d4af3
begin
	if conn_type == "None"
		connections = ConnectionsNone()
	elseif conn_type == "Full"
		connections = ConnectionsFull()
	elseif conn_type == "Nearest"
		local param = parse(Int64, conn_params[1])
		connections = ConnectionsNearest(param)
	elseif conn_type == "Radius"
		local param = parse(Float64, conn_params[1])*ΔL(ics)
		connections = ConnectionsRadius(param)
	end
end

# ╔═╡ 5bdbce07-0f50-459f-8ea6-6bb670aea47d
begin
	local blurb = md"""
	These settings control the biology parameters for the lifecyles model.

	There are two models, `"Immortal"` and `"Brooks"`. 
	
	The `"Immortal"` model has no parameters, and no clumps with grow or die by biological effects. 
	
	The `"Brooks"` model has the following parameters:
	
	- ``\mu_\text{max}``: Sargassum maximum growth rate.
	- ``m``: Sargassum mortality rate.
	- ``k_\text{N}``: Sargassum nitrogen (N) uptake half saturation.
	- `"clumps minimum"`: the number of clumps will not die below this value (default half the number of initial clumps).
	- `"clumps maximum"`: the number of clumps will not grow above this value (default twice the number of initial clumps).
	"""
	ad(
		md""" 
		## Biology
		$(details("HELP", blurb))""", 
	"tip")
end

# ╔═╡ 61ebe90a-60e9-4e77-9a24-a793e4701209
begin
		
	local blurb = md"""
		### Life Cycles Model: $(@bind gd_type Select(["Immortal", "Brooks"], default = "Immortal"))
		"""
	ad(blurb, "info")

end

# ╔═╡ dd199ecb-16cf-4e58-8918-64077b6c192c
begin
	if gd_type == "Immortal"
		
		gd_params = (nothing,)
		nothing

	elseif gd_type == "Brooks"
		local n_min = string(floor(Int64, n_clumps(ics.ics)/2))
		local n_max = string(floor(Int64, 2*n_clumps(ics.ics)))
		local ui_gd_brooks(Child) = md"""
			``\mu_\text{max}`` [``\text{d}^{-1}``]: $(Child(TextField(default = "0.1"))) \
			``m`` [``\text{d}^{-1}``]: $(Child(TextField(default = "0.05"))) \
			``k_\text{N}`` [``\text{mmol N m}^{-3}``]: $(Child(TextField(default = "0.012"))) \
			`clumps minimum`: $(Child(TextField(default = n_min))) \
			`clumps maximum`: $(Child(TextField(default = n_max)))
			"""
		@bind gd_params PlutoUI.combine() do Child
			ad(ui_gd_brooks(Child), "info")
		end

	else 
		gd_params = (nothing,)
		nothing
	end # if
end

# ╔═╡ da645592-41d8-4212-8ca0-241923f2dc14
begin
	warnings_q = false
	
	# check if requested times are within range
	local t1 = parse(DateTime, tspan_data[1])
	local t2 = parse(DateTime, tspan_data[2])

	local ts = [
		WATER_ITP.x.dims[:t], WIND_ITP.x.dims[:t], 
		STOKES_ITP.x.dims[:t], WAVES_ITP.x.dims[:t], 
		NUTRIENTS_ITP.x.dims[:t], TEMPERATURE_ITP.x.dims[:t]]
	local names = ["WATER", "WIND", "STOKES", "WAVES", "NUTRIENTS", "TEMPERATURE", "LAND"]
	
	for i = 1:length(ts)
		local tspan = ts[i] |> x -> (x[1], x[end]) .|> time2datetime
		if !(tspan[1] <= t1 <= tspan[2]) || !(tspan[1] <= t2 <= tspan[2])
			@warn "Requested timespan is outside the range of $(names[i])."
			global warnings_q = true
		end
	end

	# check rectangular parameters
	if ics_type == "Rectangle"
		local lonslats = [
			xy2sph(WATER_ITP.x.dims[:x], WATER_ITP.x.dims[:y]),
			xy2sph(WIND_ITP.x.dims[:x], WIND_ITP.x.dims[:y]),
			xy2sph(STOKES_ITP.x.dims[:x], STOKES_ITP.x.dims[:y]),
			xy2sph(WAVES_ITP.x.dims[:x], WAVES_ITP.x.dims[:y]),
			xy2sph(NUTRIENTS_ITP.x.dims[:x], NUTRIENTS_ITP.x.dims[:y]),
			xy2sph(TEMPERATURE_ITP.x.dims[:x], TEMPERATURE_ITP.x.dims[:y]),
			xy2sph(LAND_ITP.x.dims[:x], LAND_ITP.x.dims[:y])]
		local names = ["WATER", "WIND", "STOKES", "WAVES", "NUTRIENTS", "TEMPERATURE"]
		local cor = rect_params[1:4] .|> x -> parse(Float64, x)
		
		for i = 1:length(lonslats)
			local lonlat = (lonslats[i][1][1], lonslats[i][2][end])
			if !all(lonlat[1] .<= cor .<= lonlat[2])
				@warn "Requested position is outside the range of $(names[i])."
				global warnings_q = true
			end
		end
	
		try 
			local n_c_xy = rect_params[5:6] .|> x -> parse(Int64, x)
			if (n_c_xy[1] <= 0) || (n_c_xy[2] <= 0)
				@warn "`N clumps x` and `y` should both be positive"
				global warnings_q = true
			end
		catch
			@warn "`N clumps x` or `y` could not be parsed as an integer."
			global warnings_q = true
		end
	end

	# check afai parameters
	if ics_type == "AFAI"
		local date, levels = afai_params
		local date = DateTime(date, "yyyy-mm") |> yearmonth
		if !(date in keys(SargassumFromAFAI.DIST_1718))
			@warn "The AFAI distribution at this date is not one of the pre-computed distributions (2017 - 2018, months where available)."
			global warnings_q = true
		end

		try 
			levels = levels |> x -> parse(Int64, x)
			if levels <= 0
				@warn "`Levels` should be positive"
				global warnings_q = true
			end
		catch
			@warn "`Levels` could not be parsed as an integer."
			global warnings_q = true
		end
	end

	# check clump parameters
	local δ, a, σ, α, force_α, τ, force_τ = clump_parameters
	local δ, a, σ = (δ, a, σ) .|> x -> parse(Float64, x)
	if !(1.0 <= δ <= 5.0)
		@warn "δ should definitely be at least 1.0 and generally should not be larger than 5"
		global warnings_q = true
	end
	if !(0.0 <= a <= 1.0e-2)
		@warn "δ should definitely be at least 0.0 and generally should not be larger than 0.01"
		global warnings_q = true
	end
	if !(0.0 <= σ <= 2.0)
		@warn "σ should definitely be at least 0.0 and generally should not be larger than 2.0"
		global warnings_q = true
	end
	if force_α && !(0.0 <= α <= 0.05)
		@warn "α should definitely be at least 0.0 and generally should not be larger than 0.05"
		global warnings_q = true
	end
	if force_τ && !(0.0 <= τ <= 0.5)
		@warn "α should definitely be at least 0.0 and generally should not be larger than 0.5"
		global warnings_q = true
	end

	# check spring parameters
	local spring_type, amplitude = spring_parameters
	local amplitude = parse(Float64, amplitude)
	if !(0.0 <= amplitude)
		@warn "Spring amplitude should definitely be at least 0.0."
		global warnings_q = true
	end

	# check connections parameters
	if conn_type == "Nearest"
		try
			local param = parse(Int64, conn_params[1])
			if !(0.0 <= param)
				@warn "Spring parameter should definitely be at least 0.0."
				global warnings_q = true
			end
		catch e
			@warn "Could not parse the spring parameter (number of nearest neighbors) as an integer."
			global warnings_q = true
		end

	elseif conn_type == "Radius"
		local param = parse(Float64, conn_params[1])
		if !(0.0 <= param)
			@warn "Spring parameter should definitely be at least 0.0."
			global warnings_q = true
		end
	end

	# check growth/death parameters
	if gd_type == "Brooks"
		local μ_max, m, K_N, c_min, c_max = gd_params
		local μ_max, m, K_N = (μ_max, m, K_N) .|> x -> parse(Float64, x)
		

		if !all(0 .<= [μ_max, m, K_N])
			@warn "Brooks parameters should definitely be at least 0.0."
			global warnings_q = true
		end

		try 
			c_min, c_max = (c_min, c_max) .|> x -> parse(Int64, x)
			if (c_min > c_max) || c_min < 0 || c_max < 0
				@warn "Clumps limits should be positive and the minimum should be less than the maximum."
			end

		catch
			@warn "Could not parse the clump limits as integers."
		end
    end
	
	nothing
end

# ╔═╡ dc6651a1-4c47-4cd7-a831-f37812e8a8e6
begin
	if gd_type == "Immortal"
        gd_model = ImmortalModel(ics)
	elseif gd_type == "Brooks"
		local μ_max, m, k_N, c_min, c_max = gd_params
		local μ_max, m, k_N = (μ_max, m, k_N) .|> x -> parse(Float64, x)
		local c_min, c_max = (c_min, c_max) .|> x -> parse(Int64, x)
        local bmp = BrooksModelParameters(
            clumps_limits = (c_min, c_max), # the number of clumps can at most double
            μ_max = μ_max,
            m = m,
            k_N = k_N)
        gd_model = BrooksModel(ics, params = bmp)
    end
	gd_model
end

# ╔═╡ e537ca5d-86d6-423b-a3b9-d9ba503c4d31
begin
	local blurb = md"""
	These settings control how clumps interact with land/shorelines.

	There are two models, `"Land"` and `"NoLand"`. 
	
	In the `"Land"` model, clumps die when reaching land or hitting a shoreline. 

	In the `"NoLand"` model, clumps do not die when reaching land or hitting a shoreline. 
	"""
	ad(
		md""" 
		## Land
		$(details("HELP", blurb))""", 
	"tip")
end

# ╔═╡ 8a5827c1-8655-4808-8fe0-ff46fc25f982
begin
		
	local blurb = md"""
		### Land Model: $(@bind land_type Select(["Land", "NoLand"], default = "Land"))
		"""
	ad(blurb, "info")

end

# ╔═╡ 4568d0b9-e6a2-4653-abc5-44e229cc3ded
begin
	if land_type == "Land"
		land = Land()
	elseif land_type == "NoLand"
		land = NoLand()
	end
	land
end

# ╔═╡ 5401dc9a-a647-4722-b49d-21023b829cb3
ad(md""" # Warnings """, "warning")

# ╔═╡ 0eaba7b9-5bfc-44b3-a99a-8b240a952e02
begin
	if warnings_q == 0
		 ad(md"""No warnings!""", "tip")
	end
end

# ╔═╡ 084700f3-4f35-466f-91e1-f4853c426abf
begin
	@info "Defining notebook info box."

	local blurb = md"""
	This is a [Pluto notebook](https://plutojl.org/) powered by the [Julia programming language](https://julialang.org/).

	- [GitHub](https://github.com/70Gage70/SargassumInterface.jl)
	- [How to cite](https://github.com/70Gage70/SargassumInterface.jl)
	"""

	local blah = ad(
		details("ABOUT/CITE", [blurb], open = false), 
	"warning")
	
	@htl """<div style="
	position: fixed; 
	right: 1rem; 
	top: 1rem; 
	padding: 1px;
	text-align: left;
	z-index: 99;
	max-width: 18%;
	background-color: var(--main-bg-color);">
	$(blah)
	</div>"""
end

# ╔═╡ e25ab537-8be8-46e1-9b8c-e9c1f8a4dc30
begin
	@info "Defining reactive plot checkbox."
	ics;
	clumps;
	springs;
	connections;
	gd_model;
	land;
	
	local plot_box = ad(
	md"""
	Run simulation: $(@bind trigger_calculation CheckBox(default=false))
	""", 
	"danger")

	@htl """<div style="
	position: fixed; 
	left: 1rem; 
	top: 1rem; 
	padding: 1px;
	text-align: left;
	z-index: 100;
	max-width: 20%;
	max-height: 10%;
	background-color: var(--main-bg-color);">
	$(plot_box)
	</div>"""
end

# ╔═╡ d355db80-b403-4200-a4b4-a6eb6f13a79e
begin
	@info "Calculating integration."
	
	if trigger_calculation

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

# ╔═╡ 846659d3-e922-4aed-90ff-0cbab92b1639
begin

@info "Defining main plot + small window."
	
let
	try
		plot_type = plot_params[1]
		lon_min, lon_max, lat_min, lat_max = plot_params[2:5] .|> x -> parse(Float64, x)
		
		set_theme!(GEO_THEME())
		global fig = Figure(size = 2.0 .* (800, 400), figure_padding = (10, 70, 10, 20))
		ax = Axis(fig[1, 1], limits = (lon_min, lon_max, lat_min, lat_max), title = "")
		if plot_type == "Trajectories"
			trajectory!(ax, sol)
		elseif plot_type == "Heat Map"
			trajectory_hist!(ax, sol, SargassumFromAFAI.DIST_1718[(2018, 4)], 1, log_scale = true)
		end
		SargassumColors.land!(ax)
	catch
		global fig = ad(md"""The plot has not been generated yet or the integration parameters have changed.""", "warning")
	end

	@htl """<div style="
	position: fixed; 
	left: 1rem; 
	top: 6rem; 
	padding: 1px;
	text-align: left;
	z-index: 100;
	max-width: 27%;
	background-color: var(--main-bg-color);">
	$(fig)
	</div>"""
end
end

# ╔═╡ 78a2638f-f10e-443f-835e-0c8454981617
begin
	@info "Defining inspect plot trigger."
	
	global plot_box = ad(
	md"""
	Inspect/export: $(@bind inspect_plot CheckBox(default=false))
	""", 
	"danger")

	nothing
end

# ╔═╡ 76d7cff9-02ad-4841-8c50-dd3e50dcf1a4
begin

@info "Defining inspect plot trigger window."
	
if trigger_calculation

	@htl """<div style="
	position: fixed; 
	left: 12rem; 
	top: 1rem; 
	padding: 1px;
	text-align: left;
	z-index: 100;
	max-width: 20%;
	max-height: 10%;
	background-color: var(--main-bg-color);">
	$(plot_box)
	</div>"""
end
end

# ╔═╡ 32f6f7a5-19b7-4c71-9d0a-865d4f6d0506
begin

@info "Defining inspected plot background 1."
	
if inspect_plot && trigger_calculation

@htl """<div style="
position: fixed; 
left: 1rem; 
top: 6rem; 
padding: 1000px;
text-align: left;
z-index: 100;
max-width: 75%;
background-color: var(--main-bg-color);">
</div>"""

end
end

# ╔═╡ a9741ea1-32b7-477a-be23-a3f74fe8c359
begin

@info "Defining inspected plot background 2."
	
if inspect_plot && trigger_calculation

@htl """<div style="
position: fixed; 
right: 1rem; 
top: 0rem; 
padding: 35%;
text-align: left;
z-index: 100;
max-width: 20%;
background-color: var(--main-bg-color);">
</div>"""

end
end

# ╔═╡ b4a1e899-a142-4513-aa1b-3f65bcdd0b74
begin

@info "Defining inspected plot."
	
if inspect_plot && trigger_calculation

@htl """<div style="
position: fixed; 
left: 1rem; 
top: 6rem; 
padding: 1px;
text-align: left;
z-index: 101;
max-width: 75%;
background-color: var(--main-bg-color);">
$(fig)
</div>"""

end
end

# ╔═╡ e75adad7-7416-4962-9308-44e1425a8ff3
begin
	@info "Defining inspected plot options window."

	if inspect_plot && trigger_calculation
		@htl """<div style="
		position: fixed; 
		right: 1rem; 
		top: 6rem; 
		padding: 1px;
		text-align: left;
		z-index: 101;
		max-width: 20%;
		background-color: var(--main-bg-color);">
		$(ad(plot_window, "info"))
		</div>"""
	end
end

# ╔═╡ a7de95ce-62b9-40e6-a7f5-1d833bedff87
begin
	@info "Defining export options window."

	local export_details = md"""
	Select the `".mat"` type to export the raw trajectory data in [MATLAB's file format](https://www.mathworks.com/help/matlab/import_export/mat-file-versions.html). Choose this option if you want the most control over the data.

	Select the `".nc"` type to export binned trajectory data in a [NetCDF file format](https://github.com/JuliaGeo/NetCDF.jl). Choose this option if you primarily need distribution data.

	Select `".png"` to output the figure itself.
	"""
	
	local ui_integration_export(Child) = md"""
		$(details("EXPORT HELP", export_details))
		Directory \
		$(Child(TextField((30, 2), default = @__DIR__))) \
		Name
		$(Child(TextField(10, default = "my_file_name"))) \
		Export Type: $(Child(Select(["", ".mat", ".nc", ".png"], default = "")))
		"""

	try
		sol;
		
		export_blurb = @bind integration_export_parameters confirm(PlutoUI.combine() do Child
			 ui_integration_export(Child)
		end,
		label = "EXPORT")

		global export_options = ad(export_blurb, "info")
	catch
		nothing
	end
	
	if inspect_plot && trigger_calculation
		@htl """<div style="
		position: fixed; 
		right: 1rem; 
		top: 16rem; 
		padding: 1px;
		text-align: left;
		z-index: 101;
		max-width: 20%;
		background-color: var(--main-bg-color);">
		$(export_options)
		</div>"""
	end
end

# ╔═╡ 5fa34147-a71a-43bb-8f5f-689d830508b3
begin
	@info "Exporting"
	try
	
		local outfile = joinpath(integration_export_parameters[1], integration_export_parameters[2] * integration_export_parameters[3])

		if integration_export_parameters[3] == ".mat"
			rtr2mat(sol, outfile)
		elseif integration_export_parameters[3] == ".nc"
			rtr2nc(sol, outfile, range(-100.0, -40.0, length = 134), range(-100.0, -40.0, length = 64))
		elseif integration_export_parameters[3] == ".png"
			save(outfile, fig)
		end
	catch
		nothing
	end
end

# ╔═╡ d31c10fc-1d99-4d49-9a28-111b993d0936
begin
	@info "Defining AFAI parameter window."
	
	local ui_afai_plot(Child) = md"""
		Show satellite data: $(Child(CheckBox(default = false))) \
		Date (yyyy-mm): $(Child(confirm(TextField(5, default = "2018-04"), label = "SET"))) \
		Week: $(Child(Select(["1", "2", "3", "4"], default = "1"))) \
		Clouds: $(Child(Select(["Show", "Hide"], default = "Hide"))) \
		Scale: $(Child(Select(["Log", "Linear"], default = "Log"))) \
		"""
	local afai_params = @bind afai_plot_params PlutoUI.combine() do Child
		ad(ui_afai_plot(Child), "info")
	end

	@htl """<div style="
	position: fixed; 
	left: 1rem; 
	bottom: 3rem; 
	padding: 1px;
	text-align: left;
	z-index: 98;
	max-width: 24%;
	max-height: 20%;
	background-color: var(--main-bg-color);">
	$(afai_params)
	</div>"""
end

# ╔═╡ 4ff1d478-90de-42ad-af3c-7085cec44e41
begin

@info "Defining AFAI plot window."
	
let
if afai_plot_params[1]
	try
		set_theme!(GEO_THEME())
		global fig_afai = Figure(size = 2.0 .* (800, 400), figure_padding = (10, 70, 10, 20))
		ax_afai = Axis(fig_afai[1, 1], limits = (-100, -40, 0, 40), title = "")
		local date, week, clouds, scale = afai_plot_params[2:5]
		local date = DateTime(date, "yyyy-mm") |> yearmonth
		local week = parse(Int64, week)
		SargassumFromAFAI.sarg!(ax_afai, SargassumFromAFAI.DIST_1718[date], week, log_scale = scale == "Log")
		clouds == "Show" ? clouds!(ax_afai, SargassumFromAFAI.DIST_1718[date], week) : nothing
		SargassumColors.land!(ax_afai)
	catch
		global fig_afai = ad(md"""Date out of range! Currently certain months in 2017 and 2018 are supported.""", "warning")
	end

	@htl """<div style="
	position: fixed; 
	left: 1rem; 
	bottom: 10rem; 
	padding: 1px;
	text-align: center;
	z-index: 99;
	max-width: 27%;
	background-color: var(--main-bg-color);">
	$(fig_afai)
	</div>"""
end
end
end

# ╔═╡ Cell order:
# ╟─7573642c-d0c4-4f44-bd21-c0c7cd0abf2a
# ╟─b503b1ff-18b5-46b9-9809-88b54240a762
# ╟─c3eddd51-43c4-42f4-800a-ae9945df1e86
# ╟─8f0df9e4-3cc9-4265-9727-14bd7cf4497f
# ╟─ebc20b02-83d5-4b94-ae76-16a1bd619312
# ╟─62907762-cad8-483f-9dd1-5907c43b49ab
# ╟─ed4f082b-237c-4b08-b3b9-2f1846b0ecfb
# ╟─c75d9b70-d3bb-41fe-84bf-53c0ab41f406
# ╟─a644a9ff-9cf2-4121-a764-ea2e3cbb76d9
# ╟─81769b34-5373-43fe-88ef-82bb3a714ff6
# ╟─75898dc7-beec-4c4d-8580-79ec1df8cc42
# ╟─489fe878-3ac1-4e18-a185-7d4f1f6679d0
# ╟─3770ede8-77e4-47e3-bb70-6fd4d486d0b7
# ╟─6bda3ba9-fbba-4ce5-8a23-0c606845b31a
# ╟─7d5f16a6-9ce9-45c0-9483-24f44a23bd45
# ╟─e0d8925d-cc12-4a72-a383-93f07cb3d495
# ╟─c60bb5f5-82b7-484c-b56b-ded74a1e651f
# ╟─e1fd0825-6b16-4fb6-9358-4252b1bd77e9
# ╟─3b123c70-d3b9-4b3d-8c38-f4d3457f079d
# ╟─9b647b4f-233f-4795-8760-7472eeea422d
# ╟─5bdbce07-0f50-459f-8ea6-6bb670aea47d
# ╟─61ebe90a-60e9-4e77-9a24-a793e4701209
# ╟─dd199ecb-16cf-4e58-8918-64077b6c192c
# ╟─df24d7ca-2143-481d-80fe-b8f31f0a3bb8
# ╟─e537ca5d-86d6-423b-a3b9-d9ba503c4d31
# ╟─8a5827c1-8655-4808-8fe0-ff46fc25f982
# ╟─66c7f34f-378d-4a37-a112-5032c4cf07a4
# ╟─5401dc9a-a647-4722-b49d-21023b829cb3
# ╟─0eaba7b9-5bfc-44b3-a99a-8b240a952e02
# ╟─da645592-41d8-4212-8ca0-241923f2dc14
# ╟─4fddac82-52f3-464f-874f-056e8f165ba0
# ╟─d512eee1-890c-40ce-ab0e-54d1004ad5d2
# ╟─f6b36bcc-5162-4d84-a1a2-9cb3ff0e8ac1
# ╟─ea2ec22b-69ab-40d6-b8ea-704e4e6c3de8
# ╟─10a16ae5-044a-47e2-8964-13b334f5d0a8
# ╟─1b874c8c-08dd-4064-9afc-d62b2e900921
# ╟─8638b7a5-1ee0-47d2-aa6b-54cc9ab996ff
# ╟─084700f3-4f35-466f-91e1-f4853c426abf
# ╟─589f251d-a2df-4879-9933-4deb95a8003a
# ╟─d1565b62-ce6e-4e07-a041-f15e4fcc118b
# ╟─7ca9e647-d06e-4815-b30b-eb1a4e5f1577
# ╟─65b2ceb8-40d4-4f97-9541-36e0023c5d6b
# ╟─2c38594d-7d78-49d8-9597-0b723f56e76f
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
# ╟─d355db80-b403-4200-a4b4-a6eb6f13a79e
# ╟─7d0b8d87-d783-467b-8240-deaa2e88963d
# ╟─e25ab537-8be8-46e1-9b8c-e9c1f8a4dc30
# ╟─846659d3-e922-4aed-90ff-0cbab92b1639
# ╟─78a2638f-f10e-443f-835e-0c8454981617
# ╟─76d7cff9-02ad-4841-8c50-dd3e50dcf1a4
# ╟─32f6f7a5-19b7-4c71-9d0a-865d4f6d0506
# ╟─a9741ea1-32b7-477a-be23-a3f74fe8c359
# ╟─b4a1e899-a142-4513-aa1b-3f65bcdd0b74
# ╟─58d3a9da-c4df-4ec3-953e-1946495945bc
# ╟─e75adad7-7416-4962-9308-44e1425a8ff3
# ╟─a7de95ce-62b9-40e6-a7f5-1d833bedff87
# ╟─c29585d8-885c-4b5a-b530-9d34ec8daeb2
# ╟─d31c10fc-1d99-4d49-9a28-111b993d0936
# ╟─4ff1d478-90de-42ad-af3c-7085cec44e41
# ╟─154d4bd2-85c9-41dd-a68e-1f9028c55500
# ╟─5fa34147-a71a-43bb-8f5f-689d830508b3
# ╟─e90936ec-f215-4a03-bd75-da2df6308ed0
# ╟─67c5ed03-7e1b-4c4d-8fa1-837848a37924
