#!/bin/bash

set -eu
set -o pipefail

usage="usage: encrypt_folders.sh folder [folder...]"

if [[ "$#" == "0" ]] ; then
    echo ${usage}
    exit
elif [[ "$1" == "-h" || "$1" == "--help" ]] ; then
    echo ${usage}
    exit
fi

for folder in "$@"
do
    #check it's actually a folder
    if ! [[ -d "${folder}" ]] ; then
        echo Skipping "${folder}" which is not a folder
        continue
    fi

    #the zip file will be named after the folder with an "-enc" suffix
    zipfile="${folder}"-enc.zip

    #generate a random 18 byte password as 24 printable base64 characters
    #giving slightly more than 128 bits
    PASSWORD=$(head -c18 /dev/urandom | base64)

    #report the password to the terminal only
    echo encrypting "${folder}" with password "${PASSWORD}"

    #do the actual compression and encoding
    zip -rq --password ${PASSWORD} "${zipfile}" "${folder}"

    echo created "${zipfile}"
done
