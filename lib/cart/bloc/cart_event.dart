import 'package:shopping_card_app/catalog/models/item.dart';

abstract class CartEvent{}

class CartStarted extends CartEvent{}
class CartItemAdded extends CartEvent{
  CartItemAdded({required this.item});
  Item item;
}

class CartItemRemoved extends CartEvent {
  final Item item;
  CartItemRemoved({required this.item});
}

class CartItemIncremented extends CartEvent {
  final Item item;
  CartItemIncremented({required this.item});
}

class CartItemDecremented extends CartEvent {
  final Item item;
  CartItemDecremented({required this.item});
}
