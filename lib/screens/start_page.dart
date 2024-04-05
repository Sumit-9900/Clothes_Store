import 'package:ecommerce_app/providers/bottomnav_provider.dart';
import 'package:ecommerce_app/screens/cart_page.dart';
import 'package:ecommerce_app/screens/favorites_page.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      HomePage(),
      FavoritesPage(),
      CartPage(),
    ];
    return Consumer<BottomNavProvider>(
      builder: (context, bottomnavprovider, child) {
        return Scaffold(
          body: pages[bottomnavprovider.index],
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(199, 0, 0, 0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        bottomnavprovider.setindex(0);
                      },
                      icon: bottomnavprovider.index == 0
                          ? const CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.home,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          : const Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 30,
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        bottomnavprovider.setindex(1);
                      },
                      icon: bottomnavprovider.index == 1
                          ? const CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(
                                Ionicons.heart,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          : const Icon(
                              Ionicons.heart_outline,
                              color: Colors.white,
                              size: 30,
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        bottomnavprovider.setindex(2);
                      },
                      icon: bottomnavprovider.index == 2
                          ? const CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(
                                Ionicons.cart,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          : const Icon(
                              Ionicons.cart,
                              color: Colors.white,
                              size: 30,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
