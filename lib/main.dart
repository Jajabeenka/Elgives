import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9_authentication/pages/userAdmin/splash_screen.dart';
import 'firebase_options.dart';
import 'providers/todo_provider.dart';
import 'providers/auth_provider.dart';
import 'package:elgives/pages/donor/profilePage.dart';
import 'package:elgives/provider/donor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'pages/donor/donatePage.dart'; 
import 'pages/donor/orgsPage.dart'; 
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
        ChangeNotifierProvider(create: ((context) => TodoListProvider())),
        ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
        ChangeNotifierProvider(create: ((context) => DonationProvider())),
        ChangeNotifierProvider(create: ((context) => OrganizationProvider())),
        ChangeNotifierProvider(create: ((context) => DonorProvider())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleTodo',
      initialRoute: '/',
      routes: {
        // '/': (context) => const HomePage(),
        '/': (context) => const SplashScreen(),
        '/organizations': (context) => OrgsPage(),
        '/donatePage': (context) => FormSample(),
        '/donorProfile': (context) => ProfilePage(),

      },
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF00FF00, { // Green color for primary swatch
          50: Color(0xFFE0FFB0),
          100: Color(0xFFB3FF66),
          200: Color(0xFF80FF00),
          300: Color(0xFF66CC00),
          400: Color(0xFF4D9900),
          500: Color(0xFF00FF00),
          600: Color(0xFF00E600),
          700: Color(0xFF00CC00),
          800: Color(0xFF009900),
          900: Color(0xFF006600),
        }),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black), // Yellow text color
        ),
      ),
    );
  }
}
