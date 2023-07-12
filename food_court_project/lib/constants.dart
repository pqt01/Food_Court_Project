import 'package:flutter/material.dart';
import 'dart:io';

var shopId = '097A8D36-5D36-4380-9FB7-08DB81D2BFD0';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const defaultBackground = Color.fromARGB(255, 50, 58, 60);
const defaultBorder = Color.fromARGB(255, 249, 165, 65);

Uri uri(String? path) {
  return Uri.parse('https://10.0.2.2:7199/api/$path');
}

const defaultTimeout = Duration(seconds: 5);

const url = "https://localhost:7199/api";

const double defaultPadding = 16.0;
const dynamic defaultContentPadding = EdgeInsets.fromLTRB(0, 5, 10, 2);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
