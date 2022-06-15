import 'package:flutter/material.dart';

import '../Widget/appbar.dart';
import '../Widget/category.dart';
import '../Widget/product.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              //App bar
              const CustomAppBar(),
              const SizedBox(
                height: 20.0,
              ),
              // Show banner
              Banner(size: size),
              // Show category
              const SizedBox(
                height: 20,
              ),
              //Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: const [
              //     Text(
              //       "Category",
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 24),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              //const CategoryCard(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Product",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Show product
              const ProductCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({Key? key, required this.size,}) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
          height: size.height * 0.25,
          child: Row(
            children: [
              Expanded(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // Colors banner
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4ec0f5),
                                Color(0xFF2e7bee),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                            ),
                            // Radius banner
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Shoes help you\nPerform Best",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "Explore",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                primary: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),

                      // Image banner
                      Positioned(
                        top: -20,
                        right: -15,
                        child: Align(
                          child: Image.asset(
                            'assets/banner.png',
                            height: 200,
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}