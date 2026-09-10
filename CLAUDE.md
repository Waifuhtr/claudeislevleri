# Oturuma başlarken: önce belleği oku

Bu projenin bilgisi bu konteynerde **yok** — kalıcı bellekte tutuluyor:
`hf://datasets/Cnass/claude-memory` (private HF dataset). Konteyner her oturumda sıfırlanır, bellek kalmaz.

**Proje slug:** `claude-memory`

## 1. Başka bir şey yapmadan önce oku

Hugging Face MCP ile, sırayla — sadece bu üçü:

1. `hf_fs cat hf://datasets/Cnass/claude-memory/INDEX.md`
2. `hf_fs cat hf://datasets/Cnass/claude-memory/projects/claude-memory/PROJECT.md`
3. `hf_fs cat hf://datasets/Cnass/claude-memory/projects/claude-memory/STATE.md`

## 2. Ortamı elle keşfetme — bellek okunmadan `bash` çalıştırma

Hangi araçların kurulu olduğu, neyin çalışıp neyin çalışmadığı **zaten test edildi** ve
`PROJECT.md` → Tuzaklar bölümüne yazıldı: JDK, Gradle, KVM, Playwright, sandbox limitleri.
`java -version` / `which ...` / `ls /dev` gibi yoklamalara gerek yok — cevap dosyada.

Ölçüldü: sadece elle keşif 46.8k token · bellek **+** elle keşif 55.3k · sadece bellek ~2k.
Belleği okuyup yine de elle yoklamak en pahalı seçenek.

Bellekteki bilgi eksikse ya da gözlemlediğinle çelişiyorsa — o zaman test et, sonra
**sonucu geri yaz**. Bellek ancak güncel tutulursa işe yarar.

`DECISIONS.md` ve `notes/*` sadece o konuya gerçekten dokunulurken çekilir.
Repoyu `find` / `ls --recursive` ile tarama; yönlendirme `INDEX.md`'den yapılır.

## 3. Oturum sonunda geri yaz

Kalıcı bir şey değiştiyse `hf_fs_write put` ile:

| Değişen | Dosya | Nasıl |
|---|---|---|
| Nerede kalındı | `STATE.md` | Üzerine yaz |
| Kalıcı karar | `DECISIONS.md` | Üste ekle |
| Stack / komut / tuzak | `PROJECT.md` | İlgili satırı düzenle |

Limitler: `PROJECT.md` ≤ 80 satır · `STATE.md` ≤ 30 satır. Aşarsan özetle veya `notes/` altına taşı.

## Başka bir projeye bağlamak

`hf://datasets/Cnass/claude-memory/bootstrap/CLAUDE.md` dosyasını o reponun köküne
`CLAUDE.md` olarak kopyala, slug satırlarını değiştir, `INDEX.md` tablosuna satır ekle.
