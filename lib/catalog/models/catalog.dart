import 'package:shopping_card_app/catalog/models/item.dart';

class Catalog {
  Catalog(catalogItems);


  final List<Item> _catalog = [
    Item(0,' APPLE FRUITS' ,   'assets/images/image1.jpg'),
    Item(1, 'BANANA FRUITS', 'assets/images/image2.jpg'),
    Item(2, 'DAIRY CHOCOLATE', 'assets/images/image3.jpg'),
    Item(3, 'FRUITS PACKAGE','assets/images/image4.jpg'),
    Item(4, 'COCONUT OIL', 'assets/images/image5.jpg'),
    Item(2, 'KRISHNA FLUTE', 'assets/images/image6.png'),
    Item(3, 'FRUITY JUICE', 'assets/images/image7.png'),
    Item(4, 'SUGAR PACKET', 'assets/images/image8.jpg'),
    Item(3, ' BUY CARROT ', 'assets/images/image9.jpeg'),
    Item(4, ' VEG BROCCOLI ', 'assets/images/image10.jpeg'),
    Item(3, ' STUDY BOOKS', 'assets/images/image11.jpg'),
    Item(4, 'BUY PEN', 'assets/images/image12.jpg'),
    Item(3, 'POCKET PURSE', 'assets/images/image13.jpg'),
    Item(4, 'BUY PERFUME', 'assets/images/image14.jpg'),

  ];

  Item getById(int id) => _catalog.firstWhere((item) => item.id == id);

  Item getByPosition(int position) => _catalog[position];

  List<Item> get items => _catalog;
}

