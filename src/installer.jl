import Pkg
Pkg.Registry.add("General")
Pkg.Registry.add(RegistrySpec(url = "https://github.com/70Gage70/SargassumRegistry"))
Pkg.activate(temp = true)
Pkg.add("SargassumInterface")
Pkg.update()

using SargassumInterface
SargassumInterface.run()