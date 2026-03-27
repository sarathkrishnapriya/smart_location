import 'package:geolocator/geolocator.dart';
import '../models/location_data.dart';
import '../utils/safe_executor.dart';

class LocationStreamManager {
  /// Provides a continuous stream of location updates.
  Stream<LocationData> getStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 0,
    Duration? timeLimit,
  }) {
    return SafeExecutor.executeStream(() {
      final settings = LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
        timeLimit: timeLimit,
      );
      
      return Geolocator.getPositionStream(locationSettings: settings)
          .map((position) => _mapPosition(position));
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
