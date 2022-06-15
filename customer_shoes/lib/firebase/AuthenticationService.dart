import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_shoes/models/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //Dang nhap
  Future signIn(String email, String password,BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      bool lockAccount = true;
      await _firebaseFirestore.collection('users').doc(user!.uid).get().then((DocumentSnapshot documentSnapshot){
        Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
        Customer customer = Customer.fromJson(data);
        if(lockAccount == customer.lockAccount){
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Thông báo",style: TextStyle(color: Colors.red),),
                content: const Text("Tài khoản bạn đã bị khóa, vui lòng liên hệ shop để mở lại tài khoản"),
                actions: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Thoát"),
                    ),
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(width: 1),
                ),
              ),
          );
        }else {
          Fluttertoast.showToast(msg: "Đăng nhập thành công");
          Navigator.pushNamedAndRemoveUntil(context, '/home',ModalRoute.withName('/home'));
        }
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //Dang ky
  Future signUp(String email, String password, String name, String address, String phone, BuildContext context) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      Customer customer = Customer(uid: user!.uid, name: name, email: email, address: address, phone: phone,lockAccount: false);
      await _firebaseFirestore.collection('users').doc(user.uid).set(customer.toJson());
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Sign Up Succeeded'),
                content:
                    const Text("You account was created, you can now login"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/signIn');
                      },
                      child: const Text('OK'))
                ],
              ));
    } on FirebaseAuthException catch (e) {
      handleSignUpError(e, context);
    }
  }

  void handleSignUpError(FirebaseException e, BuildContext context) {
    String messageToDisplay;
    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay = "This email is alreadly in use";
        break;
      case 'invalid-email':
        messageToDisplay = "This email you enter is invalid";
        break;
      case 'operation-not-allowed':
        messageToDisplay = "This operation is not allowed";
        break;
      case 'weak-password':
        messageToDisplay = "The password you entered is too weak";
        break;
      default:
        messageToDisplay = "An unknow error occurred";
        break;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Sign Up Failed'),
              content: Text(messageToDisplay),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'))
              ],
            ));
  }

  // Dang xuat
  Future logout() async {
    await _firebaseAuth.signOut();
  }
}
