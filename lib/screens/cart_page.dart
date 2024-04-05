import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/detail_screen.dart';
import 'package:ecommerce_app/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 25.0),
          child: Consumer<CartProvider>(
            builder: (context, value, child) {
              return value.cartproduct.isNotEmpty
                  ? Column(
                      children: [
                        Text(
                          'My Cart',
                          style: appstyle(
                            25,
                            Colors.black,
                            FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: value.cartproduct.length,
                            itemBuilder: (context, index) {
                              final id = value.cartproduct.keys.toList()[index];
                              final product = value.getProductById(id);
                              final cat1 = product!.cat[0].toUpperCase() +
                                  product.cat.substring(1);
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
                                          image: product.image,
                                          title: product.title,
                                          cat: product.cat,
                                          rating: product.rating,
                                          price: product.price,
                                          description: product.des,
                                          id: product.id,
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Image.network(product.image),
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
                                                product.title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
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
                                            Expanded(
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '\$${product.price}',
                                                      style: appstyle(
                                                        28,
                                                        Colors.black,
                                                        FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      value.cartproduct
                                                              .containsKey(id)
                                                          ? 'x${value.cartproduct[id]}'
                                                          : 'x0',
                                                      style: appstyle(
                                                        22,
                                                        Colors.grey,
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          value
                                                              .removeProductFromCart(
                                                            id,
                                                            context,
                                                            product,
                                                          );
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color: Color.fromARGB(
                                                              195, 244, 67, 54),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Proceed To Checkout',
                                style: appstyle(
                                  25,
                                  Colors.white,
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
          ),
        ),
      ),
    );
  }
}
