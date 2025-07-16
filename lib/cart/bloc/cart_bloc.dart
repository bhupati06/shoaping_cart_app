import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_card_app/cart/bloc/cart_event.dart';
import 'package:shopping_card_app/cart/bloc/cart_state.dart';
import 'package:shopping_card_app/shoapping_repository.dart';

import '../model/cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ShoppingRepository shoppingRepository;

  CartBloc({required this.shoppingRepository}) : super(CartLoading()) {
    on<CartStarted>(_onCartStarted);
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemRemoved>(_onCartItemRemoved);
    on<CartItemIncremented>(_onCartItemIncremented);
    on<CartItemDecremented>(_onCartItemDecremented);
  }

  Future<void> _onCartStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cartItems = await shoppingRepository.loadCart();
      emit(CartLoaded(Cart(items: [...cartItems])));
    } catch (_) {
      emit(CartError());
    }
  }

  Future<void> _onCartItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      final updatedItems = [...state.cart.items, event.item];
      emit(CartLoaded(Cart(items: updatedItems)));
    }
  }

  Future<void> _onCartItemRemoved(CartItemRemoved event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      final updatedItems = state.cart.items.where((item) => item != event.item).toList();
      emit(CartLoaded(Cart(items: updatedItems)));
    }
  }

  Future<void> _onCartItemIncremented(CartItemIncremented event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      final items = [...state.cart.items, event.item]; // Add one more item
      emit(CartLoaded(Cart(items: items)));
    }
  }

  Future<void> _onCartItemDecremented(CartItemDecremented event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      final items = [...state.cart.items];
      final index = items.indexOf(event.item);
      if (index != -1) {
        items.removeAt(index); // Remove one instance
      }
      emit(CartLoaded(Cart(items: items)));
    }
  }
}

