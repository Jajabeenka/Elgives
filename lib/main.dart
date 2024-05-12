import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9_authentication/pages/splash_screen.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'providers/todo_provider.dart';
import 'providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => TodoListProvider())),
        ChangeNotifierProvider(create: ((context) => UserAuthProvider()))
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
