import 'package:geolocator/geolocator.dart';
import '../core/permission_manager.dart';

class SmartPermission {
  final PermissionManager _manager;

  SmartPermission(this._manager);

  /// Automatically ensures that location services are enabled
  /// and permissions are granted before proceeding.
  Future<void> ensureReady() async {
    await _manager.ensurePermission();
  }

  /// Checks if the app currently has permission.
  Future<bool> hasPermission() async {
    final status = await _manager.checkPermission();
    return status == LocationPermission.whileInUse || status == LocationPermission.always;
  }

  /// Checks if location services are enabled on the device.
  Future<bool> isServiceEnabled() async {
    return await _manager.isLocationServiceEnabled();
  }
}
