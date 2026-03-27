import 'package:flutter_test/flutter_test.dart';
import 'package:smart_location/smart_location.dart';

void main() {
  group('SmartLocation Models & Utils Tests', () {
    test('LocationData model properties', () {
      final loc = LocationData(
        latitude: 10.0,
        longitude: 20.0,
        accuracy: 5.0,
        altitude: 100.0,
        speed: 1.5,
        speedAccuracy: 0.5,
        heading: 90.0,
        timestamp: DateTime(2023, 1, 1),
      );

      expect(loc.latitude, 10.0);
      expect(loc.longitude, 20.0);
      expect(loc.accuracy, 5.0);
      expect(loc.toString(), 'LocationData(lat: 10.0, lng: 20.0, accuracy: 5.0)');
    });

    test('Custom Exceptions text mapping', () {
      final e1 = LocationDisabledException();
      expect(e1.toString(), 'Location services are disabled.');

      final e2 = PermissionDeniedException('Custom msg');
      expect(e2.toString(), 'Custom msg');
    });
  });

  // Note: Geolocator requires native bindings, so we focus on pure Dart models and exceptions for unit tests unless utilizing MethodChannel mocking.
}
