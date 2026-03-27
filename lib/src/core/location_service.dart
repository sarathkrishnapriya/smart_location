import 'package:geolocator/geolocator.dart';
import '../models/location_data.dart';
import '../utils/safe_executor.dart';

class LocationService {
  /// Fetches the current location
  Future<LocationData> getCurrentLocation({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration? timeLimit,
  }) async {
    return SafeExecutor.executeAsync(() async {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: accuracy, timeLimit: timeLimit),
      );
      return _mapPosition(position);
    });
  }

  /// Fetches the last known location
  Future<LocationData?> getLastKnownLocation() async {
    return SafeExecutor.executeAsync(() async {
      final position = await Geolocator.getLastKnownPosition();
      if (position == null) return null;
      return _mapPosition(position);
    });
  }

  LocationData _mapPosition(Position position) {
    return LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
      altitude: position.altitude,
      speed: position.speed,
      speedAccuracy: position.speedAccuracy,
      heading: position.heading,
      timestamp: position.timestamp,
    );
  }
}
