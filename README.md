# 🧠 Jarvis: Offline AI Voice Assistant

**Jarvis** is a voice-activated offline AI assistant that runs locally — no internet, no spying, just pure functionality. Powered by `Ollama` + `Mistral`, `Whisper`, and `Piper`, Jarvis can listen to your voice, think, and respond like a charming British butler.

---

## 🚀 Features

- 🧠 **Local LLM (Mistral)** via Ollama – fully offline, fast, and private
- 🎤 **Speech Recognition** using Whisper (OpenAI)
- 🔊 **Text-to-Speech** with Piper – Northern English male voice (Jarvis-style)
- 🎙️ **Voice interaction** with greeting and smart responses
- 🧪 **System diagnostics & resource checker**
- 🗂️ **Easy backup & restore scripts**
- 🧼 **No internet required**

---

## 🛠️ Requirements

- Linux system with:
  - `ollama` installed
  - Python 3.10+
  - `arecord`, `aplay`
  - `Whisper` (installed in venv)
  - `Piper` compiled from source
- ~4GB+ RAM for smooth model use
- ~4GB disk space (models + audio)

---

## 📦 Installation

1. Clone this repo:
```bash
git clone https://github.com/YOUR_USERNAME/jarvis-ai-offline.git
cd jarvis-ai-offline
```
2. (Optional) Run setup:\
```
./setup.sh
```
3. Activate aliases:
```
source ~/.bashrc
```
---

## 🧪 Usage

| Command    | Description                         |
| ---------- | ----------------------------------- |
| `jarvis`   | Text chat with your AI              |
| `vjarvis`  | Voice mode with greeting + response |
| `unjarvis` | Stops Ollama                        |
| `jcheck`   | Show CPU, RAM, GPU, tokens per sec  |

---

## 🗃️ Backup System

To save a full working backup:

```bash
./backup.sh
```

---

## 📁 Directory Layout (Simplified)

```bash
~/jarvis
├── voice-jarvis.sh
├── stop-jarvis.sh
├── Modelfile
├── backup.sh
├── setup.sh
├── venv/                  # Whisper virtualenv
└── .bash_aliases          # Contains your custom commands
```

---

## 🧙 Author

Crafted with love and ambition by **Sir Maverick of Rizal**, for those who want their own Jarvis without selling their soul to the cloud.

---

## 🔒 Privacy First

This assistant **never connects to the internet** or leaks your data. Your voice stays yours.

---

## 📖 License

MIT – Free for personal, educational, and experimental use.

```

---

Let me know if you'd like to include screenshots, a banner, or demo video later. Shall I save this into your repo as `README.md`?
```

Certainly, Sir Maverick. Here’s the updated `README.md` section with **`.tar.gz` backup instructions**, perfect for portability or setup on another machine (like your brother’s):

---

### 📦 Create a `.tar.gz` Backup

To compress your entire `jarvis` system into a portable archive:

```bash
tar -czvf jarvis-backup.tar.gz ~/jarvis
```

This will create a file called `jarvis-backup.tar.gz` in your current directory.

---

### 📂 Restore from `.tar.gz` on Another Machine

1. Copy the `.tar.gz` file to the new machine (via USB or SCP)
2. Extract it to your home directory:

```bash
tar -xzvf jarvis-backup.tar.gz -C ~/
```

3. Reactivate your virtual environment and aliases:

```bash
cd ~/jarvis
source venv/bin/activate
source ~/.bashrc
```

4. Launch your butler:

```bash
vjarvis
```

---

✅ Would you like me to now add this directly into your `README.md` file and regenerate the full one for GitHub?

