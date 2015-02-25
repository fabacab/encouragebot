#!/bin/bash -
#
# File:        encouragebot.sh
#
# Description: A simple Mac OS X utility that says encouraging things.
#
# Examples:    Use encouragebot.sh to have your Mac remind you of all
#              the ways that you are awesome. Run it from the command
#              line with no arguments to speak a random encouragement.
#
#                  ./encouragebot.sh
#
# Author:      Meitar Moscovitz <meitarm@gmail.com>
# License:     GPL3
#
###############################################################################
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#
###############################################################################

# CONSTANTS
readonly PROGRAM="`basename $0`"
readonly VERSION="0.1"

# DEFAULTS
ENCOURAGEMENTS="$HOME/Library/Application Support/encouragebot/encouragements.txt"

usage () {
    echo "Usage is as follows:"
    echo
    echo "$PROGRAM --version"
    echo "    Prints the program version number on a line by itself and exits."
    echo
    echo "$PROGRAM <--usage|--help|-?>"
    echo "    Prints this usage output and exits."
    echo
    echo "$PROGRAM [--file <file>] [--verbose|-v] [--update-url|-u <URL>]"
    echo "    Load a random encouragement, speak it, and exit."
    echo
    echo "    If '--file' or '-f' is specified, loads encouragements from a given <file>."
    echo "    By default, <file> is located at:"
    echo "    $ENCOURAGEMENTS"
    echo
    echo "    If '--verbose' or '-v' is specified, the loaded encouragement will also be"
    echo "    printed to STDOUT (in addition to being spoken aloud)."
    echo
    echo "    If '--update-url' or '-u' is specified, $PROGRAM first makes an HTTP GET"
    echo "    request to <URL>, which is expected to be a newline-delimited file of"
    echo "    phrases (encouragements) to speak, and adds any new encouragements found"
    echo "    in that file to the local encouragement phrase database in <file>."
    echo
    echo "$PROGRAM [--file|-f <file>] <--create|-c> <PHRASE>"
    echo "    Adds <PHRASE> to the local encouragement database, <file>."
    echo
    echo "$PROGRAM [--file|-f <file>] <--delete|-d> <PHRASE>"
    echo "    Removes <PHRASE> from the local encouragement database, <file>."
    echo
    echo "$PROGRAM [--file|-f <file>] <--list|-l> [pattern]"
    echo "    Lists all encouragements in the local encouragements <file>."
    echo "    If [pattern] is supplied, only the phrases matching its pattern are printed."
    echo "    Pattern matching is done using the sed utility, so [pattern] can be any"
    echo "    regular expression that sed(1) understands."
}

createEncouragement () {
    echo $1 >> "$ENCOURAGEMENTS"
    exit $?
}

deleteEncouragement () {
    sed -i '' "/^$1$/d" "$ENCOURAGEMENTS"
    exit $?
}

updateEncouragementsFromUrl () {
    cat <(curl --silent --fail -L "$1" -w "\n") "$ENCOURAGEMENTS" \
        | sort \
            | uniq \
                | sed '/^$/d' \
                    > "$ENCOURAGEMENTS.lastupdate"
    mv -f "$ENCOURAGEMENTS.lastupdate" "$ENCOURAGEMENTS"
}

# RETURN VALUES/EXIT STATUS CODES
readonly E_BAD_OPTION=254
readonly E_UNKNOWN=255

# Process command-line arguments.
while test $# -gt 0; do
    case $1 in
        -f | --file )
            shift
            ENCOURAGEMENTS="$1"
            shift
            ;;

        -c | --create )
            shift
            createEncouragement "$1" # will exit
            ;;

        -d | --delete )
            shift
            deleteEncouragement "$1" # will exit
            ;;

        -l | --list )
            shift
            if [ -z "$1" ]; then
                pat='.'
            else
                pat="$1"
            fi
            sed -n "/$pat/p" "$ENCOURAGEMENTS"
            exit $?
            ;;

        -v | --verbose )
            shift
            VERBOSE=1
            ;;

        -u | --update-url )
            shift
            UPDATE_URL="$1"
            shift
            ;;

        --version )
            echo "$PROGRAM version $VERSION"
            exit
            ;;

        -? | --usage | --help )
            usage
            exit
            ;;

        -* )
            echo "Unrecognized option: $1" >&2
            usage
            exit $E_BAD_OPTION
            ;;
    esac
done

if [ ! -f "$ENCOURAGEMENTS" ]; then
    mkdir -p "`dirname "$ENCOURAGEMENTS"`"
    touch "$ENCOURAGEMENTS"
fi

if [ "$UPDATE_URL" ]; then
    updateEncouragementsFromUrl "$UPDATE_URL"
fi

shuf=`which shuf gshuf`
if [ ! "$shuf" ]; then
    echo "You're missing a required tool: shuf"
    echo "Please install the shuf utility on your system."
    echo "shuf can be installed using MacPorts or HomeBrew"
    echo "as part of the coreutils package."
    echo
    echo "For MacPorts users:"
    echo
    echo "    port install coreutils"
    echo
    echo "For HomeBrew users:"
    echo
    echo "    brew install coreutils"
    echo
    echo "After installing, try again."
fi

encouragement="`$shuf "$ENCOURAGEMENTS" | head -n 1`"
if [ $VERBOSE ]; then
    echo "$encouragement"
fi
say "$encouragement"
