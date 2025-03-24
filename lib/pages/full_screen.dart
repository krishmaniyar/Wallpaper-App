import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

class FullScreen extends StatefulWidget {
  final String imagePath;
  const FullScreen({super.key, required this.imagePath});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> saveImage() async {
    try {
      if (Platform.isAndroid) {
        var androidVersion = int.parse(await _getAndroidVersion());

        if (androidVersion >= 30) {
          var status = await Permission.manageExternalStorage.request();
          if (!status.isGranted) {
            print("❌ Permission Denied for Manage Storage!");
            return;
          }
        } else {
          var status = await Permission.storage.request();
          if (!status.isGranted) {
            print("❌ Permission Denied for Storage!");
            return;
          }
        }
      } else {
        var status = await Permission.photos.request();
        if (!status.isGranted) {
          print("❌ Permission Denied for Photos!");
          return;
        }
      }

      var response = await Dio().get(
        widget.imagePath,
        options: Options(responseType: ResponseType.bytes),
      );

      final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(response.data),
        quality: 90,
      );

      if (result['isSuccess'] ?? false) {
        print("✅ Image saved to gallery successfully!");
      } else {
        print("❌ Failed to save image!");
      }
    } catch (e) {
      print("⚠️ Error saving image: $e");
    }
  }

  Future<String> _getAndroidVersion() async {
    var androidInfo = await Platform.environment;
    return androidInfo['ro.build.version.release'] ?? '0';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imagePath,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: widget.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: saveImage,
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54, width: 1),
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(colors: [
                        Color(0x36ffffff),
                        Color(0x0fffffff)
                      ]),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Set Wallpaper",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          "Image will be saved in Gallery",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
