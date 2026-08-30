#!/bin/bash

export RESTIC_REPOSITORY="sftp:dani@192.168.2.4:/mnt/data/backups/users/dani"
export RESTIC_PASSWORD_FILE="$HOME/.config/restic/password"

restic backup \
  --exclude "/run/media/dani/secure-storage-2/Cloud Storage/Nextcloud/Photo Library" \
  "/run/media/dani/secure-storage-2/Cloud Storage/Nextcloud"

restic forget \
  --keep-last 7 \
  --keep-weekly 4 \
  --keep-monthly 12 \
  --prune
