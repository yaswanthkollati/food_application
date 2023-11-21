import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_application/data/foodList.dart';
import 'package:food_application/screens/home_page.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          const AppState(
              likedFoodList: [],
              foodOrderNumber: 1,
              foodPrice: 0,
              selectedCategory: 0),
        );
  List<String> likedFoodIndex = [];

  void selectCategory(int selectedIndex) {
    emit(
      state.copyWith(selectedCategory: selectedIndex),
    );
  }

  void likeDislikeFood(int index) {
    final isLiked = state.likedFoodList.contains(index);

    if (isLiked) {
      final updatedLikedItems = List<int>.from(state.likedFoodList)
        ..remove(index);
      emit(state.copyWith(likedFoodList: updatedLikedItems));
    } else {
      final updatedLikedItems = List<int>.from(state.likedFoodList)..add(index);
      emit(state.copyWith(likedFoodList: updatedLikedItems));
    }
  }

  FoodList getFoodItemByIndex(int index) {
    // Replace this with your actual data retrieval logic.
    // Retrieve the FoodList object based on the given index.
    // For example, if you have a list of FoodList items, you can return the item at the specified index.
    return foodList[index];
  }

  final likedFoods = <int>[];
  // void likeDislikeFood(int index) {
  //   final isLiked = state.likedFoodList.contains(index);

  //   if (isLiked) {
  //     state.likedFoodList.remove(index);
  //   } else {
  //     state.likedFoodList.add(index);
  //   }

  //   emit(state.copyWith(likedFoodList: List.from(state.likedFoodList)));
  // }

  void determineFoodPrice(double foodPrice) {
    emit(
      state.copyWith(foodPrice: state.foodOrderNumber * foodPrice),
    );
  }

  void increaseAndDecreaseFoodOrder(bool isIncrease, double foodPrice) {
    emit(
      state.copyWith(
        foodOrderNumber: isIncrease
            ? state.foodOrderNumber + 1
            : state.foodOrderNumber > 0
                ? state.foodOrderNumber - 1
                : 0,
      ),
    );
    emit(
      state.copyWith(foodPrice: (state.foodOrderNumber) * foodPrice),
    );
  }

  void clearStatesValues() {
    emit(
      state.copyWith(
        foodOrderNumber: 1,
        foodPrice: 0,
      ),
    );
  }
}
