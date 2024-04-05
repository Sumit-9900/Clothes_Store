import 'package:ecommerce_app/model/clothes_model.dart';
import 'package:ecommerce_app/screens/detail_screen.dart';
import 'package:ecommerce_app/textstyle.dart';
import 'package:flutter/material.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({
    super.key,
    required this.fetchdata,
    required this.name,
  });

  final Future<List<ClothesModel>?> fetchdata;
  final String name;

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: appstyle(
            28,
            Colors.black,
            FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: widget.fetchdata,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    final cat1 =
                        data.cat[0].toUpperCase() + data.cat.substring(1);
                    final titleLen = snapshot.data![index].title.length;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 20,
                      ),
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
                          height: 125,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 5),
                              Container(
                                height: 180,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child:
                                    Image.network(snapshot.data![index].image),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  titleLen >= 18
                                      ? SizedBox(
                                          height: 50,
                                          width: 225,
                                          child: Text(
                                            snapshot.data![index].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: appstyle(
                                              20,
                                              Colors.black,
                                              FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Text(
                                    '($cat1)',
                                    style: appstyle(
                                      20,
                                      Colors.grey,
                                      FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '\$${snapshot.data![index].price.toString()}',
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
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
