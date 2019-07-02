# my_goto.sh

It grew out of my frustration with how hard it is to alias certain locations in
a codebase to quickly switch directory. There is a lot more to be wanted, but at
the moment it is functional enough that I can use it in my workflow. To actually
put this function in any usable state, add the following line to your bashrc.

    alias goto=". path/to/my_goto.sh

This then allows you to use the function the following format. 

    usage: goto [--help] [<alias> | <command> [...]]

## Aliases
The main functionality comes from something I called aliases. These are single
words that can represent a path that is easily memorable. For example, instead
of running

    cd ~/long/path/to/foo

I can run

    goto foo

To set this up, I must first cd into the directory in question and run
`goto add`.

    cd ~/long/path/to/foo
    goto add foo

All aliases are stored in a local .aliases file which is
updating and loaded on the first run of goto. While using goto
in an active command line, these aliases are stored in an
associative array called LOCATIONS.

## Commands
goto has three main commands: list, delete and add.

### goto add
`goto add` was described before, but the usage is the following.

    usage: goto add <alias>

This will alias the current directory to `alias`.

### goto delete
`goto delete` is another function for managing your aliases.
This allows you to delete aliases you don\'t need anymore or
that might not even exist.

    usage: goto delete <alias>

If the alias is not found, `goto delete` exits with code
1, otherwise with code 0.

### goto list
`goto list` lists the aliases that you have created in
alphabetical order. There are plans to add more sorting
options in the future but this is all that I have right
now.

    usage: goto list

## Future work
In the future I plan to add more options to specify
paths that are not in the working directory, error
checking to prevent multiple aliases, and perhaps
better naming to prevent conflict (after all, this
is a command that is supposed to be sourced).

