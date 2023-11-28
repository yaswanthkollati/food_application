import 'package:equatable/equatable.dart';
import 'package:food_application/data/foodList.dart';

class AppState extends Equatable {
  final List<int> likedFoodList;
  final List<int> likedFoods; // Add this line
  final List<FoodList> cartItems;

  final int foodOrderNumber;
  final double foodPrice;
  final int selectedCategory;

  const AppState({
    required this.likedFoodList,
    required this.foodOrderNumber,
    required this.foodPrice,
    required this.likedFoods, // Add this line
    required this.cartItems,
    required this.selectedCategory,
  });

  AppState copyWith({
    List<int>? likedFoodList,
    int? foodOrderNumber,
    double? foodPrice,
    List<int>? likedFoods, // Add this line
    List<FoodList>? cartItems, // Add this line
    int? selectedCategory,
  }) {
    return AppState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      likedFoodList: likedFoodList ?? this.likedFoodList,
      foodOrderNumber: foodOrderNumber ?? this.foodOrderNumber,
      likedFoods: likedFoods ?? this.likedFoods,
      foodPrice: foodPrice ?? this.foodPrice,
      cartItems: cartItems ?? this.cartItems, // Add this line
    );
  }

  @override
  List<Object?> get props =>
      [foodOrderNumber, foodPrice, selectedCategory, likedFoodList,cartItems];
}
