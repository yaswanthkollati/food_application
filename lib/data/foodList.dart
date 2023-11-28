class FoodList {
  final String name;
  final String image;
  final String description;
  final double price;
  int quantity; // Remove 'final' to allow updates

  FoodList({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    this.quantity = 1, // Provide a default value
  });
}
