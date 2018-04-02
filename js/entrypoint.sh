#!/bin/bash

if [ ! $LOCAL_USER_ID ]; then
    echo "Please set LOCAL_USER_ID environment variable"
    exit
fi

useradd --shell /bin/bash -u $LOCAL_USER_ID -o -c "" -m user
export HOME=/home/user

exec /usr/local/bin/gosu user "$@"
