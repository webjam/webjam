#!/bin/bash
PORT=5561
DB=webjam
# sudo sysctl -w kern.sysv.shmall=65536
# sudo sysctl -w kern.sysv.shmmax=16777216
if [ ! -d "db/pgdata" ]; then
    mkdir db/pgdata
    initdb db/pgdata
    postgres -D db/pgdata -p $PORT &
    PGPID=$!
    while [ ! -S "/tmp/.s.PGSQL.${PORT}" ]
    do
        sleep 0.5
    done
    createdb -p $PORT ${DB}_test
    createdb -p $PORT ${DB}_dev
else
    postgres -D db/pgdata -p $PORT -c log_statement=all &
    PGPID=$!
fi

wait $PGPID
