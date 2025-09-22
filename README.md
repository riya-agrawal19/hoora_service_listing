# Hoora Service Listing (Assignment)

A Flutter app for listing services with:
- Lazy loading pagination
- Favorite/unfavorite services (persisted locally in Hive)
- Tab navigation (All Services / Favorites)
- Widget tests & integration tests

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
