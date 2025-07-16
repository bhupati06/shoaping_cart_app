import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_card_app/cart/bloc/cart_bloc.dart';
import 'package:shopping_card_app/cart/bloc/cart_event.dart';
import 'package:shopping_card_app/cart/bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: ColoredBox(
        color: Colors.yellow,
        child: Column(
          children: const [
            Expanded(child: Padding(padding: EdgeInsets.all(32), child: CartList())),
            Divider(height: 4, color: Colors.black),
            TotalPrice(),
          ],
        ),
      ),
    );
  }
}

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) return CircularProgressIndicator();
              if (state is CartLoaded) {
                return Text(
                  '\$${state.cart.totalPrice}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 48),
                );
              }
              return const Text("Something went wrong");
            },
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Buying not started yet")),
              );
            },
            child: const Text("Buy"),
          ),
        ],
      ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          final cartItems = state.cart.itemsWithQuantity;
          return ListView(
            children: cartItems.keys.map((item) {
              final quantity = cartItems[item]!;
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Text(item.name),
                  subtitle: Text("Quantity: $quantity"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          context.read<CartBloc>().add(CartItemDecremented(item: item));
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          context.read<CartBloc>().add(CartItemIncremented(item: item));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<CartBloc>().add(CartItemRemoved(item: item));
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }
        return const Text("Something went wrong");
      },
    );
  }
}
