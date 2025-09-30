import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mitra_pix/features/storage/domain/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String?> uploadProfileImageMobile(String path, String fileName) {
    return _uploadFile(path, fileName, "profile_images");
  }

  @override
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
     return _uploadFileBytes(fileBytes, fileName, "profile_images");
  }

  /*

  HELPER METHODS - to uplaod file to storage

  */

  // mobile platform (file)
  Future<String?> _uploadFile(
      String path, String fileName, String folder) async {
    try {
      // get file
      final file = File(path);

      // find place to storage
      final StoragRef = firebaseStorage.ref().child('$folder/$fileName');

      // upload
      final uploadTask = await StoragRef.putFile(file);

      // get image download
      final downloadUrl = uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  // web platform (bytes)
  Future<String?> _uploadFileBytes(
      Uint8List fileBytes, String fileName, String folder) async {
    try {
      // find place to storage
      final StoragRef = firebaseStorage.ref().child('$folder/$fileName');

      // upload
      final uploadTask = await StoragRef.putData(fileBytes);

      // get image download
      final downloadUrl = uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}
