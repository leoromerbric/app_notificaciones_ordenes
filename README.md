# Production Management App

Flutter-based mobile application for production order management with real-time operations tracking, material movements, and quality control.

## Features

### 📋 Order Management
- View production orders with status tracking
- Order selection and confirmation
- Scheduled vs actual time tracking

### ⚙️ Operations Management
- Operation detail view with planned activities
- Time tracking for activities (start/end times)
- Quantity recording (good/reject/reprocess)
- Operation confirmation workflow

### 📦 Material Management
- Material inventory view with availability
- Material movements (output/return)
- Batch number tracking
- Real-time quantity updates

### 📥 Product Receipt (Optional)
- Finished product receipt recording
- Quality status assignment
- Batch number assignment

### 🔧 Additional Features
- Barcode scanning capability (mobile_scanner)
- 100% online operation with API validation
- Material Design 3 UI
- Multi-language support ready

## Technical Stack

- **Framework**: Flutter 3.24+ / Dart 3.8+
- **State Management**: Riverpod
- **Navigation**: go_router
- **HTTP Client**: dio
- **JSON Serialization**: json_serializable + build_runner
- **Barcode Scanning**: mobile_scanner
- **UI**: Material Design 3
- **Linting**: flutter_lints

## Architecture

```
lib/
├── app/                    # Application setup, routing, theme
│   ├── router/            # Navigation configuration
│   └── theme/             # Material Design 3 theme
├── core/                  # Core utilities and types
│   ├── error/             # Exception handling
│   ├── result/            # Result type for error handling
│   └── constants/         # App constants
├── domain/                # Business entities
│   ├── work_order.dart    # Work order entity
│   ├── operation.dart     # Operation entity
│   ├── activity.dart      # Activity entity
│   ├── material.dart      # Material entity
│   └── material_movement.dart # Material movement entity
├── features/              # Feature modules
│   ├── orders/            # Order management
│   ├── operations/        # Operation management
│   ├── materials/         # Material management
│   └── receipt/           # Product receipt
└── ui/                    # Shared UI components
```

## Getting Started

### Prerequisites

- Flutter 3.24 or higher
- Dart 3.8 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd app_notificaciones_ordenes
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code:
```bash
flutter packages pub run build_runner build
```

4. Run the app:
```bash
flutter run
```

## Main Flows

### 1. Order Selection Flow
1. View available production orders
2. Select order by tapping or scanning barcode
3. Navigate to operations view

### 2. Operation Confirmation Flow
1. View operation details and planned activities
2. Record quantities (good/reject/reprocess)
3. Track activity times
4. Confirm operation completion

### 3. Material Movement Flow
1. Access materials from operation screen
2. Select material for movement
3. Choose movement type (output/return)
4. Enter quantity and confirm

### 4. Product Receipt Flow (Optional)
1. Access receipt screen from completed orders
2. Enter received quantity and quality status
3. Assign batch number
4. Process receipt

## Configuration

### API Integration
Update `lib/core/constants.dart` with your API endpoints:

```dart
class AppConstants {
  static const String baseUrl = 'https://your-api.example.com';
  // ... other constants
}
```

### Barcode Scanning
The app includes barcode scanning capability using `mobile_scanner`. Ensure camera permissions are granted on the device.

## Development

### Code Generation
When modifying JSON serializable classes, run:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Linting
The project uses `flutter_lints` for code quality:
```bash
flutter analyze
```

### Testing
Run tests with:
```bash
flutter test
```

## Permissions

### Android
- `CAMERA` - For barcode scanning
- `INTERNET` - For API communication

### iOS
- Camera usage - For barcode scanning
- Network usage - For API communication

## Production Deployment

### Android
1. Build APK:
```bash
flutter build apk --release
```

2. Build App Bundle:
```bash
flutter build appbundle --release
```

### iOS
1. Build iOS app:
```bash
flutter build ios --release
```

## Contributing

1. Follow the established architecture patterns
2. Use Material Design 3 components
3. Maintain null-safety throughout
4. Write tests for new features
5. Update documentation as needed

## License

This project is licensed under the MIT License - see the LICENSE file for details.