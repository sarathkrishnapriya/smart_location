library smart_location;

import 'package:geolocator/geolocator.dart';
import 'src/core/location_service.dart';
import 'src/core/location_stream_manager.dart';
import 'src/core/permission_manager.dart';
import 'src/features/smart_permission.dart';
import 'src/models/location_data.dart';
import 'src/utils/geo_utils.dart';

export 'src/models/location_data.dart';
export 'src/exceptions/location_exceptions.dart';
export 'package:geolocator/geolocator.dart' show LocationAccuracy;

class SmartLocation {
  static final LocationService _locationService = LocationService();
  static final LocationStreamManager _streamManager = LocationStreamManager();
  static final PermissionManager _permissionManager = PermissionManager();
  static final SmartPermission _smartPermission = SmartPermission(_permissionManager);

  /// Initializes SmartLocation. Can be called on app startup.
  static Future<void> init() async {
    // Optionally pre-warm or configure globally
  }

  /// Ensures both location services are enabled and permissions are granted.
  /// Throws exceptions if denied forever or disabled.
  static Future<void> ensureReady() async {
    await _smartPermission.ensureReady();
  }

  /// Returns true if the app currently has location permissions.
  static Future<bool> hasPermission() async {
    return await _smartPermission.hasPermission();
  }

  /// Returns true if device location services are enabled.
  static Future<bool> isEnabled() async {
    return await _smartPermission.isServiceEnabled();
  }

  /// Gets the current location of the device.
  static Future<LocationData> current({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration? timeLimit,
  }) async {
    return await _locationService.getCurrentLocation(accuracy: accuracy, timeLimit: timeLimit);
  }

  /// Gets the last known location of the device. Returns null if none exists.
  static Future<LocationData?> lastKnown() async {
    return await _locationService.getLastKnownLocation();
  }

  /// Provides a stream of continuous location updates with default high accuracy.
  static Stream<LocationData> get stream {
    return _streamManager.getStream();
  }

  /// Provides a stream of continuous location updates with customizable settings.
  static Stream<LocationData> streamWithSettings({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 0,
    Duration? timeLimit,
  }) {
    return _streamManager.getStream(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
      timeLimit: timeLimit,
    );
  }

  /// Calculates the distance between two points in meters.
  static double distanceBetween(double startLat, double startLng, double endLat, double endLng) {
    return GeoUtils.distanceBetween(startLat, startLng, endLat, endLng);
  }

  /// Calculates the bearing between two points in degrees.
  static double bearingBetween(double startLat, double startLng, double endLat, double endLng) {
    return GeoUtils.bearingBetween(startLat, startLng, endLat, endLng);
  }
}
