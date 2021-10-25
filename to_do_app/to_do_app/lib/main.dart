import 'package:flutter/material.dart';

import 'presentation/themes/app_themes.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      title: "To Do App",
      theme: AppThemes.lightTheme,
    );
  }
}