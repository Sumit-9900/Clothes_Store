import 'package:ecommerce_app/model/clothes_model.dart';
import 'package:ecommerce_app/providers/fav_provider.dart';
import 'package:ecommerce_app/screens/allproducts.dart';
import 'package:ecommerce_app/screens/detail_screen.dart';
import 'package:ecommerce_app/services/api_services.dart';
import 'package:ecommerce_app/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class WomenTab extends StatefulWidget {
  const WomenTab({super.key});

  @override
  State<WomenTab> createState() => _WomenTabState();
}

class _WomenTabState extends State<WomenTab> {
  List<ClothesModel>? fetchdata;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<ClothesModel>?> getData() async {
    fetchdata = await ApiServices().getApi1();
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
              'Women\'s Clothes',
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
                      name: 'Women\'s Clothes',
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
                  const Icon(Icons.arrow_right),
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
                            'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',
                        title:
                            'BIYLACLESEN Women\'s 3-in-1 Snowboard Jacket Winter Coats',
                        cat: 'Women\'s clothing',
                        rating: 2.6,
                        price: 56.99,
                        description:
                            'Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design: Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates',
                        id: 15,
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
                      'https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg',
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
                            'https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg',
                        title:
                            'Lock and Love Women\'s Removable Hooded Faux Leather Moto Biker Jacket',
                        cat: 'Women\'s clothing',
                        rating: 2.9,
                        price: 29.95,
                        description:
                            '100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER), Faux leather material for style and comfort / 2 pockets of front, 2-For-One Hooded denim style faux leather jacket, Button detail on waist / Detail stitching at sides, HAND WASH ONLY / DO NOT BLEACH / LINE DRY / DO NOT IRON',
                        id: 16,
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
                      'https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg',
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
