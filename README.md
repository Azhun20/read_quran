# Read Quran App

A modern, feature-rich Flutter application for reading and listening to the Holy Quran. Built with Clean Architecture, BLoC pattern, and designed with beautiful Islamic aesthetics.

---

## Overview

Read Quran is a mobile application that provides a seamless experience for reading, listening to, and searching the Holy Quran. The app features a comprehensive surah list, detailed ayah view with audio playback, full-text search capabilities, and robust offline support.

---

## Features

### 🕌 Core Features

#### **Quran List (Browse Surahs)**
- Browse all 114 surahs with beautiful card-based UI
- Display surah name in Arabic and translation
- Show revelation type (Meccan/Medinan)
- Display number of ayahs and surah number
- Shimmer loading effect for better UX
- Local caching for offline access
- Pull-to-refresh functionality

#### **Quran Detail (Read & Listen)**
- Read ayahs with Arabic text and translations
- High-quality audio playback for each ayah
- Audio player with play/pause/seek controls
- Progress bar showing current playback position
- Background audio support
- **App lifecycle handling** - Audio state persistence when app is paused/resumed
- Automatic audio resume when returning to the app
- Beautiful ayah cards with proper Arabic typography
- Verse numbers and translations
- Shimmer loading for smooth content loading

#### **Quran Search**
- Full-text search across all ayahs
- Search in Arabic text and translations
- Real-time search results
- Result highlighting
- Navigate directly to searched ayah
- Fast and responsive search experience

#### **Network & Error Handling**
- Comprehensive network status monitoring
- Banner notification for offline/online status
- Automatic data caching for offline access
- Graceful error handling with user-friendly messages
- Retry mechanism for failed requests
- Connectivity status persistence

#### **Splash Screen & Branding**
- Beautiful Islamic-themed splash screen
- Custom app icon with golden circular emblem
- "Al-Quran Al-Kareem" branding in Arabic
- Bismillah display during app initialization
- Android adaptive icons with dark green background
- Smooth transition to main app

### 🎨 UI/UX Features

- Material 3 design with custom Islamic theme
- Dark green (#1a3d2e) and gold (#c9a84c) color scheme
- Montserrat and Rajdhani font families
- Smooth animations and transitions
- Shimmer loading states
- Error state handling with retry options
- Network status banner
- Responsive layouts

---

## Architecture

This project follows **Clean Architecture** principles with a **feature-based modular** structure:

```
Feature Module
├── Data Layer
│   ├── DataSources     → Remote (API) & Local (Hive cache)
│   ├── Models          → JSON-serializable DTOs
│   └── Repositories    → Implements domain contracts
├── Domain Layer
│   ├── Entities        → Pure business objects (Freezed)
│   ├── Repositories    → Abstract interfaces
│   └── UseCases        → Single-responsibility business logic
├── Presentation Layer
│   ├── Cubit           → BLoC state management
│   ├── State           → Immutable state (Freezed)
│   └── Views/Widgets   → UI components
└── DI Module           → Feature dependency injection
```

### Key Architectural Patterns

- **Clean Architecture**: Separation of concerns with clear layer boundaries
- **BLoC Pattern**: Predictable state management with Cubit
- **Repository Pattern**: Abstract data source implementation
- **Use Case Pattern**: Single responsibility business logic
- **Dependency Injection**: GetIt service locator
- **Either Pattern**: Functional error handling with dartz
- **Immutable State**: Freezed for type-safe immutable models

### Data Flow Example (Fetch Surah)

```
QuranListPage → QuranListCubit → GetSurahsUseCase → QuranListRepository
              → QuranListRemoteDataSource (API call)
              → QuranListLocalDataSource (Hive cache)
              → Either<Failure, List<SurahEntity>>
              → QuranListState (loaded)
              → UI updates with surah cards
```

---

## Project Structure

```
lib/
├── main.dart                           # App entry point
├── app/
│   └── router/                         # GoRouter configuration
├── configs/
│   ├── routes/                         # Route constants
│   ├── themes/                         # Material 3 theme configuration
│   └── ui/                             # UI constants
├── constants/                          # API, asset, Hive key constants
├── core/
│   ├── di/                             # Service locator setup
│   ├── error/                          # Failure types (ServerFailure, CacheFailure)
│   ├── extensions/                     # Context and utility extensions
│   ├── logging/                        # AppLogger for debugging
│   └── result/                         # Result wrapper type
├── features/
│   ├── quran_list/                     # Surah list feature
│   │   ├── data/                       # Surah models, remote & local datasources
│   │   ├── domain/                     # Surah entity, repository, use cases
│   │   ├── presentation/               # Surah list page, cubit, widgets
│   │   └── di/                         # Quran list DI
│   ├── quran_detail/                   # Ayah reading & audio feature
│   │   ├── data/                       # Ayah models, audio datasources
│   │   ├── domain/                     # Ayah entity, repository, use cases
│   │   ├── presentation/               # Detail page, audio player, cubit
│   │   └── di/                         # Quran detail DI
│   ├── quran_search/                   # Full-text search feature
│   │   ├── data/                       # Search models & datasources
│   │   ├── domain/                     # Search repository, use cases
│   │   ├── presentation/               # Search page, results, cubit
│   │   └── di/                         # Search DI
│   └── splash/                         # Splash screen
├── shared/
│   ├── styles/                         # Color palette, typography
│   ├── widgets/                        # Reusable components (buttons, banners)
│   └── models/                         # Shared models
└── utils/
    ├── services/                       # ApiService (Dio), HiveService
    ├── extensions/                     # String, Theme extensions
    └── functions/                      # Dialog utilities
```

---

## Tech Stack

| Category | Package | Version |
|---|---|---|
| **State Management** | flutter_bloc | ^8.1.3 |
| **Dependency Injection** | get_it | ^7.6.4 |
| **Routing** | go_router | ^12.1.1 |
| **HTTP Client** | dio | ^5.4.0 |
| **Local Storage** | hive, hive_flutter | ^2.2.3 |
| **Immutable Models** | freezed, freezed_annotation | ^2.4.1 |
| **JSON Serialization** | json_serializable | ^6.7.1 |
| **Error Handling** | dartz | ^0.10.1 |
| **Audio Playback** | just_audio | ^0.9.36 |
| **Audio UI** | audio_video_progress_bar | ^2.0.3 |
| **Image Processing** | image | ^4.1.7 |
| **Networking** | connectivity_plus | ^6.1.3 |
| **Caching** | cached_network_image | ^3.3.1 |
| **SVG Support** | flutter_svg | ^2.2.3 |
| **UI Effects** | shimmer | ^3.0.0 |
| **Notifications** | another_flushbar | ^1.12.32 |
| **Localization** | intl | ^0.20.2 |
| **Value Equality** | equatable | ^2.0.5 |

---

## Getting Started

### Prerequisites

- **Flutter SDK**: `^3.8.1` (see `.fvmrc`)
- **FVM** (Flutter Version Management) - recommended
- **Dart SDK**: `^3.8.1`
- Android Studio / Xcode for mobile development

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Azhun20/read_quran.git
   cd read_quran
   ```

2. **Install Flutter dependencies**
   ```bash
   fvm flutter pub get
   ```

3. **Generate code** (Freezed, JSON serialization, Hive adapters)
   ```bash
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Configure API** (optional)
   - Update API base URL in `lib/utils/services/api_service.dart`
   - Or use `--dart-define`:
     ```bash
     flutter run --dart-define=API_BASE_URL=https://your-api.com/v1
     ```

5. **Run the app**
   ```bash
   fvm flutter run
   ```

### Build

```bash
# Android APK
fvm flutter build apk --release

# Android App Bundle
fvm flutter build appbundle --release

# iOS
fvm flutter build ios --release

# Analyze code
fvm flutter analyze
```

---

## API Integration

The app connects to a Quran API service to fetch surah data, ayah content, and audio files.

### Base Configuration

- **API Service**: `lib/utils/services/api_service.dart`
- **Error Handling**: Maps HTTP errors to typed Failure objects

### Key Endpoints

| Endpoint | Method | Description |
|---|---|---|
| `/surahs` | GET | Fetch all surahs |
| `/surahs/{id}` | GET | Fetch surah details with ayahs |
| `/search` | GET | Search ayahs |

---

## Feature Details

### Quran List Feature

**Location**: `lib/features/quran_list/`

**Capabilities**:
- Display 114 surahs with card UI
- Show Arabic name, translation, revelation type
- Display ayah count and surah number
- Local caching for offline access
- Pull-to-refresh
- Shimmer loading effect

**Use Cases**:
- `GetSurahsUseCase`: Fetches surah list from API/cache
- `CacheSurahsUseCase`: Saves surahs locally for offline use

**Widgets**:
- `SurahCard`: Individual surah display card
- Shimmer loading placeholder

**State Management**:
```dart
QuranListState {
  bool isLoading
  List<SurahEntity> surahs
  String? errorMessage
}
```

### Quran Detail Feature

**Location**: `lib/features/quran_detail/`

**Capabilities**:
- Display ayahs with Arabic text and translations
- Audio playback with JustAudio
- Play/pause/seek controls
- Progress bar with current position
- **App lifecycle handling**: Saves playback state when app is paused
- **Auto-resume**: Restores playback when app returns to foreground
- Background audio support

**Use Cases**:
- `GetAyahsUseCase`: Fetches ayahs for a specific surah
- `PlayAudioUseCase`: Handles audio playback
- `SavePlaybackStateUseCase`: Persists audio state on app pause
- `RestorePlaybackStateUseCase`: Restores audio state on app resume

**State Management**:
```dart
QuranDetailState {
  bool isLoading
  List<AyahEntity> ayahs
  int? currentAyahIndex
  bool isPlaying
  Duration currentPosition
  Duration totalDuration
  String? errorMessage
}
```

**App Lifecycle Handling**:
- Implements `AppLifecycleListener`
- Saves current playback state (ayah index, position, playing status)
- Automatically resumes playback when returning from background
- Handles edge cases (user manually paused, finished playing)

### Quran Search Feature

**Location**: `lib/features/quran_search/`

**Capabilities**:
- Full-text search across all ayahs
- Search in Arabic and translations
- Real-time search results
- Result highlighting
- Navigate to ayah details from results

**Use Cases**:
- `SearchQuranUseCase`: Performs search query against API

**Widgets**:
- `SearchResultCard`: Display individual search result
- Empty state for no results

### Network Handling

**Location**: `lib/shared/widgets/network_status_banner.dart`

**Capabilities**:
- Real-time network connectivity monitoring
- Banner notification on connectivity change
- Green banner for online, red for offline
- Automatic hiding after 3 seconds
- Connectivity state persistence in Hive

**Implementation**:
- Uses `connectivity_plus` package
- Subscribes to connectivity stream
- Updates UI automatically

### Splash Screen & App Icon

**Location**: `lib/features/splash/splash_screen.dart`

**Design**:
- Dark green background (#1a3d2e)
- Circular golden icon with Arabic text "القرآن الكريم"
- "Read Quran" app name
- Bismillah text in Rajdhani font
- Smooth transition to main app

**App Icons**:
- Custom launcher icons for Android and iOS
- Android adaptive icons with dark green background
- Generated using `flutter_launcher_icons` package

---

## Development Guide

### Adding a New Feature

1. **Create feature structure**
   ```bash
   mkdir -p lib/features/my_feature/{data/{models,datasources,repositories},domain/{entities,repositories,usecases},presentation/{cubit,views,widgets},di}
   ```

2. **Domain Layer** - Define entities, repository interface, use cases

3. **Data Layer** - Create models, datasources, repository implementation

4. **Presentation Layer** - Create cubit, state, and views

5. **Dependency Injection** - Create DI module in `di/my_feature_di.dart`

6. **Register DI** - Add to `core/di/service_locator.dart`

7. **Add Routes** - Define in `configs/routes/route.dart` and register in router

8. **Generate Code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

### Code Generation

Run after modifying:
- Freezed classes (`@freezed`)
- JSON serializable models (`@JsonSerializable()`)
- Hive type adapters (`@HiveType()`)

```bash
# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on save)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Coding Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Private members**: `_privateField`
- **Constants**: `SCREAMING_SNAKE_CASE`

### Naming Patterns

- Entity: `SurahEntity`, `AyahEntity`
- Model: `SurahModel`, `AyahModel`
- Repository: `QuranListRepository`
- Use Case: `GetSurahsUseCase`, `PlayAudioUseCase`
- Cubit: `QuranListCubit`, `QuranDetailCubit`
- State: `QuranListState`, `QuranDetailState`
- Page: `QuranListPage`, `QuranDetailPage`

---

## Troubleshooting

### Build Runner Issues

```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Hive Initialization Error

Ensure Hive is initialized in `main.dart`:
```dart
await Hive.initFlutter();
```

### Audio Playback Issues

- Check internet connectivity for streaming
- Verify audio URL is valid
- Check app permissions for audio playback

### GetIt Registration Errors

- Ensure all dependencies are registered in `setupServiceLocator()`
- Check for circular dependencies
- Use `registerLazySingleton` for services, `registerFactory` for cubits

### Linter Issues

Run Flutter analyze to check for issues:
```bash
flutter analyze
```

Common fixes:
- Replace `.withOpacity()` with `.withValues()`
- Use package imports instead of relative imports
- Remove unused variables/fields
- Add missing await for futures

---

## Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/quran_list/domain/usecases/get_surahs_usecase_test.dart
```

### Test Structure

```
test/
├── features/
│   ├── quran_list/
│   │   ├── domain/usecases/
│   │   ├── data/repositories/
│   │   └── presentation/cubit/
│   ├── quran_detail/
│   └── quran_search/
└── widget_tests/
```

---

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Commit Convention

Use conventional commits format:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `refactor:` Code refactoring
- `test:` Adding tests
- `chore:` Maintenance tasks

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## Acknowledgments

- Quran API for providing surah and ayah data
- Flutter and the amazing open-source community
- All contributors who have helped improve this project

---

## Contact

For questions, issues, or suggestions:
- **GitHub Issues**: [https://github.com/Azhun20/read_quran/issues](https://github.com/Azhun20/read_quran/issues)
- **Pull Requests**: [https://github.com/Azhun20/read_quran/pulls](https://github.com/Azhun20/read_quran/pulls)

---

**May Allah accept this work and make it beneficial for the Ummah. Ameen.** 🤲
