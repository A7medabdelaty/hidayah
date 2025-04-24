# Hidayah - Islamic Prayer Times App 🕌

Created by Ahmed Abdelaty 🇪🇬
Contact: ahmed.abdelaty174@gmail.com

## Overview

Hidayah is a Flutter-based mobile application that provides accurate prayer times based on your location. The app offers a clean, intuitive interface for Muslims to track their daily prayers and stay connected with their faith.

## Features

- 🕌 Real-time prayer times based on location
- 📍 Location-based automatic time calculation
- 🗺️ Interactive map for location selection
- 🌍 Support for multiple locations
- ⏰ Next prayer time indicator
- 🎨 Clean and modern UI design

## Project Structure

```plaintext
lib/
├── core/
│   ├── constants
│   ├── network
│   ├── errors
│   ├── utils
│   ├── services
│   ├── routing
│   ├── theme
│   ├── cubit
│   └── extensions
├── features/
│   ├── home
│   ├── prayer_time
│   ├── qibla
│   └── splash
├── app.dart
├── main.dart
└── app_bloc_observer.dart
```

## Architecture

The app follows Clean Architecture principles with SOLID design patterns:

- Core : Base classes, services, and utilities
- Features : Feature-based modules following clean architecture
  - Domain: Business logic and entities
  - Data: Data sources and repositories
  - Presentation: UI components and state management

## Dependencies

- flutter_bloc : State management
- google_maps_flutter : Maps integration
- geolocator : Location services
- geocoding : Address lookup
- get_it : Dependency injection

## Getting Started

1. Clone the repository

```bash
git clone https://github.com/A7medabdelaty/hidayah
```

2. Install dependencies

```bash
flutter pub get
```

3. Run the app

```bash
flutter run
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## License

This project is licensed under the MIT License

✅ Built using Clean Architecture

Created by Ahmed Abdelaty 🇪🇬
