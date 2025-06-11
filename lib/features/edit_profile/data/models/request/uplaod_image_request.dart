import 'dart:io';

import 'package:dio/dio.dart';

class UploadImageRequest {
  final File? imageFile;

  UploadImageRequest({this.imageFile});

  Map<String, dynamic> toFormData() {
    if (imageFile != null) {
      return {
        'image': MultipartFile.fromFileSync(
          imageFile!.path,
          filename: imageFile!.path.split('/').last,
        ),
      };
    } else {
      throw Exception("No image file provided");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imageFile?.path,
    };
  }
}
