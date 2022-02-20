import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:my_app/account/auth_helper.dart';
import 'package:my_app/pages/load.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthHelper(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: const Load(),
      ),
    );
  }
}
