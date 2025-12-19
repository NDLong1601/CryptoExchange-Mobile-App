# 📱 CryptoExchange Mobile App (Flutter)

CryptoExchange Mobile App là một ứng dụng mobile được xây dựng bằng **Flutter**, mô phỏng giao diện và chức năng của một ứng dụng giao dịch tiền điện tử hiện đại.  
Dự án được phát triển dựa trên thiết kế Figma community và tập trung vào **clean architecture, reusable components và khả năng mở rộng**.

---

## 🎨 UI / UX Design

Thiết kế UI được tham khảo từ Figma community:

🔗 **Figma Design:**  
https://www.figma.com/design/bPnonHFqQGhv5nf7x4z4pw/CryptoExchange-Mobile-App-FREE--Community-

---

## 🚀 Features

### ✅ Implemented
- Home Screen (Portfolio balance, chart, market movers)
- Market Screen
- Trade Screen
- Wallet Screen
- Favorites Screen
- Settings Screen
- Custom AppBar & BottomNavigationBar
- Reusable UI components (AppText, AppButton, AppSection, AppPortfolioItem, ...)
- Dark / Light Theme (ThemeProvider)
- Navigation bằng Named Routes
- Clean & scalable folder structure
- Mock data cho UI

### 🔄 In Progress / Planned
- Real-time price update (WebSocket)
- Authentication flow
- State management nâng cao
- Persist theme & user settings
- API integration (Binance / CoinGecko)

---

## 🧱 Tech Stack

- **Flutter**
- **Dart**
- **Provider** (State Management)
- **Material Design**
- **Git & GitHub**

---

## 📂 Project Structure
```text
lib/
├── components/ # Reusable UI components
│ ├── app_text.dart
│ ├── app_textstyle.dart
│ ├── app_button.dart
│ ├── app_section.dart
│ ├── app_top_bar.dart
│ ├── app_bottom_navigation_bar.dart
│ └── app_card_item.dart
│
├── const/
│ ├── app_color.dart
│ └── app_assets_path.dart
│
├── routes/
│ └── app_route.dart
│
├── providers/
│ ├── theme_provider.dart
│ └── coin_provider.dart
│
├── models/
│ └── coin.dart
│
├── services/
│ ├── coin_repository.dart
│ ├── storage_service.dart
│ └── binance_websocket_service.dart
│
├── screens/
│ ├── home/
│ │ └── home_screen.dart
│ ├── market/
│ │ └── market_screen.dart
│ ├── trade/
│ │ └── trade_screen.dart
│ ├── wallet/
│ │ └── wallet_screen.dart
│ ├── favorites/
│ │ └── favorites_screen.dart
│ ├── settings/
│ │ └── settings.dart
│ └── onboarding/
│ └── onboarding_screen.dart
│
└── main.dart
```

## 🧩 Reusable Components

Một số component chính được thiết kế để tái sử dụng toàn app:

- `AppText` – Text widget dùng chung
- `AppTextstyle` – Quản lý typography
- `AppButton` – Button custom
- `AppSection` – Section header (Title + More)
- `AppPortfolioItem` – Item danh sách portfolio
- `AppTopBar` – AppBar custom
- `AppBottomNavigationBar` – Bottom navigation dùng chung

---

## 🌓 Theme

Ứng dụng hỗ trợ **Light / Dark Mode** thông qua `ThemeProvider`.

```dart
ThemeMode.light
ThemeMode.dark
```
## 🧭 Navigation
Sử dụng Named Routes để quản lý điều hướng:

```dart
Sao chép mã
Navigator.pushNamed(context, AppRoute.market);
```
## 🛠️ How to Run
### 1. Clone repository
```bash
Sao chép mã
git clone https://github.com/your-username/cryptoexchange-mobile-app.git
```

### 2. Install dependencies
```bash
Sao chép mã
flutter pub get
```
### 3. Run app
```bash
Sao chép mã
flutter run
```
## 📌 Requirements
Flutter SDK >= 3.x

Dart >= 2.17

Android Studio / VS Code

Emulator hoặc thiết bị thật

## 🤝 Contributing
Pull requests và suggestions luôn được chào đón.
Vui lòng tạo branch mới trước khi phát triển feature.

## 📄 License
This project is for learning and demo purposes only.
Design belongs to its original creator on Figma Community.

## 👨‍💻 Author
Developed by NDLong161
Flutter Developer

## ⭐ Nếu bạn thấy project này hữu ích, hãy cho repo một star nhé!
