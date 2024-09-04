import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:gallaryapp/data/models/photo_model.dart';
import 'package:gallaryapp/data/models/search_model.dart';
import 'package:gallaryapp/data/repo/photos_repo.dart';
import 'package:gallaryapp/data/repo/search_repo.dart';
import 'package:gallaryapp/locator.dart';
import 'package:gallaryapp/services/hive_manager/photo_hive_manager.dart';
import 'package:gallaryapp/services/hive_manager/search_hive_manager.dart';
import 'package:gallaryapp/services/storage/storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class Backup {
  final PhotoHiveManager _photoManager = locator.get<PhotoHiveManager>();
  final SearchHiveManager _searchManager = locator.get<SearchHiveManager>();
  final Storage _storage = locator.get<Storage>();
  final PhotosRepo _photosRepo = locator.get<PhotosRepo>();
  final SearchRepo _searchRepo = locator.get<SearchRepo>();

  String _makeData() => JsonEncoder.withIndent("    ").convert({
        "Photos": List.from(_photoManager.getAllSaved().map((e) => e.toJson())),
        "Search":
            List.from(_searchManager.getAllSaved().map((e) => e.toJson())),
      });

  Future<void> restore(
      {required void Function() onCancel,
      required void Function() onCompelete}) async {
    final data = await _pickFile();
    if (data == null) {
      onCancel();
      return;
    }
    List<PhotoModel> photosList = _photosRepo.photosMapList(data["Photos"]!);
    _photoManager.addAll(photosList.where((test) => !test.isInBox).toList());
    List<SearchModel> searchList = _searchRepo.pareseSearch(data["Search"]!);
    _searchManager.addAll(searchList.where((test) => !test.isInBox));
    onCompelete();
  }

  Future<void> saveFile(
      {required void Function() onCancel,
      required void Function() onCompelete}) async {
    try {
      String data = _makeData();
      log(data);
      String? fileName = await FilePicker.platform.saveFile(
        fileName:
            "Backup ${DateFormat('EEE, M-d-y').format(DateTime.now()).toString()}.json",
        allowedExtensions: ['json'], // Example allowed extension
        type: FileType.custom, // Use custom if specifying extensions
        dialogTitle: 'Save Backup',
      );
      if (fileName != null) {
        // Assuming you want to save this data to the file
        await _storage.saveDataToFile(fileName, data);
        onCompelete();
      } else {
        onCancel();
      }
    } on PlatformException catch (e) {
      log('Unsupported operation: $e');
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<Map<String, dynamic>?> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['json'], // Example allowed extension
        type: FileType.custom, // Use custom if specifying extensions
        dialogTitle: 'Pick Backup File',
        withData: true, // Load the file data into memory
      );

      if (result != null && result.files.single.bytes != null) {
        String fileContent = utf8.decode(result.files.single.bytes!);
        Map<String, dynamic> data = jsonDecode(fileContent);

        return data;
      }
    } on PlatformException catch (e) {
      log('Unsupported operation: $e');
    } catch (e) {
      log('Error: $e');
    }
    return null;
  }
}
