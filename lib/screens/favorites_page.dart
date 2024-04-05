import 'package:ecommerce_app/model/clothes_model.dart';
import 'package:ecommerce_app/providers/fav_provider.dart';
import 'package:ecommerce_app/screens/detail_screen.dart';
import 'package:ecommerce_app/services/api_services.dart';
import 'package:ecommerce_app/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<ClothesModel> fetch = [];
  List<ClothesModel> fetch1 = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<ClothesModel>?> getData() async {
    fetch = await ApiServices().getApi();
    fetch1 = await ApiServices().getApi1();
    fetch.addAll(fetch1);
    return fetch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(222, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favorites',
                style: appstyle(
                  25,
                  Colors.black,
                  FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Consumer<FavoriteProvider>(
                      builder: (context, value, child) {
                        return value.favoriteproductIds.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: value.favoriteproductIds.length,
                                  itemBuilder: (context, index) {
                                    final val =
                                        value.favoriteproducts(fetch)[index];
                                    final cat1 = val.cat[0].toUpperCase() +
                                        val.cat.substring(1);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                        vertical: 20,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                image: val.image,
                                                title: val.title,
                                                cat: val.cat,
                                                rating: val.rating,
                                                price: val.price,
                                                description: val.des,
                                                id: val.id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 125,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(),
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 5),
                                              Container(
                                                height: 180,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Image.network(val.image),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 225,
                                                    child: Text(
                                                      val.title,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: appstyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '($cat1)',
                                                    style: appstyle(
                                                      20,
                                                      Colors.grey,
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    '\$${val.price.toString()}',
                                                    style: appstyle(
                                                      28,
                                                      Colors.black,
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Expanded(
                                child: Center(
                                  child: Text(
                                    'No Favorites added!!!',
                                    textAlign: TextAlign.center,
                                    style: appstyle(
                                      26,
                                      Colors.black,
                                      FontWeight.w700,
                                    ),
                                  ),
                                ),
                              );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Error Fetching Data!'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
