#!/usr/bin/env bash
set -euo pipefail

PGBIN=""
for b in /Applications/Postgres.app/Contents/Versions/18/bin /Applications/Postgres.app/Contents/Versions/latest/bin; do
    if [ -x "$b/pg_dump" ]; then
        PGBIN="$b"
        break
    fi
done

PSQL="psql"
CREATEDB="createdb"
PG_RESTORE="pg_restore"
if [ -n "$PGBIN" ]; then
    PSQL="$PGBIN/psql"
    CREATEDB="$PGBIN/createdb"
    PG_RESTORE="$PGBIN/pg_restore"
fi

DB=expo_course
USER=expo
PASS=expo123
HOST=localhost
IN="${1:-expo_course.dump}"
ARCHIVE="${2:-course_uploads.tar.gz}"

export PGPASSWORD="$PASS"

if [ ! -f "$IN" ]; then
    echo "ERROR: $IN ne postoji. Pokreni backup-export.sh prvo." >&2
    exit 1
fi

if ! "$PSQL" -h "$HOST" -U "$USER" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$DB'" | grep -q 1; then
    echo "==> Kreiram bazu '$DB'"
    "$CREATEDB" -h "$HOST" -U "$USER" "$DB"
fi

echo "==> Restore $IN -> $DB (brise postojece tabele)"
"$PG_RESTORE" -h "$HOST" -U "$USER" -d "$DB" --clean --if-exists --no-owner "$IN"

if [ -f "$ARCHIVE" ]; then
    echo "==> Raspakujem slike $ARCHIVE"
    tar -xzf "$ARCHIVE"
else
    echo "!! $ARCHIVE nije nadjen - slike preskocene"
fi

echo "Import done."