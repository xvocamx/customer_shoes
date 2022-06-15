import 'package:customer_shoes/models/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../firebase/AuthenticationService.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
AuthenticationService authenticationService = AuthenticationService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade800,
                        Colors.orangeAccent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.centerRight,
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Login",style: TextStyle(color: Colors.white,fontSize: 46),),
                              SizedBox(height: 10.0,),
                              Text("Chào mừng đến với shop shoes",style: TextStyle(color: Colors.white,fontSize: 20),),
                            ],
                          ),
                        )
                    ),
                    Expanded(
                        flex: 5,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(45.0),
                                  topRight: Radius.circular(45.0)
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  // const Image(
                                  //   height: 150,
                                  //   image: AssetImage('assets/banner.png'),
                                  // ),
                                  const SizedBox(height: 30),
                                  TextFormField(
                                    validator: (value) => value!.isEmpty ? "Please enter Email" : null,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        labelText: "Email",
                                        prefixIcon: const Icon(Icons.email),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        )),
                                  ),
                                  const SizedBox(height: 30),
                                  TextFormField(
                                    validator: (value) => value!.isEmpty ? "Please enter Password" : null,
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        labelText: "Password",
                                        prefixIcon: const Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        )),
                                  ),
                                  Container(
                                    constraints:
                                    BoxConstraints.loose(const Size(double.infinity, 50)),
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Text(
                                        "Forgot password ?",
                                        style: TextStyle(fontSize: 16, color: Color(0xff606470)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30,),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 52,
                                    child: ElevatedButton(
                                      child: const Text(
                                        "Sign In",
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                      onPressed: () {
                                        if(_formKey.currentState!.validate()){
                                          authenticationService.signIn(emailController.text.trim(), passwordController.text.trim(),context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(28.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Don't have an account ?", style: TextStyle(fontSize: 18),),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/signUp');
                                        },
                                        child: const Text(
                                          "Sign Up", style: TextStyle(fontSize: 18),),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
