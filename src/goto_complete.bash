#!/bin/bash

__goto_complete() {
    COMPREPLY=()
    local word="${COMP_WORDS[COMP_CWORD]}"
    if [ "$COMP_CWORD" -eq 1 ]; then
        COMPREPLY=( $(compgen -W "$($GOTO_PATH/goto list -a)" -- "$word") )
    else
        local words=("${COMP_WORDS[@]}")
        unset words[0]
        unset words[$COMP_CWORD]
        local completions="$($GOTO_PATH/goto list -a)"
        COMPREPLY=( $(compgen -W "$completions" -- "$word") )
    fi
}
complete -F __goto_complete goto
