#!/usr/bin/python3
import os
import sys
import argparse
from enum import Enum
from pathlib import Path

from typing import Optional, Union

try:
    GOTO = Path(os.environ["GOTO_PATH"]) / ".goto"
except Exception as e:
    print(str(e))
GOTO.mkdir(exist_ok=True)


class GotoException(Exception):
    def __init__(self, string: str, exception: Optional[Exception] = None):
        self.error = string
        self.exception = exception
        super(GotoException, self).__init__(string)


class SortBy(Enum):
    PATH = "PATH"
    ALIAS = "ALIAS"


def yes_no_handler(prompt: str) -> bool:
    while True:
        x = input(prompt + " [y/n]: ")
        if x.lower() not in ("y", "yes", "n", "no"):
            print("Expected one of the following: y, yes, n, no")
        else:
            break
    return x in ("y", "yes")


def add_alias(alias: str, path: Union[str, Path], force: bool) -> None:
    path = Path(path).absolute()
    link = GOTO / alias
    if link.exists():
        if not force:
            if not yes_no_handler(
                "'%s' already aliased to '%s'. Override '%s'?"
                % (alias, link.resolve(), alias)
            ):
                return
        link.unlink()
    for x in GOTO.iterdir():
        if x.resolve() == path:
            if not yes_no_handler(
                "Alias '%s' to '%s' already exists. Create '%s' anyways?"
                % (x.stem, path, alias)
            ):
                return
    link.symlink_to(path, target_is_directory=True)


def delete_alias(alias: str, force: bool) -> None:
    alias_file = GOTO / alias
    if not alias_file.exists():
        raise GotoException("alias '%s' does not exist" % alias)
    if force is False:
        if not yes_no_handler(
            "Delete '%s' aliased to '%s'?" % (alias, alias_file.resolve())
        ):
            return
    alias_file.unlink()


def get_alias(alias: str) -> None:
    path = GOTO / alias
    if path.is_symlink():
        print(path.resolve())
    else:
        raise GotoException("alias '%s' does not exist" % alias)


def list_aliases(
    sort_by: Union[SortBy, str],
    number: bool,
    subdirs: Path,
    no_headers: bool,
    aliases: bool,
) -> None:
    if sort_by == SortBy.PATH:
        iterator = sorted(GOTO.iterdir(), key=lambda x: x.resolve())
    else:
        iterator = sorted(GOTO.iterdir(), key=lambda x: x.stem)
    count = 0
    if not number and not no_headers and not aliases:
        print("    %-15s %-15s" % ("ALIAS", "PATH"))
    for x in iterator:
        if x.is_dir():
            path = x.resolve()
            if subdirs in path.parents:
                if number:
                    count += 1
                elif aliases:
                    print(x.stem, end=" ")
                else:
                    print("    %-15s %-15s" % (x.stem, path))
    if number:
        print(count)


def add_helper(args: argparse.Namespace) -> None:
    add_alias(args.alias, os.path.abspath(args.path), args.force)


def delete_helper(args: argparse.Namespace) -> None:
    delete_alias(args.alias, args.force)


def get_helper(args: argparse.Namespace) -> None:
    get_alias(args.alias)


def list_helper(args: argparse.Namespace) -> None:
    subdirs = os.path.abspath(args.subdirs[0])
    # Already checked that the arguments are valid
    sort_by = SortBy(args.sort_by)
    list_aliases(sort_by, args.number, Path(subdirs), args.no_headers, args.aliases)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog="goto", description="goto!")
    parser.add_argument(
        "-d",
        "--debug",
        action="store_true",
        help="enter debug mode (only used if python file is called directly)",
    )
    subparsers = parser.add_subparsers(help="commands")

    #
    # ADD PARSER
    #
    add_parser = subparsers.add_parser("add", help="add a new alias")
    add_parser.set_defaults(func=add_helper)
    add_parser.add_argument("alias", help="what to alias to")
    add_parser.add_argument(
        "path", nargs="?", help="path (default: current dir)", default="."
    )
    add_parser.add_argument(
        "-f",
        "--force",
        action="store_true",
        help="force creation of symlink without prompting",
    )

    #
    # DELETE PARSER
    #
    delete_parser = subparsers.add_parser("delete", help="delete alias")
    delete_parser.set_defaults(func=delete_helper)
    delete_parser.add_argument("alias", help="alias to delete")
    delete_parser.add_argument(
        "-f", "--force", action="store_true", help="delete without confirmation"
    )

    #
    # GET PARSER
    #
    get_parser = subparsers.add_parser("get", help="get path from alias")
    get_parser.set_defaults(func=get_helper)
    get_parser.add_argument("alias", help="alias to get")

    #
    # LIST PARSER
    #
    list_parser = subparsers.add_parser("list", help="list existing aliases")
    list_parser.set_defaults(func=list_helper)
    list_parser.add_argument(
        "-n", dest="number", action="store_true", help="print number of aliases"
    )
    list_parser.add_argument(
        "-s",
        "--subdirs",
        nargs=1,
        default=["/"],
        help="only prints aliases that are subdirectories of the current directory",
    )
    list_parser.add_argument(
        "-S",
        "--sort-by",
        choices=[e.value for e in SortBy],
        default=SortBy.ALIAS.value,
        help="what to sort by (default: ALIAS)",
    )
    list_parser.add_argument(
        "--no-headers", action="store_true", help="don't print the headers"
    )
    list_parser.add_argument(
        "-a",
        "--aliases",
        action="store_true",
        help="list only aliases separated by spaces",
    )

    args = parser.parse_args()
    try:
        args.func(args)
    except GotoException as e:
        if args.debug:
            if e.exception is not None:
                raise e.exception
        else:
            print("goto: " + str(e), file=sys.stderr)
        exit(1)
