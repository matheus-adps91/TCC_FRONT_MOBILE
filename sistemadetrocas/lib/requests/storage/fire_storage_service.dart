import 'package:firebase_storage/firebase_storage.dart';

class FireStorageService  {

  static Future<void> deleteImage(String imageUrl) async {
    final StorageReference fbStorageRef = await FirebaseStorage.instance.getReferenceFromUrl(imageUrl);
    await fbStorageRef.delete();
  }

}