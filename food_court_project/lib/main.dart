import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_court_project/utils/colors.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_court_project/screen/Welcome/welcome_screen.dart';
import 'package:food_court_project/constants.dart';
import 'package:food_court_project/screen/Product/product_list_screen.dart';
import 'package:food_court_project/screen/Menu/menu_management_screen.dart';
import 'package:food_court_project/screen/Menu/testColor.dart';

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
      title: 'Flutter Groceries',
      theme: theme,
      home: const MenuManagermentScreen(),
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
