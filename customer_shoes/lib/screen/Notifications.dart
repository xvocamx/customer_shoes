import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_shoes/models/phieuhang.dart';
import 'package:customer_shoes/screen/DetailPhieuHang.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection('phieuBanHang').where('idUser',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();

  getTime(Timestamp timestamp) {
    var dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    var dateFormat = DateFormat('dd/MM/yyyy, HH:mm').format(dateTime);
    return dateFormat;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text("Loading"));
            }
            if(snapshot.hasData){
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        PhieuBanHang phieuBanHang = PhieuBanHang(
                          id: data['id'],
                          idUser: data['idUser'],
                          listShoes: data['listShoes'],
                          time: (data['time'] as Timestamp).toDate(),
                          totalPrice: data['totalPrice'],
                        );
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPhieuBanHang(phieuBanHang: phieuBanHang)));
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 10,),
                              Text("Mã Phiếu: "+ data['id'],
                                style: const TextStyle(color: Colors.teal,fontSize: 17),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance.collection('users').doc(data['idUser']).snapshots(),
                                    builder: (context, snapshot){
                                      if(snapshot.hasError) {
                                        return const Text("Something went wrong");
                                      }
                                      if(snapshot.hasData) {
                                        Map<String, dynamic> data = snapshot.data!.data() as Map<String ,dynamic>;
                                        return Text("Người đặt: "+data['name']);
                                      }
                                      return const Text("Loading");
                                    },
                                  ),
                                  Text("Ngày đặt: " +getTime(data['time'])),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Tổng tiền: " + data['totalPrice'].toString()),
                                ],
                              ),
                              const SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
