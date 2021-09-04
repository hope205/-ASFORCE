import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:asforce/Screens/control_screen.dart';

class Welcome extends StatelessWidget {
  static const String id = 'Welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // leading: GestureDetector(
        //   child: Icon(
        //     Icons.arrow_back,
        //     color: Colors.grey,
        //   ),
        //   onTap: () {
        //     //Navigator.pushNamed(context, LoginScreen.id);
        //   },
        // ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Welcome',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Column(
          children: [
            // Material(
            //   elevation: 5.0,
            //   borderRadius: BorderRadius.circular(15.0),
            //   child: Container(
            //     padding: EdgeInsets.fromLTRB(5, 20, 10, 20),
            //     height: 170,
            //     width: 340,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15.0),
            //       color: Colors.white,
            //     ),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           'Well risk predictions',
            //           style: TextStyle(fontSize: 20),
            //         ),
            //         SizedBox(
            //           height: 40,
            //         ),
            //         Container(
            //           alignment: Alignment.bottomRight,
            //           child: IconButton(
            //             icon: Icon(Icons.arrow_forward),
            //             onPressed: () {
            //               Navigator.pushNamed(context, Control.id);
            //             },
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            rule(title: 'Methane emission predictions', img: 'Images/pic3.jpg'),
            SizedBox(
              height: 40,
            ),
            rule(
              title: 'Anomaly Detection',
              img: 'Images/pic2.jpg',
            ),
            SizedBox(
              height: 40,
            ),
            rule(title: 'Power management', img: 'Images/pic.jpg'),
          ],
        ),
      ),
    );
  }
}

class rule extends StatelessWidget {
  String title;
  String img;
  rule({this.title, this.img});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              height: 170,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Rubik',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      //   bottomLeft: Radius.circular(15.0),
                      //   bottomRight: Radius.circular(15.0),
                      // ),
                      image: DecorationImage(
                        image: AssetImage(img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //
                  //
                  //   ],
                  // ),
                  // Stack(
                  //   children: [
                  //     Container(
                  //       height: 90,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(15.0),
                  //         image: DecorationImage(
                  //           image: AssetImage(img),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       top: 80,
                  //       left: 90,
                  //       child: Container(
                  //         alignment: Alignment.bottomRight,
                  //         child: IconButton(
                  //           icon: Icon(
                  //             Icons.arrow_forward,
                  //             color: Colors.grey,
                  //           ),
                  //           onPressed: () {
                  //             Navigator.pushNamed(context, Control.id);
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: 20,
          //   child:
          //   Container(
          //     height: 120,
          //     decoration: BoxDecoration(
          //       // borderRadius: BorderRadius.only(
          //       //   bottomLeft: Radius.circular(15.0),
          //       //   bottomRight: Radius.circular(15.0),
          //       // ),
          //       image: DecorationImage(
          //         image: AssetImage(img),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            top: 120,
            left: 270,
            child: Container(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Control.id);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
// SizedBox(
// height: 40,
// ),
