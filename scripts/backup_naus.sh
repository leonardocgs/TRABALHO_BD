#!/bin/bash
PGUSER="myuser"
PGDATABASE="mydatabase"
BACKUP_DIR="backup"
DATA=$(date +%Y%m%d_%H%M)

mkdir -p $BACKUP_DIR

pg_dump -U $PGUSER -F c -v -f "$BACKUP_DIR/${PGDATABASE}_${DATA}.dump" $PGDATABASE

if [ $? -eq 0 ]; then
  echo "[OK] Backup gerado em: ${PGDATABASE}_${DATA}.dump"
else
  echo "[ERRO] Falha ao gerar backup de $PGDATABASE em $DATA"
  exit 1
fi
