#!/bin/bash

source "$HOME/scripts/goto/help.bash"

__goto_error() {
    echo "goto: $1" 1>&2
}

__goto_list() {
    if [ -z $1 ]; then
        # Print out the aliases sorted by name
        for k in "${!LOCATIONS[@]}"; do
            printf "    %-15s %-15s\n" "$k" "${LOCATIONS[$k]}"
        done | sort -n -k2
    elif [ $1 == "-h" ] || [ $1 == "--help" ]; then
        __goto_help list
    elif [[ -v "LOCATIONS[$1]" ]]; then
        printf "%s\n" "${LOCATIONS[$1]}"
    else
        __goto_error "invalid option $1"
        GOTO_ERROR_CODE=1
    fi
}

__update_autocomplete() {

    commands=$( IFS=$' '; echo "${!LOCATIONS[@]}")
    complete -W "$commands" goto
    unset commands
}

# Updates the file with the current values in LOCATION
__goto_update() {
    local BACKUP=".goto_backup"
    local TEMP=".goto_temp"
    touch $TEMP
    cat $GOTO_FILE > $BACKUP
    for k in "${!LOCATIONS[@]}"; do
        echo "$k ${LOCATIONS[$k]}" >> $TEMP
    done
    cat $TEMP > $GOTO_FILE
    rm $TEMP
}

__goto_add() {
    if [ -z $1 ] || [ "$1" == "show-all-if-ambiguous" ]; then
        __goto_error "no alias name provided. See 'goto add --help'"
        GOTO_ERROR_CODE=1
    elif [ $1 == "-h" ] || [ "$1" == "--help" ]; then
        __goto_help add
    else
        LOCATIONS[$1]=$(pwd)
        echo "$1 ${LOCATIONS[$1]}" >> $GOTO_FILE
        __update_autocomplete
        echo "${LOCATIONS[$1]} successfully aliased to $1"
    fi
}

__goto_delete() {
    if [ -z $1 ] || [ "$1" == "show-all-if-ambiguous" ]; then
        __goto_error "no alias name provided. See 'goto delete --help'"
        GOTO_ERROR_CODE=1
    elif [ $1 == "--help" ] || [ $1 == "-h" ]; then
        __goto_help delete
    elif [[ -v "LOCATIONS[$1]" ]]; then
        local OLD_LOC=LOCATIONS[$1]
        unset LOCATIONS[$1]
        __goto_update
        __update_autocomplete
        echo "$1 (aliased to $OLD_LOC) successfully deleted"
    else
        __goto_error "could not find alias '$1'"
        GOTO_ERROR_CODE=1
    fi

}

__goto_refresh() {
    if [ -z $1 ]; then
        unset LOCATIONS
        declare -A LOCATIONS
        touch $GOTO_FILE
        # Read from FILE
        while IFS= read -r line; do
            vars=($line)
            LOCATIONS[${vars[0]}]=${vars[1]}
        done < $GOTO_FILE
        __update_autocomplete
    elif [ $1 == "-h" ] || [ $1 == "--help" ]; then
        __goto_help refresh
    else
        __goto_error "invalid option '$1'"
    fi
}
