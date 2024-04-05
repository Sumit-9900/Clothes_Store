import 'package:ecommerce_app/model/clothes_model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/fav_provider.dart';
import 'package:ecommerce_app/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.image,
    required this.title,
    required this.cat,
    required this.rating,
    required this.price,
    required this.description,
    required this.id,
  });

  final String image;
  final String title;
  final String cat;
  final double rating;
  final double price;
  final String description;
  final int id;

  String get category {
    return cat[0].toUpperCase() + cat.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    List size = ['S', 'M', 'L', 'XL', 'XLL'];

    ClothesModel clothes = ClothesModel(
      id: id,
      title: title,
      price: price,
      des: description,
      image: image,
      rating: rating,
      cat: cat,
    );
    return Scaffold(
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, value1, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Image.network(
                    image,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                  ),
                  Positioned(
                    left: 2,
                    top: 2,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Consumer<FavoriteProvider>(
                    builder: (context, value, child) {
                      final isFavorite = value.isFavorite(id);
                      return Positioned(
                        right: 5,
                        top: 5,
                        child: IconButton(
                          onPressed: () {
                            value.toggleFav(id, context);
                          },
                          icon: isFavorite
                              ? const Icon(Ionicons.heart)
                              : const Icon(Ionicons.heart_outline),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        border: Border.all(),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: appstyle(
                                  25,
                                  Colors.black,
                                  FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    category,
                                    style: appstyle(
                                      22,
                                      Colors.grey,
                                      FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Rating: $rating/5',
                                    style: appstyle(
                                      22,
                                      Colors.grey,
                                      FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '\$${price.toString()}',
                                style: appstyle(
                                  25,
                                  Colors.black,
                                  FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Select a Size',
                                style: appstyle(
                                  22,
                                  Colors.black,
                                  FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 65,
                                child: ListView.builder(
                                  itemCount: size.length,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.black,
                                          child: Text(
                                            size[index],
                                            style: appstyle(
                                              15,
                                              Colors.white,
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Divider(
                                color: Color.fromARGB(141, 158, 158, 158),
                              ),
                              Text(
                                description,
                                style: appstyle(
                                  18,
                                  Colors.black,
                                  FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 25),
                              GestureDetector(
                                onTap: () {
                                  value1.addProductToCart(
                                    context,
                                    id,
                                    clothes,
                                  );
                                },
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Add To Cart',
                                      style: appstyle(
                                        25,
                                        Colors.white,
                                        FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
