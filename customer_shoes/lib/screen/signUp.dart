import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../firebase/AuthenticationService.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          )),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36.0, horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Create an account, it's free",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 30),
                              TextFormField(
                                validator: (value) => value!.isEmpty ? "Please enter Email" : null,
                                controller: emailController,
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    prefixIcon: const Icon(Icons.email,color: Color(0xff606470)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    )),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                validator: (String? value) => value!.isEmpty ? "Please enter name" : null,
                                controller: nameController,
                                decoration: InputDecoration(
                                    labelText: "Name",
                                    prefixIcon: const Icon(Icons.person,color: Color(0xff606470)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    )),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                validator: (String? value) => value!.isEmpty ? "Please enter address" : null,
                                controller: addressController,
                                decoration: InputDecoration(
                                    labelText: "Address",
                                    prefixIcon: const Icon(Icons.location_on,color: Color(0xff606470)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    )),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                validator: (String? value) => value!.isEmpty ? "Please enter phone" : null,
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    labelText: "Phone",
                                    prefixIcon: const Icon(Icons.phone,color: Color(0xff606470)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    )),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                validator: (String? value) => value!.isEmpty ? "Please enter password" : null,
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    prefixIcon: const Icon(Icons.lock,color: Color(0xff606470)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    )),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                validator: (String? value) {
                                  if(value == null || value.trim().isEmpty){
                                    return "Please enter Confirm Password";
                                  }
                                  if(passwordController.text != value) {
                                    return "Password don't match";
                                  }
                                  return null;
                                },
                                controller: confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Confirm Password",
                                    prefixIcon: const Icon(Icons.lock,color: Color(0xff606470)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    )),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()){
                                      authenticationService.signUp(
                                          emailController.text,
                                          passwordController.text,
                                          nameController.text,
                                          addressController.text,
                                          phoneController.text,
                                          context
                                      );
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
                                    "Already have an Account",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Sign In",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Image extends StatelessWidget {
  const Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 2,
        )
      ],
    );
  }
}
