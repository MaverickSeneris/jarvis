#!/bin/bash

echo "🛠️ Setting up Jarvis AI... Buckle up, Sir Maverick."

# --- Log File ---
LOG="$HOME/jarvis/install.log"
mkdir -p ~/jarvis/logs
echo "Setup started at $(date)" > "$LOG"

# --- Update & Install Dependencies ---
sudo apt update && sudo apt install -y git python3 python3-venv python3-pip sox ffmpeg build-essential \
    cmake libespeak-ng-dev portaudio19-dev libsndfile1 wget unzip curl >> "$LOG" 2>&1

# --- Create Python Virtual Environment ---
cd ~/jarvis || exit 1
python3 -m venv venv >> "$LOG" 2>&1
source venv/bin/activate

# --- Install Whisper ---
pip install --upgrade pip >> "$LOG" 2>&1
pip install openai-whisper >> "$LOG" 2>&1

# --- Install Ollama ---
if ! command -v ollama &> /dev/null; then
    echo "📦 Installing Ollama..." | tee -a "$LOG"
    curl -fsSL https://ollama.com/install.sh | sh >> "$LOG" 2>&1
else
    echo "✅ Ollama already installed." | tee -a "$LOG"
fi

# --- Pull Mistral Model ---
ollama pull mistral >> "$LOG" 2>&1

# --- Build Piper ---
if [ ! -d ~/piper ]; then
    git clone https://github.com/rhasspy/piper.git ~/piper >> "$LOG" 2>&1
    cd ~/piper && mkdir build && cd build
    cmake .. >> "$LOG" 2>&1
    make -j$(nproc) >> "$LOG" 2>&1
    sudo cp piper /usr/local/bin/
fi

# --- Download Voice Model ---
mkdir -p ~/.local/share/piper/models/en
cd ~/.local/share/piper/models/en
wget -nc https://huggingface.co/rhasspy/piper-voices/resolve/main/en_GB/northern_english_male/en_GB-northern_english_male-medium.onnx >> "$LOG" 2>&1

# --- Add Aliases ---
echo "" >> ~/.bashrc
echo "# 🧠 Jarvis AI Aliases" >> ~/.bashrc
echo "alias jarvis='ollama run jarvis'" >> ~/.bashrc
echo "alias vjarvis='~/jarvis/voice-jarvis.sh'" >> ~/.bashrc
echo "alias unjarvis='~/jarvis/stop-jarvis.sh'" >> ~/.bashrc
echo "alias jcheck='~/jarvis/jarvis-diagnostics.sh'" >> ~/.bashrc
source ~/.bashrc

# --- .gitignore ---
cat > .gitignore <<EOF
venv/
logs/
*.wav
*.txt
/tmp/
~/.local/share/piper/models/
~/.ollama/models/
EOF

# --- README.md ---
cat > README.md <<EOF
# 🧠 Jarvis AI (Offline ChatGPT Assistant)

Your personal, privacy-respecting offline AI assistant. Built with:

- 🧠 Ollama (Mistral model)
- 🎤 Whisper (voice-to-text)
- 🔊 Piper TTS (Jarvis voice)
- 🐧 Bash-powered interface

> "At your service, Sir Maverick."

### Commands:
- \`jarvis\` – Text-based chat
- \`vjarvis\` – Voice-based assistant
- \`unjarvis\` – Stop Ollama
- \`jcheck\` – System diagnostics
EOF

# --- Test the Voice Output ---
echo "Boot complete. Jarvis online and at your service." | \
piper --model ~/.local/share/piper/models/en/en_GB-northern_english_male-medium.onnx --output-raw | \
aplay -r 22050 -f S16_LE -

echo "✅ Jarvis AI setup is complete, Sir Maverick. Use 'jarvis' or 'vjarvis' anytime." | tee -a "$LOG"
