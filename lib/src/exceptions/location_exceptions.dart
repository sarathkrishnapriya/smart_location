abstract class SmartLocationException implements Exception {
  final String message;
  SmartLocationException(this.message);

  @override
  String toString() => message;
}

class LocationDisabledException extends SmartLocationException {
  LocationDisabledException([String message = 'Location services are disabled.']) : super(message);
}

class PermissionDeniedException extends SmartLocationException {
  PermissionDeniedException([String message = 'Location permission denied.']) : super(message);
}

class PermissionPermanentlyDeniedException extends SmartLocationException {
  PermissionPermanentlyDeniedException([String message = 'Location permission permanently denied. Please enable it in settings.']) : super(message);
}
