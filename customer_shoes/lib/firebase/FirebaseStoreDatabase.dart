import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class FirebaseStoreDatabase {
  String? downloadURL;
  late Directory _tempDir;

  Future getImage(String maSoGiay, String nameImage) async {
    try{
      await downloadURLExample(maSoGiay, nameImage);
      return downloadURL;
    } catch (e) {
      debugPrint("Error $e");
      return null;
    }
  }

  Future<void> downloadURLExample(String maSoGiay,String nameImage) async {
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child('Shoes/$maSoGiay/$nameImage')
        .getDownloadURL();
  }

  Future<File?> getImageFile({required String storegePath}) async {
    final fileName = storegePath.split('/').last;
    final file = File('${_tempDir.path}/$fileName');
    if(storegePath == '') return null;
    if(!file.existsSync()) {
      try{
        file.create(recursive: true);
        await FirebaseStorage.instance.ref(storegePath).writeToFile(file);
        return file;
      } catch (e) {
        await file.delete(recursive: true);
        return null;
      }
    } else {
      int sizeFile = await file.length();
      if(sizeFile <= 0) {
        await FirebaseStorage.instance.ref(storegePath).writeToFile(file);
        return file;
      }
    }
    return file;
  }

  

}