# smart_location
A developer-friendly, DX-first Flutter package for handling location. It internally wraps `geolocator` with a clean, top-down designed API that minimizes boilerplate and intuitively manages permissions.

## Features
- **One-line Location Fetching:** Get the current location safely.
- **Continuous Tracking:** Listen to location stream with simple configurations.
- **Smart Permission Handling:** Checks GPS and prompts permissions automatically.
- **Pure Dart Models:** Safe mapping from raw platform data to clean Dart classes.

## Getting started

Add the dependency to your `pubspec.yaml`:
```yaml
dependencies:
  smart_location: ^0.1.0
```

## Usage

### 1. Initialize & Ensure Permissions
```dart
import 'package:smart_location/smart_location.dart';

// Automatically checks GPS status and requests Location Permissions from the user
await SmartLocation.ensureReady();
```

### 2. Get Current Location
```dart
try {
  final loc = await SmartLocation.current();
  print('Location: ${loc.latitude}, ${loc.longitude}');
} on LocationDisabledException {
  print('Please turn on GPS');
} on PermissionDeniedException {
  print('Permission was denied');
}
```

### 3. Listen to Location Stream
```dart
SmartLocation.stream.listen((loc) {
  print('Moving to: ${loc.latitude}, ${loc.longitude}');
});
```

### 4. Utility Functions
```dart
double distance = SmartLocation.distanceBetween(
  52.2165157, 21.0369204, // Point A
  52.2296756, 21.0122287, // Point B
);
```

## Additional Information
Exceptions thrown are mapped securely into predictable types:
- `LocationDisabledException`
- `PermissionDeniedException`
- `PermissionPermanentlyDeniedException`
