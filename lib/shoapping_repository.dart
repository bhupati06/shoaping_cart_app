
import 'catalog/models/item.dart';

const _delay = Duration(milliseconds: 800);
final _items = List<Item>.generate(
  10,
      (i) => Item(i, 'Item $i', 'assets/images/item_$i.png'),
);

class ShoppingRepository {
  final _cartItems = <Item>[];

  Future<List<Item>> loadCatalog() => Future.delayed(_delay, () => _items);
  Future<List<Item>> loadCart() => Future.delayed(_delay, () => _cartItems);

  void itemAddedToCart(Item item) => _cartItems.add(item);
}
