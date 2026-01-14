#!/bin/bash

# Usage:
#   ./rotating_backup.sh /path/to/source /path/to/destination 5 [--notify]

SRC="$1"
DEST="$2"
MAX_KEEP="$3"
NOTIFY="$4"
MIN_FREE_MB=200 # minimum free MB required

# Lowercase folder name
SRC_NAME=$(basename "$SRC" | tr '[:upper:]' '[:lower:]')

# Ensure destination exists
mkdir -p "$DEST"

# Timestamp for filenames: YYYYMMDD
TIMESTAMP=$(date +"%Y%m%d")

# Backup and log files
BACKUP_FILE="$DEST/${SRC_NAME}_backup_${TIMESTAMP}.tar.xz"
LOGFILE="$DEST/${SRC_NAME}_backup_${TIMESTAMP}.log"

# Path to notification script
NOTIFY_SCRIPT="$HOME/bin/send_notification.sh"

# Logging function
log() {
  echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOGFILE"
}

# Helper to send notification if enabled
notify() {
  if [ "$NOTIFY" = "--notify" ] && [ -x "$NOTIFY_SCRIPT" ]; then
    "$NOTIFY_SCRIPT" "$1"
  fi
}

# --- argument checks ---
if [ -z "$SRC" ] || [ -z "$DEST" ] || [ -z "$MAX_KEEP" ]; then
  echo "Usage: $0 <source_path> <destination_path> <num_backups_to_keep> [--notify]"
  exit 1
fi

if [ ! -d "$SRC" ]; then
  log "ERROR: Source directory does not exist: $SRC"
  notify "Backup FAILED: Source directory does not exist: $SRC"
  exit 1
fi

# --- disk space check ---
FREE_MB=$(df -Pm "$DEST" | awk 'NR==2 {print $4}')
if [ "$FREE_MB" -lt "$MIN_FREE_MB" ]; then
  log "ERROR: Not enough disk space in $DEST (free: ${FREE_MB}MB, required: ${MIN_FREE_MB}MB)"
  notify "Backup FAILED: Not enough disk space in $DEST (free: ${FREE_MB}MB)"
  exit 1
fi

# --- create backup with xz compression ---

# Remove trailing slashes
SRC="${SRC%/}"
DEST="${DEST%/}"

SRC_NAME=$(basename "$SRC" | tr '[:upper:]' '[:lower:]')
TIMESTAMP=$(date +"%Y%m%d")

BACKUP_FILE="$DEST/${SRC_NAME}_backup_${TIMESTAMP}.tar.xz"
LOGFILE="$DEST/${SRC_NAME}_backup_${TIMESTAMP}.log"

log "Starting backup of $SRC to $BACKUP_FILE"

# Use tar with fully quoted paths and -- to handle spaces and hidden files
tar -cJf "$BACKUP_FILE" -C "$(dirname "$SRC")" -- "$(basename "$SRC")" 2>>"$LOGFILE"
if [ $? -ne 0 ]; then
  log "ERROR: Backup failed!"
  notify "Backup FAILED: $SRC. Check log: $LOGFILE"
  exit 1
else
  log "Backup created successfully."
  notify "Backup completed successfully: $BACKUP_FILE"
fi

# --- rotation logic ---
log "Checking for old backups to rotate..."

BACKUP_LIST=$(ls -1t "$DEST"/${SRC_NAME}_backup_*.tar.xz 2>/dev/null)
TOTAL_BACKUPS=$(echo "$BACKUP_LIST" | wc -l)

if [ "$TOTAL_BACKUPS" -gt "$MAX_KEEP" ]; then
  FILES_TO_DELETE=$((TOTAL_BACKUPS - MAX_KEEP))
  log "Will delete $FILES_TO_DELETE old backup(s)."

  echo "$BACKUP_LIST" | tail -n "$FILES_TO_DELETE" | while read -r OLD_BACKUP; do
    OLD_TIMESTAMP=$(basename "$OLD_BACKUP" | sed -E "s/^${SRC_NAME}_backup_([0-9]+)\.tar\.xz/\1/")
    OLD_LOG="$DEST/${SRC_NAME}_backup_${OLD_TIMESTAMP}.log"

    rm -f "$OLD_BACKUP"
    log "Deleted backup: $OLD_BACKUP"

    if [ -f "$OLD_LOG" ]; then
      rm -f "$OLD_LOG"
      log "Deleted log: $OLD_LOG"
    else
      log "Warning: Log file not found for: $OLD_BACKUP"
    fi
  done
else
  log "No rotation needed. $TOTAL_BACKUPS backup(s) kept."
fi

log "Backup job completed successfully."
exit 0
