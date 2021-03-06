import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/product.dart';
import '../../../logic/providers/cart_provider.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartProvider cartProvider;

  CartBloc(this.cartProvider) : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      emit(CartLoading());
      if (event is LoadCartItems) {
        emit(CartLoaded(cartProvider.items));
      } else if (event is AddProductToCart) {
        cartProvider.addItem(
            productId: event.product.id!,
            title: event.product.name,
            price: event.product.price);
        emit(CartLoaded(cartProvider.items));
      } else if (event is RemoveProductFromCart) {
        cartProvider.removeSingleItem(event.productId);
        emit(CartLoaded(cartProvider.items));
      }
    });
  }
}
