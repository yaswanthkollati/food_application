import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_application/cubit/app_cubit.dart';
import 'package:food_application/screens/food_detail_page.dart';
import 'package:food_application/utils/parameters.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    final favoriteFoods = appCubit.state.likedFoodList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Foods'),
      ),
      body: ListView.builder(
        itemCount: favoriteFoods.length,
        itemBuilder: (context, index) {
          final foodIndex = favoriteFoods[index];
          final foodItem = appCubit.getFoodItemByIndex(foodIndex);

          return Container(
            padding: EdgeInsets.only(bottom: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FoodDetailPage(
                      parameters: Parameters(
                        foodItem: foodItem,
                        foodIndex: foodIndex,
                      ), appCubit: appCubit,
                    ),
                  ),
                );
              },
              child: ListTile(
                leading: Image.asset(foodItem.image),
                title: Text(foodItem.name),
              ),
            ),
          );
        },
      ),
    );
  }
}
