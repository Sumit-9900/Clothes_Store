import 'package:ecommerce_app/model/clothes_model.dart';
import 'package:ecommerce_app/providers/fav_provider.dart';
import 'package:ecommerce_app/screens/allproducts.dart';
import 'package:ecommerce_app/screens/detail_screen.dart';
import 'package:ecommerce_app/services/api_services.dart';
import 'package:ecommerce_app/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class MenTab extends StatefulWidget {
  const MenTab({super.key});

  @override
  State<MenTab> createState() => _MenTabState();
}

class _MenTabState extends State<MenTab> {
  List<ClothesModel>? fetchdata;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<ClothesModel>?> getData() async {
    fetchdata = await ApiServices().getApi();
    return fetchdata;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 350,
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data != null) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    final cat1 =
                        data.cat[0].toUpperCase() + data.cat.substring(1);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                image: snapshot.data![index].image,
                                title: snapshot.data![index].title,
                                cat: snapshot.data![index].cat,
                                rating: snapshot.data![index].rating,
                                price: snapshot.data![index].price,
                                description: snapshot.data![index].des,
                                id: snapshot.data![index].id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      snapshot.data![index].image,
                                      width: 250,
                                      height: 200,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Consumer<FavoriteProvider>(
                                    builder: (context, value, child) {
                                      final isFavorite = value
                                          .isFavorite(snapshot.data![index].id);
                                      return Positioned(
                                        right: 5,
                                        top: 5,
                                        child: IconButton(
                                          onPressed: () {
                                            value.toggleFav(
                                                snapshot.data![index].id,
                                                context);
                                          },
                                          icon: isFavorite
                                              ? const Icon(Ionicons.heart)
                                              : const Icon(
                                                  Ionicons.heart_outline,
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  snapshot.data![index].title,
                                  maxLines: 1,
                                  style: appstyle(
                                    20,
                                    Colors.black,
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  cat1,
                                  style: appstyle(
                                    20,
                                    Colors.grey,
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  '\$${snapshot.data![index].price.toString()}',
                                  style: appstyle(
                                    28,
                                    Colors.black,
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('Error Fetching Data'),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Men\'s Clothes',
              style: appstyle(
                22,
                Colors.black,
                FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AllProduct(
                      fetchdata: getData(),
                      name: 'Men\'s Clothes',
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Show All',
                    style: appstyle(
                      18,
                      Colors.black,
                      FontWeight.w400,
                    ),
                  ),
                  const Icon(Icons.arrow_right)
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DetailScreen(
                        image:
                            'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                        title:
                            'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops',
                        cat: 'Men\'s clothing',
                        rating: 3.9,
                        price: 109.95,
                        description:
                            'Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday',
                        id: 1,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 125,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DetailScreen(
                        image:
                            'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
                        title: 'Mens Casual Premium Slim Fit T-Shirts',
                        cat: 'Men\'s clothing',
                        rating: 4.1,
                        price: 22.3,
                        description:
                            'Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.',
                        id: 2,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 125,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
