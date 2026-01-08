# 🍔 Flutter Food App

A **production-ready food mobile application** built with Flutter, featuring a modern architecture, seamless UI/UX, and enterprise-grade features. This app showcases best practices in mobile development with clean code principles, state management, and comprehensive feature implementation.

---

## 📱 Features

### Authentication & User Management
- ✅ **User Registration & Login** - Secure authentication with validation
- ✅ **Biometric Authentication** - Fingerprint & Face ID support for quick login
- ✅ **Profile Management** - Update user information and preferences
- ✅ **Secure Storage** - Local secure data storage for sensitive information
- ✅ **Logout with Confirmation** - Safe session termination

### Product Browsing & Discovery
- 🏠 **Dynamic Home Screen** - Featured products and category browsing
- 🔍 **Product Details** - Comprehensive product information with images
- ⭐ **Favorites System** - Save and manage favorite items
- 🛒 **Smart Shopping Cart** - Add/remove items
- 💳 **Checkout Process** - Streamlined order placement

### User Experience
- 🌙 **Dark Mode Support** - Complete dark theme implementation
- 🌍 **Multi-language Support** - English & Arabic localization
- 📡 **Pull-to-Refresh** - Fresh data loading with smooth animations
- 🎨 **Lottie Animations** - Delightful loading states and transitions
- 📸 **Image Picker** - User profile picture upload capability
- ⚡ **Shimmer Loading** - Skeleton screens for better perceived performance

### Technical Excellence
- 🏗️ **Clean Architecture** - Separation of concerns with Data/Domain/Presentation layers
- 🎯 **BLoC Pattern** - Scalable and testable state management
- 🔗 **API Integration** - Robust REST API communication with Dio
- ⚙️ **Service Locator** - Dependency injection with GetIt
- 🛡️ **Error Handling** - Comprehensive error management and user feedback

---

## 🛠️ Tech Stack

### Framework & Language
- **Flutter** - Cross-platform mobile development (iOS, Android, Web, Windows, Linux)
- **Dart** - Modern, type-safe programming language

### State Management
- **Flutter BLoC** - Business Logic Component pattern for reactive programming

### Architecture & Design Patterns
- **Clean Architecture** - Domain, Data, Presentation separation
- **Repository Pattern** - Abstract data layer
- **Dependency Injection** - Service Locator with GetIt

### Networking & Storage
- **Dio** - HTTP client with interceptors and logging
- **Flutter Secure Storage** - Encrypted local storage for sensitive data
- **SharedPreferences** - Key-value storage (via local datasources)

### UI & Animation
- **Material Design** - Google's Material Design system
- **Lottie** - High-quality animation support
- **Cached Network Image** - Smart image caching
- **Shimmer** - Loading skeleton screens
- **Flutter SVG** - Scalable vector graphics
- **Convex Bottom Bar** - Modern navigation bar

### Localization & Navigation
- **Easy Localization** - Multi-language support (AR, EN)
- **Go Router** - Declarative routing and deep linking

### Other Tools
- **Local Auth** - Biometric authentication
- **Image Picker** - Device image selection
- **Pretty Dio Logger** - Request/response logging

---

## 📂 Project Structure

```
lib/
├── core/                          # Core utilities & configurations
│   ├── service_locator.dart      # Dependency injection setup
│   ├── biometric_helper/         # Biometric authentication
│   ├── constants/                # App constants (colors, etc.)
│   ├── errors/                   # Error models & handling
│   ├── localization/             # Language management
│   ├── network/                  # API configuration
│   └── theme/                    # App theming
│
├── features/                      # Feature modules
│   ├── auth/                     # Authentication module
│   │   ├── data/                 # Data layer (datasources, models, repos)
│   │   ├── domain/               # Domain layer (entities, usecases)
│   │   └── presentation/         # UI layer (screens, cubits, widgets)
│   │
│   ├── home/                     # Home module (product browsing)
│   ├── product/                  # Product details module
│   ├── cart/                     # Shopping cart module
│   ├── checkout/                 # Order checkout module
│   └── favorites/                # Favorites management module
│
├── shared/                        # Shared widgets & utilities
│   ├── custom_text_field.dart
│   └── custom_text.dart
│
└── main.dart                      # App entry point
```

---


### Theme Customization
Modify colors and styles in `lib/core/constants/colors.dart` and `lib/core/theme/app_theme.dart`

### Localization
Add new languages by creating JSON files in `assets/langs/` and updating supported locales in `main.dart`

---

## 📦 Key Dependencies

| Package | Purpose | Version |
|---------|---------|---------|
| flutter_bloc | State Management | 9.1.1 |
| dio | HTTP Client | 5.9.0 |
| get_it | Service Locator | 9.1.1 |
| flutter_secure_storage | Secure Storage | 9.2.4 |
| local_auth | Biometric Auth | 3.0.0 |
| easy_localization | Localization | 3.0.8 |
| go_router | Navigation | 17.0.1 |
| lottie | Animations | 3.3.2 |

---

## 🔒 Security Features

✅ **Secure Token Storage** - Tokens stored in encrypted local storage
✅ **Biometric Authentication** - Touch/Face ID verification
✅ **HTTPS Enforcement** - Secure API communication
✅ **Input Validation** - Comprehensive data validation
✅ **Error Logging** - Safe error handling without exposing sensitive data


---

## 📈 Performance Optimizations

- 🖼️ **Image Caching** - Efficient image loading and caching
- ⚡ **Lazy Loading** - Load data only when needed
- 🎬 **Hardware Acceleration** - Optimized animations
- 📦 **Code Splitting** - Modular feature-based structure
- 🔄 **State Management** - Efficient BLoC event handling

---

**Made with ❤️ using Flutter**
