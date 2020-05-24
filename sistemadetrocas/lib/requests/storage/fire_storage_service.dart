import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:sistemadetrocas/pages/tabs/constants.dart';

class FireStorageService  {

  // Adiciona a imagem no fireStorage
  static Future<String> uploadImageToStorage(File photoFile) async {
    StorageTaskSnapshot futureTaskSnapshot = await _upload(photoFile);
    String downloadURL = await futureTaskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  static Future<StorageTaskSnapshot> _upload(File photoFile) async {
    final RegExp regex = RegExp('([^?/]*\.(jpg))');
    final String _fileName = regex.stringMatch(photoFile.path);
    final StorageReference fbStorageRef = FirebaseStorage.instance
        .ref()
        .child(Constants.url_fire_storage_products + _fileName);
    final StorageUploadTask task = fbStorageRef.putFile(photoFile);
    var futureTaskSnapshot = await task.onComplete;
    return futureTaskSnapshot;
  }

  // Deleta a imagem armazenada no fireStorage
  static Future<void> deleteImageFromStorage(String imageUrl) async {
    final StorageReference fbStorageRef = await FirebaseStorage.instance.getReferenceFromUrl(imageUrl);
    await fbStorageRef.delete();
  }

}