#!/bin/bash

# Define constants
GOTO_FILE="$HOME/scripts/.aliases"
GOTO_ERROR_CODE=0

source "$HOME/scripts/goto/help.bash"
source "$HOME/scripts/goto/main.bash"

if [ $# -ge 1 ]; then

    # List aliases
    if [ "$1" == "list" ]; then
        __goto_list $2

    elif [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$1" == "help" ]; then
        __goto_print_long_help

    # Add a new alias
    elif [ "$1" == "add" ]; then
        __goto_add $2

    # Delete an existing alias
    elif [ "$1" == "delete" ]; then
        __goto_delete $2

    # Go the location specified
    elif [ ${LOCATIONS["$1"]} ]; then
        cd ${LOCATIONS["$1"]}

    elif [ $1 == show-all-if-ambiguous ]; then
        __goto_print_short_help
    else
        __goto_error "'$1' is not aliased or a goto command. See 'goto --help'"
        GOTO_ERROR_CODE=1
    fi

fi

return $GOTO_ERROR_CODE
