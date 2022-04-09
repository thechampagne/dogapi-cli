# Package

version       = "1.0.0"
author        = "XXIV"
description   = "Dog API CLI app"
license       = "Apache-2.0"
srcDir        = "src"
bin           = @["dogapi_cli"]
namedBin["dogapi_cli"] = "dogapi"


# Dependencies

requires "nim >= 1.6.0"
requires "dogapi >= 1.0.0"
