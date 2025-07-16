import '../model/cart.dart';

abstract class CartState{}

class CartLoading extends CartState{}

class CartLoaded extends CartState{
  CartLoaded (this.cart);
  Cart cart;
}

class CartError extends CartState{}