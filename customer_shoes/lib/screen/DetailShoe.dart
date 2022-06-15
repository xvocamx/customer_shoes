import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_shoes/Provider/cart_provider.dart';
import 'package:customer_shoes/models/shoes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../firebase/FirebaseStoreDatabase.dart';

class DetailShoesPage extends StatefulWidget {
  const DetailShoesPage({Key? key, required this.shoes,required this.tempPrice,required this.dateStart,required this.dateEnd}) : super(key: key);
  final Shoes shoes;
  final double tempPrice;
  final DateTime dateStart;
  final DateTime dateEnd;

  @override
  State<DetailShoesPage> createState() => _DetailShoesPageState();
}

class _DetailShoesPageState extends State<DetailShoesPage> {
  bool flag = true;

  Future addToCart() async {
    final user = FirebaseAuth.instance.currentUser;
    final reference = FirebaseFirestore.instance.collection('cart').doc(user!.uid).collection('items').doc(widget.shoes.maSoGiay);
    return reference.set({
      "idShoes": widget.shoes.maSoGiay,
      "nameShoes": widget.shoes.tenGiay,
      "price": flag ? widget.tempPrice : widget.shoes.price,
      "initialPrice": flag ? widget.tempPrice : widget.shoes.price,
      "quantity": 1,
      "size": Provider.of<CartProvider>(context,listen: false).size,
      "image": widget.shoes.images,
    }).then((value) {
      print("Added to cart");
      Navigator.pop(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          title: const Text(
            "Chi tiết sản phẩm",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _shoesImage(),
              const SizedBox(
                height: 20,
              ),
              _shoesName(),
              const SizedBox(
                height: 20,
              ),
              _shoesPrice(),
              const SizedBox(
                height: 20,
              ),
              _shoesType(),
              const SizedBox(
                height: 20,
              ),
              _sizeLabel(),
              _sizeList(),
              const SizedBox(
                height: 20,
              ),
              _addToCart(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  Widget _addToCart() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey.shade200,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
              padding: const EdgeInsets.all(20),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed:() => addToCart(),
              child: Text(
                "Add to Cart",
                style: GoogleFonts.spartan(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  primary: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 20)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sizeList() {
    return const LoadListSize();
  }

  Widget _sizeLabel() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "Size",
            style: GoogleFonts.spartan(
                textStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: -3,
            )),
          ),
        ),
      ],
    );
  }

  Widget _shoesType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            'Loại Giày: ${widget.shoes.loaiGiay}',
            style: GoogleFonts.spartan(
                textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            )),
          ),
        ),
      ],
    );
  }

  Widget _shoesPrice() {
    DateTime dateNow = DateTime.now();
    if(dateNow.compareTo(widget.dateStart) >= 0 && dateNow.compareTo(widget.dateEnd) <= 0) {
      flag = true;
    } else {
      flag = false;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(flag ? widget.tempPrice.toString() : widget.shoes.price.toString(),
            style: GoogleFonts.spartan(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                )),
          ),
        ),
      ],
    );




  }

  Widget _shoesName() {
    return Text(
      widget.shoes.tenGiay,
      style: GoogleFonts.spartan(
          textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        letterSpacing: -1,
      )),
    );
  }

  Widget _shoesImage() {
    return FutureBuilder(
      future: FirebaseStoreDatabase()
          .getImage(widget.shoes.maSoGiay!, widget.shoes.images!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            padding: const EdgeInsets.only(
              top: 60,
              bottom: 15,
              left: 115,
              right: 115,
            ),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70))),
            child: SizedBox(
              height: 180,
              child: Image.network(
                snapshot.data.toString(),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class LoadListSize extends StatefulWidget {
  const LoadListSize({Key? key}) : super(key: key);

  @override
  State<LoadListSize> createState() => _LoadListSizeState();
}

class _LoadListSizeState extends State<LoadListSize> {
  List<String> sizeList = ["35", "36", "37", "38", "39", "40", "41"];
  int _selectedSizeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        left: 30,
      ),
      height: 70,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sizeList.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSizeIndex = i;
                });
                Provider.of<CartProvider>(context,listen: false).changeSize(sizeList[i]);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                width: 70,
                decoration: BoxDecoration(
                    color: _selectedSizeIndex == i
                        ? Colors.black
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    sizeList[i],
                    style: GoogleFonts.spartan(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: _selectedSizeIndex == i
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
