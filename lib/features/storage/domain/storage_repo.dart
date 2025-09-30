import 'dart:typed_data';

abstract class StorageRepo {
  // upload image of mobile platform

  Future<String?> uploadProfileImageMobile(String path, String fileName);

  // upload image on web platform
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);
}
