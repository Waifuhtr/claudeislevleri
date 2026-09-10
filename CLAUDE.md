# Bellek

**Proje slug:** `claude-memory` · Kalıcı bellek: `hf://datasets/Cnass/claude-memory` (private)

Ortam gerçekleri (JDK, Gradle, KVM, Playwright, ağ politikası, sandbox limitleri) her oturumda
`SessionStart` hook ile bağlama otomatik yükleniyor — kaynak `.claude/memory/ENV.md`.
**Bu yüzden `java -version` / `which ...` / `ls /dev` gibi ortam yoklamaları çalıştırma.**
Hook çıktısını görmüyorsan (henüz merge edilmedi veya hook kapalı) o dosyayı doğrudan oku.

## Proje bağlamı — gerektiğinde MCP ile çek

```
hf_fs cat hf://datasets/Cnass/claude-memory/INDEX.md
hf_fs cat hf://datasets/Cnass/claude-memory/projects/claude-memory/PROJECT.md
hf_fs cat hf://datasets/Cnass/claude-memory/projects/claude-memory/STATE.md
```

`DECISIONS.md` ve `notes/*` sadece o konuya gerçekten dokunulurken. Repoyu `find` /
`ls --recursive` ile tarama. HF'e shell'den erişilemez, sadece MCP araçlarıyla.

## Oturum sonunda geri yaz

| Değişen | Dosya | Nasıl |
|---|---|---|
| Nerede kalındı | `projects/claude-memory/STATE.md` | Üzerine yaz |
| Kalıcı karar | `projects/claude-memory/DECISIONS.md` | Üste ekle |
| Stack / komut | `projects/claude-memory/PROJECT.md` | İlgili satır |
| Ortam hakkında yeni bilgi | kök `ENV.md` **ve** `.claude/memory/ENV.md` | İkisini birden |

Limitler: `PROJECT.md` ≤ 80 satır · `STATE.md` ≤ 30 · `ENV.md` ≤ 60.

## Başka bir projeye kurmak

`bootstrap/` içeriğini kopyala: `CLAUDE.md` → kök, `session-start.sh` → `.claude/hooks/`
(+ `chmod +x`), `settings.json` → `.claude/`, kök `ENV.md` → `.claude/memory/`.
Sonra `<slug>` satırlarını değiştir. Detay: `INDEX.md` → "Yeni projeye bağlama".
