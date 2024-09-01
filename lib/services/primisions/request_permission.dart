import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';

/// Requests audio and storage permissions for the app.
Future<void> requestPermission() async {
  try {
    // Check if audio and storage permissions are already granted
    final bool storage = await Permission.manageExternalStorage.isGranted;

    // If permissions are not granted, request them
    if (!storage) {
      final Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      // If permissions are permanently denied, open app settings
      if (statuses[Permission.manageExternalStorage] ==
          PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
    }
  } catch (e) {
    // Handle any errors that occur during the process
    log('Error requesting storage permissions: $e');
  }
}
