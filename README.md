# Jokopi Coffee Shop

Repo **Jokopi** ini berisi dua aplikasi yang terintegrasi:

1. 🎯 **jokopi-api**: Backend REST API dengan Node.js, Express, PostgreSQL & MongoDB, menggunakan HTTPS.
2. 🎨 **jokopi-react**: Frontend React + Tailwind CSS, di-serve melalui Docker & HTTPS.

> ⚠️ Sebagian kode frontend dan backend diambil dari [k1rana](https://github.com/k1rana) dan telah dimodifikasi untuk keperluan UAS. Terima kasih! 🙏

---

## Daftar Isi

1. [Prasyarat](#prasyarat)
2. [Persiapan Sertifikat HTTPS](#persiapan-sertifikat-https)
3. [Variabel Lingkungan](#variabel-lingkungan)
4. [Menjalankan Aplikasi](#menjalankan-aplikasi)
5. [Mengakses Aplikasi](#mengakses-aplikasi)
6. [Trust Sertifikat (Dev)](#trust-sertifikat-dev)
7. [Tips Produksi](#tips-produksi)
8. [Kontributor & Lisensi](#kontributor--lisensi)

---

## Prasyarat

* **Docker** & **Docker Compose** (v1 atau v2)
* **OpenSSL** (untuk generate self-signed cert)
* (Opsional) **mkcert** jika ingin trust sertifikat otomatis di browser

---

## Persiapan Sertifikat HTTPS

### 1. Generate Manual (via start.sh)

Jalankan `./start.sh` sekali. Skrip akan:

* Membuat `certs/api.key` & `certs/api.crt` (ECDSA) untuk API jika belum ada.
* Membuat `certs/react.key` & `certs/react.crt` (RSA 2048) untuk React jika belum ada.

### 2. Atau gunakan **mkcert** (direkomendasikan)

```bash
# Install mkcert & trust root CA lokal
mkcert -install
# Buat cert untuk localhost
mkcert localhost 127.0.0.1 ::1
```

File hasil: `localhost+2.pem` & `localhost+2-key.pem`, sudah trusted.

---

## Variabel Lingkungan

1. Masuk ke folder `jokopi-api/`.
2. Salin file `.env.example` menjadi `.env`:

   ```sh
   cp .env.example .env
   ```
3. Buka file `.env` dan isi semua nilai variabel sesuai petunjuk yang ada di template `.env.example`.

---

## Menjalankan Aplikasi

Setelah sertifikat & env siap:

```bash
# Beri izin dan jalankan skrip
chmod +x start.sh
./start.sh
```

Skrip ini akan otomatis rebuild dan up semua container.

---

## Mengakses Aplikasi

* 🔗 **Frontend**: `https://localhost` (port 80 secara default)
* 🔗 **Backend API**: `https://localhost:5000/apiv1/...`

Karena pakai self-signed, browser mungkin peringatkan. Lanjutkan ke “Advanced → Proceed” atau trust sertifikat.

---

## Trust Sertifikat (Dev)

* **Ubuntu/Debian**:

  ```bash
  sudo cp certs/api.crt /usr/local/share/ca-certificates/jokopi-api.crt
  sudo update-ca-certificates
  ```
* **Firefox**: Preferences → Privacy & Security → Certificates → View Certificates → Authorities → Import → pilih `api.crt` → centang Trust.
* **Chrome/Chromium**: ikuti system store setelah update-ca-certificates.

Jika menggunakan **mkcert**, trust sudah otomatis.

---

## Tips Produksi

* Ganti self-signed dengan sertifikat resmi (Let’s Encrypt ECDSA atau RSA).
* Letakkan key privat di **secret manager** (Vault, AWS Secrets Manager, Kubernetes Secret).
* Gunakan reverse proxy (Nginx) untuk terminate TLS dan serve statis.

---

## Kontributor & Lisensi

* Security & Infrastruktur: Kevin Kresna.
* Frontend & Backend: k1rana ([https://github.com/k1rana](https://github.com/k1rana)). Terima kasih!

Lisensi MIT © 2025 Jokopi Project
