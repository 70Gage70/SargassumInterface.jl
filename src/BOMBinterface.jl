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
	using WGLMakie
	using Dates
	using PlutoUI
	@info "Loaded dependencies."
end

# ╔═╡ a5e1070c-5f0a-44b6-8a43-451ffce19e73
md"""
# Introduction
"""

# ╔═╡ b503b1ff-18b5-46b9-9809-88b54240a762
md"""
!!! danger ""
	This is the interface to the `SargassumBOMB.jl` package and companion packages.

	Be aware that the interface can take several minutes to load the first time it is opened.
"""

# ╔═╡ c3eddd51-43c4-42f4-800a-ae9945df1e86
md"""
# Main Interface
"""

# ╔═╡ 5401dc9a-a647-4722-b49d-21023b829cb3
md"""
# Warnings
"""

# ╔═╡ f0590b8f-42a0-435d-a4fa-5f9cf206235a
md"""
# Integration Plot
"""

# ╔═╡ 0f208a3b-54df-4788-9cfc-57d40ba90522
md"""
# Sargassum Distribution (from AFAI) Plot
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

# ╔═╡ f6b36bcc-5162-4d84-a1a2-9cb3ff0e8ac1
md"""
# Calculations
"""

# ╔═╡ ea2ec22b-69ab-40d6-b8ea-704e4e6c3de8
md"""
!!! danger "Danger Zone!"
	\
	Don't edit past here unless you know what you're doing 😀
	\
	\
"""

# ╔═╡ 10a16ae5-044a-47e2-8964-13b334f5d0a8
md"""
## Front Matter
"""

# ╔═╡ 1b874c8c-08dd-4064-9afc-d62b2e900921
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

# ╔═╡ 65b2ceb8-40d4-4f97-9541-36e0023c5d6b
md"""
## Initial Conditions
"""

# ╔═╡ 8ba55d2d-53fa-4206-872c-0470e76fcf6b
md"""
## Clump Parameters
"""

# ╔═╡ 943f8d1a-335a-4321-8d2b-b29e5ca5845c
md"""
## Springs
"""

# ╔═╡ cac6046f-0d45-4f1a-b062-b8cc53044807
md"""
## Connections
"""

# ╔═╡ 8e250f3e-e5b9-4c76-9eac-39a4a60ded57
md"""
## Growth and Death
"""

# ╔═╡ 7aea397d-a1b3-4e2d-a265-3b528762415c
md"""
## Land
"""

# ╔═╡ fb9970b9-25a9-4235-a01c-5f4b6b2b2580
md"""
# Integration
"""

# ╔═╡ e90936ec-f215-4a03-bd75-da2df6308ed0
md"""
# Utilities
"""

# ╔═╡ 67c5ed03-7e1b-4c4d-8fa1-837848a37924
ad(text, kind) = Markdown.MD(Markdown.Admonition(kind, "", [text]))

# ╔═╡ 838e5ea0-4f9d-4954-8c9f-4df44468f438
begin
	local blurb = md"""
	## Interface Mode

	This interface has two modes, `"React"` and `"Edit"`. 

	In `"React"` mode, any changes you make to the parameters causes the integration to be re-run and the plot to be updated automatically.

	In `"Edit"` mode, parameters can be updated, but the integration is not re-run until you switch to `"React"` mode.

	In summary, use `"Edit"` mode when you need to make a lot of changes, and use `"React"` mode when you need to see results.
	
	**Mode**: $(@bind edit_mode Select(["React", "Edit"], default = "Edit"))
	"""

	ad(blurb, "warning")
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
		Lon min (°): $(Child(TextField(default = "-55.0")))
		Lon max (°): $(Child(TextField(default = "-50.0"))) \
		Lat min (°): $(Child(TextField(default = "5.0")))
		Lat max (°): $(Child(TextField(default = "10.0"))) \
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

# ╔═╡ 75898dc7-beec-4c4d-8580-79ec1df8cc42
begin
	local blurb = md"""
	These settings control the physics parameters for each clump.
	
	- ``\delta``: The buoyancy of the clump, where $\delta \geq 1$.
	- ``a``: The radius of the (assumed spherical) clump.
	- ``\sigma``: The prefactor multiplying the Stokes drift.
	- ``\alpha``: The "leeway" parameter. Depends on ``\delta`` in general, select `"force"` to ignore this dependence.
	- ``\tau``: The inertial response time. Depends on ``\delta`` and ``a`` in general, select `"force"` to ignore this dependence.
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
		``\delta`` [unitless]: $(Child(TextField(default = "1.25"))) \
		``a`` [km]: $(Child(TextField(default = "1.0e-4"))) \
		``\sigma`` [unitless]: $(Child(TextField(default = "0.0"))) \
		``\alpha`` [unitless]: $(Child(TextField(default = ""))) Force? (apply this ``\alpha`` regardless of ``\delta``|) $(Child(CheckBox(default = false))) \
		``\tau`` [d]: $(Child(TextField(default = ""))) Force? (apply this ``\tau`` regardless of ``\delta`` and  ``a``) $(Child(CheckBox(default = false))) \
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
		k: $(Child(TextField(default = "1.00")))
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
	- `"clumps minimum"`: the number of clumps will not die below this value
	- `"clumps maximum"`: the number of clumps will not grow above this value (default twice the number of initial clumps)
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
		local n_max = string(Integer(2*ics.ics[1]))
		local ui_gd_brooks(Child) = md"""
			``\mu_\text{max}`` [1/d]: $(Child(TextField(default = "0.1"))) \
			``m`` [1/d]: $(Child(TextField(default = "0.05"))) \
			``k_\text{N}`` [mmol N/m^3]: $(Child(TextField(default = "0.012"))) \
			`clumps minimum`: $(Child(TextField(default = "0"))) \
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
        gd_model = ImmortalModel()
	elseif gd_type == "Brooks"
		local μ_max, m, k_N, c_min, c_max = gd_params
		local μ_max, m, k_N = (μ_max, m, k_N) .|> x -> parse(Float64, x)
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

# ╔═╡ 0eaba7b9-5bfc-44b3-a99a-8b240a952e02
begin
	if warnings_q == 0
		 ad(md"""No warnings!""", "tip")
	end
end

# ╔═╡ ce4b7abc-f950-482a-8e85-c5fa17937b1b
begin
		
	local blurb = md"""
		### Plot type: $(@bind plot_type Select(["Trajectories", "Heat Map"], default = "Trajectories"))
		"""
	ad(blurb, "info")

end

# ╔═╡ 45234407-bbde-467e-b6fc-708e6e9f5d97
begin

	local ui_afai_plot(Child) = md"""
		Date (yyyy-mm): $(Child(TextField(default = "2018-04"))) \
		Week: $(Child(Select(["1", "2", "3", "4"], default = "1"))) \
		Scale: $(Child(Select(["Log", "Linear"], default = "Log")))
		"""
	@bind afai_plot_params PlutoUI.combine() do Child
		ad(ui_afai_plot(Child), "info")
	end
end

# ╔═╡ afd7ed42-0297-4618-a44f-08d109954724
begin
	local date, week, scale = afai_plot_params
	local date = DateTime(date, "yyyy-mm") |> yearmonth
	if !(date in keys(SargassumFromAFAI.DIST_1718))
		@warn "The AFAI distribution at this date is not one of the pre-computed distributions (2017 - 2018, months where available)."
	end
end

# ╔═╡ 201ffe60-8dc4-4b1d-8db1-52b3646f90a9
begin
	fig_afai = Figure(size = (800, 400), figure_padding = (10, 40, 10, 10))
	ax_afai = geo_axis(fig_afai[1, 1], limits = (-100, -40, 0, 40), title = "", labelscale = 0.5)
	local date, week, scale = afai_plot_params
	local date = DateTime(date, "yyyy-mm") |> yearmonth
	local week = parse(Int64, week)
	SargassumFromAFAI.plot!(ax_afai, SargassumFromAFAI.DIST_1718[date], week, log_scale = scale == "Log")
	land!(ax_afai)
	fig_afai
end

# ╔═╡ 4c0ac1c0-13a8-4492-aaa1-2e071572da74
begin
	if edit_mode == "Edit"
		ad(md"""The integration is stopped in edit mode.""", "warning")
	else
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
	if edit_mode == "Edit"
		ad(md"""The plot is not displayed in edit mode.""", "warning")
	else
		fig = Figure(size = (800, 400), figure_padding = (10, 40, 10, 10))
		ax = geo_axis(fig[1, 1], limits = (-100, -40, 0, 40), title = "", labelscale = 0.5)
		if plot_type == "Trajectories"
			trajectory!(ax, sol)
		elseif plot_type == "Heat Map"
			trajectory_hist!(ax, sol, SargassumFromAFAI.DIST_1718[(2018, 4)], 1, log_scale = true)
		end
		land!(ax)
		fig
	end
end

# ╔═╡ Cell order:
# ╟─a5e1070c-5f0a-44b6-8a43-451ffce19e73
# ╟─b503b1ff-18b5-46b9-9809-88b54240a762
# ╟─c3eddd51-43c4-42f4-800a-ae9945df1e86
# ╟─838e5ea0-4f9d-4954-8c9f-4df44468f438
# ╟─8f0df9e4-3cc9-4265-9727-14bd7cf4497f
# ╟─ebc20b02-83d5-4b94-ae76-16a1bd619312
# ╟─62907762-cad8-483f-9dd1-5907c43b49ab
# ╟─ed4f082b-237c-4b08-b3b9-2f1846b0ecfb
# ╟─c75d9b70-d3bb-41fe-84bf-53c0ab41f406
# ╟─75898dc7-beec-4c4d-8580-79ec1df8cc42
# ╟─489fe878-3ac1-4e18-a185-7d4f1f6679d0
# ╟─6bda3ba9-fbba-4ce5-8a23-0c606845b31a
# ╟─7d5f16a6-9ce9-45c0-9483-24f44a23bd45
# ╟─c60bb5f5-82b7-484c-b56b-ded74a1e651f
# ╟─e1fd0825-6b16-4fb6-9358-4252b1bd77e9
# ╟─3b123c70-d3b9-4b3d-8c38-f4d3457f079d
# ╟─5bdbce07-0f50-459f-8ea6-6bb670aea47d
# ╟─61ebe90a-60e9-4e77-9a24-a793e4701209
# ╟─dd199ecb-16cf-4e58-8918-64077b6c192c
# ╟─e537ca5d-86d6-423b-a3b9-d9ba503c4d31
# ╟─8a5827c1-8655-4808-8fe0-ff46fc25f982
# ╟─5401dc9a-a647-4722-b49d-21023b829cb3
# ╟─da645592-41d8-4212-8ca0-241923f2dc14
# ╟─0eaba7b9-5bfc-44b3-a99a-8b240a952e02
# ╟─f0590b8f-42a0-435d-a4fa-5f9cf206235a
# ╟─ce4b7abc-f950-482a-8e85-c5fa17937b1b
# ╟─e25ab537-8be8-46e1-9b8c-e9c1f8a4dc30
# ╟─0f208a3b-54df-4788-9cfc-57d40ba90522
# ╟─45234407-bbde-467e-b6fc-708e6e9f5d97
# ╟─afd7ed42-0297-4618-a44f-08d109954724
# ╟─201ffe60-8dc4-4b1d-8db1-52b3646f90a9
# ╟─d512eee1-890c-40ce-ab0e-54d1004ad5d2
# ╟─f6b36bcc-5162-4d84-a1a2-9cb3ff0e8ac1
# ╟─ea2ec22b-69ab-40d6-b8ea-704e4e6c3de8
# ╟─10a16ae5-044a-47e2-8964-13b334f5d0a8
# ╟─1b874c8c-08dd-4064-9afc-d62b2e900921
# ╟─589f251d-a2df-4879-9933-4deb95a8003a
# ╟─d1565b62-ce6e-4e07-a041-f15e4fcc118b
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
# ╟─4c0ac1c0-13a8-4492-aaa1-2e071572da74
# ╟─e90936ec-f215-4a03-bd75-da2df6308ed0
# ╟─67c5ed03-7e1b-4c4d-8fa1-837848a37924
