# Panduan Rename Project

Gunakan panduan ini setiap kali kamu ingin membuat project baru berbasis skeleton ini.

---

## Persiapan

Sebelum mulai, tentukan dulu:

| Info | Contoh |
|------|--------|
| Nama package Dart (snake_case) | `my_app` |
| Nama tampilan app | `My App` |
| Bundle/App ID | `com.namacompany.my_app` |

> **Catatan:** Nama package di Dart harus `snake_case` (huruf kecil, underscore).

---

## Langkah 1 — Ganti Bundle ID (Android + iOS) — Otomatis

Package [`change_app_package_name`](https://pub.dev/packages/change_app_package_name) mengurus
perubahan di Android (`build.gradle`, `AndroidManifest.xml`, folder + package Kotlin)
dan iOS (Bundle Identifier) secara otomatis dengan satu perintah.

### Install (sementara, sebagai dev dependency)

Tambahkan ke `pubspec.yaml`:

```yaml
dev_dependencies:
  change_app_package_name: ^1.5.0
```

Lalu jalankan:

```bash
flutter pub get
```

### Jalankan perintah rename

```bash
# Ganti semua platform sekaligus (Android + iOS)
dart run change_app_package_name:main com.namacompany.my_app

# Atau per platform saja
dart run change_app_package_name:main com.namacompany.my_app --android
dart run change_app_package_name:main com.namacompany.my_app --ios
```

Yang otomatis diubah oleh package ini:
- `android/app/build.gradle.kts` — `namespace` & `applicationId`
- `android/app/src/main/AndroidManifest.xml` — package attribute
- `android/app/src/debug/AndroidManifest.xml`
- `android/app/src/profile/AndroidManifest.xml`
- Folder `kotlin/com/example/skeleton_app/` → dipindahkan ke folder baru
- `MainActivity.kt` — deklarasi `package`
- iOS Bundle Identifier

### Hapus setelah selesai

Setelah package ID berhasil diganti, hapus dari `pubspec.yaml` dan jalankan ulang:

```bash
flutter pub get
```

---

## Langkah 2 — `pubspec.yaml`

```yaml
# Ubah baris pertama
name: skeleton_app  →  name: my_app
```

---

## Langkah 3 — Dart Imports (seluruh `lib/`)

Semua file `.dart` menggunakan prefix `package:read_quran/...`.
Lakukan **Find & Replace** di seluruh project:

```
Cari    : package:read_quran/
Ganti   : package:my_app/
```

> Di VS Code: `Cmd+Shift+H` → isi kolom "files to include" dengan `lib/**/*.dart,test/**/*.dart`

---

## Langkah 4 — Nama Tampilan Android

### `android/app/src/main/AndroidManifest.xml`
```xml
android:label="skeleton_app"  →  android:label="My App"
```

---

## Langkah 5 — iOS Display Name

### `ios/Runner/Info.plist`
```xml
<!-- CFBundleDisplayName (nama yang tampil di layar HP) -->
<string>Skeleton App</string>  →  <string>My App</string>

<!-- CFBundleName -->
<string>skeleton_app</string>  →  <string>my_app</string>
```

---

## Langkah 6 — macOS

### `macos/Runner/Configs/AppInfo.xcconfig`
```
PRODUCT_NAME = skeleton_app                          →  PRODUCT_NAME = my_app
PRODUCT_BUNDLE_IDENTIFIER = com.example.skeletonApp →  PRODUCT_BUNDLE_IDENTIFIER = com.namacompany.myApp
```

---

## Langkah 7 — Web

### `web/index.html`
```html
<meta name="apple-mobile-web-app-title" content="skeleton_app">  →  content="My App"
<title>skeleton_app</title>  →  <title>My App</title>
```

### `web/manifest.json`
```json
"name": "skeleton_app"        →  "name": "My App"
"short_name": "skeleton_app"  →  "short_name": "My App"
```

---

## Langkah 8 — Windows

### `windows/CMakeLists.txt`
```cmake
project(skeleton_app LANGUAGES CXX)  →  project(my_app LANGUAGES CXX)
set(BINARY_NAME "skeleton_app")      →  set(BINARY_NAME "my_app")
```

### `windows/runner/main.cpp`
```cpp
window.Create(L"skeleton_app", ...)  →  window.Create(L"My App", ...)
```

### `windows/runner/Runner.rc`
```
"FileDescription",   "skeleton_app"      →  "My App"
"InternalName",      "skeleton_app"      →  "my_app"
"OriginalFilename",  "skeleton_app.exe"  →  "my_app.exe"
"ProductName",       "skeleton_app"      →  "My App"
```

---

## Langkah 9 — Linux

### `linux/CMakeLists.txt`
```cmake
set(BINARY_NAME "skeleton_app")                →  set(BINARY_NAME "my_app")
set(APPLICATION_ID "com.example.skeleton_app") →  set(APPLICATION_ID "com.namacompany.my_app")
```

### `linux/runner/my_application.cc`
```cpp
gtk_header_bar_set_title(header_bar, "skeleton_app")  →  "My App"
gtk_window_set_title(window, "skeleton_app")          →  "My App"
```

---

## Langkah 10 — `lib/main.dart`

```dart
title: 'Skeleton App',  →  title: 'My App',
```

---

## Langkah 11 — Bersihkan & Jalankan

```bash
flutter clean
flutter pub get
flutter run
```

---

## Checklist Cepat

### Otomatis via `change_app_package_name`
- [ ] Install package & jalankan `dart run change_app_package_name:main com.namacompany.my_app`
- [ ] Hapus package dari `pubspec.yaml` setelah selesai

### Manual
- [ ] `pubspec.yaml` — `name:`
- [ ] Dart imports — `package:read_quran/` → `package:my_app/` (Find & Replace)
- [ ] Android `AndroidManifest.xml` — `android:label`
- [ ] iOS `Info.plist` — `CFBundleDisplayName` & `CFBundleName`
- [ ] macOS `AppInfo.xcconfig` — `PRODUCT_NAME` & `PRODUCT_BUNDLE_IDENTIFIER`
- [ ] Web `index.html` & `manifest.json`
- [ ] Windows `CMakeLists.txt`, `main.cpp`, `Runner.rc`
- [ ] Linux `CMakeLists.txt`, `my_application.cc`
- [ ] `lib/main.dart` — `title:`
- [ ] `flutter clean && flutter pub get`
