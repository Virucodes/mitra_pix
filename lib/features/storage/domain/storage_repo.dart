import 'dart:typed_data';

abstract class StorageRepo {
  // upload image of mobile platform

  Future<String?> uploadProfileImageMobile(String path, String fileName);

  // upload image on web platform
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);

  // upload post image on mobile platform
  Future<String?> uploadPostImageMobile(String path, String fileName);

  // upload post image on web platform
  Future<String?> uploadPostImageWeb(Uint8List fileBytes, String fileName);
}
