import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class MyHome extends StatefulWidget {
  static String language = "";
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<String> titles = [
    "PYTHON",
    "C COMPILER",
    "C++\nCOMPILER",
    "LINUX",
  ];

  final List<Widget> images = [
    Card(
      color: Colors.green,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/python.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.blue,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/c_compiler.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      color: Colors.orange,
      elevation: 20,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/cpp_compiler.png',
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    Card(
      // color: Colors.purple,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset(
        'assets/linux.png',
        fit: BoxFit.cover,
      ),
      elevation: 20,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Click 2 Code',
        ),
        backgroundColor: Colors.teal,
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: VerticalCardPager(
                    titles: titles, // required
                    images: images, // required
                    textStyle: TextStyle(
                        letterSpacing: 5,
                        fontFamily: 'Chewy',
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(4.0, 4.0),
                            blurRadius: 12.0,
                            color: Colors.black54,
                          ),
                        ],
                        color: Colors.white,
                        fontWeight: FontWeight.bold), // optional
                    onPageChanged: (page) {
                      // optional
                    },
                    onSelectedItem: (index) {
                      print(index);
                      if (index == 0) {
                        MyHome.language = "python";
                        Navigator.pushNamed(context, 'listfiles');
                      } else if (index == 1) {
                        MyHome.language = "c";
                        Navigator.pushNamed(context, 'listfiles');
                      } else if (index == 2) {
                        MyHome.language = "cpp";
                        Navigator.pushNamed(context, 'listfiles');
                      } else if (index == 3) {
                        Navigator.pushNamed(context, 'linux');
                      }

                      // optional
                    },
                    initialPage: 0, // optional
                    align: ALIGN.CENTER // optional
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
