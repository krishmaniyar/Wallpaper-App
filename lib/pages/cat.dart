import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_models.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widget/widget.dart';

class Cat extends StatefulWidget {
  final String? category;
  const Cat({super.key, this.category});

  @override
  State<Cat> createState() => _SearchState();
}

class _SearchState extends State<Cat> {

  List<PhotosModel> photos = [];
  TextEditingController searchcontroller = TextEditingController();
  bool search = false;

  @override
  void initState() {
    if(widget.category == "Wildlife") {
      searchcontroller.text = 'Wildlife';
      getSearchWallpaper(searchcontroller.text);
    }
    if(widget.category == "Food") {
      searchcontroller.text = 'Food';
      getSearchWallpaper(searchcontroller.text);
    }
    if(widget.category == "Nature") {
      searchcontroller.text = 'Nature';
      getSearchWallpaper(searchcontroller.text);
    }
    if(widget.category == "City") {
      searchcontroller.text = 'City';
      getSearchWallpaper(searchcontroller.text);
    }
    super.initState();
  }


  getSearchWallpaper(String searchQuery) async {
    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$searchQuery&per_page=30"), headers: {"Authorization": "TCyy6x0cb7QwqzwTaGChNp1nQsuHiW5KFjbMZCs1oa3VCmD9YaUNw3GN"}).then((value){
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });
      setState(() {
        search = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.grey[900],
          ),
        ),
        centerTitle: true,
        title: Text(
          "${widget.category}",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Expanded(child: wallpaper(photos, context)),
        ],
      ),
    );
  }
}
