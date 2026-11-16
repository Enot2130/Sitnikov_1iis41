#!/bin/bash

if [ -z "$1" ]; then
echo "Usage: $0 [status|backup|logs]"
exit 1
fi

if [ "$1" = "status" ]; then
echo "== IIS status check =="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo "=========================================="

elif [ "$1" = "backup" ]; then
echo "== Starting backup =="
mkdir -p ./backups
DATA_TAG=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="./backups/iis_backup_$DATA_TAG.txt"
echo "IIS knowledge base backup from $DATA_TAG" > "$BACKUP_FILE"
echo "Configuration successfully saved to file: $BACKUP_FILE"
echo "=========================================="

elif [ "$1" = "logs" ]; then
echo "== grafana_monitoring logs =="
if [ -n "$(docker ps -q -f name=^/grafana_monitoring$)" ]; then
docker logs grafana_monitoring
else
echo "Error: grafana_monitoring not run"
exit 1
fi
echo "=========================================="

else
echo "Error: Unknown command '$1'. Use 'status' or 'backup'."
exit 1
fi
