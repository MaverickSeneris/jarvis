#!/bin/bash

echo "🧼 Shutting down Jarvis and cleaning memory, Sir Maverick..."

# Stop all running Ollama models
ollama list | awk '/running/ {print $1}' | while read model; do
    echo "🧠 Stopping model: $model"
    ollama stop "$model"
done

# Kill voice-related processes
echo "🎙️ Killing audio and whisper processes..."
pkill -f whisper
pkill -f arecord
pkill -f piper

# Clear RAM cache (safe)
echo "🧹 Clearing system cache..."
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

# Done
echo "✅ All clean, Sir. Jarvis is fully disengaged. RAM restored."
