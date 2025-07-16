import 'package:shopping_card_app/catalog/models/item.dart';

class Cart {
  final List<Item> items;

  Cart({required this.items});
  Map<Item, int> get itemsWithQuantity {
    final Map<Item, int> quantityMap = {};
    for (final item in items) {
      quantityMap[item] = (quantityMap[item] ?? 0) + 1;
    }
    return quantityMap;
  }

  double get totalPrice =>
      items.fold(0, (total, item) => total + item.price);
}
