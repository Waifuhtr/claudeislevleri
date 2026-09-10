# Bellek

Bu projenin kalıcı belleği: `hf://datasets/Cnass/claude-memory` (private HF dataset).

**Proje slug:** `claude-memory`

## Oturum başında

Hugging Face MCP aracıyla sırayla oku — **sadece bu üçü**:

1. `hf_fs cat hf://datasets/Cnass/claude-memory/INDEX.md`
2. `hf_fs cat hf://datasets/Cnass/claude-memory/projects/claude-memory/PROJECT.md`
3. `hf_fs cat hf://datasets/Cnass/claude-memory/projects/claude-memory/STATE.md`

`DECISIONS.md` ve `notes/*` sadece o konuya gerçekten dokunulurken çekilir.
Repoyu `find` / `ls --recursive` ile tarama — yönlendirme INDEX.md'den yapılır.

## Oturum sonunda

Kalıcı bir şey değiştiyse `hf_fs_write put` ile geri yaz:

| Değişen | Dosya | Nasıl |
|---|---|---|
| Nerede kalındı | `STATE.md` | Üzerine yaz |
| Kalıcı karar | `DECISIONS.md` | Üste ekle |
| Stack / komut / tuzak | `PROJECT.md` | İlgili satırı düzenle |

Limitler: `PROJECT.md` ≤ 80 satır · `STATE.md` ≤ 30 satır. Aşarsan özetle veya `notes/` altına taşı.

## Başka bir projeye bağlamak

`hf://datasets/Cnass/claude-memory/bootstrap/CLAUDE.md` dosyasını o reponun köküne
`CLAUDE.md` olarak kopyala, slug satırını değiştir, `INDEX.md` tablosuna satır ekle.
