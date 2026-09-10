#!/bin/bash
set -euo pipefail

# Stdout'u oturum bağlamına enjekte edilir. Ağa çıkmaz: huggingface.co egress
# politikasıyla engelli (403 CONNECT), bu yüzden ortam gerçekleri yerel kopyadan okunur.

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
ENV_FILE="$PROJECT_DIR/.claude/memory/ENV.md"
SLUG="claude-memory"

cat <<PROTOCOL
=== KALICI BELLEK ===

Proje geçmişi ve kararlar bu blokta DEĞİL, HF'te. Gerektiğinde MCP ile çek:
  hf_fs cat hf://datasets/Cnass/claude-memory/INDEX.md
  hf_fs cat hf://datasets/Cnass/claude-memory/projects/$SLUG/PROJECT.md
  hf_fs cat hf://datasets/Cnass/claude-memory/projects/$SLUG/STATE.md

Oturum sonunda kalıcı bir şey değiştiyse hf_fs_write put ile geri yaz:
STATE.md (üzerine yaz) · DECISIONS.md (üste ekle) · PROJECT.md (ilgili satır).
PROTOCOL

# Ortam gerçekleri yalnızca uzak konteynerde geçerli; yerel makinede yanıltıcı olur.
if [ "${CLAUDE_CODE_REMOTE:-}" = "true" ]; then
  if [ -f "$ENV_FILE" ]; then
    cat <<'NOTICE'

Aşağıdaki ortam gerçekleri test edilip doğrulanmıştır. Bunları yeniden keşfetmek için
`java -version`, `which ...`, `ls /dev` gibi yoklamalar ÇALIŞTIRMA — cevap zaten burada.
Ölçüldü: elle keşif 46.8k token, bu blok ~700.
NOTICE
    echo
    cat "$ENV_FILE"
  else
    echo
    echo "UYARI: $ENV_FILE yok — ortam gerçekleri yüklenemedi, bellekten yeniden senkronla."
  fi
fi

echo
echo "=== bellek sonu ==="
