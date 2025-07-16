import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_card_app/cart/bloc/cart_bloc.dart';
import 'package:shopping_card_app/cart/bloc/cart_event.dart';
import 'package:shopping_card_app/cart/bloc/cart_state.dart';
import 'package:shopping_card_app/catalog/bloc/catalog_bloc.dart';
import 'package:shopping_card_app/catalog/bloc/catalog_state.dart';
import 'package:shopping_card_app/catalog/models/item.dart';
import 'package:shopping_card_app/theme/bloc/theme_bloc.dart';
import 'package:shopping_card_app/theme/bloc/theme_state.dart';
import 'package:shopping_card_app/theme/bloc/theme_event.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CatalogAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is CatalogLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return CatalogListItem(state.catalog.getByPosition(index));
                    },
                    childCount: state.catalog.items.length,
                  ),
                );
              }
              return const SliverFillRemaining(
                child: Center(child: Text("Something went wrong")),
              );
            },
          )
        ],
      ),
    );
  }
}

class CatalogListItem extends StatelessWidget {
  const CatalogListItem(this.item, {super.key});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 72,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(item.imagePath, fit: BoxFit.cover),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                item.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(width: 24),
            AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CircularProgressIndicator();
        } else if (state is CartLoaded) {
          final isInCart = state.cart.items.contains(item);

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: isInCart
                ? Icon(
              Icons.check_circle,
              key: const ValueKey('added'),
              color: Colors.green,
              size: 28,
              semanticLabel: "ADDED",
            )
                : TextButton(
              key: const ValueKey('add_button'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                context.read<CartBloc>().add(CartItemAdded(item: item));
              },
              child: const Text("ADD TO CART"),
            ),
          );
        }
        return const Text("Something went wrong");
      },
    );
  }
}

class CatalogAppBar extends StatelessWidget {
  const CatalogAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      title: const Text('Catalog'),
      actions: [
        // 🔁 Cart icon with badge
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            int itemCount = 0;
            if (state is CartLoaded) {
              itemCount = state.cart.items.length;
            }

            return IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: badges.Badge(
                showBadge: itemCount > 0,
                badgeContent: Text(
                  '$itemCount',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                child: const Icon(Icons.shopping_cart),
              ),
            );
          },
        ),

        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final isDarkMode = state.themeMode == ThemeMode.dark;
            return IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleTheme());
              },
            );
          },
        ),
      ],
    );
  }
}
