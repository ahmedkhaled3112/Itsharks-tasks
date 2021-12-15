import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/blocs/orders_bloc/orders_bloc.dart';
import '../../../logic/providers/order_provider.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const String routeName = "/ordersScreen";

  @override
  Widget build(BuildContext context) {
    final ordersData = RepositoryProvider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersInitial) {
            BlocProvider.of<OrdersBloc>(context).add(LoadAllOrders());
          } else if (state is OrdersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: ordersData.orders.length,
            itemBuilder: (context, i) => OrderItem(ordersData.orders[i]),
          );
        },
      ),
    );
  }
}
