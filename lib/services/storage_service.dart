import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class IStorageService {
  Future<String> uploadImage({required File file, required String imgPath});
  Future<void> deleteImage({required String imgPath});
}

class StorageService extends IStorageService {
  //Add validation to determine if file is image or not...
  @override
  Future<String> uploadImage(
      {required File file, required String imgPath}) async {
    try {
      final Reference ref = FirebaseStorage.instance.ref().child(imgPath);
      final UploadTask uploadTask = ref.putFile(file);
      final Reference sr = (await uploadTask).ref;
      return (await sr.getDownloadURL()).toString();
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<void> deleteImage({required String imgPath}) async {
    try {
      final Reference ref = FirebaseStorage.instance.ref().child(imgPath);
      await ref.delete();
      return;
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }
}
