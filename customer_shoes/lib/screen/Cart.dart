import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_shoes/Provider/cart_provider.dart';
import 'package:customer_shoes/models/phieuhang.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../firebase/FirebaseStoreDatabase.dart';
import '../models/shoes.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('items')
      .snapshots();

  //Ham totalPrice
  getTotalPrice() async {
    double totalPrice = 0.0;
    QuerySnapshot snapshot = await firebaseFirestore
        .collection('cart')
        .doc(user.uid)
        .collection('items')
        .get();

    for (var element in snapshot.docs) {
      {
        totalPrice += element.get('initialPrice');
      }
    }
    return totalPrice;
  }

  //Ham xoa item cart
  removeItemCart(String idCart) async {
    await firebaseFirestore
        .collection('cart')
        .doc(user.uid)
        .collection('items')
        .doc(idCart)
        .delete();
  }

  //Ham thanh toan
  Future checkOutShoes(double totalPrice) async {
    PhieuBanHang phieuBanHang = PhieuBanHang();
    final docPhieuBanHang = firebaseFirestore.collection('phieuBanHang').doc();
    final snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(user.uid)
        .collection('items')
        .get();

    List listShoes = snapshot.docs.map((doc) => doc.data()).toList();
    phieuBanHang.id = docPhieuBanHang.id;
    phieuBanHang.idUser = user.uid;
    phieuBanHang.listShoes = listShoes;
    phieuBanHang.totalPrice = totalPrice;
    phieuBanHang.time = DateTime.now();
    final data = phieuBanHang.toJson();

    //Set data vao phieu ban hang
    await docPhieuBanHang.set(data).then((value) async =>  {
      //Xoa item ra khoi cart
      await firebaseFirestore.collection('cart').doc(user.uid).collection('items').get().then((value) => {
        for(DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete().then((value) => print("Deteled"))
        }
      }),
    });
  }

  //Update quantity item cart
  Future updateQuantity(String idShoes,String nameShoes,double price,String size, String image,int quantity, double newPrice) async {
    final user = FirebaseAuth.instance.currentUser;
    final reference = FirebaseFirestore.instance.collection('cart').doc(user!.uid).collection('items').doc(idShoes);
    return reference.update({
      "idShoes": idShoes,
      "nameShoes": nameShoes,
      "price": price,
      "initialPrice": newPrice,
      "quantity": quantity,
      "size": size,
      "image": image,
    }).then((value) {
      print("Update quantity successed");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Column(
        children:  [
          const Text("Your cart",style: TextStyle(color: Colors.black),),
          Text("4 items", style: Theme.of(context).textTheme.caption,)
        ],
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Padding(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 25),
            child: Text(
              "My bag",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
            ),
          ),
          getItemCart(),
          Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 25, right: 25, bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Toal Price",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                  FutureBuilder(
                    future: getTotalPrice(),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data.toString() + " VNĐ",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      );
                    },
                  ),
                ],
              )),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: FutureBuilder(
                    future: getTotalPrice(),
                    builder: (context,snapshot){
                      return ElevatedButton(
                        onPressed: () async {
                          double totalPrice = double.parse(snapshot.data.toString());
                          checkOutShoes(totalPrice);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Check Out",
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
                      );
                    },
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getItemCart() {
    return StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: FutureBuilder(
                              future: FirebaseStoreDatabase().getImage(
                                  documentSnapshot['idShoes'],
                                  documentSnapshot['image']),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Something went wrong");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Container(
                                    width: (MediaQuery.of(context).size.width - 100) / 3,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 1,
                                            blurRadius: 0.5,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey.shade500,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                snapshot.data.toString()),
                                            fit: BoxFit.cover)),
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documentSnapshot['nameShoes'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Size: ${documentSnapshot['size']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                documentSnapshot['initialPrice'].toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          onTap: (){
                                            int quantity = documentSnapshot['quantity'];
                                            double price = documentSnapshot['price'];
                                            quantity--;
                                            double? newPrice = quantity * price;
                                            String idShoes = documentSnapshot['idShoes'];
                                            String nameShoes = documentSnapshot['nameShoes'];
                                            String image = documentSnapshot['image'];
                                            String size = documentSnapshot['size'];

                                            if(quantity > 0){
                                              setState(() {
                                                updateQuantity(idShoes,nameShoes,price,size,image, quantity, newPrice);
                                              });
                                            }
                                          },
                                          child: const Icon(Icons.remove, color: Colors.white,)
                                      ),
                                      Text(documentSnapshot['quantity'].toString()),
                                      InkWell(
                                          onTap: (){
                                            int quantity = documentSnapshot['quantity'];
                                            double price = documentSnapshot['price'];
                                            quantity++;
                                            double? newPrice = quantity * price;
                                            String idShoes = documentSnapshot['idShoes'];
                                            String nameShoes = documentSnapshot['nameShoes'];
                                            String image = documentSnapshot['image'];
                                            String size = documentSnapshot['size'];
                                            setState(() {
                                              updateQuantity(idShoes,nameShoes,price,size,image, quantity, newPrice);
                                            });
                                          },
                                          child: const Icon(Icons.add, color: Colors.white,)
                                      ),
                                    ],

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 150,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              removeItemCart(documentSnapshot.id);
                              setState(() {
                                getTotalPrice();
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  );
                });
          }
          else{
            return const Center(
              child: Text("Not item"),
            );
          }
        });
  }
}






