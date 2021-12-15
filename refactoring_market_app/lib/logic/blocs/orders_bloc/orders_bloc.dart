import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/cart.dart';
import '../../../data/models/order.dart';
import '../../../logic/providers/order_provider.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersProvider ordersProvider;

  OrdersBloc(this.ordersProvider) : super(OrdersInitial()) {
    on<OrdersEvent>((event, emit) async {
      emit(OrdersLoading());
      if (event is LoadAllOrders) {
        try {
          await ordersProvider.fetchAndSetOrder();
          emit(OrdersLoaded(ordersProvider.orders));
        } catch (e) {
          emit(OrdersLoadingFailed());
        }
      } else if (event is AddOrder) {
        try {
          await ordersProvider.addOrder(event.products, event.total);
          emit(OrdersLoaded(ordersProvider.orders));
        } catch (e) {
          emit(OrdersLoadingFailed());
        }
      }
    });
  }
}
