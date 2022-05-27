#!/bin/bash

package_json=$(find "$1" -name "package.json" | head -n 1)

run_prebuild() {
    local heroku_prebuild_script

    heroku_prebuild_script=$(json_get_key "$package_json" ".scripts[\"heroku-prebuild\"]")

    if [[ $heroku_prebuild_script ]]; then
        pnpm run heroku-prebuild
    fi
}

run_build() {
    local build_script
    local heroku_postbuild_script

    build_script=$(json_get_key "$package_json" ".scripts.build")
    heroku_postbuild_script=$(json_get_key "$package_json" ".scripts[\"heroku-postbuild\"]")

    if [[ $heroku_postbuild_script ]]; then
        pnpm run heroku-postbuild
    elif [[ $build_script ]]; then
        pnpm run build
    fi
}
