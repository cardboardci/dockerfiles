# Sum Verified Rules Investigation

## Abstract

Dependencies that are installed onto images built by Bazel are not sum verified. This design proposes a mechanism for in-bazel sum verification of dependencies based on the packages downloaded from the associated package managers.

## Proposal

This proposes the introduction of rules based on each type of package, that would declare the necessary parameter to download the package from its authoritative source. Each rule would be of the form `container_*_package`, that would at minimum ensure a `name`, `version` and `sum`. This rule would not be responsible for downloading the package itself, as to make it easier to vendor the dependencies into internal data stores. The responsibility of downloading and installing packages would be handled by other macros that would handle downloading and sum verification.

An example of the rule can be seen for `lua` as such:

```starlark
# Define a package file that is used for download/integrity checks
container_lua_package(
    name = "lua_luacheck",
    package = "luacheck",
    version = "1.23.0",
    sum = "4521794f0fba2e20f3bf15846ab5e01d5332e587e9ce81629c7f96c793bb7036",
)
```

The `container_*_package` rule would yield an output file that is used by the `container_*_download` macro for downloading the packages from an authoritative source. This file is intended to be re-usable, so that it can be used to retrieve the dependencies internal data stores instead of the authoritative source.

An example of the macro can be seen for `lua` as such:

```starlark
# This outputs a tar, csv and build script
container_lua_download(
    name = "lua_download",
    image_tar = "//images/downloader:image.tar",
    packages = [
        ":lua_luacheck",
        # other dependencies can be added here
    ]
)
```

When the download is completed, a tar file is available with all of the dependencies downloaded by the macro. Each dependency has its sum generated that placed into a package lock csv file. This CSV file is supplied to an internal verification rule to ensure the dependencies are as expected. The CSV file would be of the format: `package,file,version,sum`. This file would be supplied to the installation rule.

### Verification

Verification of the downloaded dependencies would be handled by `container_pkg_check`. This rule would be used internally by the `container_*_download` macros to assist with caching the downloaded files. Multiple package lock csv files can be provided to the rule, which allow checking sums for

An example of the macro can be seen for `lua` as such:

```starlark
# This outputs a tar, csv and build script
container_pkg_check(
    name = "image_integrity",
    tar = [
        ":lua_download.csv",
        ":npm_download.csv",
        # A type of install that requires a custom `image_tar`
        ":npm_special_download.csv",
        # other package dependencies can be added here
    ],
    packages = [
        ":lua_luacheck",
        ":npm_bazel",
        ":npm_specialdependency",
        # other dependencies can be added here
    ]
)
```

Splitting verification into its own rule enables for it to be leveraged by custom/freeform mechanisms of retrieving dependencies outside of the common package managers. The retrieved files can be checked as long as the package lock csv file format is met.

## Full Example

Below is an outline of the design for checking the integrity of all packages installed into the docker image, to ensure that the installed package is as expected. This is a design idea and not implemented into the code at this time.

```starlark
# Define a package file that is used for download/integrity checks
container_lua_package(
    name = "lua_luacheck",
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
container_lua_download(
    name = "lua_download",
    image_tar = "//images/downloader:image.tar",
    packages = [
        ":lua_luacheck",
        # other dependencies can be added here
    ]
)

# docker run :integrity will convert the package files into an
# index that can be checked by each entry in the downloaded CSVs
container_package_integrity(
    name = "integrity",
    packages = [
        ":lua_luacheck",
        # ... and other json files
    ],
    results = [
        ":lua_download.csv",
    ]
)

# The tar file is then installed using the existing package manager
container_lua_install(
    name = "lua_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":lua_download.tar",
    installation_pre_commands = "",
    installation_post_commands = "",
    output_image_name = "lua_installed",
)
```
