# Dog API CLI

[![](https://img.shields.io/github/v/tag/thechampagne/dogapi-cli?label=version)](https://github.com/thechampagne/dogapi-cli/releases/latest) [![](https://img.shields.io/github/license/thechampagne/dogapi-cli)](https://github.com/thechampagne/dogapi-cli/blob/main/LICENSE)

Dog API CLI app.

### Download

Latest Release: [GitHub Release](https://github.com/thechampagne/dogapi-cli/releases/latest)

#### Using Nimble

```
nimble install dogapi_cli
```

### Usage

```
dogapi -r
        (Download random dog image)
or  dogapi -r [number]
        (Download multiple random dog images)
or  dogapi -r --breed "BREED_NAME"
        (Download random dog image from the givien breed)
or  dogapi -r --breed "BREED_NAME" [number]
        (Download multiple random dog images from the givien breed)
or  dogapi --breed "BREED_NAME"
        (Download all dog images from the givien breed)
or  dogapi -r --breed "BREED_NAME" --sub-breed "SUB_BREED_NAME"
        (Download random dog image from the givien sub breed)
or  dogapi -r --breed "BREED_NAME" --sub-breed "SUB_BREED_NAME" [number]
        (Download multiple random dog images from the givien sub breed)
or  dogapi --breed "BREED_NAME" --sub-breed "SUB_BREED_NAME"
        (Download all dog images from the givien sub breed)
```

### License

This repo is released under the [Apache License 2.0](https://github.com/thechampagne/dogapi-cli/blob/main/LICENSE).

```
 Copyright 2022 XXIV

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
```