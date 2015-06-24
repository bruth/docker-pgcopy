#!/bin/bash

# Explicitly set the location of the password file.
export PGPASSFILE="/.pgpass"

echo 'Creating .pgpass file...'

# Create .pgpass file.
cat << EOF > /.pgpass
$SOURCE_HOST:$SOURCE_PORT:$SOURCE_DB:$SOURCE_USER:$SOURCE_PASS
$TARGET_HOST:$TARGET_PORT:$TARGET_DB:$TARGET_USER:$TARGET_PASS
EOF

chmod 0600 /.pgpass

echo 'Starting copy...'

# Dump from the source and pipe to the target.
pg_dump \
    --no-owner \
    --verbose \
    --no-privileges \
    --no-password \
    -h "$SOURCE_HOST" \
    -p "$SOURCE_PORT" \
    -U "$SOURCE_USER" \
    -d "$SOURCE_DB" \
| psql \
    --no-password \
    -h "$TARGET_HOST" \
    -p "$TARGET_PORT" \
    -U "$TARGET_USER" \
    -d "$TARGET_DB"
