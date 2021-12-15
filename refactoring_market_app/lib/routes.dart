import 'package:flutter/widgets.dart';

import 'presentation/screens/add_product/user_products_screen.dart';
import 'presentation/screens/orders/orders_screen.dart';
import 'presentation/screens/cart/cart_screen.dart';
import 'presentation/screens/add_product/add_product_screen.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/forget_password/forget_password_screen.dart';
import 'presentation/screens/on_boarding/on_boarding_screen.dart';
import 'presentation/screens/login/login_screen.dart';
import 'presentation/screens/signup/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => OnBoardingScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AddProductScreen.routeName: (context) => const AddProductScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  OrdersScreen.routeName: (context) => const OrdersScreen(),
  UserProductsScreen.routeName: (context) => const UserProductsScreen(),
};
