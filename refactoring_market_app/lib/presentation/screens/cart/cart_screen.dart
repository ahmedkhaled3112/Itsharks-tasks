import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/screens/login/login_screen.dart';
import '../../../logic/blocs/orders_bloc/orders_bloc.dart';
import '../../../logic/providers/cart_provider.dart';
import '../../widgets/cart_item.dart' as w;

class CartScreen extends StatelessWidget {
  static const String routeName = "/cartScreen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final cart = RepositoryProvider.of<CartProvider>(context);
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is OrdersLoaded) {
          cart.clearCart();
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Cart'),
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.cyan,
                    ),
                    BlocBuilder<OrdersBloc, OrdersState>(
                      builder: (context, state) {
                        if (state is OrdersLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return TextButton(
                            onPressed: () {
                              BlocProvider.of<OrdersBloc>(context).add(
                                AddOrder(
                                  cart.items.values.toList(),
                                  cart.totalAmount,
                                ),
                              );
                            },
                            child: const Text("Place Now"));
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, i) => w.CartItem(
                  id: cart.items.values.toList()[i].id,
                  productId: cart.items.keys.toList()[i],
                  price: cart.items.values.toList()[i].price,
                  quantity: cart.items.values.toList()[i].quantity,
                  title: cart.items.values.toList()[i].title,
                ),
                itemCount: cart.itemsCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
