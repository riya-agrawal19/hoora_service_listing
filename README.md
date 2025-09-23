# 📱 Hoora Service Listing (Assignment)

A Flutter app that demonstrates a clean architecture with Riverpod, Hive, and API-based service listing.  
The app allows users to **browse services**, **lazy-load data**, and **favorite/unfavorite services** with persistence across restarts.  

---

## ✨ Features

- 📄 **Lazy Loading Pagination** – Fetches services page by page as you scroll.  
- ❤️ **Favorite/Unfavorite Services** – Tap the heart icon to mark favorites.  
- 💾 **Local Persistence** – Favorites are saved in Hive, so they survive app restarts.  
- 🗂 **Tabbed Navigation** – Switch between **All Services** and **Favorites**.  
- ✅ **Testing** – Includes **widget tests** and **integration tests** for reliability.  

---

## 🛠️ Tech Stack

- **Flutter** 3.x  
- **Riverpod** (State Management)  
- **Hive** (Local Persistence)  
- **Dart Freezed** (Model Generation)  
- **Flutter Test & Integration Test** (Automated Testing)  

---
## 📦 Setup

1. Clone the repo
   ```bash
   git clone https://github.com/riya-agrawal19/hoora_service_listing.git
   cd hoora_service_listing
2. Install dependencies
   ```bash
   flutter pub get
3. Run the app
   ```bash
   flutter run

 ## Running Tests

1. Widget Tests
   ```bash
   flutter test test/widget/

3. Integration Tests
   Make sure a simulator/emulator is running, then:
   ```bash
   flutter test integration_test/favorite_persistence_test.dart
   flutter test integration_test/pagination_scroll_test.dart

## 📹 Demo Video
https://www.loom.com/share/f63bec4c987547e0a3aaf56e33fdad68?sid=33c8836b-dfc3-4b51-be8d-ea3f6820ff33
