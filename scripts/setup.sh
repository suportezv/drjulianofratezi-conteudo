#!/usr/bin/env bash
# Setup do estúdio de conteúdo (Linux/cloud). Agnóstico de marca: o symlink usa o
# nome da pasta do repo. No Mac, siga SETUP.md manualmente.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TOOLS_DIR="${TOOLS_DIR:-/workspace}"
VIDEO_USE="$TOOLS_DIR/browser-use/video-use"
HYPERFRAMES="$TOOLS_DIR/heygen-com/hyperframes"

echo "== 1/5 ffmpeg =="
if ! command -v ffmpeg >/dev/null; then
  if ! { apt-get update -qq && apt-get install -y -qq ffmpeg fonts-liberation; } 2>/dev/null; then
    # Cloud desta conta: apt bloqueado pelo proxy (403 em HTTP). Build estático GPL
    # do BtbN tem subtitles (libass), zscale (zimg) e zoompan.
    echo "apt bloqueado; instalando ffmpeg estático (BtbN, github releases)"
    curl -sL -o /tmp/ffmpeg.tar.xz "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz"
    tar xf /tmp/ffmpeg.tar.xz -C /tmp
    cp /tmp/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg /tmp/ffmpeg-master-latest-linux64-gpl/bin/ffprobe /usr/local/bin/
    rm -rf /tmp/ffmpeg.tar.xz /tmp/ffmpeg-master-latest-linux64-gpl
  fi
fi
ffmpeg -version | head -1

echo "== 2/5 video-use =="
if [ ! -d "$VIDEO_USE/.git" ]; then
  GIT_LFS_SKIP_SMUDGE=1 git clone --depth 1 https://github.com/browser-use/video-use "$VIDEO_USE"
fi
if git -C "$VIDEO_USE" apply --check "$REPO_ROOT/patches/video-use-is-portrait-source.patch" 2>/dev/null; then
  git -C "$VIDEO_USE" apply "$REPO_ROOT/patches/video-use-is-portrait-source.patch"
  echo "patch is_portrait_source aplicado"
else
  echo "patch is_portrait_source: já aplicado ou não aplicável (verifique manualmente)"
fi
(cd "$VIDEO_USE" && uv sync) || (cd "$VIDEO_USE" && pip install -e .)
mkdir -p ~/.claude/skills
ln -sfn "$VIDEO_USE" ~/.claude/skills/video-use

echo "== 3/5 hyperframes + media-use =="
if [ ! -d "$HYPERFRAMES/.git" ]; then
  GIT_LFS_SKIP_SMUDGE=1 git clone --depth 1 https://github.com/heygen-com/hyperframes "$HYPERFRAMES"
fi
# O update remoto falha onde raw.githubusercontent.com é bloqueado; fallback: symlink do clone local.
npx --yes hyperframes skills update || true
if [ ! -e ~/.claude/skills/hyperframes ]; then
  for d in "$HYPERFRAMES/skills"/*/; do ln -sfn "$d" ~/.claude/skills/"$(basename "$d")"; done
  echo "skills do hyperframes registradas por symlink do clone local"
fi

echo "== 4/5 Python (PIL para overlays, numpy para batidas) =="
python3 -c 'import PIL' 2>/dev/null || pip3 install pillow
python3 -c 'import numpy' 2>/dev/null || pip3 install numpy

echo "== 5/5 estúdio =="
STUDIO_NAME="$(basename "$REPO_ROOT")"
ln -sfn "$REPO_ROOT" ~/"$STUDIO_NAME"
echo "~/$STUDIO_NAME -> $REPO_ROOT"

if [ ! -f "$VIDEO_USE/.env" ]; then
  if [ -n "${ELEVENLABS_API_KEY:-}" ]; then
    printf 'ELEVENLABS_API_KEY=%s\n' "$ELEVENLABS_API_KEY" > "$VIDEO_USE/.env"
    echo "ELEVENLABS_API_KEY gravada em $VIDEO_USE/.env (da env var do environment)"
  else
    echo "PENDENTE: gravar ELEVENLABS_API_KEY em $VIDEO_USE/.env (peça ao usuário; chave sk_ de 51 chars)"
  fi
fi
echo "Setup concluído. Rode: bash $REPO_ROOT/scripts/validate.sh"
