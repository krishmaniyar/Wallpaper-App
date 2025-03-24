import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/cat.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Categories",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Route route = MaterialPageRoute(builder: (context) => Cat(category: 'Wildlife',));
                Navigator.push(context, route);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "images/wildlife.jpeg",
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Wildlife",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 35.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Route route = MaterialPageRoute(builder: (context) => Cat(category: 'Food',));
                Navigator.push(context, route);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "images/food.png",
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Food",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 35.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Route route = MaterialPageRoute(builder: (context) => Cat(category: 'Nature',));
                Navigator.push(context, route);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "images/nature.png",
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Nature",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 35.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Route route = MaterialPageRoute(builder: (context) => Cat(category: 'City',));
                Navigator.push(context, route);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "images/city.png",
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "City",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 35.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
