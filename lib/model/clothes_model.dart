class ClothesModel{
  ClothesModel({
    required this.id,
    required this.title,
    required this.price,
    required this.des,
    required this.image,
    required this.rating,
    required this.cat,
  });

  final int id;
  final String title;
  final double price;
  final String des;
  final String image;
  final double rating;
  final String cat;

  static ClothesModel fromJson(Map<String, dynamic> json) {
    return ClothesModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      des: json['description'],
      image: json['image'],
      rating: json['rating']['rate'],
      cat: json['category'],
    );
  }
}
