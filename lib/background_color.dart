import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:image/image.dart' as Img;

class BackgroundColor {
  final List<int> removeColorRGB;
  final List<int> addColorRGB;

  const BackgroundColor({required this.removeColorRGB, required this.addColorRGB});

  static Future<Uint8List> changeBackgroundOfImage(
      {required Uint8List bytes, required List<int> removeColorRGB, required List<int> addColorRGB}) async {
    print("실행changeBackgroundOfImage");
    Img.Image? image = Img.decodeImage(bytes);
    Img.Image newImage = await _customeColor(src: image, removeColorRGB: removeColorRGB, addColorRGB: addColorRGB);
    var newPng = Img.encodePng(newImage);

    // await Future.delayed(Duration(milliseconds: 10));

    return newPng;
  }

  static Future<Img.Image> _customeColor({Img.Image? src, required List<int> removeColorRGB, required List<int> addColorRGB}) async {
    var pixels = src!.getBytes();

    int j = 10;
    for (int i = 0, len = pixels.length; i < len; i += j) {
      if (pixels[i] == removeColorRGB[0] && pixels[i + 1] == removeColorRGB[1] && pixels[i + 2] == removeColorRGB[2]) {
        // if (pixels[i] == removeColorRGB[0] && pixels[i + 1] == removeColorRGB[1] && pixels[i + 2] == removeColorRGB[2] && pixels[i + 3] == 255) {
        pixels[i] = addColorRGB[0];
        pixels[i + 4] = addColorRGB[0];
        pixels[i + 8] = addColorRGB[0];
        pixels[i + 1] = addColorRGB[1];
        pixels[i + 5] = addColorRGB[1];
        pixels[i + 9] = addColorRGB[1];
        pixels[i + 2] = addColorRGB[2];
        pixels[i + 6] = addColorRGB[2];
        pixels[i + 10] = addColorRGB[2];
        // pixels[i + 3] = 0;
      }
      if (j == 3) {
        j = 4;
      } else {
        j = 3;
      }
    }

    return src;
  }
}
