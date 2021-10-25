import 'package:flutter/material.dart';

import 'presentation/screens/home_screen.dart';
import 'presentation/screens/nav_bar_screen.dart';

Map<String, WidgetBuilder> routes = {
  // '/' : (_) => const HomeScreen(),
  '/':(_) => const NavBarScreen(),
};
