#!/usr/bin/env bash
# 
# test.sh: run some stashr commands


function populate_directory {
    mkdir subdir
    touch a
    touch subdir/b
}

function run_cmds {
    echo "Starting tests in $(pwd) ..."

    stashr a
    if [[ -f a ]]; then
        echo "Could not push a file"
    fi

    stashr
    if [[ ! -f a ]]; then
        echo "Could not pop a file"
    fi

    stashr subdir
    if [[ -d subdir ]]; then
        echo "Could not push a dir"
    fi

    stashr
    if [[ ! -d subdir ]]; then
        echo "Could not pop a dir"
    fi

    stashr a subdir
    if [ `ls -1 2> /dev/null | wc -l` -gt 0 ]; then
        echo "Could not push all"
    fi

    stashr
    if [ `ls -1 2> /dev/null | wc -l` -lt 2 ]; then
        echo "Could not pop all"
    fi
}

mkdir /usr/test_dir
cd /usr/test_dir

populate_directory
run_cmds

cd /mount/vdrive

find .

populate_directory
run_cmds

find .

echo "Finished..."

