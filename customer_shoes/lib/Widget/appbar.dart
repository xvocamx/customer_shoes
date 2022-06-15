import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/Cart.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _counter = 0;
    bool showBadge = true;
    final user = FirebaseAuth.instance.currentUser!;


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/person.png'),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasError) {
                  return const Text("Something went wrong");
                }
                if(snapshot.hasData) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String ,dynamic>;
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(data['name'],style: const TextStyle(fontSize: 20,color: Colors.black),),
                  );
                }
                return const Text("Loading");
              },
            ),
          ],
        ),
        IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart'),
            icon: const Icon(Icons.shopping_cart,color: Colors.blue,)
        )
      ],
    );
  }
}
