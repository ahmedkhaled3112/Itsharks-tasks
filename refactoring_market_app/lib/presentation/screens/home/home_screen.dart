import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refactoring_market_app/presentation/screens/login/login_screen.dart';
import '../../../data/models/product.dart';
import '../../../logic/blocs/auth_bloc/auth_bloc.dart';
import '../../../logic/blocs/cart_bloc/cart_bloc.dart';
import '../../../logic/blocs/products_bloc/product_bloc.dart';
import '../../../logic/providers/cart_provider.dart';
import '../cart/cart_screen.dart';
import '../product_details/product_details.dart';
import '../../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Market App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.of<AuthBloc>(context)
                            .state is Authenticated
                        ? const CartScreen()
                        : const LoginScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ProductsBloc>(context).add(LoadAllProducts());
        },
        child: BlocBuilder<ProductsBloc, ProductsState>(
          buildWhen: (old, newState) {
            return old != newState;
          },
          builder: (context, state) {
            final _productsBloc = BlocProvider.of<ProductsBloc>(context);
            if (state is ProductInitial) {
              _productsBloc.add(LoadAllProducts());
            } else if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductsLoadingFailed) {
              return const Center(
                child: Text("Unexpected error occurred pull down to refresh!"),
              );
            } else if (state is ProductsLoaded) {
              List<Product> products = state.productsList;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 5),
                itemBuilder: (context, itemIndex) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(products[itemIndex].id!)));
                  },
                  child: GridTile(
                    header: Container(
                      color: const Color.fromRGBO(0, 0, 0, 0.4),
                      child: ListTile(
                        tileColor: const Color.fromRGBO(0, 0, 0, 0.6),
                        leading: IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () {},
                        ),
                        trailing: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            var isContained =
                                RepositoryProvider.of<CartProvider>(context)
                                    .items
                                    .containsKey(products[itemIndex].id!);
                            return IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: isContained ? Colors.cyan : null,
                              ),
                              onPressed: () {
                                if (isContained) {
                                  BlocProvider.of<CartBloc>(context).add(
                                      RemoveProductFromCart(
                                          products[itemIndex].id!));
                                } else {
                                  BlocProvider.of<CartBloc>(context).add(
                                      AddProductToCart(products[itemIndex]));
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    child: Hero(
                      tag: products[itemIndex].id!,
                      child: Image.network(
                        products[itemIndex].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                itemCount: products.length,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
