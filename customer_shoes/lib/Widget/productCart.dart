import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../firebase/FirebaseStoreDatabase.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({Key? key, required this.context,required this.totalPrice,}) : super(key: key);
  final BuildContext context;
  final double totalPrice;

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection('cart').doc(user.uid).collection('items').snapshots();

    removeItemCart(String idCart) async {
      await FirebaseFirestore.instance.collection('cart').doc(user.uid).collection('items').doc(idCart).delete();
    }

    return StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasError){
            return const Text("Something went wrong");
          }
          if(snapshot.hasData){
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_,index){
                  DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                  return Dismissible(
                    key: Key(index.toString()),
                    onDismissed: (direction){
                      setState(() {
                        removeItemCart(documentSnapshot.id);
                      });
                    },
                    background: Container(color: Colors.red,),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                      child: Row(
                        children: [
                          Expanded(
                              child: FutureBuilder(
                                future: FirebaseStoreDatabase().getImage(documentSnapshot['idShoes'], documentSnapshot['image']),
                                builder: (context, snapshot) {
                                  if(snapshot.hasError){
                                    return const Text("Something went wrong");
                                  }
                                  if(snapshot.connectionState == ConnectionState.done){
                                    return Container(
                                      width: (MediaQuery.of(context).size.width - 50) / 3,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 1,
                                              blurRadius: 0.5,
                                              color: Colors.black.withOpacity(0.1),
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(30),
                                          image:  DecorationImage(
                                            image: NetworkImage(snapshot.data.toString()),
                                            fit: BoxFit.contain
                                          )
                                    ),);
                                  }
                                  return const Center(child: CircularProgressIndicator());
                                },
                              )
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
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
                                const SizedBox(height: 15),

                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    Text(
                                      documentSnapshot['price'].toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Text(
                                      "x1",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          }else {
            return const Center(child: Text("Not item"),);
          }
        }
    );
  }
}
