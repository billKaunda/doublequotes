import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WallpaperService {
  //TODO Update to incude the intended company name, i.e, ALOGA or MARAD
  static const _platform = MethodChannel('com.example.wallpaper/wallpaper');

  static Future<Uint8List?> _getWallpaper() async {
    try {
      final Uint8List? wallpaperBytes =
          await _platform.invokeMethod('getWallpaper');
      return wallpaperBytes;
    } on PlatformException catch (e) {
      throw Exception('Failed to get wallpaper. ${e.message}');
    }
  }
    
  //Convert Uint8List object to an [ImageProvider]
  Future<ImageProvider> toImageProvider() async {
    final Uint8List? wallpaper = await _getWallpaper();

    ImageProvider imageProvider = MemoryImage(wallpaper!);

    return imageProvider;
  }
}
