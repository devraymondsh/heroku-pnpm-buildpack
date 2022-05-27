#!/usr/bin/env bash
JQ="/usr/bin/jq"

if ! test -f "$JQ"; then
    curl -Ls "https://github.com/stedolan/jq/releases/latest/download/jq-linux64" >"/usr/bin/jq" &&
        chmod +x "/usr/bin/jq"
fi

json_get_key() {
    file="$1"
    key="$2"

    if test -f "$file"; then
        jq -c -M --raw-output "$key // \"\"" <"$file" || return 1
    else
        echo ""
    fi
}

read_json() {
    file="$1"
    key="$2"

    if test -f "$file"; then
        # -M = strip any color
        # -c = print on only one line
        # --raw-output = if the filter’s result is a string then it will be written directly
        #                to stdout rather than being formatted as a JSON string with quotes

        # shellcheck disable=SC2002
        cat "$file" | $JQ -c -M --raw-output "$key // \"\"" || return 1
    else
        echo ""
    fi
}
