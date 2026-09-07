#!/usr/bin/env bash
set -euo pipefail

PGBIN=""
for b in /Applications/Postgres.app/Contents/Versions/18/bin /Applications/Postgres.app/Contents/Versions/latest/bin; do
    if [ -x "$b/pg_dump" ]; then
        PGBIN="$b"
        break
    fi
done

PG_DUMP="pg_dump"
[ -n "$PGBIN" ] && PG_DUMP="$PGBIN/pg_dump"

DB=expo_course
USER=expo
PASS=expo123
HOST=localhost
OUT="${1:-expo_course.dump}"
ARCHIVE="${2:-course_uploads.tar.gz}"

export PGPASSWORD="$PASS"

echo "==> Exporting database '$DB' -> $OUT (client: $PG_DUMP)"
"$PG_DUMP" -h "$HOST" -U "$USER" -d "$DB" -F c -f "$OUT"

if [ -d uploads ]; then
    echo "==> Packing uploads/ -> $ARCHIVE"
    tar -czf "$ARCHIVE" uploads
else
    echo "!! uploads/ not found - skipping images (kept uploads on disk)"
fi

if [ -f "$ARCHIVE" ]; then
    ls -lh "$OUT" "$ARCHIVE"
else
    ls -lh "$OUT"
fi
echo "Export done. Copy $OUT (i $ARCHIVE ako postoji) na drugi racunar."