#!/bin/bash

# based on: https://docwhat.org/bash-checking-a-port-number

function to_int {
    local -i num="10#${1}"
    echo "${num}"
}

function port_is_ok {
    local port="$1"
    local -i port_num=$(to_int "${port}" 2>/dev/null)

    if (( $port_num < 1 || $port_num > 65535 )) ; then
        echo "*** ${port} is not a valid port" 1>&2
        return 1
    fi

    return 0
}

port_is_ok "$1"
