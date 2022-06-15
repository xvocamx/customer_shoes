import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_shoes/firebase/FirebaseStoreDatabase.dart';
import 'package:customer_shoes/models/shoes.dart';
import 'package:flutter/material.dart';
import '../screen/DetailShoe.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection('shoes').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError){
          return const Text("Something went wrong");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading");
        }
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return GestureDetector(
              onTap: (){
                Shoes shoes = Shoes(maSoGiay: data['maSoGiay'],tenGiay: data['tenGiay'], loaiGiay: data['loaiGiay'], price: data['price'], soLuong: data['soLuong'],images: data['images']);
                double tempPrice = data['tempPrice'];
                DateTime dateStart = (data['dateStart']).toDate();
                DateTime dateEnd = (data['dateEnd']).toDate();
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailShoesPage(
                  shoes: shoes,
                  tempPrice: tempPrice,
                  dateStart: dateStart,
                  dateEnd: dateEnd,
                )));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Stack(
                    children: [
                      FadeInDown(
                        duration: Duration(microseconds: 300 * data.length),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [BoxShadow(
                                spreadRadius: 1,
                                color: Colors.black.withOpacity(0.1),
                              )]
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: FutureBuilder(
                                        future: FirebaseStoreDatabase().getImage(data['maSoGiay'], data['images']),
                                        builder: (context, snapshot) {
                                          if(snapshot.hasError){
                                            return const Text("Something went wrong");
                                          }
                                          if(snapshot.connectionState == ConnectionState.done){
                                            return Image.network(snapshot.data.toString(),width: 280,height: 180,fit: BoxFit.contain,);
                                          }
                                          return const Center(child: CircularProgressIndicator());
                                        },
                                      )
                                  ),
                                ],
                              ),
                              Text(data['tenGiay'],
                                style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,

                                ),
                              ),
                              const SizedBox(height: 15,),
                              getPrice(data),
                              // Text("Giá: " + data['price'].toString() + " VNĐ",
                              //   style: const TextStyle(
                              //       fontSize: 17,
                              //       fontWeight: FontWeight.w700
                              //   ),
                              // ),
                              const SizedBox(height: 15,),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget getPrice(Map<String, dynamic> data) {
    DateTime now = DateTime.now();
    DateTime dateStart = (data['dateStart']).toDate();
    DateTime dateEnd = (data['dateEnd']).toDate();
    if(now.compareTo(dateStart) >= 0 && now.compareTo(dateEnd) <= 0) {
      return Text("Giá: " + data['tempPrice'].toString() + " VNĐ",
        style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700
        ),
      );
    } else {
      return Text("Giá: " + data['price'].toString() + " VNĐ",
        style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700
        ),
      );
    }

  }
}
