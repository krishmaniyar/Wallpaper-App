import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_models.dart';
import 'package:wallpaper_app/pages/full_screen.dart';

Widget wallpaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      padding: EdgeInsets.all(4.0),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: listPhotos.map((PhotosModel photosModel) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(imagePath: photosModel.src!.portrait!)));
            },
            child: Hero(tag: photosModel.src!.portrait!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: photosModel.src!.portrait!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}