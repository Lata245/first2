#!/bin/bash

# Database credentials
DB_USER="your_db_user"
DB_PASSWORD="your_db_password"
DB_NAME="your_db_name"

# Backup directory and filename
BACKUP_DIR="/path/to/backup/directory"
DATE=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.sql"

# Maintenance tasks
MAINTENANCE_LOG="/path/to/maintenance.log"

# Database backup
echo "Starting database backup..."
mysqldump -u $DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_FILE
if [ $? -eq 0 ]; then
  echo "Database backup completed successfully."
else
  echo "Error: Database backup failed." >> $MAINTENANCE_LOG
fi

# Maintenance tasks (e.g., optimizing tables, etc.)
echo "Starting database maintenance..."
mysql -u $DB_USER -p$DB_PASSWORD -e "OPTIMIZE TABLE your_table;" $DB_NAME
if [ $? -eq 0 ]; then
  echo "Database maintenance completed successfully."
else
  echo "Error: Database maintenance failed." >> $MAINTENANCE_LOG
fi

# You can add more maintenance tasks here as needed

# Clean up old backups (optional)
find $BACKUP_DIR -type f -name 'backup_*' -mtime +7 -exec rm {} \;

echo "Maintenance tasks completed. See $MAINTENANCE_LOG for details."

