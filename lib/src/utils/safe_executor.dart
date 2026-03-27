import 'package:geolocator/geolocator.dart';
import '../exceptions/location_exceptions.dart' as smart_loc;

class SafeExecutor {
  /// Safely executes a location future and maps exceptions
  static Future<T> executeAsync<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on smart_loc.PermissionDeniedException {
      rethrow;
    } on LocationServiceDisabledException {
      throw smart_loc.LocationDisabledException();
    } on PermissionDeniedException {
      throw smart_loc.PermissionDeniedException();
    } catch (e) {
      if (e.toString().contains('Permission denied')) {
        throw smart_loc.PermissionDeniedException();
      } else if (e.toString().contains('permanently denied')) {
        throw smart_loc.PermissionPermanentlyDeniedException();
      } else if (e.toString().contains('Location services are disabled')) {
        throw smart_loc.LocationDisabledException();
      }
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// Safely executes a location stream and maps exceptions
  static Stream<T> executeStream<T>(Stream<T> Function() action) {
    return action().handleError((error) {
      if (error is smart_loc.PermissionDeniedException || 
          error is smart_loc.LocationDisabledException || 
          error is smart_loc.PermissionPermanentlyDeniedException) {
        throw error;
      }
      
      if (error is LocationServiceDisabledException) {
        throw smart_loc.LocationDisabledException();
      } else if (error is PermissionDeniedException) {
         throw smart_loc.PermissionDeniedException();
      }
      
      final msg = error.toString();
      if (msg.contains('Permission denied')) {
        throw smart_loc.PermissionDeniedException();
      } else if (msg.contains('permanently denied')) {
        throw smart_loc.PermissionPermanentlyDeniedException();
      } else if (msg.contains('Location services are disabled')) {
        throw smart_loc.LocationDisabledException();
      }
      throw Exception('An unexpected error occurred: $error');
    });
  }
}
