#!/bin/bash

# 📦 Jarvis AI Backup Script
# Creates a timestamped tar.gz backup of the ~/jarvis folder and important configs

BACKUP_DIR="$HOME/jarvis/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="jarvis_backup_$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"
echo "🔄 Creating backup: $BACKUP_FILE..."

tar -czvf "$BACKUP_DIR/$BACKUP_FILE" \
    "$HOME/jarvis" \
    "$HOME/.bashrc" \
    "$HOME/.local/share/piper/models/en/en_GB-northern_english_male-medium.onnx" \
    "$HOME/.ollama/models" \
    --exclude='*.wav' \
    --exclude='*.txt' \
    --exclude='__pycache__' \
    --exclude='venv/lib/*/site-packages/*/__pycache__' \
    --exclude='*.log'

echo "✅ Backup completed: $BACKUP_DIR/$BACKUP_FILE"
echo "You may copy this archive to a USB, NAS, or remote server."
