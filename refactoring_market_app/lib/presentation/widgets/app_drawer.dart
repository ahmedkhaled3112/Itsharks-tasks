import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refactoring_market_app/presentation/screens/home/home_screen.dart';
import 'package:refactoring_market_app/presentation/screens/login/login_screen.dart';
import '../../logic/blocs/auth_bloc/auth_bloc.dart';
import '../screens/orders/orders_screen.dart';
import '../screens/add_product/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend !'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      BlocProvider.of<AuthBloc>(context).state is Authenticated
                          ? const OrdersScreen()
                          : const LoginScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Your Products'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      BlocProvider.of<AuthBloc>(context).state is Authenticated
                          ? const UserProductsScreen()
                          : const LoginScreen(),
                ),
              );
            },
          ),
          const Divider(),
          if (BlocProvider.of<AuthBloc>(context).state is Authenticated)
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log Out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
        ],
      ),
    );
  }
}
