import 'dart:math';

import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';

import 'package:my_app/account/auth_helper.dart';
import 'package:my_app/db/achievement.dart';
import 'package:my_app/db/db_helper.dart';
import 'package:my_app/db/record.dart';
import 'package:my_app/pages/intro_pages.dart';
import 'package:my_app/pages/main_page.dart';

class CatFeed extends StatefulWidget {
  const CatFeed({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CatFeedState createState() => _CatFeedState();
}

class _CatFeedState extends State<CatFeed> with SingleTickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _animationController;
  String _url = 'assets/cat_hungry.png';
  final List _colors = [
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
    Colors.pink,
    Colors.brown
  ];
  final Random _random = Random();
  int _index = 0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void openMenu() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.pink,
            title: const Text('Menu'),
            centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    fixedSize: const Size.fromWidth(200),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MainPage(title: "Labwork 1")),
                        (ret) => false);
                  },
                  child: const Text('Main page')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    fixedSize: const Size.fromWidth(200),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IntroSliderPage()),
                        (ret) => true);
                  },
                  child: const Text('Hints')),
              Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                        fixedSize: const Size.fromWidth(200),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        final provider =
                            Provider.of<AuthHelper>(context, listen: false);
                        provider.signOut();
                        Navigator.pop(context);
                      },
                      child: const Text('Sign out')))
            ],
          ),
        ),
      );
    }));
  }

  void _checkSelectedColor(int indexSelected) {
    setState(() {
      if (_index == indexSelected) {
        _index = _random.nextInt(4);
        _counter = 0;
        _url = 'assets/cat_hungry.png';
      }
    });
  }

  void _showSaved(BuildContext context) {
    AchievementView(context,
            title: "Success!",
            textStyleSubTitle:
                const TextStyle(color: Colors.green, fontSize: 15),
            alignment: Alignment.bottomCenter,
            color: Colors.green[50],
            icon: const Icon(CupertinoIcons.checkmark_circle,
                color: Colors.green),
            typeAnimationContent: AnimationTypeAchievement.fadeSlideToLeft,
            isCircle: true,
            subTitle: "Your score has been saved!",
            textStyleTitle: const TextStyle(color: Colors.green, fontSize: 15))
        .show();
  }

  Future<void> _save() async {
    await DatabaseHelper.instance.addRecord(Record(
        id: await DatabaseHelper.instance.getSizeRecords() + 1,
        name: widget.title,
        date: DateTime.now().toString(),
        satiety: _counter));
    _showSaved(context);
  }

  void _showAchievement(BuildContext context, String title, String subTitle) {
    AchievementView(context,
            title: title,
            textStyleSubTitle: const TextStyle(color: Colors.pink),
            color: Colors.pink[50],
            icon:
                const Icon(CupertinoIcons.suit_heart_fill, color: Colors.pink),
            typeAnimationContent: AnimationTypeAchievement.fadeSlideToLeft,
            isCircle: true,
            subTitle: subTitle,
            textStyleTitle:
                const TextStyle(color: Colors.deepOrangeAccent, fontSize: 15))
        .show();
  }

  Future<void> _listenerAchievements() async {
    if (_counter == 15) {
      String title = "You're doing great!";
      bool isAlreadyGot =
          await DatabaseHelper.instance.isAchievementExist(title, widget.title);
      if (!isAlreadyGot) {
        String subTitle = "Cat is happy!";
        _showAchievement(context, title, subTitle);
        await DatabaseHelper.instance.addAchievement(
          Achievement(
              id: await DatabaseHelper.instance.getSizeAchievements() + 1,
              name: widget.title,
              title: title,
              subTitle: subTitle),
        );
      }
    }
    if (_counter == 50) {
      String title = "Well...";
      bool isAlreadyGot =
          await DatabaseHelper.instance.isAchievementExist(title, widget.title);
      if (!isAlreadyGot) {
        String subTitle = "Cat is overfeed, but still happy!";
        _showAchievement(context, title, subTitle);
        await DatabaseHelper.instance.addAchievement(
          Achievement(
              id: await DatabaseHelper.instance.getSizeAchievements() + 1,
              name: widget.title,
              title: title,
              subTitle: subTitle),
        );
      }
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter >= 15 && _counter < 50) {
        _url = 'assets/cat_hearts.png';
      }
      if (_counter >= 50) {
        _url = 'assets/cat_over_feed.png';
      }
      if (_counter % 15 == 0) {
        if (_animationController.status == AnimationStatus.completed) {
          _animationController.reset();
        }
        _animationController.forward();
      }
    });
    _listenerAchievements();
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'See my results', text: 'My cat\'s satiety is $_counter!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: openMenu, icon: const Icon(CupertinoIcons.ellipsis)),
          IconButton(onPressed: share, icon: const Icon(CupertinoIcons.share))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  'Satiety:' + _counter.toString(),
                  style: const TextStyle(fontSize: 25, color: Colors.pink),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: AnimatedBuilder(
                  animation: _animationController.view,
                  builder: (context, child) {
                    return Transform.rotate(
                        angle: _animationController.value * 2 * pi,
                        child: child);
                  },
                  child: Image(
                    image: AssetImage(_url),
                    width: 200,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      fixedSize: const Size.fromWidth(100),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: _incrementCounter,
                    child: const Text('Feed!'))),
            ElevatedButton(
              child: const Text('  '),
              style: ElevatedButton.styleFrom(
                primary: _colors[_index],
              ),
              onPressed: () {},
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => _checkSelectedColor(0),
                  child: const Text('  '),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => _checkSelectedColor(1),
                  child: const Text('  '),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => _checkSelectedColor(2),
                  child: const Text('  '),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => _checkSelectedColor(3),
                  child: const Text('  '),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        backgroundColor: Colors.pink,
        child: const Icon(CupertinoIcons.star),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
