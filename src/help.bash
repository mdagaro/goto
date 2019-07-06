#!/bin/bash

__goto_print_command() {
    printf "    %-15s %-15s\n" "$1" "$2"
}

__goto_print_short_help() {
    printf "usage: goto [--help] <alias>\n"
    printf "   or: goto <command> [--help] [...]\n"
}

__goto_print_long_help() {
    __goto_print_short_help
    echo ""
    echo "If an alias is specified, this function changes the working directory to that alias."
    echo ""
    echo "  Commands"
    __goto_print_command "add" "create and add new aliases"
    __goto_print_command "delete" "delete an alias"
    __goto_print_command "help" "view this help message"
    __goto_print_command "list" "list currently defined aliases"
    __goto_print_command "refresh" "refresh goto based on file"

}

__goto_print_add_help() {
    echo "usage: goto add [--help] alias"
    echo ""
    __goto_print_command "alias" "what to alias the current directory to"
    __goto_print_command "-h, --help" "display this help message"
}

__goto_print_delete_help() {
    echo "usage: goto delete [--help] <alias>"
    echo ""
    __goto_print_command "alias" "the name of the alias to be deleted"
    __goto_print_command "-h, --help" "display this help message"
}

__goto_print_list_help() {
    echo "usage: goto list [--help]"
    echo ""
    __goto_print_command "-h, --help" "display this help message"
}

__goto_print_refresh_help() {
    echo "usage: goto refresh [--help]"
    echo ""
    echo "Refresh the locations based on the file in memory. Useful if you update goto in"
    echo "a different terminal"
    echo ""
    __goto_print_command "-h, --help" "display this help message"
}

__goto_help() {
    case $1 in
        add)
            __goto_print_add_help
            ;;
        delete)
            __goto_print_delete_help
            ;;
        list)
            __goto_print_list_help
            ;;
        short)
            __goto_print_short_help
            ;;
        long)
            __goto_print_long_help
            ;;
        refresh)
            __goto_print_refresh_help
            ;;
    esac

}
