#!/bin/sh

export PGDATA=$CONDA_PREFIX/local/pgsql/data

pg_ctl start -l $PGDATA/logfile
