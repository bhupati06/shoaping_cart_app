import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_card_app/cart/bloc/cart_event.dart';
import 'package:shopping_card_app/cart/view/cart_page.dart';
import 'package:shopping_card_app/catalog/view/catalog_page.dart';
import 'package:shopping_card_app/onboarding_screen.dart';
import 'package:shopping_card_app/shoapping_repository.dart';
import 'package:shopping_card_app/simple_bloc_observer.dart';
import 'package:shopping_card_app/theme/bloc/theme_bloc.dart';
import 'package:shopping_card_app/theme/bloc/theme_event.dart';
import 'package:shopping_card_app/theme/bloc/theme_state.dart';

import 'cart/bloc/cart_bloc.dart';
import 'catalog/bloc/catalog_bloc.dart';
import 'catalog/bloc/catalog_event.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final shoppingRepository =ShoppingRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => CatalogBloc(shoppingRepository)..add(LoadCatalog())),
        BlocProvider(create: (_) => CartBloc(shoppingRepository: shoppingRepository)..add(CartStarted()),
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shopping App',
          themeMode: state.themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepOrange,
          ),
          home: const OnboardingScreen(),
          routes: {
        '/catalog': (_) => const CatalogPage(),
            '/cart': (_) => const CartPage(),
          },
        );
      },
    );
  }
}
