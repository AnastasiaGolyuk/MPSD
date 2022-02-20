import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:my_app/pages/main_page.dart';

class Load extends StatelessWidget {
  const Load({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: const MainPage(title: "Labwork 1"),
      title: const Text(
        "Labwork 1",
        style: TextStyle(fontSize: 20, color: Colors.pink),
      ),
      image: const Image(
        image: AssetImage("assets/cat_hearts.png"),
      ),
      loadingText: const Text("Loading",
          style: TextStyle(fontSize: 20, color: Colors.pink)),
      photoSize: 100.0,
      loaderColor: Colors.pink,
    );
  }
}
