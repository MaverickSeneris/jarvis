#!/bin/bash
source ~/jarvis/venv/bin/activate

# One-time Greeting
echo "At your service, Sir Maverick." | \
piper --model ~/.local/share/piper/models/en/en_GB-northern_english_male-medium.onnx --output-raw | \
aplay -r 22050 -f S16_LE -

while true; do
  # RECORD VOICE
  echo "[🎙️ Listening... Speak now]"
  arecord -d 5 -r 16000 -f S16_LE -t wav /tmp/voice.wav

  # TRANSCRIBE WITH WHISPER (save to /tmp)
  whisper /tmp/voice.wav --language English --model base --fp16 False -o /tmp

  # LOAD TRANSCRIPTION
  if [[ -f /tmp/voice.txt ]]; then
    TRANSCRIPT=$(cat /tmp/voice.txt)
  else
    echo "⚠️ Whisper did not produce a transcript, Sir."
    continue
  fi

  # DISPLAY
  echo "[📜 You said]: $TRANSCRIPT"

  # EMPTY CHECK
  if [[ -z "$TRANSCRIPT" ]]; then
    echo "⚠️ I didn’t catch that, Sir Maverick."
    continue
  fi

  # EXIT CONDITION
  if echo "$TRANSCRIPT" | grep -qiE "^(exit|quit|shutdown|bye)"; then
    echo "Very well, Sir. Shutting down." | \
    piper --model ~/.local/share/piper/models/en/en_GB-northern_english_male-medium.onnx --output-raw | \
    aplay -r 22050 -f S16_LE -
    break
  fi

  # RUN THROUGH JARVIS (OLLAMA)
  RESPONSE=$(echo "$TRANSCRIPT" | ollama run jarvis)

  # DISPLAY + SPEAK RESPONSE
  echo "[🤖 Jarvis says]: $RESPONSE"
  echo "$RESPONSE" | \
  piper --model ~/.local/share/piper/models/en/en_GB-northern_english_male-medium.onnx --output-raw | \
  aplay -r 22050 -f S16_LE -

  # CLEANUP
  rm -f /tmp/voice.txt /tmp/voice.json /tmp/voice.wav
done

