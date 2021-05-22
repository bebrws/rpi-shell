#!/usr/bin/env zsh
#### THE BASH BIBLE https://github.com/dylanaraps/pure-bash-bible#parameter-expansion

function split() {
   # Usage: split "string" "delimiter"
   IFS=$'\n' read -d "" -ra arr <<< "${1//$2/$'\n'}"
   printf '%s\n' "${arr[@]}"
}

function lower() {
    # Usage: lower "string"
    printf '%s\n' "${1,,}"
}

function upper() {
    # Usage: upper "string"
    printf '%s\n' "${1^^}"
}


function trim_quotes() {
    # Usage: trim_quotes "string"
    # Documentation for : is https://stackoverflow.com/questions/3224878/what-is-the-purpose-of-the-colon-gnu-bash-builtin
    # The portion after : (: is jsut a throwaway call to true) is stripping ' from the argument $1'
    : "${1//\'}"
    # $_ = expands to the last argument to the previous command after expansion.
    # https://unix.stackexchange.com/questions/271659/vs-last-argument-of-the-preceding-command-and-output-redirection
    printf '%s\n' "${_//\"}"
}

function strip_all() {
    # Usage: strip_all "string" "pattern"
    # strip_all "The Quick Brown Fox" "[[:space:]]"
    # strip_all "The Quick Brown Fox" "[aeiou]"
    # strip_all "The Quick Brown Fox" "Quick "
    printf '%s\n' "${1//$2}"
}

function urlencode() {
    # Usage: urlencode "string"
    local LC_ALL=C
    for (( i = 0; i < ${#1}; i++ )); do
        : "${1:i:1}"
        case "$_" in
            [a-zA-Z0-9.~_-])
                printf '%s' "$_"
            ;;

            *)
                printf '%%%02X' "'$_"
            ;;
        esac
    done
    printf '\n'
}

function urldecode() {
    # Usage: urldecode "string"
    : "${1//+/ }"
    printf '%b\n' "${_//%/\\x}"
}

# Check if string contians sub string
# if [[ $var == *sub_string* ]]; then
#     printf '%s\n' "sub_string is in var."
# fi

function reverse_array() {
    # Usage: reverse_array "array"
    shopt -s extdebug
    f()(printf '%s\n' "${BASH_ARGV[@]}"); f "$@"
    shopt -u extdebug
}

# arr=( "B" "R" "A" "D" ) 
# function cycle() {                                                                                                      ~/repos/ish
#     printf '%s ' "${arr[${i:=0}]}"
#     ((i=i>=${#arr[@]}?0:++i))
# }

# For loop Range:
# for i in {0..100}; do
#     printf '%s\n' "$i"
# done

# For loop array
# arr=(apples oranges tomatoes)
# for element in "${arr[@]}"; do
#     printf '%s\n' "$element"
# done

# Loop over contents of file line by line
# while read -r line; do
#     printf '%s\n' "$line"
# done < "filennamehere"

# Read file into variable:
# file_data="$(<"filenamehere")"

function fileHead() {
    # Usage: head "n" "file"
    mapfile -tn "$1" line < "$2"
    printf '%s\n' "${line[@]}"
}

function fileTail() {
    # Usage: tail "n" "file"
    mapfile -tn 0 line < "$2"
    printf '%s\n' "${line[@]: -$1}"
}

function readNLinesOfFile() {
    # Usage: lines "file"
    mapfile -tn 0 lines < "$1"
    printf '%s\n' "${#lines[@]}"
}

## END BASH BIBLE

# Replacing strings ina  variable
# https://github.com/dylanaraps/pure-bash-bible#parameter-expansion

### ALIAS ALL THE COLUMNS
alias c1="awk '{print \$1}'"
alias c2="awk '{print \$2}'"
alias c3="awk '{print \$3}'"
alias c4="awk '{print \$4}'"
alias c5="awk '{print \$5}'"
alias c6="awk '{print \$6}'"
alias c7="awk '{print \$7}'"
alias c8="awk '{print \$8}'"
alias c9="awk '{print \$9}'"
alias c10="awk '{print \$10}'"

alias c2skipLine1="awk '{ if (NR != 1) print $2 }'"

## END COLUMNS

