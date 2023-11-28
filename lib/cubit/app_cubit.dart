import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_application/data/foodList.dart';
import 'package:food_application/screens/home_page.dart';

import 'app_state.dart';
class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          const AppState(
            cartItems: [],
            likedFoodList: [],
            foodOrderNumber: 1,
            foodPrice: 0,
            likedFoods: [],
            selectedCategory: 0,
          ),
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
   void addToCart(int foodIndex) {
  // Get the currently selected food item
  final selectedFoodItem = getFoodItemByIndex(foodIndex);

  // Add the selected item to the cart
  final updatedCartItems = List<FoodList>.from(state.cartItems)
    ..add(selectedFoodItem);

  emit(
    state.copyWith(
      cartItems: updatedCartItems,
    ),
  );
}


  FoodList getFoodItemByIndex(int index) {

    return foodList[index];
  }

  final likedFoods = <int>[];


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

void increaseAndDecreaseQuantity(int index, bool isIncrease) {
  final updatedCartItems = List<FoodList>.from(state.cartItems);
  final item = updatedCartItems[index];

  if (isIncrease) {
    item.quantity++;
  } else {
    if (item.quantity > 0) {
      item.quantity--;
    }
  }

  emit(
    state.copyWith(
      cartItems: updatedCartItems,
    ),
  );
}





}
