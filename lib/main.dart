
import 'package:firebase_authentication/screens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

main() async {
  runApp(MaterialApp(home: Signin(),debugShowCheckedModeBanner: false,));
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}

