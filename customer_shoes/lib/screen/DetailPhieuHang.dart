import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_shoes/models/phieuhang.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DetailPhieuBanHang extends StatelessWidget {
  const DetailPhieuBanHang({Key? key, required this.phieuBanHang}) : super(key: key);
  final PhieuBanHang phieuBanHang;

  getTime(DateTime dateTime) {
    var dateFormat = DateFormat('dd/MM/yyyy, HH:MM').format(dateTime);
    return dateFormat;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết phiếu bán hàng"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Mã phiếu: "+phieuBanHang.id!,style: const TextStyle(color: Colors.green,fontSize: 20),)),
            const SizedBox(height: 15,),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(phieuBanHang.idUser!).snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasError) {
                  return const Text("Something went wrong");
                }
                if(snapshot.hasData) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String ,dynamic>;
                  return Text("Người đặt hàng: "+data['name'],style: const TextStyle(color: Colors.black,fontSize: 17));
                }
                return const Text("Loading");
              },
            ),
            const SizedBox(height: 15,),
            Text("Ngày đặt hàng: "+getTime(phieuBanHang.time!),style: const TextStyle(color: Colors.black,fontSize: 17),),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow:  [BoxShadow(
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.5),
                  )]
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 15, bottom: 5),
                    child: Text(
                      "Danh sách đã mua",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600,color: Colors.red),
                    ),
                  ),
                  ListView.builder(
                    itemCount: phieuBanHang.listShoes!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index) {
                      var item = phieuBanHang.listShoes![index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8,bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['nameShoes'],style: const TextStyle(fontSize: 17),),
                                Text("Giá: "+item['price'].toString(),style: const TextStyle(fontSize: 17),),
                              ],
                            )
                          ),
                          Text("x"+item['quantity'].toString(),style: const TextStyle(fontSize: 17),),
                        ],
                      );
                    },
                  ),

                ],
              ),
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Toal Price",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7)),
                ),
                Text(phieuBanHang.totalPrice.toString()+ " VNĐ",style: const TextStyle(color: Colors.black,fontSize: 20)),
              ],
            )
          ],
        ),
      )
    );
  }
}
