import 'package:flutter/material.dart';

import 'package:sikucing/screens/home/splashscreen.dart';
import 'theme/color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cat Adoption App',
      theme: ThemeData(
        primaryColor: AppColor.primary,
      ),
      home: const SplashScreen(),
    );
  }
}
