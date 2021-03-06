import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/products_bloc/product_bloc.dart';
import '../../../logic/providers/user_provider.dart';
import 'add_product_screen.dart';
import '../../widgets/user_product_item.dart';
import '../../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const String routeName = "/userProducts";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddProductScreen()));
              }),
        ],
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          final products = BlocProvider.of<ProductsBloc>(context)
              .productsProvider
              .products
              .where((element) =>
                  element.ownerId ==
                  RepositoryProvider.of<UserProvider>(context).getUserId())
              .toList();
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemBuilder: (_, i) => Column(
                children: [
                  UserProductItem(products[i]),
                  const Divider(),
                ],
              ),
              itemCount: products.length,
            ),
          );
        },
      ),
    );
  }
}
