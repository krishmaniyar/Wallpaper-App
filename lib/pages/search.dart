import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_models.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widget/widget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<PhotosModel> photos = [];
  TextEditingController searchcontroller = TextEditingController();
  bool search = false;

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
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                "Search",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
                controller: searchcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      photos = [];
                      search = false;
                      setState(() {

                      });
                      getSearchWallpaper(searchcontroller.text);
                    },
                    child: Icon(
                      Icons.search_outlined,
                      color: Color.fromARGB(255, 84, 87, 93),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(child: wallpaper(photos, context)),
          ],
        ),
      ),
    );
  }
}
