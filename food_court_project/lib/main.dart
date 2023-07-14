import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_court_project/utils/colors.dart';
import 'package:food_court_project/constants.dart';

import 'package:food_court_project/screens/splash_screen.dart';
import 'package:food_court_project/screens/Welcome/welcome_screen.dart';
import 'package:food_court_project/screens/Menu/tabs.dart';
import 'package:food_court_project/screens/Product/product_list_screen.dart';
import 'package:food_court_project/screens/Menu/menu_management_screen.dart';
import 'package:food_court_project/screens/Menu/testColor.dart';
import 'package:food_court_project/screens/Product/add_product_screen.dart';
import 'package:food_court_project/screens/auth_screen.dart';
import 'package:food_court_project/screens/Menu/test_screen.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Food court',
      theme: theme,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const TabsScreen();
            }
            return const AuthScreen();
          }),
    );
  }
}

final theme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    primary: primaryColor,
    seedColor: primaryColor,
    surface: backgroundColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
      filled: true, fillColor: primaryColor, iconColor: primaryColor),
  textTheme: GoogleFonts.baiJamjureeTextTheme(),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: const WelcomeScreen(),
    );
  }
}
