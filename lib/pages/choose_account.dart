import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/account/auth_helper.dart';
import 'package:my_app/pages/cat_feed.dart';
import 'package:my_app/pages/main_page.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChooseAccount extends StatefulWidget {
  const ChooseAccount({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ChooseAccountState createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
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
                  child: const Text('Main page'))
            ],
          ),
        ),
      );
    }));
  }

  Widget _createPage() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          centerTitle: true,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MainPage(title: "Labwork 1")),
                        (ret) => false);
                  },
                  icon: const Icon(CupertinoIcons.arrow_left)),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Text(widget.title))
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  fixedSize: const Size.fromWidth(250),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                icon:
                    const FaIcon(FontAwesomeIcons.google, color: Colors.white),
                onPressed: () {
                  final provider =
                      Provider.of<AuthHelper>(context, listen: false);
                  provider.signIn();
                },
                label: const Text('Sign in with Google'),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error with authorization",
                  style: TextStyle(fontSize: 20, color: Colors.pink)),
            );
          } else if (snapshot.hasData) {
            User? account = FirebaseAuth.instance.currentUser;
            if (account != null) {
              return CatFeed(title: account.displayName ?? '');
            } else {
              return const Center(
                child: Text("Error with authorization",
                    style: TextStyle(fontSize: 20, color: Colors.pink)),
              );
            }
          } else {
            return _createPage();
          }
        },
      ),
    );
  }
}
