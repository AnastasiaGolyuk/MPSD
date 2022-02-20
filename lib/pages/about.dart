import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(20),
              child: Image(
                image: AssetImage('assets/my_photo.jpg'),
                width: 250,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Labwork 1",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.pink,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Anastasia Golyuk",
                style: TextStyle(fontSize: 20, color: Colors.pink),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "951006",
                style: TextStyle(fontSize: 20, color: Colors.pink),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
