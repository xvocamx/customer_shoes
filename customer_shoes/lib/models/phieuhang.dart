import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_shoes/models/shoes.dart';
import 'package:customer_shoes/models/shoesCart.dart';

class PhieuBanHang {
  String? id;
  String? idUser;
  List? listShoes;
  double? totalPrice;
  DateTime? time;

  PhieuBanHang(
      {this.id, this.idUser, this.listShoes, this.totalPrice, this.time});

  factory PhieuBanHang.fromJson(Map<String, dynamic> json) {
    return PhieuBanHang(
      id: json['id'],
      idUser: json['idUser'],
      listShoes: json['listShoes'],
      totalPrice: json['totalPrice'],
      time: (json["time"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'idUser': idUser,
        'listShoes': listShoes,
        'totalPrice': totalPrice,
        'time': time,
      };
}
