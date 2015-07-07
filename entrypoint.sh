#!/bin/bash

echo 'Creating /.pgpass file...'

# Explicitly set the location of the password file.
export PGPASSFILE="/.pgpass"

# Create /.pgpass file.
cat << EOF > $PGPASSFILE
$SOURCE_HOST:${SOURCE_PORT:=*}:$SOURCE_DB:$SOURCE_USER:$SOURCE_PASS
$TARGET_HOST:${TARGET_PORT:=*}:${TARGET_DB:=*}:$TARGET_USER:$TARGET_PASS
EOF

chmod 0600 $PGPASSFILE

echo "Ensuring '${TARGET_DB}' exists..."

createdb \
    --no-password \
    -h "$TARGET_HOST" \
    -p "$TARGET_PORT" \
    -U "$TARGET_USER" \
    $TARGET_DB > /dev/null 2>&1

echo 'Copying...'

# Dump from the source and pipe to the target.
pg_dump \
    --verbose \
    --no-owner \
    --no-privileges \
    --no-password \
    $@ \
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
