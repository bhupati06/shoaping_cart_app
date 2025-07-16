import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_card_app/cart/bloc/cart_bloc.dart';
import 'package:shopping_card_app/cart/bloc/cart_event.dart';
import 'package:shopping_card_app/cart/view/cart_page.dart';
import 'package:shopping_card_app/catalog/bloc/catalog_bloc.dart';
import 'package:shopping_card_app/catalog/bloc/catalog_event.dart';
import 'package:shopping_card_app/shoapping_repository.dart';

import 'catalog/view/catalog_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(
        create: (context) => CatalogBloc(ShoppingRepository())..add(CatalogStarted()),

    ),
          BlocProvider(
            create: (context) =>
            CartBloc(shoppingRepository: ShoppingRepository())..add(CartStarted()),

          ),
        ],
    child:  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
    '/':(context) =>CatalogPage(),
    '/cart':(context)=>CartPage()
    },
    ),
    );
  }
}
