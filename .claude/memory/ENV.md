# Ortam Gerçekleri

> Kopya — canonical kaynak `hf://datasets/Cnass/claude-memory/ENV.md`.
> SessionStart hook bunu oturum bağlamına yükler (hook ağa çıkamaz, "Ağ" bölümüne bak).
> Son senkron: 2026-09-10.

## Oturum konteyneri — Claude Code burada çalışır

- Ubuntu · 4 çekirdek / 15GB RAM
- **JDK 21.0.10 ve Gradle 8.14.3 zaten kurulu** — `JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64`,
  `/opt/gradle`. Ayrıca JDK kurma. `gradle assembleDebug` ile APK derlemek çalışır.
- Node 22, npm, bun, uv kurulu.
- Chromium + Playwright kurulu (`PLAYWRIGHT_BROWSERS_PATH=/opt/pw-browsers`) — web/HTML5 için
  gerçek ekran görüntüsü alınabilir. `playwright install` **çalıştırma**.
- `JAVA_TOOL_OPTIONS` proxy + truststore ayarlarıyla dolu gelir. Çıktıda görünmesi normal,
  hata değil — **`unset` etme**, yoksa Maven Central erişimi kırılır.
- `CLAUDE_CODE_REMOTE=true` ortamda set gelir — hook guard'ı test ederken `env -u` ile temizle,
  yoksa "yerel mod" testi yanlış sonuç verir.

## Ağ — egress proxy politikası

- İzinli: npm, pypi, crates.io, proxy.golang.org, Anthropic API'leri.
- **`huggingface.co` shell'den ENGELLİ** (403 CONNECT, organizasyon politikası).
  HF'e yalnızca MCP araçlarıyla erişilir (`hf_fs`, `hf_fs_write`). Hiçbir `curl` / script /
  `hf` CLI HF'e ulaşamaz. Bu yüzden SessionStart hook belleği ağdan çekemez; yerel kopya kullanır.
- Politika durumu: `curl -sS "$HTTPS_PROXY/__agentproxy/status"`

## HF sandbox — `hf_sandbox create` ile açılan ayrı makine

- Debian 13 trixie · 16 vCPU / 123GB RAM · JDK kurulu **değil**
  (apt'te `openjdk-17-*` **yok**; 21 ve 25 var).
- `hf_sandbox_exec` foreground limiti **55 sn** → uzun işler `--detach` + log dosyasına
  yönlendirme + `hf_sandbox ps` (exit_code) / `hf_sandbox_fs cat` ile takip.
- Her açılışta sıfırdan (Android SDK kurulumu ~447MB). İşin bitince `terminate` et.

## Her ikisinde de geçerli

- **`/dev/kvm` yok, `vmx`/`svm` flag'i yok** → Android Emulator (AVD) hiçbirinde çalışmaz.
  Alternatif: Paparazzi / Roborazzi (JVM'de render eder) veya KVM'li GitHub Actions runner.
- **HF Space değil dataset kullan:** Space uygulama gibi build edilmeye çalışır, app dosyası
  olmayınca error state'te kalır.
