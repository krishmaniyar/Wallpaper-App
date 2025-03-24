import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'full_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List Wallpaperimage = [
    "https://thumbs.dreamstime.com/b/vertical-shot-mercedes-amg-gt-c-luxury-car-streetgasm-event-bran-romania-vertical-shot-mercedes-amg-gt-c-luxury-car-345633835.jpg",
    "https://e1.pxfuel.com/desktop-wallpaper/298/751/desktop-wallpaper-car-portrait-vertical-car-thumbnail.jpg",
    "https://nedricknews.com/wp-content/uploads/2023/05/Dream-Cars.jpg",
  ];

  int activeIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(60),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        "images/boy.png",
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Wallify',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: () async {
                          await _auth.signOut();
                        },
                        child: Icon(
                          Icons.logout_outlined,
                          size: 30,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30,),
              CarouselSlider.builder(
                itemCount: Wallpaperimage.length,
                itemBuilder: (context, index, realIndex) {
                  final res = Wallpaperimage[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(imagePath: Wallpaperimage[index])));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: Wallpaperimage[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height/1.5,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  }
                ),
              ),
              SizedBox(height: 20,),
              Center(child: buildIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: Wallpaperimage.length,
    effect: SlideEffect(
      dotHeight: 15,
      dotWidth: 15,
      activeDotColor: Colors.blue,
    ),
  );

  Widget buildImage(String urlImage, int index) => Container(
    height: MediaQuery.of(context).size.height/1.5,
    width: MediaQuery.of(context).size.width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(
        urlImage,
        fit: BoxFit.cover,
      ),
    ),
  );
}
