# Flutter Starter Template

A clean Flutter starter template with essential features for building modern applications. This template provides a solid foundation with Bloc state management, type-safe navigation, dependency injection, and responsive design utilities.

## Core Features

- **State Management**: Bloc pattern implementation with responsive state handling
- **Navigation**: Auto-route for type-safe navigation
- **Dependency Injection**: GetIt for easy dependency management
- **Responsive Design**: Built-in responsive utilities and screen management

## Project Structure

```
lib/
├── app/
│   ├── common/      # Shared utilities and components
│   ├── features/    # Feature modules
│   │   └── hello/   # Example feature
│   │       ├── base/     # Base widgets and states
│   │       ├── data/     # Data layer
│   │       ├── domain/   # Business logic
│   │       └── presentation/ # UI and state
│   └── root/        # App router and root component
└── main.dart        # App entry point
```

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Start building your features in `lib/app/features/`

## Key Components

- `ResponsiveState`: Base class for responsive stateful widgets
- `BaseScreen`: Basic screen wrapper
- `AppRouter`: Type-safe navigation
- `ResponsiveUtil`: Screen size and orientation utilities

## License

MIT
