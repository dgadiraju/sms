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

PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" << EOF
CREATE DATABASE sms_db;
CREATE USER sms_user WITH ENCRYPTED PASSWORD 'itversity';
GRANT ALL PRIVILEGES ON DATABASE sms_db TO sms_user;

\c sms_db

CREATE TABLE hw (
    i INT,
    s VARCHAR(30)
);

INSERT INTO hw VALUES (1, 'Hello');
INSERT INTO hw VALUES (2, 'World');

GRANT ALL PRIVILEGES ON DATABASE sms_db TO sms_user;
EOF

>&2 echo "Postgres is up - executing command"
exec $cmd