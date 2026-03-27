import 'package:geolocator/geolocator.dart';
import '../exceptions/location_exceptions.dart' as smart_loc;
import '../utils/safe_executor.dart';

class PermissionManager {
  /// Checks if location services are enabled on the device.
  Future<bool> isLocationServiceEnabled() async {
    return SafeExecutor.executeAsync(() async {
      return await Geolocator.isLocationServiceEnabled();
    });
  }

  /// Checks the current location permission status without requesting.
  Future<LocationPermission> checkPermission() async {
    return SafeExecutor.executeAsync(() async {
      return await Geolocator.checkPermission();
    });
  }

  /// Requests location permission from the user.
  Future<LocationPermission> requestPermission() async {
    return SafeExecutor.executeAsync(() async {
      return await Geolocator.requestPermission();
    });
  }

  /// Convenience method that checks permission, and if denied, requests it.
  /// Throws exceptions if permanently denied or if services are disabled.
  Future<void> ensurePermission() async {
    final serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw smart_loc.LocationDisabledException();
    }

    var permission = await checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await requestPermission();
      if (permission == LocationPermission.denied) {
        throw smart_loc.PermissionDeniedException();
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      throw smart_loc.PermissionPermanentlyDeniedException();
    }
  }
}
