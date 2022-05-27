#!/bin/bash

export_env_dir() {
    env_dir=$1

    if [ -d "$env_dir" ]; then
        alowlist_regex=${2:-''}
        blocklist_regex=${3:-'^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH|LANG|BUILD_DIR)$'}

        # shellcheck disable=SC2164
        pushd "$env_dir" >/dev/null
        for e in *; do
            [ -e "$e" ] || continue

            echo "$e" | grep -E "$alowlist_regex" | grep -qvE "$blocklist_regex" &&
                export "$e=$(cat "$e")"
            :
        done

        # shellcheck disable=SC2164
        popd >/dev/null
    fi
}

write_profile() {
    bp_dir="$1"
    build_dir="$2"

    mkdir -p "$build_dir/.profile.d"

    cp "$bp_dir"/profile/* "$build_dir/.profile.d/"
}
