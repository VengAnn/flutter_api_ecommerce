class ProductResModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;
  final Rating rating;
  //Constructor
  ProductResModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.category,
      required this.image,
      required this.rating});

  //
  factory ProductResModel.fromJson(Map<String, dynamic> json) {
    return ProductResModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      image: json['image'],
      rating: Rating(
        rate: json['rating']['rate'],
        count: json['rating']['count'],
      ),
    );
  }
}

class Rating {
  final dynamic rate;
  final int count;
  //Constructor
  Rating({required this.rate, required this.count});
}
