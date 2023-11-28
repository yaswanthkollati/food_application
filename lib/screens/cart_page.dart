import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_application/cubit/app_cubit.dart';
import 'package:food_application/cubit/app_state.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final appCubit = context.read<AppCubit>();
        final cartItems = state.cartItems;

        double totalAmount = 0.0;

        // Calculate total amount outside the loop
        for (final cartItem in cartItems) {
          totalAmount += cartItem.price * cartItem.quantity;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),
          body: Column(
            children: [
              Expanded(
                child: // Inside your ListView.builder
ListView.builder(
  itemCount: cartItems.length,
  itemBuilder: (context, index) {
    final cartItem = cartItems[index];
    return Dismissible(
      key: UniqueKey(), // Use UniqueKey for each item
      onDismissed: (direction) {
        // Remove the item from the list when dismissed
      },
      background: Container(
        color: Colors.red, // Background color when swiping
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16.0),
      ),
      child: ListTile(
        // Your existing ListTile content
        leading: CircleAvatar(
          radius: 40.0,
          backgroundImage: AssetImage(cartItem.image),
        ),
        title: Text(cartItem.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price:${cartItem.price.toStringAsFixed(2)}'),
          ],
        ),
        trailing: Container(
          // Your existing Quantity controls
          width: 110,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              IconButton(
                icon: Icon(Icons.add, color: Colors.black),
                onPressed: () {
                  appCubit.increaseAndDecreaseQuantity(index, true);
                },
              ),
              Text('${cartItem.quantity}', style: TextStyle(fontSize: 16)),
              IconButton(
                icon: Icon(Icons.remove, color: Colors.black),
                onPressed: () {
                  appCubit.increaseAndDecreaseQuantity(index, false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  },
)

              ),
              Card(
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Handle checkout logic
                        },
                        child: Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
