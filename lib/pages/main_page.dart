import 'package:flutter/material.dart';
import 'package:my_app/db/db_helper.dart';
import 'package:my_app/db/record.dart';
import 'package:my_app/pages/about.dart';
import 'package:my_app/pages/achievements.dart';
import 'package:my_app/pages/choose_account.dart';
import 'package:my_app/pages/result.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
            children: [
              FutureBuilder<Record>(
                  future: DatabaseHelper.instance.getLastRecord(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Record> snapshot) {
                    return (!snapshot.hasData)
                        ? const Center(
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text("No records",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.pink))))
                        : Center(
                            child: Column(children: [
                            const Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "Last record:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Text(
                                  snapshot.requireData.name +
                                      " has score: " +
                                      snapshot.requireData.satiety.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.pink),
                                  textAlign: TextAlign.center,
                                ))
                          ]));
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: const Size.fromWidth(200)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ChooseAccount(title: "Choose account")),
                        (ret) => false);
                  },
                  child: const Text('Feed the Cat')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: const Size.fromWidth(200)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const About(title: "About creator")),
                        (ret) => true);
                  },
                  child: const Text('About creator')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: const Size.fromWidth(200)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Results(title: "Results")),
                        (ret) => true);
                  },
                  child: const Text('Results')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: const Size.fromWidth(200)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Achievements(title: "Achievements")),
                        (ret) => true);
                  },
                  child: const Text('Achievements')),
            ],
          ),
        ));
  }
}
