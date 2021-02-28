# Sum Verified Rules Investigation

Below is an outline of the design idea for checking the integrity of all packages installed into the docker image, to ensure that the installed package is as expected. This is a design idea and not implemented into the code at this time.

```starlark
# Define a package file that is used for download/integrity checks
container_luarocks_package(
    name = "luarocks_luacheck",
    package = "luacheck",
    version = "1.23.0",
    sum = "4521794f0fba2e20f3bf15846ab5e01d5332e587e9ce81629c7f96c793bb7036",
)

# Download the luarock packages, with the necessary data to perform
# integrity checks on the data. The output csv can be used with the
# json sums to ensure integrity of the downloaded files. Failing on 
# an integrity check will just be a pain point
#
# This outputs a tar, csv and build script
container_luarocks_download(
    name = "luarocks_download",
    image_tar = "//images/downloader:image.tar",
    packages = [
        ":luarocks_luacheck",
        # other dependencies can be added here
    ]
)

# docker run :integrity will convert the package files into an
# index that can be checked by each entry in the downloaded CSVs
container_package_integrity(
    name = "integrity",
    packages = [
        ":luarocks_luacheck",
        # ... and other json files
    ],
    results = [
        ":luarocks_download.csv",
    ]
)

# The tar file is then installed using the existing package manager
container_luarocks_install(
    name = "luarocks_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":luarocks_download.tar",
    installation_pre_commands = "",
    installation_post_commands = "",
    output_image_name = "luarocks_installed",
)
```