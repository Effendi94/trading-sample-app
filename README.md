# Trading Sample App

Flutter v3.29.3 • channel stable • https://github.com/flutter/flutter.git

Dart 3.7.2 • DevTools 2.42.3

## 🎥 Demo Video

[🎬 Watch Demo Video](demo/demo_trading_simple_app.mp4)

[▶️ Watch Demo on Google Drive](https://drive.google.com/file/d/1VvFx7x4YlO2KPLrnQRLNSzPRuovff00K/view?usp=sharing)

## Cara Run Project

- clone repo

- masuk ke project directory

- install package

- run generator

- run the application (web or mobile)

## Command Line

```sh
git clone https://github.com/Effendi94/trading-sample-app.git

cd trading-sample-app

flutter pub get

dart run build_runner build --delete-conflicting-

flutter run -d windows
or
flutter run -d  chrome
```

## Library yang Digunakan & Alasan

| Library                   | Kegunaan                               | Alasan Digunakan                                                                      |
| ------------------------- | -------------------------------------- | ------------------------------------------------------------------------------------- |
| **flutter**               | Framework utama                        | Digunakan untuk membangun UI cross-platform                                           |
| **flutter_localizations** | Dukungan multi-bahasa                  | Menyediakan localizations untuk `intl` dan widget berbasis lokasi pengguna            |
| **cupertino_icons**       | Icon-style iOS                         | Menambahkan icon sistem bergaya iOS untuk aplikasi dengan desain Cupertino            |
| **intl**                  | Format angka, tanggal, dan mata uang   | Digunakan untuk menampilkan format USD yang sesuai, serta mendukung lokal bahasa      |
| **flutter_svg**           | Render file SVG                        | Untuk menampilkan gambar atau logo yang menggunakan format SVG                        |
| **shimmer**               | Efek loading shimmer                   | Meningkatkan UX saat data sedang dimuat (misalnya loading harga atau portfolio)       |
| **bcrypt**                | Enkripsi dan validasi hash password    | Digunakan untuk kebutuhan autentikasi atau hash data sensitif (seperti password)      |
| **hive**                  | Penyimpanan lokal (NoSQL)              | Digunakan sebagai local storage untuk menyimpan data transaksi                        |
| **hive_flutter**          | Integrasi Hive dengan Flutter          | Sinkronisasi Hive dengan lifecycle aplikasi Flutter dan Widget Binding                |
| **stacked**               | MVVM state management                  | Menyediakan arsitektur `ViewModel` yang scalable dan clean, cocok untuk project besar |
| **stacked_hooks**         | Integrasi Flutter Hooks dengan Stacked | Memudahkan penggunaan `useEffect`, `useTextController`, dll dalam ViewModel           |
| **stacked_services**      | Navigasi, snackbar, dialog service     | Digunakan untuk mengakses service - service yang ada pada stacked architecture        |
| **web_socket_channel**    | Koneksi WebSocket ke Binance           | Digunakan untuk mengakses data atau stream pada websocket                             |
| **build_runner**          | Generator kode                         | Diperlukan oleh `hive_generator` & `stacked_generator` untuk generate kode otomatis   |
| **hive_generator**        | Generator adapter Hive                 | Digunakan untuk generate otomatis code yang sesuai dengan TypeAdapter pada `Hive`     |
| **stacked_generator**     | Generator routing & ViewModel          | Otomatisasi file seperti `app.locator.dart`, `app.router.dart`, dan bindings          |
| **flutter_test**          | Pengujian unit & widget                | Standar testing Flutter, digunakan untuk membuat unit test                            |
| **flutter_lints**         | Linting standar                        | Memberikan pedoman coding best practices agar kode tetap bersih dan konsisten         |

## Folder Structure

```
└── 📁trading_sample_app
    └── 📁android
    └── 📁assets
        └── 📁fonts
            └── 📁poppins
                ├── *****.ttf
        └── 📁icons
            └── 📁symbols
                ├── asset_file
            ├── asset_file
        └── 📁images
            ├── asset_file
    └── 📁build
    └── 📁ios
    └── 📁lib
        └── 📁app
            └── 📁constants
                ├── common.dart
                ├── custom_colors.dart
                ├── endpoint.dart
                ├── icon_constants.dart
            └── 📁enums
                ├── snackbar_type.dart
                ├── trade_input_type.dart
            └── 📁helper
                ├── format_helpers.dart
                ├── string_extentions.dart
                ├── ui_helpers.dart
            └── 📁models
                ├── asset_model.dart
                ├── order_model.dart
                ├── order_model.g.dart
                ├── portfolio_model.dart
                ├── profile_model.dart
                ├── profile_model.g.dart
                ├── static_model.dart
                ├── ticker_model.dart
            └── 📁services
                ├── binance_websocket_service.dart
                ├── hive_service.dart
                ├── order_service.dart
                ├── profile_service.dart
            └── 📁theme
                ├── app_text_theme.dart
                ├── app_theme_data.dart
            ├── app.dart
            ├── app.locator.dart
            ├── app.router.dart
            ├── trading_simple_app.dart
        └── 📁infrastructure
            └── 📁apis
        └── 📁ui
            └── 📁shared
                └── 📁form
                    ├── custom_text_field.dart
                ├── circle_avatar_widget.dart
                ├── custom_button.dart
                ├── setup_snackbar_ui.dart
                ├── shimmer_widget.dart
            └── 📁views
                └── 📁home
                    ├── home_view.dart
                    ├── home_viewmodel.dart
                └── 📁market
                    └── 📁widgets
                        ├── buy_widget.dart
                        ├── sell_widget.dart
                    ├── market_view.dart
                    ├── market_viewmodel.dart
                └── 📁order
                    ├── order_view.dart
                    ├── order_viewmodel.dart
                └── 📁portfolio
                    └── 📁widgets
                        ├── header_card.dart
                        ├── list_portfolio.dart
                    ├── portfolio_view.dart
                    ├── portfolio_viewmodel.dart
                └── 📁profile
                    ├── profile_view.dart
                    ├── profile_viewmodel.dart
                └── 📁root
                    └── 📁widgets
                        ├── bottom_navigation_bar.dart
                    ├── root_view.dart
                    ├── root_viewmodel.dart
        ├── main.dart
    └── 📁linux
    └── 📁macos
    └── 📁test
    └── 📁web
    └── 📁windows
    ├── .flutter-plugins
    ├── .flutter-plugins-dependencies
    ├── .gitignore
    ├── .metadata
    ├── analysis_options.yaml
    ├── devtools_options.yaml
    ├── pubspec.lock
    ├── pubspec.yaml
    ├── README.md
    └── trading_sample_app.iml
```
