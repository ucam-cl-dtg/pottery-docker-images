#!/bin/bash

if [ ! $LOCAL_USER_ID ]; then
    echo "Please set LOCAL_USER_ID environment variable"
    exit
fi

useradd --shell /bin/bash -u $LOCAL_USER_ID -o -c "" -m user
export HOME=/home/user

echo "alias java=\"java -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap\"" >> /home/user/.bashrc

ln -s /usr/local/maven-cache/.m2 /home/user/.m2

exec /usr/local/bin/gosu user "$@"
