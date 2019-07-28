# goto

`goto` grew out of my frustration with how hard it is to alias certain locations
in a codebase to quickly switch directory. There is a lot more to be wanted, but
at the moment it is functional enough that I can use it in my workflow.

This then allows you to use the function the following format. 

    usage: goto [--help] [<alias> | <command> [...]]

## Installation
Go to the directory you would like to install `goto` and run the following
commands.

    git clone https://github.com/mdagaro/goto.git
    GOTO_PATH="`pwd`/goto"
    export GOTO_PATH
    cd goto
    sudo make install

You will likely want to add GOTO\_PATH to your bashrc, otherwise you will need
to redefine it every time you start a terminal. Also, in your bashrc, it is
helped to add

    alias goto=". $GOTO_PATH/goto"

Otherwise, you will need to source it every time you run it.

`goto` has two main functions, aliases and commands which are described below.

## Aliases
The main functionality comes from something I called aliases. These are single
words that can represent a path that is easily memorable. Under the hood, they
are symbolic links that are stored in `$GOTO_PATH/.goto`. For example, instead
of running

    cd ~/long/path/to/foo

I can run

    goto foo

I can set this up easily by running 

    goto add foo ~/long/path/to/foo

or by cd-ing into `~/long/path/to/foo` and running

    goto add foo

## Commands
`goto` has three main commands: add, delete, list, and get. Below are basic
overviews. More information can be found by running `man goto-add`, `man
goto-delete`, `man goto-list` and `man goto-get`.

### goto add
`goto add` is how you create aliases.

    usage: goto add OPTIONS <alias> [<path>]

This will alias the current directory to `alias`. As described before, you can
alias `foo` to `~/long/path/to/foo` by running

    goto add foo ~/long/path/to/foo

or by cd-ing into `~/long/path/to/foo` and running

    goto add foo

`goto add` will prompt you if you are overriding an alias that already exists,
or are creating a duplicate alias to the same location. To override these
prompt, you can use the `-f, --force` flag.

### goto delete

`goto delete` allows you to delete aliases you have already defined. This allows
you to delete aliases you don\'t need anymore or to directories that don't exist
anymore.

    usage: goto delete OPTIONS <alias>

For example, to delete the previously defined alias `foo`, you can run

    goto delete foo

You will be prompted to make sure you want to delete this alias. To override
this prompting, you can use the `-f, --force` flag.

### goto list

`goto list` allows you to see you already defined aliases. Consult the manpage
for all the output options, but some basic ones are `-n` which prints out the
number of aliases you have, `-s` which prints out the aliases which are
(noninclusive) subdirectories of a specified directory and `--no-headers`
which doesn't print out the headers in the beginnging. 

Here are some example outputs.

    > goto list
        ALIAS           PATH           
        dotfiles        /home/mdagaro/dotfiles
        git             /home/mdagaro/git
        goto            /home/mdagaro/git/goto
        gotodocs        /home/mdagaro/git/goto/docs
        gotosrc         /home/mdagaro/git/goto/src
        scripts         /home/mdagaro/scripts
        vim             /home/mdagaro/dotfiles/vim
    > goto list --sort-by PATH
        ALIAS           PATH           
        dotfiles        /home/mdagaro/dotfiles
        vim             /home/mdagaro/dotfiles/vim
        git             /home/mdagaro/git
        goto            /home/mdagaro/git/goto
        gotodocs        /home/mdagaro/git/goto/docs
        gotosrc         /home/mdagaro/git/goto/src
        scripts         /home/mdagaro/scripts
    > goto list --subdirs ~/git -n
    3

### goto get
`goto get` is the final command. You probably won't use this much, if at all. It
is mainly used to get the path for a specific alias.

For example...

    > goto get git
    /home/mdagaro/git

# Future work
I will the ability to save your `goto` aliases in a file, likely through `goto
list`. I will also allow to load your aliases from a file through `goto add`.
There will be some sanity checks to delete broken symlinks and the sort. I don't
want to overengineer this and code too many commands that users might want to
use as their own alias.
