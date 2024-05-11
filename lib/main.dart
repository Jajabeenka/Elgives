import 'package:elgives/pages/profilePage.dart';
import 'package:elgives/provider/donor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; 
import '../pages/donatePage.dart'; 
import '../pages/orgsPage.dart'; 
import '../provider/orgs_provider.dart'; 
import '../models/donation.dart'; 
import 'firebase_options.dart';
import 'provider/donation_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => DonationProvider())),
        ChangeNotifierProvider(create: ((context) => OrganizationProvider())),
        ChangeNotifierProvider(create: ((context) => DonorProvider())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EWAN Q PA',
      initialRoute: '/organizations',
      routes: { 
        '/organizations': (context) => OrgsPage(),
        '/donatePage': (context) => FormSample(),
        '/donorProfile': (context) => ProfilePage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}


