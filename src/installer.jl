import Pkg
Pkg.Registry.add("General")
Pkg.Registry.add(RegistrySpec(url = "https://github.com/70Gage70/SargassumRegistry"))
Pkg.add("SargassumInterface")
Pkg.update()

using SargassumInterface
SargassumInterface.run()