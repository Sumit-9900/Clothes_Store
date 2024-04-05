import 'package:ecommerce_app/textstyle.dart';
import 'package:ecommerce_app/widgets/men_tab.dart';
import 'package:ecommerce_app/widgets/women_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);

  bool isselected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(41, 158, 158, 158),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                'Clothes Collection',
                style: appstyle(30, Colors.black, FontWeight.bold),
              ),
              TabBar(
                controller: tabController,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                isScrollable: true,
                tabs: const [
                  Tab(child: Text('Men\'s Clothes')),
                  Tab(child: Text('Women\'s Clothes'))
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    MenTab(),
                    WomenTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
