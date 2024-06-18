import Pkg
Pkg.pkg"registry add"
Pkg.pkg"registry add https://github.com/70Gage70/SargassumRegistry"
Pkg.pkg"add SargassumInterface"
Pkg.pkg"update"

using SargassumInterface
SargassumInterface.run()