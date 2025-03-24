import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreen extends StatefulWidget {
  String imagePath;
  FullScreen({super.key, required this.imagePath});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
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
            margin: EdgeInsets.only(bottom: 50),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width/1.7,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(colors: [Color(0x36ffffff), Color(0x0fffffff)]),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // _save() async{
  //   var response = await Dio().get(widget.imagePath,
  //     options: Options(responseType: ResponseType.bytes)
  //   );
  //   final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  //   print(result);
  //   Navigator.pop(context);
  // }
}
