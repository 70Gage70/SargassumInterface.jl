import Pkg
Pkg.Registry.add("General")
Pkg.Registry.add(Pkg.RegistrySpec(url = "https://github.com/70Gage70/SargassumRegistry"))
Pkg.activate(temp = true)
Pkg.add("SargassumInterface")
Pkg.update()

using SargassumInterface
SargassumInterface.run()