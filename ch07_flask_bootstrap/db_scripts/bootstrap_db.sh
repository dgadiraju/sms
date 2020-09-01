#!/bin/sh
# bootstrap_db.sh

set -e

host="$1"
shift
cmd="$@"

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done
if [ ! -f .initialized ]; then
  echo "Initializing container"
  ./db_scripts/01_create_db.sh "$host"
  ./db_scripts/02_create_tables_courses.sh "$host"
  ./db_scripts/03_insert_courses.sh "$host"
  touch .initialized
fi

>&2 echo "Postgres is up - executing command"
exec $cmd