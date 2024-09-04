import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';

/// Requests audio and storage permissions for the app.
Future<void> requestPermission() async {
  try {
    // Check if audio and storage permissions are already granted
    final bool storage = await Permission.manageExternalStorage.isGranted;
    final bool photos = await Permission.photos.isGranted;
    final bool videos = await Permission.videos.isGranted;
    final bool audio = await Permission.audio.isGranted;

    // If permissions are not granted, request them
    if (!storage && !photos && !videos && !audio) {
      final Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.videos,
        Permission.photos,
        Permission.audio,
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
